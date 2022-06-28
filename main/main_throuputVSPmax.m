%%
clear all;
%% Initialize System Parameters
systemParams; %
%%
theta1 = 0.8;
theta2 = 0.8;

PmaxdB = 0:2.5:45;
tic;
for iPmax = 1:length(PmaxdB)
    Pmax = db2pow(PmaxdB(iPmax));
    
    PC1 = theta1*Pmax;
    PE1 = (1-theta1)*Pmax;
    
    PC2 = theta2*Pmax;
    PU2 = (1-theta2)*Pmax;
    %
    e0 = R_F_xC1(PC1) > R_th_C;
    e1 = hCU2 > hEU2;
    e2 = R_ADMUC_U_xC1(PC1,PE1) > R_th_C;
    e3 = R_ADMUC_U_xE(PC1,PE1) > R_th_E;
    e4 = hCU2 < hEU2;
    e5 = R_ADMUE_U_xE(PC1,PE1) > R_th_E;

    e6 = hCF2 > hUF2;
    e7 = R_ADMFC_F_xC2(PC2,PU2) > R_th_C;
    e8 = R_ADMFC_F_hxE(PC2,PU2) > R_th_E;
    e9 = hCF2 < hUF2;
    e10= R_ADMFE_F_hxE(PC2,PU2) > R_th_E;
    e11= R_ADMFE_F_xC2(PC2,PU2) > R_th_C;

    e12= R_F_xC2(PC2) > R_th_C;
    %% Simulation
    % Theorem 1:
    OP_U_xE = mean(((~e2)|(~e3))&(e1)) + mean((~e5)&(e4));
    OP_U2F_hXE = mean(((~e7)|(~e8))&(e6)) + mean((~e10)&(e9));
    OP_hxE_SIM(iPmax) = 1 - (1-OP_U_xE) * (1-OP_U2F_hXE);
    % Theorem 2:
    OP_UC2F_xC2 = mean((~e7)&(e6))+mean(((~e10)|(~e11))&(e9));
    OP_C2F_xC2 = mean(~e12);
    OP_xC2_SIM(iPmax) = (1-OP_U_xE)*OP_UC2F_xC2 + OP_U_xE*OP_C2F_xC2;
    % Theorem 3:
    OP_xC1_SIM(iPmax) = 1 - mean(e0);
end
toc;

tic;
for iPmax = 1:length(PmaxdB)
    Pmax = db2pow(PmaxdB(iPmax));
    
    PC1 = theta1*Pmax;
    PE1 = (1-theta1)*Pmax;
    
    PC2 = theta1*Pmax;
    PU2 = (1-theta1)*Pmax;
    %
    %% Analytical
    tau_th_C = 2^(2*R_th_C)-1;
    tau_th_E = 2^(2*R_th_E)-1;
    
    a1 = tau_th_C/(PC1/noisePow);
    a2 = tau_th_E/(PE1/noisePow);
    alp1= (PE1/noisePow)*a1;
    alp2= (PC1/noisePow)*a2;
    A1 = a1/(1-alp1);
    A2 = a2/(1-alp2);
    A = (A1-a2)/alp2;
    
    % ======================== P1 ========================
    K0  = 1;
    chi0= [pCU 1-pCU]; mu0 = [mCU 1];
    Omg0= (waveLen/(4*pi*dCU))^2./[mCU*etaLoS etaNLoS];
    
    K1  = 1;
    chi1= [pEU 1-pEU]; mu1 = [mEU 1];
    Omg1= (waveLen/(4*pi*dEU))^2./[mEU*etaLoS etaNLoS];
    
    K2  = 1; V2 = ones(1,K2+1);
    chi2= [1/2 1/2]; mu2 = [1 1];
    Omg2= xi*LCU*V2;
    
    P1 = EqP1(K0,chi0,Omg0,mu0,...
         K1,chi1,Omg1,mu1,...
         K2,chi2,Omg2,mu2,...
         a1,a2,alp1,alp2,A1,A2,A);
    % ======================== P2 ========================
    K0  = 1;
    chi0= [pEU 1-pEU]; mu0 = [mEU 1];
    Omg0= (waveLen/(4*pi*dEU))^2./[mEU*etaLoS etaNLoS];
    
    K1  = 1;
    chi1= [pCU 1-pCU]; mu1 = [mCU 1];
    Omg1= (waveLen/(4*pi*dCU))^2./[mCU*etaLoS etaNLoS];
    
    P2 = EqP2(K0,chi0,Omg0,mu0,...
         K1,chi1,Omg1,mu1,...
         a2,alp2,A2);
    %% ======================== P3 ========================
    b1 = tau_th_C/(PC2/noisePow);
    b2 = tau_th_E/(PU2/noisePow);
    bet1= (PU2/noisePow)*b1;
    bet2= (PC2/noisePow)*b2;
    B1 = b1/(1-bet1);
    B2 = b2/(1-bet2);
    B = (B1-b2)/bet2; 
    hat_B= (B2-b1)/bet1; 
    
    a1= b1; A1= B1; alp1 = bet1;
    a2= b2; A2= B2; alp2 = bet2; A = B;

    alp = 1/(2*bCF)*(2*bCF*mCF/(2*bCF*mCF+OmgCF))^mCF;
    bet = 1/(2*bCF);
    del = OmgCF/(2*bCF*(2*bCF*mCF+OmgCF));
    zet = @(l) (-1).^l .* pochhammer(1-mCF,l) ./ factorial(l) .* del.^l;

    K0  = mCF-1; V0 = ones(1,K0);
    chi0= alp*[zet(1:K0)./(bet-del).^(2:mCF) 1/(bet-del)];
    Omg0= [LCF/(bet-del)*V0 LCF/(bet-del)];
    mu0 = [(2:mCF) 1];
    
    K1  = 1;
    chi1= [pUF 1-pUF]; mu1 = [mUF 1];
    Omg1= (waveLen/(4*pi*dUF))^2./[mUF*etaLoS etaNLoS];
    
    K2  = 1;
    chi2= [1/2 1/2];
    Omg2= [xi*LCF xi*LCF];
    mu2 = [1 1];
    
    P3 = EqP1(K0,chi0,Omg0,mu0,...
         K1,chi1,Omg1,mu1,...
         K2,chi2,Omg2,mu2,...
         a1,a2,alp1,alp2,A1,A2,A);
    % ======================== P4 ========================
    K0  = 1;
    chi0= [pUF 1-pUF]; mu0 = [mUF 1];
    Omg0= (waveLen/(4*pi*dUF))^2./[mUF*etaLoS etaNLoS];
    
    K1  = mCF-1; V1 = ones(1,K1);
    chi1= alp*[zet(1:K1)./(bet-del).^(2:mCF) 1/(bet-del)];
    Omg1= [LCF/(bet-del)*V1 LCF/(bet-del)];
    mu1 = [(2:mCF) 1];
    
    P4 = EqP2(K0,chi0,Omg0,mu0,...
         K1,chi1,Omg1,mu1,...
         a2,alp2,A2);
    %
    OP_hxE_ANA(iPmax) = 1 - (P1+P2)*(P3+P4);
    %% ======================== P5 ========================
    K0  = 1;
    chi0= [pUF 1-pUF]; mu0 = [mUF 1];
    Omg0= (waveLen/(4*pi*dUF))^2./[mUF*etaLoS etaNLoS];
    
    K1  = mCF-1; V1 = ones(1,K1);
    chi1= alp*[zet(1:K1)./(bet-del).^(2:mCF) 1/(bet-del)];
    Omg1= [LCF/(bet-del)*V1 LCF/(bet-del)];
    mu1 = [(2:mCF) 1];
    
    K2  = 1; V2 = ones(1,K2+1);
    chi2= [1/2 1/2]; mu2 = [1 1];
    Omg2= xi*LUF*V2;
    
    a1 = b2; alp1 = bet2; A1 = B2;
    a2 = b1; alp2 = bet1; A2 = B1; A = hat_B;
    
    P5 = EqP1(K0,chi0,Omg0,mu0,...
         K1,chi1,Omg1,mu1,...
         K2,chi2,Omg2,mu2,...
         a1,a2,alp1,alp2,A1,A2,A);
    % ======================== P6 ========================
    K0  = mCF-1; V0 = ones(1,K0);
    chi0= alp*[zet(1:K0)./(bet-del).^(2:mCF) 1/(bet-del)];
    Omg0= [LCF/(bet-del)*V0 LCF/(bet-del)];
    mu0 = [(2:mCF) 1];
     
	K1  = 1;
    chi1= [pUF 1-pUF]; mu1 = [mUF 1];
    Omg1= (waveLen/(4*pi*dUF))^2./[mUF*etaLoS etaNLoS];
    
    P6 = EqP2(K0,chi0,Omg0,mu0,...
         K1,chi1,Omg1,mu1,...
         a2,alp2,A2);
    % ======================== P7 ========================
    K0  = mCF-1; V0 = ones(1,K0);
    chi0= alp*[zet(1:K0)./(bet-del).^(2:mCF) 1/(bet-del)];
    Omg0= [LCF/(bet-del)*V0 LCF/(bet-del)];
    mu0 = [(2:mCF) 1];

    P7 = 0;
    for k = 1:(K0+1)
        P7 = P7 + chi0(k) * gammainc( b1/Omg0(k),mu0(k),'upper' );
    end
    
    OP_xC2_ANA(iPmax) = (P1+P2)*(1-P5-P6)+(1-P1-P2)*(1-P7);
    % ======================== P8 ========================
    a1 = tau_th_C/(PC1/noisePow);
    P8 = 0;
    for k = 1:(K0+1)
        P8 = P8 + chi0(k) * gammainc( a1/Omg0(k),mu0(k),'upper' );
    end
    P8 = 1-P8;
    
    OP_xC1_ANA(iPmax) = P8;
end
toc;
%
Throughput_SIM = R_th_E/2*( 1-OP_hxE_SIM ) + R_th_C/2*( 1-OP_xC2_SIM ) + R_th_C/2*( 1-OP_xC1_SIM );
Throughput_ANA = R_th_E/2*( 1-OP_hxE_ANA ) + R_th_C/2*( 1-OP_xC2_ANA ) + R_th_C/2*( 1-OP_xC1_ANA );
%
%
blue1=[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
purple1=[0.4940, 0.1840, 0.5560];
green1=[0.4660, 0.6740, 0.1880];
cyan1=[0.3010, 0.7450, 0.9330];
red1=[0.6350, 0.0780, 0.1840];

color_sky = [173 235 255]/255;

% save('OP_hxE_SIM_RC05_RE025.mat','OP_hxE_SIM');
% save('OP_hxE_ANA_RC05_RE025.mat','OP_hxE_ANA');
% save('OP_xC1_SIM_RC05_RE025.mat','OP_xC1_SIM');
% save('OP_xC1_ANA_RC05_RE025.mat','OP_xC1_ANA');
% save('OP_xC2_SIM_RC05_RE025.mat','OP_xC2_SIM');
% save('OP_xC2_ANA_RC05_RE025.mat','OP_xC2_ANA');

figure(1);
semilogy(PmaxdB,OP_hxE_SIM,'o','color','b','linewidth',1,'markersize',7,...
    'markerfacecolor',color_sky); hold on;
semilogy(PmaxdB,OP_hxE_ANA,'-','color','m','linewidth',1); hold on;

semilogy(PmaxdB,OP_xC1_SIM,'v','color','m','linewidth',1,'markersize',7,...
    'markerfacecolor',color_sky); hold on;
semilogy(PmaxdB,OP_xC1_ANA,'-','color','b','linewidth',1); hold on;

semilogy(PmaxdB,OP_xC2_SIM,'s','color','b','linewidth',1,'markersize',8,...
    'markerfacecolor',color_sky); hold on;
semilogy(PmaxdB,OP_xC2_ANA,'-','color','g','linewidth',1); hold on;
axis([min(PmaxdB) max(PmaxdB) 10^(-3.5) 1]);

grid on;
xlabel('P_{max} [dBm]');
ylabel('Outage Probability');
legend('Ana, $x_{\mathsf{E}}(t_1)$','Sim, $x_{\mathsf{E}}(t_1)$',...
       'Ana, $x_{\mathsf{C}}(t_1)$','Sim, $x_{\mathsf{C}}(t_1)$',...
       'Ana, $x_{\mathsf{C}}(t_2)$','Sim, $x_{\mathsf{C}}(t_2)$','Interpreter','LaTex');
set(gca,'Fontsize',12);
set(gcf,'Position',[100 100 500 400]);
set(gca,'LooseInset',get(gca,'TightInset'));
%
figure(2);
semilogy(PmaxdB,Throughput_SIM,'o'); hold on;
semilogy(PmaxdB,Throughput_ANA,'-'); hold on;