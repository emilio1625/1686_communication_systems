function x = cuantizar(signal, min, max, n)
  levels = 2 ^ n;
  factor = (levels / 2) / (abs(max) + abs(min));
  x = round(signal * factor) / levels;
