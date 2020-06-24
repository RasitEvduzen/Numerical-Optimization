clc,clear all,close all;

%%% DATA %%%   Canım sevgilim
T = [2 3 5]';  % Input Data
Y = [1 6 4]';  % Output Data
n = 2;  % Polynom Degree
A = [ones(size(T))];

for i=1:n
     A = [A, T.^(i)];
%     A = [T^2 T ones(size(T))];
end

xstar = inv(A)*Y;  % Polynom parameters

%%% PLOT %%%

plot(T,Y,'ro'), hold on, grid minor
t = min(T)-0.5:0.01:max(T)+0.5;
ystar = xstar(1) + xstar(2)*t + xstar(3)*t.^2;
plot(t,ystar,'b')
legend('Data','Fitting Polynom')


