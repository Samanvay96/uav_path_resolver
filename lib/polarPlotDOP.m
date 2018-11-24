function polarPlotDOP(bestSatConfig,worstSatConfig,timeArray,pseudo_data,maxDOPIndex,minDOPIndex,cumArray,figNum)
% Making a polar plot

% polarPlot - This function is used to produce a polar plot
% INPUT  ---> UAVArray
% OUTPUT ---> Plots
% Author ---> Samanvay Karambhe, 2016 

%% Initial Set-up for graphs
angle = 0:360;

figure(figNum)

for R = 30:30:90

X = R*cosd(angle);
Y = R*sind(angle);
h = plot(X,Y,'b');
set(h, 'color', [0.5 0.5 0.5])
hold on;

end

h = plot(0,0,'r');
set(h, 'color', [0.5 0.5 0.5])

hold on
for theta = 0:30:360

h = plot([0 90*cosd(theta)],[0 90*sind(theta)],'b');
set(h, 'color', [0.5 0.5 0.5])

    hold on;

end

set(gcf,'position',[0 320 700 600])

%% Find Visible Satellites

[lim1best,lim2best]   = findLimits(cumArray,max(minDOPIndex));
[lim1worst,lim2worst] = findLimits(cumArray,max(maxDOPIndex));

satellitesWorst = pseudo_data(lim1worst:lim2worst,2);
satellitesBest  = pseudo_data(lim1best:lim2best,2);


%% Plotting data

Radius_Sat_Best   = 90 - rad2deg(bestSatConfig(3,:,:));
Theta_Sat_Best    =      rad2deg(bestSatConfig(2,:,:));

Radius_Sat_Worst  = 90 - rad2deg(worstSatConfig(3,:,:));
Theta_Sat_Worst   =      rad2deg(worstSatConfig(2,:,:));

for i = 1

    % Satellite Position for Best DOP Positions
    X_Sat_BEST       = Radius_Sat_Best(1, i, satellitesBest).*cosd(Theta_Sat_Best(1, i, satellitesBest));
    Y_Sat_BEST       = Radius_Sat_Best(1, i, satellitesBest).*sind(Theta_Sat_Best(1, i, satellitesBest));

    % Bad DOP Configuration for Worst DOP Positions
    X_Sat_WORST      = Radius_Sat_Worst(1, i, satellitesWorst).*cosd(Theta_Sat_Worst(1, i, satellitesWorst));
    Y_Sat_WORST      = Radius_Sat_Worst(1, i, satellitesWorst).*sind(Theta_Sat_Worst(1, i, satellitesWorst));

    A_BEST           = reshape(X_Sat_BEST(1, 1, :), [1, length(satellitesBest)]);
    B_BEST           = reshape(Y_Sat_BEST(1, 1, :), [1, length(satellitesBest)]);

    A_WORST          = reshape(X_Sat_WORST(1, 1, :), [1, length(satellitesWorst)]);
    B_WORST          = reshape(Y_Sat_WORST(1, 1, :), [1, length(satellitesWorst)]);

    Mag_BEST         = sqrt(A_BEST.^2 + B_BEST.^2);
    Mag_WORST        = sqrt(A_WORST.^2 + B_WORST.^2);

    C_BEST           = find(Mag_BEST <= 90);
    C_WORST          = find(Mag_WORST <= 90);

    plot(A_BEST(C_BEST), B_BEST(C_BEST), 'Or', 'MarkerSize', 10)
    hold on
    plot(A_WORST(C_WORST), B_WORST(C_WORST), 'Xb', 'MarkerSize', 10)
    hold on

end

textcolor = 'k';
% Radial Circle Labels
text(1,3,'90^o','color',textcolor,'fontweight','bold','fontsize',13);
text(13,28,'60^o','color',textcolor,'fontweight','bold','fontsize',13);
text(33,55,'30^o','color',textcolor,'fontweight','bold','fontsize',13);
text(48,80,'0^o','color',textcolor,'fontweight','bold','fontsize',13);

% Direction Labels
text(0,95,'East','color',textcolor,'fontweight','bold','fontsize',13);
text(0,-105,'West','color',textcolor,'fontweight','bold','fontsize',13);
text(95,-6,'North','color',textcolor,'fontweight','bold','fontsize',13);
text(-95,-6,'South','color',textcolor,'fontweight','bold','fontsize',13);
title('Best and Worst Satellite Configuration based on DOP')

view([90 -90])
axis off;

end
