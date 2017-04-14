% Generaci�n de una se�al pseudo-anal�gica aleatoria
% Pablo Torres Ferrera, Sistemas de Comunicaciones 2017-2

close all
clear all

Amp=1; N=20;                        % Par�metros de la se�al x_a(t), N = N�mero de coeficientes de la Serie de Fourier
FLAG_PLOT=1;                        % Indica si graficar (1) o no (0)

f0=100;                             % Frecuencia fundamental de la se�al x_a(t)
T0=1/f0;                            % Per�odo fundamental de la se�al x_a(t)
Res=32;                             % Muestras por cada per�odo fundamental de la se�al pseudo-anal�gica, les hab�a dicho 8, pueden dejarla como 32
fs_mat=Res*N*f0;                    % Frecuencia de muestreo para generar la se�al pseudo-anal�gica (NO confundir con frecuencia de muestreo para discretizarla)
Ts_mat=1/fs_mat;                    % Intervalos de muestreo para generar la se�al pseudo-anal�gica
t=0:Ts_mat:2*T0;                    % Vector de tiempo, de 0 a 2 per�odos (para graficar)

%C�lculo de los coeficientes de la serie de Fourier y reconstrucci�n de la se�al x(t)
a0=0;                               % Componente de DC
x_a=a0;
A=rand(1,N);
Theta=pi*rand(1,N);
for n=1:1:N
    x_temp=A(n)*cos(2*pi*f0*n*t-Theta(n));
    x_a=x_a+x_temp;
end

% Discretizar la se�al pseudo-anal�gica

S=4;
fs=S*N*f0;      % Frecuencia de muestreo = S veces la frecuencia m�xima (N*f0) de la se�al pseudo-anal�gica
Ts=1/fs;        % Per�odo de muestreo [s]

x_dis(1)=x_a(1+0*Res/S); % x_dis es la se�al pseudo-anal�gica muestreada. S�lo obtengo como ejemplo las primeras 4 muestras. Generalicen para muestrear toda la se�al
x_dis(2)=x_a(1+1*Res/S);
x_dis(3)=x_a(1+2*Res/S);
x_dis(4)=x_a(1+3*Res/S);
%etc...

t_dis=0:Ts:2*T0;
t_dis=t_dis(1:4); % t_dis(1:4) sirve para limitar el vector de tiempo para s�lo las primeras cuatro muestras que les puse de ejemplo. Generalizar para todo el tiempo que dura x_a(t)

% Cuantizar la se�al muestreada (esta es su tarea)

% Codificar la se�al cuantizada (esta es su tarea)

% Graficas
if FLAG_PLOT == 1
    figure
    plot(t,x_a);                % Gr�fica de la se�al x_a(t)
    grid on; xlabel('Tiempo [s]','fontsize',20); ylabel('x_a(t)','fontsize',20);
    figure
    hold on                     % Sirve para graficar dos curvas en la misma gr�fica. Las se�ales cuantizadas de tarea las quiero as� traslapadas con la se�al original
    stem(t_dis(1:4),x_dis)      % Gr�fica de la se�al muestreada
    hold off
end
