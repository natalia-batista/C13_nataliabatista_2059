clc
close all
clear all

%% 1 - entrada e saida
in = input('Cidade: ', 's');
disp(in)

fprintf("Cidade escolhida: %s \n", in)

%% if elseif else
x = 11;

if x > 10
    disp('Maior que 10')
elseif x == 10
    disp('Igual a 10')
else
    disp('Menor que 10')
end

%% for

for i = 1:5
    disp(i*3)
end

%% while
x = 0;
i = 0;

while i < 5
    x = x + 1;
    i = i + 1;
    disp(x)
end

%% switch
opcao = 1;

switch opcao

    case 1
        disp('Opcao A')

    case 2
        disp('Opcao B')

    case 3
        disp('Opcao C')

    otherwise
        disp('Opcao Invalida')

end

%% função
funcao_triplo(10)