%Gera os arquivos dos per�odos ESTRATEGICO e P�S-ESTRAT�GICO

for rep=1:par_repeticoes   %In�cio do loop de repeti��es das rodadas

tic;               %dispara o cron�metro

% (1) Carrega o arquivo com as vari�veis BASE
    load([file_amb_base '.mat'] ,'var*');  %carrega apenas as vari�veis do ambiente BASE
    disp(' ');disp(['Rep.' num2str(rep) ': 1-Arquivo BASE carregado para iniciar a simula��o']);toc;

% (2) seleciona lista de peri�dicos "estrat�gicos" dentre as que foram geradas no �ltimo ano BASE
%  A lista a ser usada depende do par�metro "par_prob_pestrat"
    if par_prob_pestrat == 0.2
        var_pe = var_pe02;
    elseif par_prob_pestrat == 0.5
        var_pe = var_pe05;
    elseif par_prob_pestrat == 0.9
        var_pe = var_pe09;
    end
    disp(' ');disp(['Rep.' num2str(rep) ': 2-Lista de peri�dicos "estrat�gicos" selecionada']);toc;

% (3) Loop dos per�odos "estrat�gicos"
for par_ano=(par_anos_base+1):par_anos_estr
    
    for par_mes=[3,4,6,8,9,12]; %m�s de publica��o dos artigos
                                %s� ocorrem publica��es nesses meses
                                
        par_ult=var_a(end,2);       %c�digo do �ltimo artigo gerado no per�odo anterior
	
        % (3.1) gera a lista de artigos publicados no ano (mesma fun��o usada nos per�odos "sem estrat�gia"
            var_an=p350geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (3.2) separa os artigos DO ANO publicados pelos peri�dicos "normais" dos "estrat�gicos"
            [var_an_norm,var_an_estrat]=p355separaartan(var_an,var_pe,par_prob_aestrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.2-Artigos DO ANO dos peri�dicos "normais" e "estrat�gicos" do ano ' num2str(par_ano) ' separados' ]);toc;

        % (3.3) separa os artigos EXISTENTES publicados pelos peri�dicos "normais" dos "estrat�gicos"
            [var_a_estrat]=p356separaart(var_a,var_pe);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.3-Artigos EXISTENTES dos peri�dicos "normais" e "estrat�gicos" do ano ' num2str(par_ano) ' separados' ]);toc;

        % (3.4) gera a lista de cita��es entre os artigos dos peri�dicos NORMAIS publicados e os existentes
            var_citn_norm=p361geracitano_nNEW(var_a,var_an_norm);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.4-Geradas cita��es NORMAIS dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.5) gera a lista de cita��es entre os artigos dos peri�dicos ESTRAT�GICOS publicados e os existentes
            var_citn_estrat=p362geracitano_eNEW(var_a,var_a_estrat,var_an_estrat,par_prob_cestrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.5-Geradas cita��es ESTRAT�GICAS dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.6) anexa as listas NORMAIS do per�odo �s listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p370juntaart(var_a,var_an_norm,var_cit,var_citn_norm);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.6-Listas NORMAIS de artigos e cita��es do ano ' num2str(par_ano) ' anexadas �s anteriores' ]);toc;

        % (3.7) anexa as listas ESTRAT�GICAS do per�odo �s listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p370juntaart(var_a,var_an_estrat,var_cit,var_citn_estrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.7-Listas ESTRAT�GICAS de artigos e cita��es do ano ' num2str(par_ano) ' anexadas �s anteriores' ]);toc;

        % (3.8) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.8-Atualizadas informa��es dos artigos do ano ' num2str(par_ano)]);toc;

        % (3.9) sumariza as cita��es entre peri�dicos no ano
            var_citpern=p383sumcitper(var_citn_norm,var_citn_estrat);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.9-Cita��es entre peri�dicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (3.10) anexa as cita��es entre peri�dicos no ano �s cita��es entre peri�dicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern); 
            disp(' ');disp(['Rep.' num2str(rep) ': 3.10-Cita��es entre peri�dicos atualizadas com as cita��es no ano ' num2str(par_ano)]);toc;

        % (3.11) atualiza as informa��es dos peri�dicos (grau, artigos e fitness m�dio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 3.11-Arquivos com informa��es dos peri�dicos atualizados para o ano ' num2str(par_ano)]);toc;

    end
end
% (4) Fim dos per�odos "estrat�gicos"
    disp(' ');disp(['Rep.' num2str(rep) ': 4-Fim dos per�odos "estrat�gicos"']);toc;

% (5) Loop de per�odos p�s ciclo estrat�gico
for par_ano=(par_anos_estr+1):(par_anos_estr+10)
    
    for par_mes=[3,4,6,8,9,12]; %m�s de publica��o dos artigos
                                %s� ocorrem publica��es nesses meses
                                
        par_ult=var_a(end,2);       %c�digo do �ltimo artigo gerado no per�odo anterior
	
        % (5.1) gera a lista de artigos publicados no ano
            var_an=p050geraartano(var_p,par_ano,par_ncit,par_ult,par_mes);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.1-Gerados artigos do ano ' num2str(par_ano)]);toc;

        % (5.2) gera a lista de cita��es entre os artigos publicados e os existentes
            var_citn=p060geracitanoNEW(var_a,var_an);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.2-Geradas cita��es dos artigos do ano ' num2str(par_ano)]);toc;

        % (5.3) anexa as listas do per�odo �s listas existentes e atualiza o fitness acumulado
            [var_a,var_cit]=p070juntaart(var_a,var_an,var_cit,var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.3-Listas de artigos e cita��es do ano ' num2str(par_ano) ' anexadas �s anteriores' ]);toc;

        % (5.4) atualiza o grau de entrada, o fitness ponderado e o fitness ponderado acumulado dos artigos
            var_a=p040grauentart(var_a,var_cit,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.4-Atualizadas informa��es dos artigos do ano ' num2str(par_ano)]);toc;

        % (5.5) sumariza as cita��es entre peri�dicos no ano
            var_citpern=p083sumcitper(var_citn);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.5-Cita��es entre peri�dicos no ano ' num2str(par_ano) ' sumarizadas']);toc;

        % (5.6) anexa as cita��es entre peri�dicos no ano �s cita��es entre peri�dicos existentes
            var_citper=p086juntacitper(var_citper,var_citpern);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.6-Cita��es entre peri�dicos atualizadas com as cita��es no ano ' num2str(par_ano)]);toc;

        % (5.7) atualiza as informa��es dos peri�dicos (grau, artigos e fitness m�dio)
            [var_pgrau,var_parts,var_pfit,var_pif]=p090atulinfoper(var_pgrau,var_parts,var_pfit,var_pif,var_citper,var_a,par_ano);
            disp(' ');disp(['Rep.' num2str(rep) ': 5.7-Arquivos com informa��es dos peri�dicos atualizados para o ano ' num2str(par_ano)]);toc;

    end
end

% (6) Fim dos per�odos p�s ciclo estrat�gico - Estra��o das informa��es gerais

    [sai_tot, sai_2an, sai_5an,sai_dp_tot, sai_dp_2an, sai_dp_5an]=p900extrai_mdp(var_pif,var_pgrau,var_pe);
    par_anos_extrai=[par_anos_base par_anos_estr (par_anos_estr+par_anos_apos)];
    [sai_rec]=p211calcrecip(var_p, var_pe, var_citper,par_anos_extrai);

    save([file_amb_save num2str(rep)]);
    disp(' ');disp(['Rep.' num2str(rep) ': 6-Informa��es gerais extra�das; ambiente final salvo']);
    disp(['Fim da repeti��o ' num2str(rep)]);toc;
    clear var*;

end   %END do loop de repeti��es
