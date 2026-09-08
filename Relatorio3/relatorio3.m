clc;
clear all;
close all;

%% 1. Identificação de um sistema de primeira ordem a partir de um ensaio

K = 1.8; % ganho (entrada unitária, saída 1.8)
T = 1.2; % tempo pra atingir 63%

G = tf(K, [T 1]); % função de transferência

zero(G) % zeros
pole(G) % polos

Tr = 2.2*T % tempo de subida
Ta = 4*T % tempo de acomodação

% Resposta ao degrau
figure
step(G,8), grid
title("Resposta ao degrau - Sistema de primeira ordem")
xlabel("Tempo (s)")
ylabel("Amplitude")

% degrau de amplitude 2.5
saida = 2.5 * K % valor final da saida (mesmo ganho)

figure
step(2.5*G,8), grid
title("Resposta ao degrau - Sistema de primeira ordem")
xlabel("Tempo (s)")
ylabel("Amplitude")

% A rapidez da resposta é a mesma, porque a constante de tempo permanece
% igual. A posição do polo também não se altera com a mudança na amplitude
% da entrada. (Apenas a amplitude da saída muda)

%% 2 - Escolha entre três sistemas de segunda ordem
% Parametros do sistema

%frequencia natural
wn = 5 % mesma para todos

% zeta = coeficiente de amortecimento
zeta_A = 3/(2*wn) % 0.3 - subamortecido
zeta_B = 10/(2*wn) % 1 - criticamente amortecido
zeta_C = 16/(2*wn) % 1.6 - superamortecido

% Funcao de transferencia na forma padrao
G_A = tf(wn^2, [1 2*zeta_A*wn wn^2])
G_B = tf(wn^2, [1 2*zeta_B*wn wn^2])
G_C = tf(wn^2, [1 2*zeta_C*wn wn^2])

% polos
pole(G_A)
pole(G_B)
pole(G_C)

% ganho em regime permanente
dcgain(G_A)
dcgain(G_B)
dcgain(G_C)

% Respostas ao degrau

figure
step(G_A, 8)
grid on
title("Resposta ao degrau do sistema A")
xlabel('Tempo (s)');
ylabel('Amplitude');

figure
step(G_B, 8)
grid on
title("Resposta ao degrau do sistema B")
xlabel('Tempo (s)');
ylabel('Amplitude');

figure
step(G_C, 8)
grid on
title("Resposta ao degrau do sistema C")
xlabel('Tempo (s)');
ylabel('Amplitude');

% Mapa de polos e zeros
figure
pzmap(G_A, G_B, G_C)
grid on
legend("Sistema A", "Sistema B", "Sistema C")
title("Posicao dos polos dos tres sistemas")

% zeta > 0.4 -> excessivo sobressinal
% zeta < 0.8 -> resposta muito lenta
% para uma aplicação sem sobressinal e com tempo de resposta mais baixo ->
% Sistema B, zeta = 1 (zeta menor que do sistema C, então é mais rápido)

%% 3 - Avaliação de desempenho de dois sistemas de segunda ordem


%frequencia natural
wn_1 = 4
wn_2 = 5

% zeta = coeficiente de amortecimento
zeta_1 = 2.8/(2*wn_1) 
zeta_2 = 6.5/(2*wn_2) 

% Funcao de transferencia na forma padrao
G_1 = tf(wn_1^2, [1 2*zeta_1*wn_1 wn_1^2])
G_2 = tf(wn_2^2, [1 2*zeta_2*wn_2 wn_2^2])

% Resposta ao degrau 
figure
step(G_1, 8)
grid on
title("Resposta ao degrau do sistema 1")
xlabel('Tempo (s)');
ylabel('Amplitude');

figure
step(G_2, 8)
grid on
title("Resposta ao degrau do sistema 2")
xlabel('Tempo (s)');
ylabel('Amplitude');

% polos
pole(G_1)
pole(G_2)

figure
pzmap(G_1, G_2)
grid on
legend("Sistema 1", "Sistema 2")
title("Posicao dos polos dos 2 sistemas")

% SISTEMA 1

valor_final_1 = dcgain(G_1) % calcula o valor final da resposta
[y_1, t_1] = step(G_1, 8); % calcula a resposta ao degrau e os instantes de tempo


% Tempo de atraso: instante em que a resposta atinge 50% do valor final
indice_atraso_1 = find(y_1 >= 0.5*valor_final_1, 1); % encontra o primeiro indice em que y atinge 50%
td_1 = t_1(indice_atraso_1) % armazena o instante correspondente ao indice

limites_subida = [0 1]; % considera o tempo de subida de 0% a 100%
tolerancia_acomodacao = 0.02; % considera uma tolerancia de 2%
info = stepinfo(y_1, t_1, valor_final_1, 'RiseTimeLimits', limites_subida, 'SettlingTimeThreshold', tolerancia_acomodacao); 


info.RiseTime % tempo de subida
info.PeakTime % tempo em que ocorre o pico
info.Peak % valor do primeiro pico
info.Overshoot % maximo sobressinal em porcentagem
info.SettlingTime % tempo de acomodacao considerando tolerancia de 2%

if info.Overshoot < 10
    if info.SettlingTime < 1.5
        disp('Escolher sistema 1')
    end
end


% SISTEMA 2

valor_final_2 = dcgain(G_2) % calcula o valor final da resposta
[y_2, t_2] = step(G_2, 8); % calcula a resposta ao degrau e os instantes de tempo


% Tempo de atraso: instante em que a resposta atinge 50% do valor final
indice_atraso_2 = find(y_2 >= 0.5*valor_final_2, 1); % encontra o primeiro indice em que y atinge 50%
td_2 = t_2(indice_atraso_2) % armazena o instante correspondente ao indice

limites_subida = [0 1]; % considera o tempo de subida de 0% a 100%
tolerancia_acomodacao = 0.02; % considera uma tolerancia de 2%
info = stepinfo(y_2, t_2, valor_final_2, 'RiseTimeLimits', limites_subida, 'SettlingTimeThreshold', tolerancia_acomodacao); 


info.RiseTime % tempo de subida
info.PeakTime % tempo em que ocorre o pico
info.Peak % valor do primeiro pico
info.Overshoot % maximo sobressinal em porcentagem
info.SettlingTime % tempo de acomodacao considerando tolerancia de 2%

if info.Overshoot < 10
    if info.SettlingTime < 1.5
        disp('Escolher sistema 2')
    end
end

% O Sistema 2 e escolhido por apresentar sobressinal inferior a 10% 
% e tempo de acomodacao inferior a 1,5 s. Pode-se perceber pelo gráfico que
% a resposta do sistema 2 é mais amortecida (oscila menos)

%% 4 -  Seleção de parâmetros para um sistema de segunda ordem