clear all;
m = 2*rand + 0.5;

s = random('uniform', -6, 10, [1e5, 1]);
s = db2pow(s);
%logspace(-6, 10, 1e5).';
[w, t] = gamequiv(m, s, 1e-3);
M = length(w);

L_exact = @(x) (1+x/m).^(-m);
L_approx= @(x) 0;
for i = 1:M
    L_approx = @(x) L_approx(x) + w(i)./(1+t(i)*x);
end
L_approx = @(x) (1+x/m).^(-floor(m)) .* L_approx(x);

figure;
fplot(L_exact, [min(s), max(s)]); hold on;
fplot(L_approx, [min(s), max(s)]);hold off;
set(gca, 'XScale', 'Log');
set(gca, 'YScale', 'Log');