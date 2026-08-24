clc;
clear all;
close all;

%% sistema massa-atrito (caixa branca) --> comparação gráfica
m1 = 2;
b1 = 3;
m2 = 4;
b2 = 6;

num = 1;
den1 = [m1 b1];
den2 = [m2 b2];

G1 = tf(num, den1)
G2 = tf(num, den2)

% Resposta ao degrau

figure
step(G1, 20)
hold on
step(G2, 20)
% Representacao da forca aplicada ao sistema
plot([0 0 20], [0 1 1], "r--", "LineWidth", 1)

grid on

xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito - Caixa branca")
legend("Velocidade do corpo 1","Velocidade do corpo 2", "Forca aplicada", "Location", "southeast")

% [posicao horizontal, posicao vertical, largura, altura]
axes('Position',[0.2 0.3 0.2 0.4])

box on   % Mostra a borda da nova janela
step(G1, 5)
hold on
step(G2, 5)

xlim([0 5])
grid on

figure
%---------------------------------------------------------------
% subplot(linhas, colunas, posicao)
subplot(2,1,1)
step(G1, 20)
xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito 1")

subplot(2,1,2)
step(G2, 20)
xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito 2")

%% Circuito RC e comparação de escalas

r = 2000;
tau = 2.5;
C = tau/r;
disp(C)

num = 1;
den = [r*C 1];
G1 = tf(num, den)

% Resposta ao degrau
figure
step(G1, 15)
grid on

xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Caixa cinza")

Rteste = 100:100:10000;
tau = C * Rteste;

figure

subplot(2,2,1)
plot(Rteste,tau)
grid on
xlabel('resistencias')
ylabel('tau')
title('escala normal')


subplot(2,2,2)
semilogy(Rteste,tau)
grid on
xlabel('resistencias')
ylabel('tau')
title('escala log em y')

subplot(2,2,3)
semilogx(Rteste,tau)
grid on
xlabel('resistencias')
ylabel('tau')
title('escala log em x')

subplot(2,2,4)
loglog(Rteste,tau)
grid on
xlabel('resistencias')
ylabel('tau')
title('escala log em x e y')

%% 3 identificação e visualização de dados experimentais (caixa preta)
t = (0:25)';
u =  [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
y =  [0.008 0.012 0.006 0.010 0.020 0.382 0.671 0.903 1.082 1.226 1.335 1.425 1.492 1.547 1.587 1.618 1.642 1.660 1.674 1.684 1.692 1.698 1.702 1.706 1.709 1.711];
u = u';
y = y';

figure
subplot(2,1,1)
plot(t,u)
grid on
xlabel('t')
ylabel('u')
title('Entrada')

subplot(2,1,2)
plot(t,y)
grid on
xlabel('t')
ylabel('y')
title('Saída')

figure
plot3(t,u,y)
grid on
xlabel('t')
ylabel('u')
zlabel('y')


Ts = 1; %tempo de amostragem dos dados
dados = iddata(y, u, Ts); % Organizando entrada, saida e tempo de amostragem

% Estimando uma funcao de transferencia
G1 = tfest(dados, 1, 0) % tfest(dados, quantidade de polos, quantidade de zeros)

figure
compare(dados, G1) % Comparacao entre os dados e o modelo identificado
grid on

figure
step(G1, 25) % Resposta ao degrau do modelo identificado
grid on

xlabel("Tempo (s)")
ylabel("Saida")
title("Modelo identificado - Caixa preta")

%% 4 - análise de diferente circuitos RC
R = [1000 2000 3000 5000];
tau = [1.2 2.8 3.9 7];
C = tau./R

figure
plot3(R,tau,C)
grid on
xlabel('R')
ylabel('tau')
zlabel('C')

num = 1;
den = [R(3)*C(3) 1];
G1 = tf(num, den) % Função de transferencia do experimento 3

% Resposta ao degrau
figure
step(G1, 20)
grid on

xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Caixa cinza")

% [posicao horizontal, posicao vertical, largura, altura]
axes('Position',[0.2 0.3 0.2 0.4])

box on   % Mostra a borda da nova janela
step(G1, 20)
grid on

% Regiao que sera mostrada na ampliacao
xlim([0 5])

%% 5 - análise completa dos 3 tipos de modelagem

% massa atrito
m = 3;
b = 5;
num = 1;
den = [m b];
G1 = tf(num, den)

% rc
r = 1500;
tau = 3;
c = tau/r
num = 1;
den = [r*c 1];
G2 = tf(num, den)

% caixa preta
t = (0:20)';
u = [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
y = [0.010 0.006 0.012 0.018 0.408 0.706 0.934 1.103 1.229 1.322 1.391 1.441 1.479 1.505 1.526 1.540 1.551 1.558 1.564 1.568 1.571];
ts = 1;

dados = iddata(y', u', ts); % Organizando entrada, saida e tempo de amostragem

% Estimando uma funcao de transferencia
G3 = tfest(dados, 1, 0) % tfest(dados, quantidade de polos, quantidade de zeros)

figure
subplot(3,1,1)
step(G1,20)
grid on
xlabel('tempo')
ylabel('G1')
title('Massa-atrito')

subplot(3,1,2)
step(G2,20)
grid on
xlabel('tempo')
ylabel('G2')
title('RC')

subplot(3,1,3)
step(G3,20)
grid on
xlabel('tempo')
ylabel('G3')
title('Caixa preta')

figure
subplot(2,1,1)
plot(t,u)
xlabel('tempo')
ylabel('u')
title('entrada')
grid on

subplot(2,1,2)
plot(t,y)
xlabel('tempo')
ylabel('y')
title('saída')
grid on


figure
compare(dados, G3) % Comparacao entre os dados e o modelo identificado
grid on

% caixa branca: todos os parametros e equações do sistema são conhecidos
% caixa cinza: alguns parâmetros do sistema são desconhecidos e precisam
% ser calculados/estimados
% caixa preta: a física do sistema não é conhecida