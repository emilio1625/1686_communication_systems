function x = codificar(signal, m)
  x = [];
  for i = signal
    x = [x (dec2bin(i, m) - '0')];
  end
