 function [s] = GoldenSection(x,p)

salt = -5;             % Başlangıç Noktası
sust = 5;             % Başlangıç Noktası

Ds = 1e-6;           % Virgülden sonra kaç basamak hassasiyet lazımsa onu belirliyor
tau = 0.38197;        % 2- golden section
eps = Ds/(sust-salt);        % Tolerans Değerimiz
N = ceil(-2.078*log(eps));   % Algoritmanın kaç adım gideceğini hesaplıyoruz.


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






