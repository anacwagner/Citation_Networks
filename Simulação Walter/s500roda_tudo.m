% % -------------------------------------------
% %  --------------- Rodada BASE ---------------
% % -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
   sp00;
%Parâmetros para nomes dos arquivos
   rodada='BASE';
   file_amb1=['amb_Carol_' num2str(par_anos_base) '_' rodada '_'];  %arquivo com o ambiente ao final das rodadas BASE
% Chama a rodada BASE
   s501roda_BASE
   clear

% -------------------------------------------
% -------------- Rodada NORMAL --------------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='1';   %proporção de artigos estratégicos
    par_prop_cit='1';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='BASE';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas NORMAIS
% Chama a rodada NORMAL
    s510roda_NORMAL;
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='1';   %proporção de artigos estratégicos
    par_prop_cit='1';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='1';   %proporção de artigos estratégicos
    par_prop_cit='5';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='1';   %proporção de artigos estratégicos
    par_prop_cit='9';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='5';   %proporção de artigos estratégicos
    par_prop_cit='1';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='5';   %proporção de artigos estratégicos
    par_prop_cit='5';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='5';   %proporção de artigos estratégicos
    par_prop_cit='9';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='9';   %proporção de artigos estratégicos
    par_prop_cit='1';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='9';   %proporção de artigos estratégicos
    par_prop_cit='5';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRATÉGICA -----------
% -------------------------------------------

%Parâmetros gerais da simulação, controle de anos e de repetiçoes
    sp00;
%Parâmetros de proporções de periódicos/artigos/citações
    par_prop_per='2';   %proporção de periódicos estratégicos
    par_prop_art='9';   %proporção de artigos estratégicos
    par_prop_cit='9';   %proporção de citaçoes estratégicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de parâmetros
    eval(['s' rodada]); %chama script com parâmetros de proporção estratégica
%Parâmetros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informações iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRATÉGICAS
% Chama a rodada ESTRATÉGICA
    s510roda_ESTRAT
    clear

