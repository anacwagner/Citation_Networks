%Gera os arquivos dos per�odos NORMAIS que servem de base de compara��o com o comportamento estrat�gico

for rep=1:par_repeticoes   %In�cio do loop de repeti��es das rodadas

tic;               %dispara o cron�metro

% (1) Carrega o arquivo com as vari�veis BASE
    load([file_amb_base '.mat'] ,'var*');  %carrega apenas as vari�veis do ambiente BASE
    disp(' ');disp(['Rep.' num2str(rep) ': 1-Arquivo BASE carregado para iniciar a simula��o']);toc;

% (3) Loop de per�odos "normais", sem comportamento estrat�gico, para compara��o
for par_ano=(par_anos_base+1):(par_anos_estr+10)
    
    for par_mes=[3,4,6,8,9,12]; %m�s de publica��o dos artigos
                                %s� ocorrem publica��es nesses meses
    
        par_ult=var_a(end,2);       %c�digo do �ltimo artigo gerado no per�odo anterior
	
        % (3.1) gera a lista de artigos publicados no ano
            var_an=p050geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (3.2) gera a lista de cita��es entre os artigos publicados e os existentes
            var_citn=p060geracitanoNEW(var_a,var_an);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.2-Geradas cita��es dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.3) anexa as listas do per�odo �s listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p070juntaart(var_a,var_an,var_cit,var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.3-Listas de artigos e cita��es do ano ' num2str(par_ano) ' anexadas �s anteriores' ]);toc;

        % (3.4) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.4-Atualizadas informa��es dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.5) sumariza as cita��es entre peri�dicos no ano
            var_citpern=p083sumcitper(var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.5-Cita��es entre peri�dicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (3.6) anexa as cita��es entre peri�dicos no ano �s cita��es entre peri�dicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.6-Cita��es entre peri�dicos atualizadas com as cita��es no ano ' num2str(par_ano)]);toc;

        % (3.7) atualiza as informa��es dos peri�dicos (grau, artigos e fitness m�dio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.7-Arquivos com informa��es dos peri�dicos atualizados para o ano ' num2str(par_ano)]);toc;
        
    end
end

% (4) Fim dos per�odos p�s ciclo estrat�gico - Estra��o das informa�oes gerais
    [sai_tot02, sai_2an02, sai_5an02,sai_dp_tot02, sai_dp_2an02, sai_dp_5an02]=p900extrai_mdp(var_pif,var_pgrau,var_pe02);
    [sai_tot05, sai_2an05, sai_5an05,sai_dp_tot05, sai_dp_2an05, sai_dp_5an05]=p900extrai_mdp(var_pif,var_pgrau,var_pe05);
    [sai_tot09, sai_2an09, sai_5an09,sai_dp_tot09, sai_dp_2an09, sai_dp_5an09]=p900extrai_mdp(var_pif,var_pgrau,var_pe09);
    par_anos_extrai=[par_anos_base par_anos_estr (par_anos_estr+par_anos_apos)];
    [sai_rec02]=p211calcrecip(var_p, var_pe02, var_citper,par_anos_extrai);
    [sai_rec05]=p211calcrecip(var_p, var_pe05, var_citper,par_anos_extrai);
    [sai_rec09]=p211calcrecip(var_p, var_pe09, var_citper,par_anos_extrai);

    save([file_amb_save num2str(rep)]);
    disp(' ');disp(['Rep.' num2str(rep) ': 4-Informa�oes gerais extra�das; ambiente final salvo']);
    disp(['Fim da repeti��o ' num2str(rep)]);toc;
    clear var*;

end   %END do loop de repeti��es
