%Gera os arquivos do per�odo BASE (iniciais/prepara��o)

for rep=1:par_repeticoes   %In�cio do loop de repeti��es das rodadas BASE

    tic;               %dispara o cron�metro
    par_ano=0;         %inicializa vari�vel de ano de publica��o dos artigos
    
    % (1) gera a lista de peri�dicos
        var_p=p010geraperini(par_n_periodicos,par_faixa_fitness,par_nart_ini,par_nart_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 1-Lista de peri�dicos gerada']);toc;

    % (2) gera arquivos com informa��es dos peri�dicos (grau, artigos e fitness m�dio)
        [var_pgrau,var_parts,var_pfit,var_pif]=p015geraindper(var_p);
        disp(' ');disp(['Rep.' num2str(rep) ': 2-Arquivos com informa��es dos peri�dicos gerados']);toc;
        
    % (3) gera a lista inicial de artigos dos peri�dicos (ano zero)
        var_a=p020geraartini(var_p,par_ncit);
        disp(' ');disp(['Rep.' num2str(rep) ': 3-Lista inicial de artigos gerada']);toc;
        
    % (4) gera a lista inicial de cita��es entre os artigos iniciais (ano zero)
        var_cit=p030geracitiniNEW(var_a,par_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 4-Lista inicial de cita��es entre artigos gerada']);toc;

    % (5) calcula o grau de entrada dos artigos iniciais, com base nas cita��es
        var_a=p040grauentart(var_a,var_cit,par_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 5-Grau de entrada dos artigos iniciais calculado']);toc;

    % (6) sumariza as cita��es entre peri�dicos para o ano zero
        var_citper=p083sumcitper(var_cit);
        disp(' ');disp(['Rep.' num2str(rep) ': 6-Cita��es iniciais entre peri�dicos sumarizadas']);toc;

    % (7) atualiza as informa��es dos peri�dicos (grau, artigos e fitness m�dio)
        [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
        disp(' ');disp(['Rep.' num2str(rep) ': 7-Arquivos com informa��es iniciais dos peri�dicos atualizados - fim da prepara��o']);toc;;
   
% (8) roda os per�odos BASE (base da a��o estrat�gica - ser�o usados depois)
for par_ano=1:par_anos_base
    
    for par_mes=[3,4,6,8,9,12]; %m�s de publica��o dos artigos
                                %s� ocorrem publica��es nesses meses
                               
        par_ult=var_a(end,2);       %c�digo do �ltimo artigo gerado no per�odo anterior
	
        % (8.1) gera a lista de artigos publicados no ano
            var_an=p050geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (8.2) gera a lista de cita��es entre os artigos publicados e os existentes
            var_citn=p060geracitanoNEW(var_a,var_an);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.2-Geradas cita��es dos artigos do ano ' num2str(par_ano)]);toc;

        % (8.3) anexa as listas do per�odo �s listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p070juntaart(var_a,var_an,var_cit,var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.3-Listas de artigos e cita��es do ano ' num2str(par_ano) ' anexadas �s anteriores' ]);toc;

        % (8.4) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.4-Atualizadas informa��es dos artigos do ano ' num2str(par_ano)]);toc;

        % (8.5) sumariza as cita��es entre peri�dicos no ano
            var_citpern=p083sumcitper(var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.5-Cita��es entre peri�dicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (8.6) anexa as cita��es entre peri�dicos no ano �s cita��es entre peri�dicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.6-Cita��es entre peri�dicos atualizadas com as cita��es no ano ' num2str(par_ano)]);toc;

        % (8.7) atualiza as informa��es dos peri�dicos (grau, artigos e fitness m�dio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 8.7-Arquivos com informa��es dos peri�dicos atualizados para o ano ' num2str(par_ano)]);toc;
    end
end
% (9) Fim dos per�odos BASE
    disp(' ');disp(['Rep.' num2str(rep) ': 9-Fim dos ' par_anos_base ' per�odos BASE']);toc;

% (10) gera 3 listas de peri�dicos "estrat�gicos" no �ltimo ano BASE
% Listas diferentes dependendo do par�metro "par_prob_pestrat"
    par_prob_pestrat=0.2
        var_pe02=p310selestrat(var_pif,par_prob_pestrat,par_anos_base);
        disp(' ');disp(['Rep.' num2str(rep) ': 10-Lista de peri�dicos "estrat�gicos p=0.2" gerada']);toc;

    par_prob_pestrat=0.5
        var_pe05=p310selestrat(var_pif,par_prob_pestrat,par_anos_base);
        disp(' ');disp(['Rep.' num2str(rep) ': 10-Lista de peri�dicos "estrat�gicos p=0.5" gerada']);toc;

    par_prob_pestrat=0.9
        var_pe09=p310selestrat(var_pif,par_prob_pestrat,par_anos_base);
        disp(' ');disp(['Rep.' num2str(rep) ': 10-Lista de peri�dicos "estrat�gicos p=0.9" gerada']);toc;


% (11) Salva ambiente com vari�veis ap�s ciclos estrat�gicos
    save([file_amb1 num2str(rep)]);
    disp(' ');disp(['Rep.' num2str(rep) ': 11-Ambiente ' [file_amb1 num2str(rep)]  ' salvo']);toc;
    clear var*;
    disp(['Fim da repeti��o ' num2str(rep)]);toc;

end   %END do loop de repeti��es
