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
global tau  = 0.01e-6;                       % tiempo en alta por periodo
global T    = 2 * tau;                      % periodo de la señal en segundos
global duty = tau / T;                      % ciclo de trabajo de 0 a 1
global f = 1 / T;                           % frecuencia de// la señal
global w = 2 * pi * f;                      % velocidad angular de la señal
global t = 0 : T / 2000 : 3 * T;            % vector de tiempo
global x = tmp + tmp * square(w * t, duty); % señal

% coeficiente de la serie trigonometrica
function x = a_(n)
    global amp; global duty;
    x = (amp / (pi * n)) * sin(2 * pi * n * duty);
endfunction

function x = b_(n)
    global amp; global duty;
    x = (amp / (pi * n)) * (1 - cos(2 * pi * n * duty));
endfunction

% coeficientes de la serie simplificada
function [A O] = coef(i)
    for n = 1:i
        a       = a_(n);
        b       = b_(n);
        A(n)    = sqrt(a^2 + b^2);
        O(n)    = atan2(b, a);
    endfor
endfunction

% grafica la señal reconstruida
function plot_rsignal(n)
    global amp; global t; global w; global duty;
    [An On] = coef(n);
    % creamos un vector vacio del tamaño del vector de tiempo
    % y sumamos la componente de directa
    x = 0 .* t .+ duty;
    for i = 1 : n
        x = x + An(i) * cos(w * i * t .- On(i));
    endfor
    plot(t, x); axis([0 t(length(t)) -0.5 * amp amp * 1.5]);
    title('Señal reconstruida'); xlabel('tiempo [ms]'); ylabel('x(t)');
endfunction

%grafica los coeficientes
function plot_coef(n, s)
    global amp; global f;
    [An On] = coef(n);
    nv = 1 : n;
    if (s == 0)
        stem(f * nv, On); axis([0 f * n]);
        title('Fase de la serie'); xlabel('frecuencia [Hz]'); ylabel('Øn');
    else
        stem(f * nv, An); axis([0 f * n]);
        title('Armónicos de la señal'); xlabel('frecuencia [Hz]'); ylabel('An');
    endif
endfunction

function x = Hf(n, R, C)
    global f;
    for i = 1:n
        x(i) = 1 / sqrt(1 + 2 * pi * n* f * R * C);
    endfor
endfunction

function x = Of(n, R, C)
    global f;
    for i = 1:n
        x(i) = - atan(2 * pi * n * f * R);
    endfor
endfunction

function [Ay Oy] = f_resp(n, R, C)
    [Ax Ox] = coef(n);
    Af = Hf(n, R,C);
    Of = Of(n, R, C);
    Ay = Ax .* Af;
    Oy = Ox .* Of;
endfunction

function plot_fresp(n, R, C)
    global f; global w; global t; global duty;
    [Ay Oy] = f_resp(n, R, C);
    nv = 1 : n;
    x = 0 .* t + duty;
    for i = 1 : n
        x = x + Ay(i) * cos(w * i * t .- Oy(i));
    endfor
    plot(t, x);
    title('Respuesta en el tiempo'); xlabel('tiempo [ms]'); ylabel('x(t)');
    figure;
    stem(f * nv, Oy); axis([0 f * n]);
    title('Respuesta en fase'); xlabel('frecuencia [Hz]'); ylabel('Øn');
    figure;
    stem(f * nv, Ay); axis([0 f * n]);
    title('Respuesta en magnitud'); xlabel('frecuencia [Hz]'); ylabel('An');
endfunction

plot_fresp(100, 1e3, 2e-12);
[Ay Oy]= f_resp(100, 1e3, 2e-12);