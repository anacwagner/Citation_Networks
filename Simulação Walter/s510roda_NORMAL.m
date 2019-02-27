%Gera os arquivos dos períodos NORMAIS que servem de base de comparação com o comportamento estratégico

for rep=1:par_repeticoes   %Início do loop de repetições das rodadas

tic;               %dispara o cronômetro

% (1) Carrega o arquivo com as variáveis BASE
    load([file_amb_base '.mat'] ,'var*');  %carrega apenas as variáveis do ambiente BASE
    disp(' ');disp(['Rep.' num2str(rep) ': 1-Arquivo BASE carregado para iniciar a simulação']);toc;

% (3) Loop de períodos "normais", sem comportamento estratégico, para comparação
for par_ano=(par_anos_base+1):(par_anos_estr+10)
    
    for par_mes=[3,4,6,8,9,12]; %mês de publicação dos artigos
                                %só ocorrem publicações nesses meses
    
        par_ult=var_a(end,2);       %código do último artigo gerado no período anterior
	
        % (3.1) gera a lista de artigos publicados no ano
            var_an=p050geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (3.2) gera a lista de citações entre os artigos publicados e os existentes
            var_citn=p060geracitanoNEW(var_a,var_an);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.2-Geradas citações dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.3) anexa as listas do período às listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p070juntaart(var_a,var_an,var_cit,var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.3-Listas de artigos e citações do ano ' num2str(par_ano) ' anexadas às anteriores' ]);toc;

        % (3.4) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.4-Atualizadas informações dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.5) sumariza as citações entre periódicos no ano
            var_citpern=p083sumcitper(var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.5-Citações entre periódicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (3.6) anexa as citações entre periódicos no ano às citações entre periódicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.6-Citações entre periódicos atualizadas com as citações no ano ' num2str(par_ano)]);toc;

        % (3.7) atualiza as informações dos periódicos (grau, artigos e fitness médio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.7-Arquivos com informações dos periódicos atualizados para o ano ' num2str(par_ano)]);toc;
        
    end
end

% (4) Fim dos períodos pós ciclo estratégico - Estração das informaçoes gerais
    [sai_tot02, sai_2an02, sai_5an02,sai_dp_tot02, sai_dp_2an02, sai_dp_5an02]=p900extrai_mdp(var_pif,var_pgrau,var_pe02);
    [sai_tot05, sai_2an05, sai_5an05,sai_dp_tot05, sai_dp_2an05, sai_dp_5an05]=p900extrai_mdp(var_pif,var_pgrau,var_pe05);
    [sai_tot09, sai_2an09, sai_5an09,sai_dp_tot09, sai_dp_2an09, sai_dp_5an09]=p900extrai_mdp(var_pif,var_pgrau,var_pe09);
    par_anos_extrai=[par_anos_base par_anos_estr (par_anos_estr+par_anos_apos)];
    [sai_rec02]=p211calcrecip(var_p, var_pe02, var_citper,par_anos_extrai);
    [sai_rec05]=p211calcrecip(var_p, var_pe05, var_citper,par_anos_extrai);
    [sai_rec09]=p211calcrecip(var_p, var_pe09, var_citper,par_anos_extrai);

    save([file_amb_save num2str(rep)]);
    disp(' ');disp(['Rep.' num2str(rep) ': 4-Informaçoes gerais extraídas; ambiente final salvo']);
    disp(['Fim da repetição ' num2str(rep)]);toc;
    clear var*;

end   %END do loop de repetições
