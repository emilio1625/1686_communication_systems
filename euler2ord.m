function [x y] = euler2ord(func1, ui, yi, xi, xf, n)
  h = (xf - xi) / n;
  x(1) = xi;
  u(1) = ui;
  y(1) = yi;
  for i = 1:n
    x(i + 1) = x(i) + h;
    y(i + 1) = y(i) + h * u(i);
    u(i + 1) = u(i) + h * func1(x(i), y(i), u(i));
  endfor
    