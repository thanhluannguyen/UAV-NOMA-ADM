% the FC
XF = 0; 
YF = 0; 
ZF = 0; 

% the UE-C
XC = -1.957;
YC = 7.3266;
ZC = 0;

% the UE-E
XE_0 = -13.4888;
YE_0 = -18.8525;
ZE_0 = 0.2338;

XE = XE_0;
YE = YE_0;
ZE = ZE_0;

% the UAV 3D Cartesian Coordinates
% XU_0 = -6.6561;
% YU_0 = -7.6165;
% ZU_0 = 6.7750;
% XU = XU_0;
% YU = YU_0;
% ZU = ZU_0;

XU_0 = cell2mat(struct2cell(load('XU.mat')));
YU_0 = cell2mat(struct2cell(load('YU.mat')));
ZU_0 = cell2mat(struct2cell(load('ZU.mat')));
XU = XU_0;
YU = YU_0;
ZU = ZU_0;

blue1=[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
green1=[0.4660, 0.6740, 0.1880];
%% 
figure;
subplot(2,2,[1,2]);
plot3(XF,YF,ZF,'o','markerfacecolor',blue1); hold on;
plot3(XE,YE,ZE,'v','markerfacecolor',orange1); hold on;
plot3(XC,YC,ZC,'s','markerfacecolor',yellow1); hold on;
plot3(XU_0(1),YU_0(1),ZU_0(1),'o','markersize',5,'markerfacecolor',green1); hold on;

N = 5e2;
plot3(XU(1:N),YU(1:N),ZU(1:N),'.','markersize',3); hold on;
box on;
zlabel('$z$ [m]','Interpreter','Latex');
leg = legend('${\mathbf{p}_{\mathsf{F}}}$','${\mathbf{p}_{\mathsf{E}}}$',...
    '${\mathbf{p}_{\mathsf{C}}}$','${\mathbf{p}_{\mathsf{U}}}$',...
    '${\mathbf{p}_{\mathsf{U}}}$ (RWP)','Location','NorthWest',...
    'Interpreter','LaTex','NumColumns',2);
leg.ItemTokenSize = [10,18];
grid on;
set(gcf,'Position',[100 100 300 300]);
set(gca,'LooseInset',get(gca,'TightInset'));

subplot(2,2,3);
plot(XF,YF,'o','markerfacecolor',blue1); hold on;
plot(XE,YE,'v','markerfacecolor',orange1); hold on;
plot(XC,YC,'s','markerfacecolor',yellow1); hold on;
plot(XU_0(1),YU_0(1),'o','markersize',5,'markerfacecolor',green1); hold on;
plot(XU(1:N),YU(1:N),'.','markersize',3); hold on;

xlabel('$x$ [m]','Interpreter','Latex');
ylabel('$y$ [m]','Interpreter','Latex');
grid on;
axis([-15 10 -21 10]);

subplot(2,2,4);
plot(XF,ZF,'o','markerfacecolor',blue1); hold on;
plot(XE,ZE,'v','markerfacecolor',orange1); hold on;
plot(XC,ZC,'s','markerfacecolor',yellow1); hold on;
plot(XU_0(1),ZU_0(1),'^','markerfacecolor',green1); hold on;

xlabel('$x$ [m]','Interpreter','Latex');
ylabel('$z$ [m]','Interpreter','Latex');
grid on;
axis([-15 1 -1 10]);