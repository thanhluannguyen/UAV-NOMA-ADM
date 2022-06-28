trials = 1e6;
%% General Characteristics
GCdB = 0; % dBi
GFdB = 0; % dBi
fc = 3; % GHz - carrier frequency
waveLen = physconst('LightSpeed')/(fc*10^9);
%
etaLoSdB =1.6; etaLoS = db2pow(etaLoSdB);
etaNLoSdB= 23; etaNLoS= db2pow(etaNLoSdB);
%
NPB = -144; % dBm/Hz
BW = 20*10^6; % MHz
noisePow = 10^(NPB/10)*BW; % mW
%%
% theta1 = 0.8;
% theta2 = 0.8;
R_th_C = 1.0;
R_th_E = 0.05;
% R_th_C = 0.5;
% R_th_E = 0.025;
%% 3D location of nodes
 % network area
L = 25;
% the FC is located as the origin
XF = 0; YF = 0; ZF = 0; 
% the UE-C
XC = -1.957;
YC = 7.3266;
% XC = (L/2)*sqrt(rand)*cos(rand*2*pi); 
% YC = (L/2)*sqrt(rand)*sin(rand*2*pi); 
ZC = 0;
% the UE-E
XE_0 = -13.4888;
YE_0 = -18.8525;
ZE_0 = 0.2338;

XE = XE_0;
YE = YE_0;
ZE = ZE_0;

% % the UAV 3D Cartesian Coordinates
XU_0 = -6.6561;
YU_0 = -7.6165;
ZU_0 = 6.7750;
XU = XU_0;
YU = YU_0;
ZU = ZU_0; % 1 pU 9 15

% XU_0 = cell2mat(struct2cell(load('XU.mat')));
% YU_0 = cell2mat(struct2cell(load('YU.mat')));
% ZU_0 = cell2mat(struct2cell(load('ZU.mat')));
% XU = XU_0(iter);
% YU = YU_0(iter);
% ZU = ZU_0(iter);

% 
% XU_0 = -6.6561;
% YU_0 = -7.6165;
% ZU_0 = 6.7750;
% 
% Theta = linspace(0,2*pi,N);
% RU = sqrt(XE_0^2 + YE_0^2)/2;
% XU = XU_0 + RU*cos(Theta(iter));
% YU = YU_0 + RU*sin(Theta(iter));
% ZU = ZU_0;
%%
% blue1=[0, 0.4470, 0.7410];
% orange1=[0.8500, 0.3250, 0.0980];
% yellow1=[0.9290, 0.6940, 0.1250];
% green1=[0.4660, 0.6740, 0.1880];
% 
% figure;
% plot3(XF,YF,ZF,'o','markerfacecolor',blue1); hold on;
% plot3(XE,YE,ZE,'v','markerfacecolor',orange1); hold on;
% plot3(XC,YC,ZC,'s','markerfacecolor',yellow1); hold on;
% plot3(XU,YU,ZU,'^','markerfacecolor',green1); hold on;
% 
% xlabel('$x$ [m]','Interpreter','Latex');
% ylabel('$y$ [m]','Interpreter','Latex');
% zlabel('$z$ [m]','Interpreter','Latex');
% legend('FC','UE-E','UE-C','UAV','Location','Best');
% grid on;
% axis equal;
% set(gcf,'Position',[100 100 400 300]);

%% Large-Scale Fading
% ------------- The G2G channel from CU-C to FC ------------- 
dCF = sqrt( (XC-XF)^2+(YC-YF)^2+(ZC-ZF)^2 );
LCF = db2pow( GCdB+GFdB-22.7-26*log10(fc)-36.7*log10(dCF) );
% ------------- The G2A channels from CU-C to UAV ------------- 
dCU = sqrt( (XC-XU)^2+(YC-YU)^2+(ZC-ZU)^2 );
phiCU = 180/pi*asin( abs(ZC-ZU)/dCU );
pCU = 1/(1+12.08*exp(-0.11*(phiCU-12.08)));
LCULoS = (waveLen/(4*pi*dCU))^2/etaLoS;
LCUNLoS= (waveLen/(4*pi*dCU))^2/etaNLoS;
BCU = rand(1,trials) < pCU;
LCU = LCULoS .*pCU + LCUNLoS.*(1-pCU);
% ------------- The G2A channels from CU-E to UAV ------------- 
dEU = sqrt( (XE-XU)^2+(YE-YU)^2+(ZE-ZU)^2 );
phiEU = 180/pi*asin( abs(ZE-ZU)/dEU );
pEU = 1/(1+12.08*exp(-0.11*(phiEU-12.08)));
LEULoS = (waveLen/(4*pi*dEU))^2/etaLoS;
LEUNLoS= (waveLen/(4*pi*dEU))^2/etaNLoS;
BEU = rand(1,trials) < pEU;
LEU = LEULoS .*pEU + LEUNLoS.*(1-pEU);
% ------------- The G2A channels from UAV to FC ------------- 
dUF = sqrt( (XF-XU)^2+(YF-YU)^2+(ZF-ZU)^2 );
phiUF = 180/pi*asin( abs(ZF-ZU)/dUF );
pUF = 1/(1+12.08*exp(-0.11*(phiUF-12.08)));
LUFLoS = (waveLen/(4*pi*dUF))^2/etaLoS;
LUFNLoS= (waveLen/(4*pi*dUF))^2/etaNLoS;
BUF = rand(1,trials) < pUF;
LUF = LUFLoS .*pUF + LUFNLoS.*(1-pUF);
%% Small-Scale Fading
% ------------- The G2G channel from CU-C to FC ------------- 
mCF = 5; OmgCF = 0.279; bCF = 0.251;
Z = random('Nakagami',mCF,OmgCF,[1,trials]);
gCF = random('Rician',Z,sqrt(bCF),[1,trials]);
hCF2= gCF.^2 .* LCF; 
% ------------- The G2A channels from CU-C to UAV ------------- 
mCU = 3;
gCULoS = sqrt(gamrnd(mCU,1/mCU,[1,trials]));
gCUNLoS= sqrt(exprnd(1,[1,trials]));
hCU2= gCULoS.^2 .* LCULoS .*(BCU)...
    + gCUNLoS.^2.* LCUNLoS.*(1-BCU);
% ------------- The G2A channels from CU-E to UAV -------------
mEU = 1;
gEULoS = sqrt(gamrnd(mEU,1/mEU,[1,trials]));
gEUNLoS= sqrt(exprnd(1,[1,trials]));
hEU2= gEULoS.^2 .* LEULoS .*(BEU)...
    + gEUNLoS.^2.* LEUNLoS.*(1-BEU);
% ------------- The G2A channels from UAV to FC ------------- 
mUF = 5;
gUFLoS = sqrt(gamrnd(mUF,1/mUF,[1,trials]));
gUFNLoS= sqrt(exprnd(1,[1,trials]));
hUF2= gUFLoS.^2 .* LUFLoS .*(BUF)...
    + gUFNLoS.^2.* LUFNLoS.*(1-BUF);
%% Residual Interference Normalized Power
xi = db2pow(-10);
% xi = db2pow(-30);
thCU2 = exprnd(xi,[1,trials]).*LCU;
thCF2 = exprnd(xi,[1,trials]).*LCF;
thUF2 = exprnd(xi,[1,trials]).*LUF;
%% Achievable Rates
R_F_xC1 = @(PC) (1/2)*log2( 1+PC*hCF2/noisePow );
R_ADMUC_U_xC1= @(PC,PE) (1/2)*log2( 1+(PC*hCU2)./(PE*hEU2+noisePow) );
R_ADMUC_U_xE = @(PC,PE) (1/2)*log2( 1+(PE*hEU2)./(PC*thCU2+noisePow) );
R_ADMUE_U_xE = @(PC,PE) (1/2)*log2( 1+(PE*hEU2)./(PC*hCU2+noisePow) );

R_ADMFC_F_xC2= @(PC,PU) (1/2)*log2( 1+(PC*hCF2)./(PU*hUF2+noisePow) );
R_ADMFC_F_hxE= @(PC,PU) (1/2)*log2( 1+(PU*hUF2)./(PC*thCF2+noisePow) );
R_ADMFE_F_hxE= @(PC,PU) (1/2)*log2( 1+(PU*hUF2)./(PC*hCF2+noisePow) );
R_ADMFE_F_xC2= @(PC,PU) (1/2)*log2( 1+(PC*hCF2)./(PU*thUF2+noisePow) );

R_F_xC2 = @(PC) (1/2)*log2( 1+PC*hCF2/noisePow );
% %% The Decoding Events
% e0 = @(PC) R_F_xC1(PC) > R_th_C;
% e1 = hCU2 > hEU2;
% e2 = @(PC,PE) R_ADMUC_U_xC2(PC,PE) > R_th_C;
% e3 = @(PC,PE) R_ADMUC_U_xE(PC,PE) > R_th_E;
% 
% e4 = hCU2 < hEU2;
% e5 = @(PC,PE) R_ADMUE_U_xE(PC,PE)  > R_th_E;
% 
% e6 = hCF2 > hUF2;
% e7 = @(PC,PU) R_ADMFC_F_xC2(PC,PU) > R_th_C;
% e8 = @(PC,PU) R_ADMFC_F_hxE(PC,PU) > R_th_E;
% 
% e9 = hCF2 < hUF2;
% e10= @(PC,PU) R_ADMFE_F_hxE(PC,PU) > R_th_E;
% e11= @(PC,PU) R_ADMFE_F_xC2(PC,PU) > R_th_C;
% 
% e12= @(PC) R_F_xC2(PC) > R_th_C;