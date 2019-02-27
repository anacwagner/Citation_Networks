%Gera os arquivos do período BASE (iniciais/preparação)

for rep=1:par_repeticoes   %Início do loop de repetições das rodadas BASE

    tic;               %dispara o cronômetro
    par_ano=0;         %inicializa variável de ano de publicação dos artigos
    
    % (1) gera a lista de periódicos
        var_p=p010geraperini(par_n_periodicos,par_faixa_fitness,par_nart_ini,par_nart_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 1-Lista de periódicos gerada']);toc;

    % (2) gera arquivos com informações dos periódicos (grau, artigos e fitness médio)
        [var_pgrau,var_parts,var_pfit,var_pif]=p015geraindper(var_p);
        disp(' ');disp(['Rep.' num2str(rep) ': 2-Arquivos com informações dos periódicos gerados']);toc;
        
    % (3) gera a lista inicial de artigos dos periódicos (ano zero)
        var_a=p020geraartini(var_p,par_ncit);
        disp(' ');disp(['Rep.' num2str(rep) ': 3-Lista inicial de artigos gerada']);toc;
        
    % (4) gera a lista inicial de citações entre os artigos iniciais (ano zero)
        var_cit=p030geracitiniNEW(var_a,par_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 4-Lista inicial de citações entre artigos gerada']);toc;

    % (5) calcula o grau de entrada dos artigos iniciais, com base nas citações
        var_a=p040grauentart(var_a,var_cit,par_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 5-Grau de entrada dos artigos iniciais calculado']);toc;

    % (6) sumariza as citações entre periódicos para o ano zero
        var_citper=p083sumcitper(var_cit);
        disp(' ');disp(['Rep.' num2str(rep) ': 6-Citações iniciais entre periódicos sumarizadas']);toc;

    % (7) atualiza as informações dos periódicos (grau, artigos e fitness médio)
        [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 7-Arquivos com informações iniciais dos periódicos atualizados - fim da preparação']);toc;;
   
% (8) roda os períodos BASE (base da ação estratégica - serão usados depois)
for par_ano=1:par_anos_base
    
    for par_mes=[3,4,6,8,9,12]; %mês de publicação dos artigos
                                %só ocorrem publicações nesses meses
                               
        par_ult=var_a(end,2);       %código do último artigo gerado no período anterior
	
        % (8.1) gera a lista de artigos publicados no ano
            var_an=p050geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (8.2) gera a lista de citações entre os artigos publicados e os existentes
            var_citn=p060geracitanoNEW(var_a,var_an);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.2-Geradas citações dos artigos do ano ' num2str(par_ano)]);toc;

        % (8.3) anexa as listas do período às listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p070juntaart(var_a,var_an,var_cit,var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.3-Listas de artigos e citações do ano ' num2str(par_ano) ' anexadas às anteriores' ]);toc;

        % (8.4) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.4-Atualizadas informações dos artigos do ano ' num2str(par_ano)]);toc;

        % (8.5) sumariza as citações entre periódicos no ano
            var_citpern=p083sumcitper(var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.5-Citações entre periódicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (8.6) anexa as citações entre periódicos no ano às citações entre periódicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.6-Citações entre periódicos atualizadas com as citações no ano ' num2str(par_ano)]);toc;

        % (8.7) atualiza as informações dos periódicos (grau, artigos e fitness médio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.7-Arquivos com informações dos periódicos atualizados para o ano ' num2str(par_ano)]);toc;
    end
end
% (9) Fim dos períodos BASE
    disp(' ');disp(['Rep.' num2str(rep) ': 9-Fim dos ' par_anos_base ' períodos BASE']);toc;

% (10) gera 3 listas de periódicos "estratégicos" no último ano BASE
% Listas diferentes dependendo do parâmetro "par_prob_pestrat"
    par_prob_pestrat=0.2
        var_pe02=p310selestrat(var_pif,par_prob_pestrat,par_anos_base);
        disp(' ');disp(['Rep.' num2str(rep) ': 10-Lista de periódicos "estratégicos p=0.2" gerada']);toc;

    par_prob_pestrat=0.5
        var_pe05=p310selestrat(var_pif,par_prob_pestrat,par_anos_base);
        disp(' ');disp(['Rep.' num2str(rep) ': 10-Lista de periódicos "estratégicos p=0.5" gerada']);toc;

    par_prob_pestrat=0.9
        var_pe09=p310selestrat(var_pif,par_prob_pestrat,par_anos_base);
        disp(' ');disp(['Rep.' num2str(rep) ': 10-Lista de periódicos "estratégicos p=0.9" gerada']);toc;


% (11) Salva ambiente com variáveis após ciclos estratégicos
    save([file_amb1 num2str(rep)]);
    disp(' ');disp(['Rep.' num2str(rep) ': 11-Ambiente ' [file_amb1 num2str(rep)]  ' salvo']);toc;
    clear var*;
    disp(['Fim da repetição ' num2str(rep)]);toc;

end   %END do loop de repetições
