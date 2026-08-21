clc;
clear all;
close all;

%% 1 - funções e gráficos 2D
t = 0:0.1:10;
seno = 2*sin(3*t);
cosseno = 2*cos(3*t);

figure
plot(t,seno)

hold on
plot(t,cosseno)
hold off

grid on
xlabel("Tempo");
ylabel("Amplitude");
title("Senoide e cossenoide")
legend('seno','cosseno');

%% 2 - entrada de dados, condição e gráfico
a = input('A: ');
x = -10:10;
y = a*x + 2;

if a < 0
    disp('Coef negativo')
elseif a > 0
    disp('Coef positivo')
else
    disp('Coef igual a zero')
end

figure
plot(x,y)

% destacando uma região visualmente
grid on
xlabel('Tempo')
ylabel('Amplitude')
title('Ampliacao - Reta')

% [posicao horizontal, posicao vertical, largura, altura]
axes('Position',[0.2 0.3 0.2 0.4])

box on   % Mostra a borda da nova janela

plot(x,y,'g','LineWidth',1.5)

grid on

% Regiao que sera mostrada na ampliacao
xlim([-2 2])

%% 3 - Repetição e organização de gráficos
x = 1:5;
v = ones(5,1);
for i = 1:5
    v(i) = v(i) * 3 * i;
end

% Subplot - 2 linhas e 1 coluna
figure

% subplot(linhas, colunas, posicao)
subplot(2,1,1)
plot(x,v)
xlabel('x')
ylabel('3*x')
title('Multiplos de 3')

subplot(2,1,2)
plot(x,2*v)
xlabel('x')
ylabel('6*x')
title('Multiplos de 6')

%% 4 - comparação de escalas

t = 1:100;
y = 50000*exp(-0.05*t);

% Escala normal
figure()    % Abre ou seleciona a Figura 1
subplot(2,1,1)
plot(t,y)
grid on

xlabel('Tempo (s)')
ylabel('Amplitude')
title('Escala normal')

% Escala logaritmica no eixo Y
% O eixo X continua normal e apenas Y fica logaritmico

subplot(2,1,2)
semilogy(t,y)
grid on

xlabel('Tempo (s)')
ylabel('Amplitude')
title('Escala logaritmica em Y')

%% 5 - Gráficos 3D

% Criando uma malha com meshgrid
x = 1:10;
y = 1:20;

[x,y] = meshgrid(x, y); % meshgrid cria as coordenadas X e Y da superficie

z = sin(x) + cos(y);

figure
surf(x,y,z)

colormap("summer") % colormap altera as cores utilizadas no grafico
shading interp     % shading interp suaviza a transicao entre as cores

xlabel('x')
ylabel('y')
zlabel('z')

% Grafico de contorno

figure
contour(z,5) % contour mostra as curvas de nivel da superficie

colormap default

xlabel('x')
ylabel('y')