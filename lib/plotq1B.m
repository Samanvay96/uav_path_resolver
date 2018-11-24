function plotq1B(plotData)
% plotq1B - This function is used to plot the relevant graphs for question
% 1 B
%
% INPUT  ---> plotData
% OUTPUT --->
% Author ---> Samanvay Karambhe, 2016

%% Plot Graphs
% Plot Initialisation
time = 1:300;
trueC = '.b';
obsC  = '-r';

% Produce a plot plot of UAV Positions
figNum = 1;
titleName = 'True Position vs. Observed Data';
polarPlot(plotData.pos_UAV_Pol_Obs,plotData.pos_UAV_Pol_True,plotData.pos_Sat_Pol_Obs,figNum,titleName)

% Produce a polar plot with best and worst satellite configurations
figNum2 = 2;
polarPlotDOP(plotData.bestSatConfig,plotData.worstSatConfig,...
            plotData.timeArray,plotData.pseudo_data,plotData.maxDOPIndex,...
            plotData.minDOPIndex,plotData.cumArray,figNum2);

% % % 3D Trajectory Plot of UAV
figure(3)
plot3(plotData.pos_UAV_Cart_True(1,:),plotData.pos_UAV_Cart_True(2,:),plotData.pos_UAV_Cart_True(3,:),trueC)
hold on
plot3(plotData.pos_UAV_Cart_obs(1,:),plotData.pos_UAV_Cart_obs(2,:),plotData.pos_UAV_Cart_obs(3,:),obsC)
xlabel('X_{LGCV} (m)','FontSize',15,'Interpreter','Tex');
ylabel('Y_{LGCV} (m)','FontSize',15,'Interpreter','Tex');
zlabel('Z_{LGCV} (m)','FontSize',15,'Interpreter','Tex');
title('3D UAV Trajectory','FontSize',15);
h1 = legend('True','Observed');
set(h1,'FontSize',15)
grid on;
axis equal;

% % 2D UAV Pos w.r.t Ground Station
figure(4)
plot(plotData.pos_UAV_Cart_True(1,:),plotData.pos_UAV_Cart_True(2,:),trueC)
hold on;
plot(plotData.pos_UAV_Cart_obs(1,:),plotData.pos_UAV_Cart_obs(2,:),obsC)
xlabel('X_{LGCV} (m)','FontSize',15,'Interpreter','Tex');
ylabel('Y_{LGCV} (m)','FontSize',15,'Interpreter','Tex');
title('2D UAV Trajectory','FontSize',15);
h2 = legend('True','Observed','Location','Best');
set(h2,'FontSize',15)
axis equal;
grid on;

% % UAV Altitude vs. Time GS
figure(5)
plot(time(:),-plotData.pos_UAV_Cart_True(3,1:10:3000));
hold on
plot(time(:),-plotData.pos_UAV_Cart_obs(3,1:300));
xlabel('Time (s)','FontSize',20);
ylabel('Altitude (m)','FontSize',20);
title('UAV Altitude vs. Time','FontSize',16)
l = legend('True','Observed','Location','Best');
set(l,'FontSize',15)
grid on

% Close Bias vs. TIme w.r.t GS
figure(6)
plot(time,plotData.UAVPos(4,:));
xlabel('Time (s)','FontSize',20);
ylabel('Clock Bias (s)','FontSize',20);
title('Clock Bias vs. Time','FontSize',16)
grid on

% Number of Visible Satellites vs. Time
figure(7)
subplot(2,1,1)
plot(time,plotData.DOP.GDOP);
ylabel('GDOP','FontSize',15);
title('GDOP vs. Time','FontSize',15)
grid on;

subplot(2,1,2)
plot(time,plotData.nTimes);
xlabel('Time (s)','FontSize',20);
ylabel('No. of Visible Satellites','FontSize',15);
title('Number of Visible Satellites vs. Time','FontSize',15)
grid on

% Range, Azimuth, Elevation vs. Time
figure(8)
subplot(3,1,1)
plot(time,plotData.pos_UAV_Pol_Obs(1,:));
hold on
plot(time,plotData.pos_UAV_Pol_True(1,1:10:3000));
xlabel(' ','FontSize',15);
ylabel('Range (m)','FontSize',15);
title('Range vs. Time','FontSize',15)
l = legend('True','Observed','Location','Best');
set(l,'FontSize',12)
grid on

subplot(3,1,2)
plot(time,rad2deg(plotData.pos_UAV_Pol_Obs(2,:)));
hold on
plot(time,rad2deg(plotData.pos_UAV_Pol_True(2,1:10:3000)));
xlabel(' ','FontSize',15);
ylabel('Azimuth (Deg)','FontSize',15);
title('Azimuth vs. Time','FontSize',15)
grid on

subplot(3,1,3)
plot(time,rad2deg(plotData.pos_UAV_Pol_Obs(3,:)));
hold on
plot(time,rad2deg(plotData.pos_UAV_Pol_True(3,1:10:3000)));
xlabel('Time (s)','FontSize',15);
ylabel('Elevation (Deg)','FontSize',15);
title('Elevation vs. Time','FontSize',15)
grid on

% DOP Plots
figure(8)

% GDOP Plot
subplot(2,3,1)
plot(time,plotData.DOP.GDOP);
title('Geometric DOP');
xlabel('Time (s)');
ylabel('GDOP');
grid on

% PDOP Plot
subplot(2,3,2)
plot(time,plotData.DOP.PDOP);
title('Position DOP');
xlabel('Time (s)');
ylabel('GDOP');
grid on

% HDOP Plot
subplot(2,3,3)
plot(time,plotData.DOP.HDOP);
title('Horizontal DOP');
xlabel('Time (s)');
ylabel('GDOP');
grid on

% VDOP Plot
subplot(2,3,4)
plot(time,plotData.DOP.VDOP);
title('Vertical DOP');
xlabel('Time (s)');
ylabel('GDOP');
grid on

% TDOP Plot
subplot(2,3,5)
plot(time,plotData.DOP.TDOP);
title('Time DOP');
xlabel('Time (s)');
ylabel('GDOP');
grid on
hold on

end
