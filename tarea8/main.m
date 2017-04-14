clear all;
f0 = 100; % frecuencia fundamental de la señal analogica
T0 = 1 / f0; % periodo de la señal
res = 32; % resolucion de la señal pseudo-analógica
N = 20; % numero de armonicos de la señal
fs = res * N * f0;
Ts = 1 / fs; % incremento del vector de tiempo
t = 0 : Ts : 2 * T0; % vector de tiempo

xt = pseudoanalog(f0, N, t);

samples = 4;
fs = samples * N * f0;
Ts = 1 / fs;
xn = muestrear(xt, res, samples);

n = 0 : Ts : 2 * T0;

L = 4; % numero de bits para cuantizar

xd = cuantizar(xn, L);
