% % -------------------------------------------
% %  --------------- Rodada BASE ---------------
% % -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
   sp00;
%Par�metros para nomes dos arquivos
   rodada='BASE';
   file_amb1=['amb_Carol_' num2str(par_anos_base) '_' rodada '_'];  %arquivo com o ambiente ao final das rodadas BASE
% Chama a rodada BASE
   s501roda_BASE
   clear

% -------------------------------------------
% -------------- Rodada NORMAL --------------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='1';   %propor��o de artigos estrat�gicos
    par_prop_cit='1';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='BASE';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas NORMAIS
% Chama a rodada NORMAL
    s510roda_NORMAL;
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='1';   %propor��o de artigos estrat�gicos
    par_prop_cit='1';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='1';   %propor��o de artigos estrat�gicos
    par_prop_cit='5';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='1';   %propor��o de artigos estrat�gicos
    par_prop_cit='9';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='5';   %propor��o de artigos estrat�gicos
    par_prop_cit='1';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='5';   %propor��o de artigos estrat�gicos
    par_prop_cit='5';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='5';   %propor��o de artigos estrat�gicos
    par_prop_cit='9';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='9';   %propor��o de artigos estrat�gicos
    par_prop_cit='1';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='9';   %propor��o de artigos estrat�gicos
    par_prop_cit='5';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

% -------------------------------------------
% ------------ Rodada ESTRAT�GICA -----------
% -------------------------------------------

%Par�metros gerais da simula��o, controle de anos e de repeti�oes
    sp00;
%Par�metros de propor��es de peri�dicos/artigos/cita��es
    par_prop_per='2';   %propor��o de peri�dicos estrat�gicos
    par_prop_art='9';   %propor��o de artigos estrat�gicos
    par_prop_cit='9';   %propor��o de cita�oes estrat�gicas
    rodada=['p0' par_prop_per 'a0' par_prop_art 'c0' par_prop_cit]; %serve para nome do arquivo e script de par�metros
    eval(['s' rodada]); %chama script com par�metros de propor��o estrat�gica
%Par�metros para nomes dos arquivos
    tipo='ESTR';
    maq='VM167';
    base=1;      %arquivo BASE usado
%Arquivos do ambiente
    file_amb_base=['amb_Carol_' num2str(par_anos_base) '_BASE_' num2str(base)];                             %arquivo BASE com informa��es iniciais
    file_amb_save=['amb_Carol_' num2str(par_anos_base) '_B' num2str(base) '_' tipo '_' rodada '_' maq '_']; %arquivo com o ambiente ao final das rodadas ESTRAT�GICAS
% Chama a rodada ESTRAT�GICA
    s510roda_ESTRAT
    clear

