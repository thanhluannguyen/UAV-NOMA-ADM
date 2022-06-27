
blue1=[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
purple1=[0.4940, 0.1840, 0.5560];
green1=[0.4660, 0.6740, 0.1880];
cyan1=[0.3010, 0.7450, 0.9330];
red1=[0.6350, 0.0780, 0.1840];

Theta = linspace(0,2*pi,100);
min_OP_xC2_nADM = cell2mat(struct2cell(load('min_OP_xC2_nADM.mat')));
min_OP_hxE_nADM = cell2mat(struct2cell(load('min_OP_hxE_nADM.mat')));
OP_xC2_ANA = cell2mat(struct2cell(load('OP_xC2_ANA.mat')));
OP_ADM_hxE_SIM = cell2mat(struct2cell(load('OP_ADM_hxE_SIM.mat')));

figure;
subplot(1,2,1);
polarplot(Theta,-10*log10(OP_xC2_ANA),'-m','markersize',4); hold on;
polarplot(Theta,-10*log10(min_OP_xC2_nADM),'-','color',yellow1,'markersize',4); hold on;

rticklabels({'' '-10' '-20' '-30'});
   
grid on;
set(gca,'Fontsize',8);
set(gcf,'Position',[100 100 300 300]);
set(gca,'LooseInset',get(gca,'TightInset'));

subplot(1,2,2);
polarplot(Theta,-10*log10(OP_ADM_hxE_SIM),'-m','markersize',5); hold on;
polarplot(Theta,-10*log10(min_OP_hxE_nADM),'-','color',yellow1,'markersize',5); hold on;

rticklabels({'' '-1' '-2' '-3'});

leg = legend('ADM','min nADM','Location','Best','NumColumns',2);
leg.ItemTokenSize = [15,18];
   
grid on;
set(gca,'Fontsize',8);
set(gcf,'Position',[100 100 300 150]);
set(gca,'LooseInset',get(gca,'TightInset'));