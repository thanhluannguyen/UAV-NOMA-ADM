theta1_vec = linspace(0.01,0.99,15);
theta2_vec = linspace(0.01,0.99,15);

Throughput_SIM = cell2mat(struct2cell(load('Throughput_SIM.mat')));
Throughput_ANA = cell2mat(struct2cell(load('Throughput_ANA.mat')));

figure;
colormap winter 
leg_1 = surf(theta1_vec,theta2_vec,Throughput_SIM,'FaceColor','None'); hold on;
leg_2 = surf(theta1_vec,theta2_vec,Throughput_ANA,'EdgeColor','None'); hold on;

maximum = max(Throughput_SIM,[],'all');
[y,x] = find(Throughput_SIM==maximum);
lbl = plot3(theta1_vec(x),theta2_vec(y),Throughput_SIM(y,x),'pr',...
    'markerfacecolor','r','markersize',10); hold on;

contourf(theta1_vec,theta2_vec,Throughput_SIM); hold on;
plot(theta1_vec(x),theta2_vec(y),'pr',...
    'markerfacecolor','r','markersize',10); hold on;

xlabel('$\theta_1$','Interpreter','LaTex');
ylabel('$\theta_2$','Interpreter','LaTex');
zlabel('Throughput [bits/s/Hz]','Interpreter','LaTex');
set(gca,'Fontsize',8);
set(gcf,'Position',[100 100 300 250]);
axis([0 1 0 1]);
leg = legend([leg_1 leg_2 lbl],{'Sim','Ana','Optimal'},'Location','Best');
leg.ItemTokenSize = [15,18];
box on;
colorbar;

windowSize = get(gca,'TightInset'); 
windowSize(3) = 0.025;
windowSize(4) = 0.025;
set(gca,'LooseInset',windowSize);