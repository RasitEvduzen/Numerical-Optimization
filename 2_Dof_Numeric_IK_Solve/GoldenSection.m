 function [s] = GoldenSection(x,p)

salt = -5;             % Ba�lang�� Noktas�
sust = 5;             % Ba�lang�� Noktas�

Ds = 1e-6;           % Virg�lden sonra ka� basamak hassasiyet laz�msa onu belirliyor
tau = 0.38197;        % 2- golden section
eps = Ds/(sust-salt);        % Tolerans De�erimiz
N = ceil(-2.078*log(eps));   % Algoritman�n ka� ad�m gidece�ini hesapl�yoruz.


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






