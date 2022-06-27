
blue1=[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
purple1=[0.4940, 0.1840, 0.5560];
green1=[0.4660, 0.6740, 0.1880];
cyan1=[0.3010, 0.7450, 0.9330];
red1=[0.6350, 0.0780, 0.1840];
sky1 = [173 235 255]/255;

PmaxdB = 0:2.5:45;
inds = 1:2:length(PmaxdB);

OP_hxE_SIM_3 = cell2mat(struct2cell(load('OP_hxE_SIM_R3.mat')));
OP_hxE_ANA_3 = cell2mat(struct2cell(load('OP_hxE_ANA_R3.mat')));
OP_hxE_SIM_2 = cell2mat(struct2cell(load('OP_hxE_SIM_R2.mat')));
OP_hxE_ANA_2 = cell2mat(struct2cell(load('OP_hxE_ANA_R2.mat')));
OP_hxE_SIM_1 = cell2mat(struct2cell(load('OP_hxE_SIM_R1.mat')));
OP_hxE_ANA_1 = cell2mat(struct2cell(load('OP_hxE_ANA_R1.mat')));

OP_xC1_SIM_3 = cell2mat(struct2cell(load('OP_xC1_SIM_R3.mat')));
OP_xC1_ANA_3 = cell2mat(struct2cell(load('OP_xC1_ANA_R3.mat')));
OP_xC1_SIM_2 = cell2mat(struct2cell(load('OP_xC1_SIM_R2.mat')));
OP_xC1_ANA_2 = cell2mat(struct2cell(load('OP_xC1_ANA_R2.mat')));
OP_xC1_SIM_1 = cell2mat(struct2cell(load('OP_xC1_SIM_R1.mat')));
OP_xC1_ANA_1 = cell2mat(struct2cell(load('OP_xC1_ANA_R1.mat')));

OP_xC2_SIM_3 = cell2mat(struct2cell(load('OP_xC2_SIM_R3.mat')));
OP_xC2_ANA_3 = cell2mat(struct2cell(load('OP_xC2_ANA_R3.mat')));
OP_xC2_SIM_2 = cell2mat(struct2cell(load('OP_xC2_SIM_R2.mat')));
OP_xC2_ANA_2 = cell2mat(struct2cell(load('OP_xC2_ANA_R2.mat')));
OP_xC2_SIM_1 = cell2mat(struct2cell(load('OP_xC2_SIM_R1.mat')));
OP_xC2_ANA_1 = cell2mat(struct2cell(load('OP_xC2_ANA_R1.mat')));

figure;
ah = axes;
lgd4 = semilogy(0,0,'-k'); hold on;
lgd5 = semilogy(0,0,'--k');
lgd6 = semilogy(0,0,'-.k');

lgd7 = semilogy(0,0,'-','color',green1);
lgd8 = semilogy(0,0,'-','color',yellow1);
lgd9 = semilogy(0,0,'-','color',blue1);
%
lgd3 = semilogy(PmaxdB(inds),OP_hxE_SIM_3(inds),'>','color',green1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_hxE_ANA_3,'-','color',green1); hold on;
%
lgd2 = semilogy(PmaxdB(inds),OP_hxE_SIM_2(inds),'o','color',yellow1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_hxE_ANA_2,'-','color',yellow1); hold on;
%
lgd1 = semilogy(PmaxdB(inds),OP_hxE_SIM_1(inds),'d','color',blue1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_hxE_ANA_1,'-','color',blue1); hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
semilogy(PmaxdB(inds),OP_xC1_SIM_3(inds),'>','color',green1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_xC1_ANA_3,'--','color',green1); hold on;

semilogy(PmaxdB(inds),OP_xC1_SIM_2(inds),'o','color',yellow1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_xC1_ANA_2,'--','color',yellow1); hold on;

semilogy(PmaxdB(inds),OP_xC1_SIM_1(inds),'d','color',blue1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_xC1_ANA_1,'--','color',blue1); hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
semilogy(PmaxdB(inds),OP_xC2_SIM_3(inds),'>','color',green1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_xC2_ANA_3,'-.','color',green1); hold on;

semilogy(PmaxdB(inds),OP_xC2_SIM_2(inds),'o','color',yellow1,'markersize',5,...
    'markerfacecolor','None'); hold on;
semilogy(PmaxdB,OP_xC2_ANA_2,'-.','color',yellow1); hold on;

semilogy(PmaxdB(inds),OP_xC2_SIM_1(inds),'d','color',blue1,'markersize',5,...
    'markerfacecolor','None'); hold on;
lgd12 = semilogy(PmaxdB,OP_xC2_ANA_1,'-.','color',blue1); hold off;
%
xlabel('$P_{\max}$ [dBm]','Interpreter','LaTex');
ylabel('Outage Probability','Interpreter','LaTex');
set(gca,'Fontsize',8);

leg = legend(ah,[lgd1 lgd2 lgd3],...
       {'${\mathbf{R}_1}$ ({Sim})',...
        '${\mathbf{R}_2}$ ({Sim})',...
        '${\mathbf{R}_3}$ ({Sim})'},...
        'Interpreter','LaTex');
leg.Location= 'southwest';
set(gcf,'Position',[100 100 300 200]);
set(gca,'LooseInset',get(gca,'TightInset'));
leg.ItemTokenSize = [15,18];
axis([min(PmaxdB) 40 1e-3 1]);