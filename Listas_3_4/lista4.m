clc;
clear all;
close all;

%% 1 - sistema massa-mola-amortecedor (Caixa branca)

m = 2;
b = 3;
k = 8;


num = [b k]; % Numerador da funcao de transferencia
den = [m b k]; % Denominador da funcao de transferencia
G1 = tf(num, den) % Criando a funcao de transferencia do sistema

figure
step(G1, 15) % Resposta ao degrau
hold on

% Representacao da forca aplicada ao sistema
plot([0 0 15], [0 1 1], "r--", "LineWidth", 1)

grid on

xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-mola-amortecedor (Caixa branca)")
legend("Velocidade do corpo", "Forca aplicada", "Location", "southeast")

%% Circuito RC - Caixa Cinza

R = 1000;
tau = 2;
C = tau/R;
disp(C)

num = 1;
den = [R*C 1];
G1 = tf(num, den)

% Resposta ao degrau
figure
step(G1, 10)
grid on

xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Caixa cinza")

%% Sistema massa-atrito (Caixa Cinza)
m = 4;
f = 1;
v = 0.5;

b = f/v; % f = b * v
disp(b)

% Numerador da funcao de transferencia
num = 1;

% Denominador da funcao de transferencia
den = [m b];

% Criando a funcao de transferencia do sistema
G1 = tf(num, den)

% Resposta ao degrau
figure
step(G1, 100)
hold on

% Representacao da forca aplicada ao sistema
plot([0 0 100], [0 1 1], "r--", "LineWidth", 1)

grid on

xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito - Caixa cinza")
legend("Velocidade do corpo", "Forca aplicada", "Location", "southeast")
