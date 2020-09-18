 function [s] = GoldenSection(x,p)

salt = -5;            % initial Condition
sust = 5;             % initial Condition

Ds = 1e-6;           
tau = 0.38197;               % 2 - tau =  golden section
eps = Ds/(sust-salt);        % Tolerance
N = ceil(-2.078*log(eps));   % Algorithm Step Size


F = @(x) 3 + (x(1) - 1.5 * x(2))^2 + (x(2)-2)^2 ;

s1 = salt + tau*(sust-salt);
f1 =F(x+s1*p);
s2 = sust - tau*(sust-salt);
f2 = F(x+s2*p);
for k = 1:N
    
    if f1 > f2
        salt = s1;
        s1 = s2;
        f1 = f2;
        s2 = sust - tau*(sust-salt);
        f2 = F(x+s2*p);
    else
        sust = s2;
        s2 = s1;
        f2 = f1;
        s1 = salt + tau*(sust - salt);
        f1 = F(x+s1*p);
    end
end

s = mean([s1,s2]);






