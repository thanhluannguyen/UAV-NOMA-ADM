
blue1=[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
purple1=[0.4940, 0.1840, 0.5560];
green1=[0.4660, 0.6740, 0.1880];
cyan1=[0.3010, 0.7450, 0.9330];
red1=[0.6350, 0.0780, 0.1840];

OptThroughput_SIM = cell2mat(struct2cell(load('OptThroughput_SIM.mat')));
OptThroughput_nADM1_SIM = cell2mat(struct2cell(load('OptThroughput_nADM1_SIM.mat')));
OptThroughput_nADM2_SIM = cell2mat(struct2cell(load('OptThroughput_nADM2_SIM.mat')));
OptThroughput_nADM3_SIM = cell2mat(struct2cell(load('OptThroughput_nADM3_SIM.mat')));
OptThroughput_nADM4_SIM = cell2mat(struct2cell(load('OptThroughput_nADM4_SIM.mat')));

OptThroughput_AVG = cell2mat(struct2cell(load('OptThroughput_AVG.mat')));
Throughput_ADM_SIM = cell2mat(struct2cell(load('Throughput_ADM_SIM.mat')));
Throughput_ADM1_SIM = cell2mat(struct2cell(load('Throughput_ADM1_SIM.mat')));
Throughput_ADM2_SIM = cell2mat(struct2cell(load('Throughput_ADM2_SIM.mat')));
Throughput_ADM3_SIM = cell2mat(struct2cell(load('Throughput_ADM3_SIM.mat')));
Throughput_ADM4_SIM = cell2mat(struct2cell(load('Throughput_ADM4_SIM.mat')));

figure;
subplot(2,1,1);
iN = 1:3e2;

plot(iN,OptThroughput_SIM(iN),'-m','markersize',5,'LineWidth',1); hold on;
plot(iN,OptThroughput_nADM1_SIM(iN),'-g','markersize',4,'LineWidth',1); hold on;
plot(iN,OptThroughput_nADM2_SIM(iN),'-b','markersize',4,'LineWidth',1); hold on;
plot(iN,OptThroughput_nADM3_SIM(iN),'-r','markersize',4,'LineWidth',1); hold on;
plot(iN,OptThroughput_nADM4_SIM(iN),'-','Color',cyan1,'markersize',4,'LineWidth',1); hold on;
xlabel('Index');
ylabel('[bits/s/Hz]');
title('Optimal Throughput');
set(gca,'Fontsize',8);
axis([min(iN) max(iN) -Inf 1.05]);

subplot(2,1,2);
iN = 1:1e3;
plot(iN,Throughput_ADM_SIM(iN),'-m','markersize',5,'LineWidth',1); hold on;
plot(iN,Throughput_ADM1_SIM(iN),'-g','markersize',4,'LineWidth',1); hold on;
plot(iN,Throughput_ADM2_SIM(iN),'-b','markersize',4,'LineWidth',1); hold on;
plot(iN,Throughput_ADM3_SIM(iN),'-r','markersize',4,'LineWidth',1); hold on;
plot(iN,Throughput_ADM4_SIM(iN),'-','Color',cyan1,'markersize',4,'LineWidth',1); hold on;
xlabel('Index');
ylabel('[bits/s/Hz]');
title('Throughput');

leg = legend('ADM',...
             '${\mathrm{NADM}}^{\mathsf{CC}}$',...
             '$\mathrm{NADM}^{\mathsf{CE}}$',...
             '$\mathrm{NADM}^{\mathsf{EC}}$',...
             '$\mathrm{NADM}^{\mathsf{EE}}$',...
       'Interpreter','LaTex','Location','eastoutside');
leg.ItemTokenSize = [15,18];
   
set(gca,'Fontsize',8);
set(gcf,'Position',[100 100 300 300]);
set(gca,'LooseInset',get(gca,'TightInset'));
axis([min(iN) max(iN) 0.6 1.05]);