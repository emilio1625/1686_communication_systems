function x = cuantizar(signal, levels, n)
  mx = max(signal);
  mn = min(signal);
  q = (abs(mx) + abs(mn)) / (levels + 1);
  signal = signal + abs(mn) - (q / 2); % volvemos completamente positiva la señal
  % y nos aseguramos que los valores max y min salgan del la escala
  plot ()
  x = round(signal / levels);
