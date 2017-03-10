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

% Características de la señal
global amp  = 1;                           % amplitud de la señal
global tmp  = amp / 2;                     % temporal
global duty = 0.5;                         % ciclo de trabajo de 0 a 1
global T = 0.02;                           % periodo de la señal en segundos
global f = 1 / T;                          % frecuencia de// la señal
global w = 2 * pi * f;                     % velocidad angular de la señal
global t = 0 : T / 200 : 3 * T;            % vector de tiempo
global x = tmp + tmp * square(w * t, duty);% señal


