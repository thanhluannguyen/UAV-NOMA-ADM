clear all;
trials = 1e6;
%% 3D location of nodes
 % network area
L = 25;
% the FC is located as the origin
XF = 0; YF = 0; ZF = 0; 

% the UE-C
XC_0 = -1.957;
YC_0 = 7.3266;
ZC_0 = 0;

XC = XC_0;
YC = YC_0;
ZC = ZC_0;

% the UE-E
XE_0 = -13.4888;
YE_0 = -18.8525;
ZE_0 = 0.2338;

XE = XE_0;
YE = YE_0;
ZE = ZE_0;

% the UAV, Intial Location, i.e., the First Waypoint
XU_0 = -6.6561; 
YU_0 = -7.6165; 
ZU_0 =  6.7750;

XU = cell2mat(struct2cell(load('XU.mat')));
YU = cell2mat(struct2cell(load('YU.mat')));
ZU = cell2mat(struct2cell(load('ZU.mat')));

% % % v_min = 0.1;
% % % v_max = 1;
% % % % Location of Waypoints
% % % N = 1e6; % Number of Waypoints
% % % Theta = 2*pi*rand(N,1);
% % % R = sqrt((XE-XU_0)^2+(YE-YU_0)^2)*sqrt(rand(N,1));
% % % XW = R.*cos(Theta); XW = [XU_0;XW];
% % % YW = R.*sin(Theta); YW = [XU_0;YW];
% % % % Waypoint Index
% % % indexWP= 1;
% % % % The Initial Location
% % % XW_1 = XW(indexWP);
% % % YW_1 = YW(indexWP);
% % % % Movement Trace of the UAV
% % % Trace_X = XW_1; 
% % % Trace_Y = YW_1; 
% % % while(1)
% % %     % Location of the Next Waypoint (W_2)
% % %     XW_2 = XW(indexWP+1);
% % %     YW_2 = YW(indexWP+1);
% % %     
% % %     % Distance between W_1 and W_2
% % %     DistanceW1W2 = sqrt((XW_2-XW_1)^2+(YW_2-YW_1)^2);
% % %     
% % %     % Direction from W_1 to W_2
% % %     dirMovement = atan2( YW_2-YW_1,XW_2-XW_1 ); 
% % % %     dirMovement = sign(YW_2-YW_1)*acos( (XW_2-XW_1)/Distance );
% % %     
% % %     % Velocity to move from W_1 to W_2
% % %     Velovity = (v_max-v_min)*rand + v_min;
% % %     
% % %     % Live: The UAV move from W_1 to W_2
% % %     % Initial Location of the UAV in time (t)
% % %     XU_1 = XW_1; 
% % %     YU_1 = YW_1;
% % %     % Trace of the UAV when moving from W_1 to W_2
% % %     TraceX_W1W2 = XW_1;
% % %     TraceY_W1W2 = YW_1;
% % %     %
% % %     TravelDistance = sqrt((XU_1-XW_1)^2+(YU_1-YW_1)^2);
% % %     %
% % %     while(1)
% % %         % Next Location of the UAV in time (t)
% % %         XU_2 = XU_1 + Velovity.*cos(dirMovement);
% % %         YU_2 = YU_1 + Velovity.*sin(dirMovement);
% % %         % Initial Location of the UAV in time (t+1)
% % %         XU_1 = XU_2; YU_1 = YU_2;
% % %         % Recalculate the Traveled Distance from W_1 to the UAV
% % %         TravelDistance = sqrt((XU_1-XW_1)^2+(YU_1-YW_1)^2);
% % %         
% % %         % Save the Trace of the UAV when moving from W_1 to W_2
% % %         TraceX_W1W2 = [TraceX_W1W2, XU_1];
% % %         TraceY_W1W2 = [TraceY_W1W2, YU_1];
% % %     
% % %         % Save the Trace of the UAV 
% % %         Trace_X = [Trace_X, XU_1];
% % %         Trace_Y = [Trace_Y, YU_1];
% % %         
% % %         % Stoping Criterion: The UAV arrives at W_2
% % %         if (DistanceW1W2 <= TravelDistance)
% % %             Trace_X(end) = XW_2;
% % %             Trace_Y(end) = YW_2;
% % %             TraceX_W1W2(end) = XW_2;
% % %             TraceY_W1W2(end) = YW_2;
% % %             
% % %             break;
% % %         end
% % %     end
% % %     % Choose A New Waypoint
% % %     indexWP = indexWP + 1;
% % %     % The Initial Location
% % %     XW_1 = XW(indexWP);
% % %     YW_1 = YW(indexWP);
% % % 
% % %     if (length(Trace_X) > 1e6)
% % %         break;
% % %     end
% % % end
% % % Trace_Z = ZU_0*ones(1,length(Trace_X));

% % % XU = Trace_X;
% % % YU = Trace_Y;
% % % ZU = Trace_Z;
% % % save('XU.mat','XU');
% % % save('YU.mat','YU');
% % % save('ZU.mat','ZU');

blue1=[0, 0.4470, 0.7410];
orange1=[0.8500, 0.3250, 0.0980];
yellow1=[0.9290, 0.6940, 0.1250];
green1=[0.4660, 0.6740, 0.1880];

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