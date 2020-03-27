clear all
clc

a = -10;
b = 10;
n = 10;
z = 3;

pts = a:((b-a)/100):b;
    
figure;
subplot(2,2,1)
hold on
plot(pts, arrayfun(@(x) f(x), pts))
monInt = pts;
for i = 1:length(pts)
   [~, val] = monomialInterpolation(a, b, n, pts(i));
   monInt(i) = val;
end
plot(pts, monInt)
hold off
subplot(2,2,2)
hold on
plot(pts, arrayfun(@(x) f(x), pts))
lagInt = pts;
for i = 1:length(pts)
   [~, val] = monomialInterpolation(a, b, n, pts(i));
   lagInt(i) = val;
end
plot(pts, lagInt)
hold off

function y = f(x)
    y = cos(x);
end

function [Xs, Wn] = lagrangeInterpolation(a, b, n, zeta)
    Xs = eqDistNodes(a, b, n);    % get nodes
    Ys = arrayfun(@(x) f(x), Xs); % get values at nodes
    Wn = sum(arrayfun(@(i) lagrPolyn(i, zeta, Xs)*Ys(i+1), 0:n)); % value of interpolation at zeta
end

function Pin = lagrPolyn(i, x, Xs)
    if i > length(Xs)
       error('i must be inside nodes interval')
    end
    Pin = 1;
    for it = [0:(i-1), (i+1):(length(Xs)-1)]
        Pin = Pin * (x-Xs(it+1)) / (Xs(i+1)-Xs(it+1));
    end
end

function [Xs, Wn] = monomialInterpolation(a, b, n, zeta)
    Xs = eqDistNodes(a, b, n);    % get nodes
    Ys = arrayfun(@(x) f(x), Xs); % get values at nodes
    A = vander(Xs);               % create vandermonde matrix
    coeffs = linsolve(A, Ys');    % solve A*coeffs = Ys
    Wn = polyval(coeffs, zeta);   % value of interpolation at zeta
end

function nodes = eqDistNodes(a, b, n)
    nodes = zeros(1, n);
    if a < b
        for i = 0:n
            nodes(i+1) = a + (b-a)*i/n;
        end
    else
        error('a must be smaller than b!')
    end
end

function nodes = ChebyshevNodes(a, b, n)
    nodes = zeros(1, n);
    if a < b
        for i = 0:n
            x = cos((2*i+1)/(2*n+2)*pi);
            nodes(i+1) = ((b-a)*x + a + b)/2;
        end
        nodes = flip(nodes);
    else
        error('a must be smaller than b!')
    end
end
