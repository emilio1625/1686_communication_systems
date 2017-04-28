function x = cuantizar(signal, levels)
  mx = max(signal);
  mn = min(signal);
  q = (abs(mx) + abs(mn)) / levels;
  signal = signal + abs(mn) - (q / 2); % volvemos completamente positiva la señal
  % y nos aseguramos que los valores max y min salgan del la escala por q/2
  x = round(signal / q);
  x(x > (levels - 1)) = levels - 1; % si algun valor es mayor al numero de niveles
  x(x < 0) = 0; % si algun valor es menor a 0
