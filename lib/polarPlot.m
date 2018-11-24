function polarPlot(pos_UAV_Pol_Obs,pos_UAV_Pol_True,pos_Sat_Pol_Obs,figNum,titleName)
% Making a polar plot

% polarPlot - This function is used to produce a polar plot
% INPUT  ---> UAVArray
% OUTPUT ---> 
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


%% Plotting data

Radius_True = 90  - rad2deg(pos_UAV_Pol_True(3,:));
Theta_True  =       rad2deg(pos_UAV_Pol_True(2,:));
Radius_Obs  = 90  -  rad2deg(pos_UAV_Pol_Obs(3,:));
Theta_Obs   =        rad2deg(pos_UAV_Pol_Obs(2,:));

Radius_Sat  = 90 - rad2deg(pos_Sat_Pol_Obs(3,:,:));
Theta_Sat   =      rad2deg(pos_Sat_Pol_Obs(2,:,:));

for i = 1:size(Radius_Sat,2)

    % Satellite Positions
    X_Sat       = Radius_Sat(1,i,:).*cosd(Theta_Sat(1,i,:));
    Y_Sat       = Radius_Sat(1,i,:).*sind(Theta_Sat(1,i,:));
    
    A           = reshape(X_Sat(1,1,:),[1,31]);
    B           = reshape(Y_Sat(1,1,:),[1,31]);
    
    Mag         = sqrt(A.^2 + B.^2);
    
    C           = find(Mag<=90);
    
    plot(A(C),B(C),'.k')
    hold on 
    
end

for i = 1:size(Radius_True,2)
    X_UAV_True  = Radius_True(i)*cosd(Theta_True(i)); 
    Y_UAV_True  = Radius_True(i)*sind(Theta_True(i));
    plot(X_UAV_True,Y_UAV_True,'.b')
    hold on 
    
end

for i = 1:size(Radius_Obs,2)
    X_UAV_Obs  = Radius_Obs(i)*cosd(Theta_Obs(i)); 
    Y_UAV_Obs  = Radius_Obs(i)*sind(Theta_Obs(i));
    hold on;
    plot(X_UAV_Obs,Y_UAV_Obs,'.r')
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
title(titleName);

view([90 -90])
axis off;

end
