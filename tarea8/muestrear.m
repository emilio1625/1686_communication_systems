function x = muestrear(signal, res, samples)
  n = 1;
  t = 1 + (n - 1) * res / samples;
  while t <= length(signal)
    x(n) = signal(t);
    n++;
    t = 1 + (n - 1) * res / samples;
  end
