clc
clear
close all

%% 1 - operações básicas
a = 12;
b = 5;

soma = a + b
sub = a - b
mult = a * b
div = a / b
pot = a ^ b

%% 2 - raiz, arredondamento e resto

raiz = sqrt(144)
arredondado = round(7.6)
arr_cima = ceil(4.01)
resto = mod(250,17)

%% 3 - MDC e MMC

mdc = gcd(24,36)
mmc = lcm(12,18)

%% 4 - exponencial e trigonometria

e = exp(2)
s = sind(30)
c = cosd(60)
t = tand(45)

%% 5 - criando vetores

v = 1:10
v2 = 10:-1:1
v3 = 0:2:20
v4 = linspace(0,100,5)

%% 6 - acessando posiçoes

v = [4 8 15 16 23 42]
v(1)
v(end)
v(2:4)
v([1,3,6])

%% Informações sobre um vetor
v = [5 10 15 20 25]
length(v)
size(v)
sum(v)
mean(v)
max(v)
min(v)

%% vetor linha e vetor coluna

v = [10 20 30 40]
vt = v'
size(v)
size(vt)

%% criando e acessando matriz
A = [3 6 9;
    2 4 8;
    1 5 7]

A(2,3)
A(1,:)
A(:,2)
size(A)

%% operações com matrizes
A = [1 2;
    3 4]

B = [2 0;
    1 5]

soma = A + B
mult = A * B
At = A'

zeros(3)
ones(2,4)
eye(4)
rand(3)