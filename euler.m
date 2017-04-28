function [x y] = euler(func, yi, xi, xf, n)
  h = (xf - xi) / n;
  x(1) = xi;
  y(1) = yi;
  for i = 2:n+1
    x(i) = x(i - 1) + h;
    y(i) = y(i - 1) + h * func(x(i - 1), y(i - 1));
  endfor
