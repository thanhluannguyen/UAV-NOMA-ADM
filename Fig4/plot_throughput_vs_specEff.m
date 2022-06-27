%%
blue1=[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
purple1=[0.4940, 0.1840, 0.5560];
green1=[0.4660, 0.6740, 0.1880];
cyan1=[0.3010, 0.7450, 0.9330];
red1=[0.6350, 0.0780, 0.1840];
sky1 = [173 235 255]/255;



T1_sim = cell2mat(struct2cell(load('Throughput_SIM_vs_R_1.mat')));
T1_ana = cell2mat(struct2cell(load('Throughput_ANA_vs_R_1.mat')));

T2_sim = cell2mat(struct2cell(load('Throughput_SIM_vs_R_2.mat')));
T2_ana = cell2mat(struct2cell(load('Throughput_ANA_vs_R_2.mat')));

T3_sim = cell2mat(struct2cell(load('Throughput_SIM_vs_R_3.mat')));
T3_ana = cell2mat(struct2cell(load('Throughput_ANA_vs_R_3.mat')));

T4_sim = cell2mat(struct2cell(load('Throughput_SIM_vs_R_4.mat')));
T4_ana = cell2mat(struct2cell(load('Throughput_ANA_vs_R_4.mat')));

R_spec_eff = 0:0.25:7.0;
inds = 1:2:length(T1_sim);

figure;
plot(R_spec_eff(inds),T1_sim(inds),'o','Color',blue1); hold on;
plot(R_spec_eff(inds),T2_sim(inds),'s','Color',red1); hold on;
plot(R_spec_eff(inds),T3_sim(inds),'v','Color',yellow1); hold on;
plot(R_spec_eff(inds),T4_sim(inds),'^','Color',purple1); hold on;

plot(R_spec_eff,T1_ana,'-','Color',blue1); hold on;
plot(R_spec_eff,T2_ana,'-','Color',red1); hold on;
plot(R_spec_eff,T3_ana,'-','Color',yellow1); hold on;
plot(R_spec_eff,T4_ana,'-','Color',purple1); hold on;
%
leg = legend('$Z_{\sf U} = 1$ [m] (Sim.)', '$Z_{\sf U} = 6.77$ [m] (Sim.)',...
       '$Z_{\sf U} = 9$ [m] (Sim.)', '$Z_{\sf U} = 15$ [m] (Sim.)','Interpreter','LaTex');
%
axis([-Inf Inf 0 3.1]);
set(gcf,'Position',[100 100 300 200]);
set(gca,'LooseInset',get(gca,'TightInset'));   
xlabel('$R_{\sf th,C} = \gamma R_{\sf th,E}$ [bits/s/Hz]','Interpreter','LaTex');
ylabel('Throughput [bits/s/Hz]');
leg.ItemTokenSize = [15,18];

%%
% OP_hxE_SIM_1 = cell2mat(struct2cell(load('OP_hxE_SIM_vs_R_1.mat','OP_hxE_SIM')));
% OP_hxE_ANA_1 = cell2mat(struct2cell(load('OP_hxE_ANA_vs_R_1.mat','OP_hxE_ANA')));
% OP_xC2_SIM_1 = cell2mat(struct2cell(load('OP_xC2_SIM_vs_R_1.mat','OP_xC2_SIM')));
% OP_xC2_ANA_1 = cell2mat(struct2cell(load('OP_xC2_ANA_vs_R_1.mat','OP_xC2_ANA')));
% OP_xC1_SIM_1 = cell2mat(struct2cell(load('OP_xC1_SIM_vs_R_1.mat','OP_xC1_SIM')));
% OP_xC1_ANA_1 = cell2mat(struct2cell(load('OP_xC1_ANA_vs_R_1.mat','OP_xC1_ANA')));
% 
% OP_hxE_SIM_2 = cell2mat(struct2cell(load('OP_hxE_SIM_vs_R_2.mat','OP_hxE_SIM')));
% OP_hxE_ANA_2 = cell2mat(struct2cell(load('OP_hxE_ANA_vs_R_2.mat','OP_hxE_ANA')));
% OP_xC2_SIM_2 = cell2mat(struct2cell(load('OP_xC2_SIM_vs_R_2.mat','OP_xC2_SIM')));
% OP_xC2_ANA_2 = cell2mat(struct2cell(load('OP_xC2_ANA_vs_R_2.mat','OP_xC2_ANA')));
% OP_xC1_SIM_2 = cell2mat(struct2cell(load('OP_xC1_SIM_vs_R_2.mat','OP_xC1_SIM')));
% OP_xC1_ANA_2 = cell2mat(struct2cell(load('OP_xC1_ANA_vs_R_2.mat','OP_xC1_ANA')));
% 
% OP_hxE_SIM_3 = cell2mat(struct2cell(load('OP_hxE_SIM_vs_R_3.mat','OP_hxE_SIM')));
% OP_hxE_ANA_3 = cell2mat(struct2cell(load('OP_hxE_ANA_vs_R_3.mat','OP_hxE_ANA')));
% OP_xC2_SIM_3 = cell2mat(struct2cell(load('OP_xC2_SIM_vs_R_3.mat','OP_xC2_SIM')));
% OP_xC2_ANA_3 = cell2mat(struct2cell(load('OP_xC2_ANA_vs_R_3.mat','OP_xC2_ANA')));
% OP_xC1_SIM_3 = cell2mat(struct2cell(load('OP_xC1_SIM_vs_R_3.mat','OP_xC1_SIM')));
% OP_xC1_ANA_3 = cell2mat(struct2cell(load('OP_xC1_ANA_vs_R_3.mat','OP_xC1_ANA')));
% 
% OP_hxE_SIM_4 = cell2mat(struct2cell(load('OP_hxE_SIM_vs_R_4.mat','OP_hxE_SIM')));
% OP_hxE_ANA_4 = cell2mat(struct2cell(load('OP_hxE_ANA_vs_R_4.mat','OP_hxE_ANA')));
% OP_xC2_SIM_4 = cell2mat(struct2cell(load('OP_xC2_SIM_vs_R_4.mat','OP_xC2_SIM')));
% OP_xC2_ANA_4 = cell2mat(struct2cell(load('OP_xC2_ANA_vs_R_4.mat','OP_xC2_ANA')));
% OP_xC1_SIM_4 = cell2mat(struct2cell(load('OP_xC1_SIM_vs_R_4.mat','OP_xC1_SIM')));
% OP_xC1_ANA_4 = cell2mat(struct2cell(load('OP_xC1_ANA_vs_R_4.mat','OP_xC1_ANA')));
% 
% inds = 1:2:length(R_spec_eff);
% 
% figure;
% plot(R_spec_eff(inds),1-OP_hxE_SIM_1(inds),'o','color',blue1); hold on;
% plot(R_spec_eff(inds),1-OP_xC1_SIM_1(inds),'v','color',red1); hold on;
% plot(R_spec_eff(inds),1-OP_xC2_SIM_1(inds),'s','color',yellow1); hold on;
% 
% plot(R_spec_eff,1-OP_hxE_ANA_1,'-','color',blue1); hold on;
% plot(R_spec_eff,1-OP_xC1_ANA_1,'-','color',red1); hold on;
% plot(R_spec_eff,1-OP_xC2_ANA_1,'-','color',yellow1); hold on;
% % 
% plot(R_spec_eff(inds),1-OP_hxE_SIM_2(inds),'o','color',blue1); hold on;
% plot(R_spec_eff(inds),1-OP_xC2_SIM_2(inds),'s','color',yellow1); hold on;
% 
% plot(R_spec_eff,1-OP_hxE_ANA_2,'--','color',blue1); hold on;
% plot(R_spec_eff,1-OP_xC2_ANA_2,'--','color',yellow1); hold on;
% %
% plot(R_spec_eff(inds),1-OP_hxE_SIM_3(inds),'o','color',blue1); hold on;
% plot(R_spec_eff(inds),1-OP_xC2_SIM_3(inds),'s','color',yellow1); hold on;
% 
% plot(R_spec_eff,1-OP_hxE_ANA_3,'-.','color',blue1); hold on;
% plot(R_spec_eff,1-OP_xC2_ANA_3,'-.','color',yellow1); hold on;
% %
% plot(R_spec_eff(inds),1-OP_hxE_SIM_4(inds),'o','color',blue1); hold on;
% plot(R_spec_eff(inds),1-OP_xC2_SIM_4(inds),'s','color',yellow1); hold on;
% 
% plot(R_spec_eff,1-OP_hxE_ANA_4,':','color',blue1); hold on;
% plot(R_spec_eff,1-OP_xC2_ANA_4,':','color',yellow1); hold on;
% 
% axis([-Inf Inf 0 1]);
% grid on;
% xlabel('P_{max} [dBm]');
% ylabel('Outage Probability');
% legend('Ana, $x_{\mathsf{E}}(t_1)$','Sim, $x_{\mathsf{E}}(t_1)$',...
%        'Ana, $x_{\mathsf{C}}(t_1)$','Sim, $x_{\mathsf{C}}(t_1)$',...
%        'Ana, $x_{\mathsf{C}}(t_2)$','Sim, $x_{\mathsf{C}}(t_2)$','Interpreter','LaTex');
% set(gca,'Fontsize',12);
% set(gcf,'Position',[100 100 500 400]);
% set(gca,'LooseInset',get(gca,'TightInset'));