clear all;
N = 1e3;
%%
blue1  =[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
purple1=[0.4940, 0.1840, 0.5560];
green1 =[0.4660, 0.6740, 0.1880];
cyan1  =[0.3010, 0.7450, 0.9330];
red1   =[0.6350, 0.0780, 0.1840];
%%
Throughput_ADM_slowMov = struct2mat(load('Throughput_ADM_slowMov.mat'));
Throughput_NADM_CC_slowMov = struct2mat(load('Throughput_NADM_CC_slowMov.mat'));
Throughput_NADM_EC_slowMov = struct2mat(load('Throughput_NADM_EC_slowMov.mat'));
Throughput_NADM_CE_slowMov = struct2mat(load('Throughput_NADM_CE_slowMov.mat'));
Throughput_NADM_EE_slowMov = struct2mat(load('Throughput_NADM_EE_slowMov.mat'));

Throughput_ADM_fastMov = struct2mat(load('Throughput_ADM_fastMov.mat'));
Throughput_NADM_CC_fastMov = struct2mat(load('Throughput_NADM_CC_fastMov.mat'));
Throughput_NADM_EC_fastMov = struct2mat(load('Throughput_NADM_EC_fastMov.mat'));
Throughput_NADM_CE_fastMov = struct2mat(load('Throughput_NADM_CE_fastMov.mat'));
Throughput_NADM_EE_fastMov = struct2mat(load('Throughput_NADM_EE_fastMov.mat'));
%%
% ==========================================================================
figure;
plot(1:N,Throughput_ADM_fastMov,'-m','markersize',5,'LineWidth',2); hold on;
plot(1:N,Throughput_NADM_CC_fastMov,'-k','markersize',4); hold on;
plot(1:N,Throughput_NADM_EC_fastMov,'-b','markersize',4); hold on;
plot(1:N,Throughput_NADM_CE_fastMov,'-r','markersize',4); hold on;
plot(1:N,Throughput_NADM_EE_fastMov,'-c','markersize',4); hold on;

leg =legend('ADM','NADM, ${\bf d}_{\sf CC}$','NADM, ${\bf d}_{\sf EC}$',...
        'NADM, ${\bf d}_{\sf CE}$','NADM, ${\bf d}_{\sf EE}$',...
        'Location','Best','Interpreter','LaTex');
leg.ItemTokenSize = [10,5];

set(gcf,'Position',[100 100 300 300]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

xlabel('Location Index','Interpreter','LaTex');
ylabel('Throughput [bits/s/Hz]','Interpreter','LaTex');
title('Fast moving nodes');
axis([1 N 0.2 0.55]);

% ==========================================================================
figure;
plot(1:N,Throughput_ADM_slowMov,'-m','markersize',5,'LineWidth',2); hold on;
plot(1:N,Throughput_NADM_CC_slowMov,'-k','markersize',4); hold on;
plot(1:N,Throughput_NADM_EC_slowMov,'-b','markersize',4); hold on;
plot(1:N,Throughput_NADM_CE_slowMov,'-r','markersize',4); hold on;
plot(1:N,Throughput_NADM_EE_slowMov,'-c','markersize',4); hold on;

set(gcf,'Position',[100 100 300 300]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

xlabel('Location Index','Interpreter','LaTex');
ylabel('Throughput [bits/s/Hz]','Interpreter','LaTex');

leg =legend('ADM','NADM, ${\bf d}_{\sf CC}$','NADM, ${\bf d}_{\sf EC}$',...
        'NADM, ${\bf d}_{\sf CE}$','NADM, ${\bf d}_{\sf EE}$',...
        'Location','Best','Interpreter','LaTex');
title('Slow moving nodes');
leg.ItemTokenSize = [10,5];
axis([1 N 0.25 0.55]);

% ==========================================================================
t.TileSpacing = 'none';
t.Padding = 'none';