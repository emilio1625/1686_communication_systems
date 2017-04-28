% Copyright (c) 2017 Emilio Cabrera <emilio1625@gmail.com>
%
% GNU GENERAL PUBLIC LICENSE
%    Version 3, 29 June 2007
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% Preparamos el area de trabajo
clear all;
pkg load signal;

% Características de la señal
global amp  = 1;                            % amplitud de la señal
global tmp  = amp / 2;                      % temporal
global tau  = 0.01                          % tiempo en alta por periodo
global T = 0.02;                            % periodo de la señal en segundos
global duty = tau / T;                      % ciclo de trabajo de 0 a 1
global f = 1 / T;                           % frecuencia de// la señal
global w = 2 * pi * f;                      % velocidad angular de la señal
global t = 0 : T / 200 : 3 * T;             % vector de tiempo
global x = tmp + tmp * square(w * t, duty); % señal

% coeficiente de la serie trigonometrica
function x = a_(n)
    global amp; global duty;
    x = (amp / (pi * n)) * sin(2 * pi * n * duty);

function x = b_(n)
    global amp; global duty;
    x = (amp / (pi * n)) * (1 - cos(2 * pi * n * duty));

% coeficientes de la serie simplificada
function [An On] = coef(i)
    for n = 1:i
        a   = a_(n);
        b   = b_(n);
        An  = sqrt(a^2 + b^2);
        On  = atan2(a, b);
    endfor

% grafica la señal reconstruida
function plot_rsignal(n):
    global amp; global w; global t;
    [An, On] = coef(n);
    % creamos un vector vacio del tamaño del vector de tiempo
    % y sumamos la componente de directa
    x = 0 .* t .+ amp / 2;
    for i = 1:n
        x = x + An(i) * cos(w * i * t .- On(i));
    endfor
    plot(t, x); axis([amp * 1.5 amp * 1.5 0 length(t) - 1]);
    title('Señal reconstruida x(t)'); xlabel('tiempo [ms]'); ylabel('x(t)');

%grafica los coeficientes
function plot_coef(n, f)
    global amp; global w; global t;
    [An, On] = coef(n);
    nv = (1:n)
    if (f == 0)
        stem(nv * f, On); axis([amp * 1.5 amp * 1.5 0 length(t) - 1]);
        title('Armónicos de la señal'); xlabel('frecuencia [Hz]'); ylabel('An');
    else
        stem(nv * f, On); axis([amp * 1.5 amp * 1.5 0 length(t) - 1]);
        title('Fase de la serie'); xlabel('frecuencia [Hz]'); ylabel('Øn');
    endif
