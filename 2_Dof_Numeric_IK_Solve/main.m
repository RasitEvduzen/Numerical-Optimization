clc,clear all,close all,warning off;
%% 2 Dof Robotic Arm Steppest Descent based Inverse Kinematics solve
% Written By Raþit EVDÜZEN
% 18-Sep-2020 10:49:18

% Robot % Path Parameter
l1 = 2;       % Robot link 1
l2 = 2;       % Robot link 2
ll = l1+l2;   % total link length
Tp = [1, 1]'; % Target Point
x = [90; -45];   % Robot Joint 1 & 2 initial Angle
Loop = 1;     % Algorithm Loop
alpha = -5;  % Step Size

% 2Dof Robotic Arm Forward Kinematics
f = @(x,l1,l2) [l1*cos(deg2rad(x(1))) + l2*cos(deg2rad(x(1)+x(2)))
    l1*sin(deg2rad(x(1))) + l2*sin(deg2rad(x(1)+x(2)))];
% Function Jacobian
J = @(x,l1,l2) [-l1*sin(deg2rad(x(1)))-l2*sin(deg2rad(x(1)+x(2)))    -l2*sin(deg2rad(x(1)+x(2)))
    l1*cos(deg2rad(x(1)))+l2*cos(deg2rad(x(1)+x(2)))     l2*cos(deg2rad(x(1)+x(2)))];


cplot = @(r,x0,y0) plot(x0 + r*cos(linspace(0,2*pi)),y0 + r*sin(linspace(0,2*pi)),'-');
X = [];   % Robot angle trajectory
Y = [];   % Robot end effector trajectory
S = [];   % Step Size trajectory
while Loop
    clf
    
    % Optimization Algorithm
    [yhat] = f(x,l1,l2);         % Calculate FK value
    e = [Tp - yhat];             % Calculate Error
    Jr = J(x,l1,l2);             % Calculate Jacobian
    %-----Adaptif Step Size Golden Section------%
%     p = sum(Jr);
%     s = GoldenSection(x,p);
%     S = [S,s];
%     x = x - s*Jr*e;     % Update Parameter via Gradient direction
    %-----Const Step Size  ------%
    x = x - alpha*Jr*e; % Update Parameter via Gradient direction
    X = [X, x];
    Y = [Y, yhat];
    %-----PLOT DATA------%
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    A1x = [0 l1*cos(deg2rad(x(1)))];
    A1y = [0 l1*sin(deg2rad(x(1)))];
    A2x = [A1x(:,2) A1x(:,2)+l2*cos(deg2rad(x(1)+x(2)))];
    A2y = [A1y(:,2) A1y(:,2)+l2*sin(deg2rad(x(1)+x(2)))];
    plot(A1x,A1y,'r','LineWidth',2)
    hold on,grid minor
    cplot(ll,0,0)
    plot(A2x,A2y,'b','LineWidth',2)
    axis equal
    axis([-ll-1 ll+1 -ll-1 ll+1])
    xlabel('X - Axis') , ylabel('Y - Axis'), title({'2 Dof Robot Arm';['Error : ',num2str(norm(e))]})
    scatter(Tp(1),Tp(2),'k')
    
    drawnow
    if norm(e) < 1e-5          % Stop Condition
        Loop = 0;
        figure
        set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
        subplot(211)
        plot(X'),grid minor, title('2 Dof Robot Joint Degree')
        legend('\theta 1 (Degree)','\theta 2 (Degree)')
        subplot(212)
        plot(Y'),grid minor,title('2 Dof Robot End Effector Position')
        legend('X position ','Y position ')
    end
    
end

