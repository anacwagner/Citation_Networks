% Fit dynamic stochastic block model (SBM) to Enron email data
% Author: Kevin S. Xu

deltaT = 7;	% Length of each time step (in days)
thres = 1;  % Threshold for edges (number of emails required to place edge)
includeCc = true;
directed = true;

% Parameters for known classes
kPri = 7;
pPri = kPri^2;
initCovPri = eye(pPri);
stateCovInPri = 0.01;
stateCovOutPri = 0;

% Parameters for unknown classes
kPost = 4;
pPost = kPost^2;
initCovPost = eye(pPost);
stateCovInPost = 0.1;
stateCovOutPost = 0.02;

% Optional parameters
Opt.directed = directed;
% Number of random initializations for k-means step of spectral clustering
Opt.nKmeansReps = 5;
Opt.maxIter = 200;  % Maximum number of local search iterations
Opt.output = 1; % Level of output to display in console

%% Load data
if directed == false
	str1 = 'Undirected';
else
	str1 = 'Directed';
end
if includeCc == false
	str2 = 'NoCc';
else
	str2 = 'WithCc';
end
load(['Enron' str1 str2 '_' int2str(deltaT) 'Days.mat'])

% Truncate weeks at beginning and end with low participation
if deltaT == 7
	adj = adj(:,:,57:176);
	traceStartDate = traceStartDate + 56*deltaT;
	traceEndDate = traceEndDate - 13*deltaT;
end

%% Pre-processing
[n,~,tMax] = size(adj);

% Dichotomize edges
adj(adj<thres) = 0;
adj(adj>=thres) = 1;

% Combine roles into 7 groups:
% 1: Director, Managing Director
% 2: CEO
% 3: President
% 4: Vice President
% 5: Manager
% 6: Trader
% 7: Employee, In House Lawyer, and N/A
rolesOld = roles;
roles = kPri*ones(n,1);    % Set default role to number of classes
roles(rolesOld == find(strcmp(roleLabels,'Director'),1)) = 1;
roles(rolesOld == find(strcmp(roleLabels,'Managing Director'),1)) = 1;
roles(rolesOld == find(strcmp(roleLabels,'CEO'),1)) = 2;
roles(rolesOld == find(strcmp(roleLabels,'President'),1)) = 3;
roles(rolesOld == find(strcmp(roleLabels,'Vice President'),1)) = 4;
roles(rolesOld == find(strcmp(roleLabels,'Manager'),1)) = 5;
roles(rolesOld == find(strcmp(roleLabels,'Trader'),1)) = 6;

logistic = @(x) 1./(1+exp(-x));	% Logistic function

%% Estimate states using EKF with a priori classes
disp('Estimating states using EKF with a priori classes')

stateTransPri = eye(pPri);
stateCovPri = generateStateCov(kPri,stateCovInPri,stateCovOutPri,directed);

[blockDens,nEdges,nPairs,OptPriEkf] = calcBlockDens(adj, ...
    roles,Opt);
OptPriEkf.nClasses = kPri;
[psiPriEkf,psiCovPriEkf,~,OptPriEkf] = ekfDsbm(blockDens,stateTransPri, ...
    stateCovPri,[],[],initCovPri,OptPriEkf);
thetaPriEkfMat = blockvec2mat(logistic(psiPriEkf),directed);

% Compute 95% confidence intervals for class connection probabilities
% estimated by a priori EKF
psiStdPriEkf = zeros(pPri,tMax);
for t = 1:tMax
    psiStdPriEkf(:,t) = sqrt(diag(psiCovPriEkf(:,:,t)));
end
thetaPriEkfUpperMat = blockvec2mat(logistic(psiPriEkf + 2*psiStdPriEkf), ...
    directed);
thetaPriEkfLowerMat = blockvec2mat(logistic(psiPriEkf - 2*psiStdPriEkf), ...
    directed);

%% Estimate states using EKF with classes estimated by local search
disp('Estimating states using EKF with a posteriori class estimates')

stateTransPost = eye(pPost);
stateCovPost = generateStateCov(kPost,stateCovInPost,stateCovOutPost,directed);

OptPostEkf = Opt;
OptPostEkf.nClasses = kPost;
[classPostEkf,psiPostEkf,psiCovPostEkf,~,OptPostEkf] = ekfDsbmLocalSearch ...
    (adj,kPost,stateTransPost,stateCovPost,[],[],initCovPost,OptPostEkf);
thetaPostEkf = logistic(psiPostEkf);

%% Calculate forecast error of block densities
psiPredPriEkf = stateTransPri*psiPriEkf;
thetaPredPriEkf = [zeros(pPri,1) logistic(psiPredPriEkf(:,1:tMax-1))];
msePredPriEkf = sum((thetaPredPriEkf(:,2:tMax) - blockDens(:,2:tMax)).^2);

blockDensPost = calcBlockDens(adj,classPostEkf,OptPostEkf);
psiPredPostEkf = stateTransPost*psiPostEkf;
thetaPredPostEkf = [zeros(pPost,1) logistic(psiPredPostEkf(:,1:tMax-1))];
msePredPostEkf = sum((thetaPredPostEkf(:,2:tMax) - blockDensPost(:,2:tMax)).^2);

%% Calculate forecast error of links
disp('Calculating ROC of link forecast')

% Exponentially-weighted moving average (EWMA) predictor
predMatEwma = zeros(n,n,tMax);
ff = 0.5;   % Forgetting factor for EWMA
ccWt = 0.01;   % Weight of EKF predictor in convex combination

rolesMat = repmat(roles,1,tMax);
rolesMat(classPostEkf==0) = 0;
% Link forecast based on a priori classes (employee roles)
predMatPriEkf = predAdjMatDsbm(adj,blockvec2mat ...
    (thetaPredPriEkf,directed),rolesMat);
% Link forecast based on a posteriori class estimates
predMatPostEkf = predAdjMatDsbm(adj,blockvec2mat(thetaPredPostEkf, ...
    directed),classPostEkf);

predMatEwma(:,:,2) = adj(:,:,2);
for t = 3:tMax
    predMatEwma(:,:,t) = ff*predMatEwma(:,:,t-1) + (1-ff)*adj(:,:,t-1);
end
predMatPriEkfEwma = ccWt*predMatPriEkf + (1-ccWt)*predMatEwma;
predMatPostEkfEwma = ccWt*predMatPostEkf + (1-ccWt)*predMatEwma;

nTotPairs = n*(n-1)*(tMax-1);
if directed == false
    nTotPairs = nTotPairs/2;
end

adjVect = reshape(adjmat2vec(adj(:,:,2:end),directed),1,nTotPairs);
[fprPri,tprPri,~,aucPri] = perfcurve(adjVect,reshape(adjmat2vec ...
    (predMatPriEkf(:,:,2:tMax),directed),1,nTotPairs),1);
[fprPost,tprPost,~,aucPost] = perfcurve(adjVect,reshape(adjmat2vec ...
    (predMatPostEkf(:,:,2:tMax),directed),1,nTotPairs),1);
[fprEwma,tprEwma,~,aucEwma] = perfcurve(adjVect,reshape(adjmat2vec ...
    (predMatEwma(:,:,2:tMax),directed),1,nTotPairs),1);
[fprPriEwma,tprPriEwma,~,aucPriEwma] = perfcurve(adjVect,reshape ...
    (adjmat2vec(predMatPriEkfEwma(:,:,2:tMax),directed),1,nTotPairs),1);
[fprPostEwma,tprPostEwma,~,aucPostEwma] = perfcurve(adjVect,reshape ...
    (adjmat2vec(predMatPostEkfEwma(:,:,2:tMax),directed),1,nTotPairs),1);

%% Summary statistics
disp('-----')
disp('Summary statistics:')
disp(['Mean a priori EKF block density forecast MSE: ' ...
    num2str(mean(msePredPriEkf),'%5.3f')])
disp(['Mean a posteriori EKF block density forecast MSE: ' ...
    num2str(mean(msePredPostEkf),'%5.3f')])
disp(['A priori EKF AUC: ' num2str(aucPri,'%5.3f')])
disp(['A posteriori EKF AUC: ' num2str(aucPost,'%5.3f')])
disp(['Exponentially-weighted moving average (EWMA) AUC: ' ...
    num2str(aucEwma,'%5.3f')])
disp(['A priori EKF + EWMA AUC: ' num2str(aucPriEwma,'%5.3f')])
disp(['A posteriori EKF + EWMA AUC: ' num2str(aucPostEwma,'%5.3f')])

%% Plot all state estimates for one block
figure(1)
row = 2;
col = 3;
plot(1:tMax,reshape(thetaPriEkfMat(row,col,:),1,tMax),'b', ...
    1:tMax,reshape(thetaPriEkfLowerMat(row,col,:),1,tMax),':b', ...
    1:tMax,reshape(thetaPriEkfUpperMat(row,col,:),1,tMax),':b')
legend('Estimated edge probability','95% confidence intervals', ...
    'Location','Best')
xlabel('Week')
ylabel('Edge probability')
title(['Estimated edge probability from ' roleLabels{row} 's to ' ...
    roleLabels{col} 's'])

%% Plot heat map of mean estimated edge probabilities
figure(2)
imagesc(mean(thetaPriEkfMat,3))
colorbar
colormap gray
xlabel('Recipient class')
ylabel('Sender class')
set(gca,'XTickLabel',roleLabels)
set(gca,'XTickLabelRotation',45)
set(gca,'YTickLabel',roleLabels)

%% Plot ROC curves
figure(3)
plot(fprPri,tprPri,fprPost,tprPost,fprEwma,tprEwma,fprPriEwma,tprPriEwma, ...
    fprPostEwma,tprPostEwma)
legend('A priori EKF','A posteriori EKF','EWMA','A priori EKF + EWMA', ...
    'A posteriori EKF + EWMA','Location','Best')
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC curves for link forecasts')
