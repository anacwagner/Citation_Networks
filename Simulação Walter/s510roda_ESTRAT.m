%Gera os arquivos dos períodos ESTRATEGICO e PÓS-ESTRATÉGICO

for rep=1:par_repeticoes   %Início do loop de repetições das rodadas

tic;               %dispara o cronômetro

% (1) Carrega o arquivo com as variáveis BASE
    load([file_amb_base '.mat'] ,'var*');  %carrega apenas as variáveis do ambiente BASE
    disp(' ');disp(['Rep.' num2str(rep) ': 1-Arquivo BASE carregado para iniciar a simulação']);toc;

% (2) seleciona lista de periódicos "estratégicos" dentre as que foram geradas no último ano BASE
%  A lista a ser usada depende do parâmetro "par_prob_pestrat"
    if par_prob_pestrat == 0.2
        var_pe = var_pe02;
    elseif par_prob_pestrat == 0.5
        var_pe = var_pe05;
    elseif par_prob_pestrat == 0.9
        var_pe = var_pe09;
    end
    disp(' ');disp(['Rep.' num2str(rep) ': 2-Lista de periódicos "estratégicos" selecionada']);toc;

% (3) Loop dos períodos "estratégicos"
for par_ano=(par_anos_base+1):par_anos_estr
    
    for par_mes=[3,4,6,8,9,12]; %mês de publicação dos artigos
                                %só ocorrem publicações nesses meses
                                
        par_ult=var_a(end,2);       %código do último artigo gerado no período anterior
	
        % (3.1) gera a lista de artigos publicados no ano (mesma função usada nos períodos "sem estratégia"
            var_an=p350geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (3.2) separa os artigos DO ANO publicados pelos periódicos "normais" dos "estratégicos"
            [var_an_norm,var_an_estrat]=p355separaartan(var_an,var_pe,par_prob_aestrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.2-Artigos DO ANO dos periódicos "normais" e "estratégicos" do ano ' num2str(par_ano) ' separados' ]);toc;

        % (3.3) separa os artigos EXISTENTES publicados pelos periódicos "normais" dos "estratégicos"
            [var_a_estrat]=p356separaart(var_a,var_pe);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.3-Artigos EXISTENTES dos periódicos "normais" e "estratégicos" do ano ' num2str(par_ano) ' separados' ]);toc;

        % (3.4) gera a lista de citações entre os artigos dos periódicos NORMAIS publicados e os existentes
            var_citn_norm=p361geracitano_nNEW(var_a,var_an_norm);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.4-Geradas citações NORMAIS dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.5) gera a lista de citações entre os artigos dos periódicos ESTRATÉGICOS publicados e os existentes
            var_citn_estrat=p362geracitano_eNEW(var_a,var_a_estrat,var_an_estrat,par_prob_cestrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.5-Geradas citações ESTRATÉGICAS dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.6) anexa as listas NORMAIS do período às listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p370juntaart(var_a,var_an_norm,var_cit,var_citn_norm);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.6-Listas NORMAIS de artigos e citações do ano ' num2str(par_ano) ' anexadas às anteriores' ]);toc;

        % (3.7) anexa as listas ESTRATÉGICAS do período às listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p370juntaart(var_a,var_an_estrat,var_cit,var_citn_estrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.7-Listas ESTRATÉGICAS de artigos e citações do ano ' num2str(par_ano) ' anexadas às anteriores' ]);toc;

        % (3.8) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.8-Atualizadas informações dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.9) sumariza as citações entre periódicos no ano
            var_citpern=p383sumcitper(var_citn_norm,var_citn_estrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.9-Citações entre periódicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (3.10) anexa as citações entre periódicos no ano às citações entre periódicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern); 
            disp(' ');disp(['Rep.' num2str(rep) ': 3.10-Citações entre periódicos atualizadas com as citações no ano ' num2str(par_ano)]);toc;

        % (3.11) atualiza as informações dos periódicos (grau, artigos e fitness médio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.11-Arquivos com informações dos periódicos atualizados para o ano ' num2str(par_ano)]);toc;

    end
end
% (4) Fim dos períodos "estratégicos"
    disp(' ');disp(['Rep.' num2str(rep) ': 4-Fim dos períodos "estratégicos"']);toc;

% (5) Loop de períodos pós ciclo estratégico
for par_ano=(par_anos_estr+1):(par_anos_estr+10)
    
    for par_mes=[3,4,6,8,9,12]; %mês de publicação dos artigos
                                %só ocorrem publicações nesses meses
                                
        par_ult=var_a(end,2);       %código do último artigo gerado no período anterior
	
        % (5.1) gera a lista de artigos publicados no ano
            var_an=p050geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (5.2) gera a lista de citações entre os artigos publicados e os existentes
            var_citn=p060geracitanoNEW(var_a,var_an);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.2-Geradas citações dos artigos do ano ' num2str(par_ano)]);toc;

        % (5.3) anexa as listas do período às listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p070juntaart(var_a,var_an,var_cit,var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.3-Listas de artigos e citações do ano ' num2str(par_ano) ' anexadas às anteriores' ]);toc;

        % (5.4) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.4-Atualizadas informações dos artigos do ano ' num2str(par_ano)]);toc;

        % (5.5) sumariza as citações entre periódicos no ano
            var_citpern=p083sumcitper(var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.5-Citações entre periódicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (5.6) anexa as citações entre periódicos no ano às citações entre periódicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.6-Citações entre periódicos atualizadas com as citações no ano ' num2str(par_ano)]);toc;

        % (5.7) atualiza as informações dos periódicos (grau, artigos e fitness médio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.7-Arquivos com informações dos periódicos atualizados para o ano ' num2str(par_ano)]);toc;

    end
end

% (6) Fim dos períodos pós ciclo estratégico - Estração das informações gerais

    [sai_tot, sai_2an, sai_5an,sai_dp_tot, sai_dp_2an, sai_dp_5an]=p900extrai_mdp(var_pif,var_pgrau,var_pe);
    par_anos_extrai=[par_anos_base par_anos_estr (par_anos_estr+par_anos_apos)];
    [sai_rec]=p211calcrecip(var_p, var_pe, var_citper,par_anos_extrai);

    save([file_amb_save num2str(rep)]);
    disp(' ');disp(['Rep.' num2str(rep) ': 6-Informações gerais extraídas; ambiente final salvo']);
    disp(['Fim da repetição ' num2str(rep)]);toc;
    clear var*;

end   %END do loop de repetições
