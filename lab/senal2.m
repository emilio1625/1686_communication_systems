fs  = 1000;
ti  = 0;
tf  = 1;
t   = ti:1/fs:tf;
x   = 20*cos(2*pi*100*t) + 10*sin(2*pi*50*t);
plot(1000*t, x + 20*rand(size(t))); axis([0 100 -40 40]);
title("Señal x(t) con ruido"); xlabel("tiempo[ms]"); ylabel("x(t)");
