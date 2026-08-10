%% 
clc
clear all
close all

%% 1
medicao = zeros(3,1);

for i = 1:3
    medicao(i) = input('Medição: ');
end

media = mean(medicao);

fprintf("Media: %f \n", media);
fprintf("Maior: %f \n", max(medicao));
fprintf("Menor: %f \n", min(medicao));

if media > 8
    disp('Resultado alto')
elseif media < 5
    disp('Resultado baixo')
else
    disp('Resultado Intermediário')
end

%% 2

A = [3 8 2 10 5 7 1 6];
B = zeros(size(A));

for i = 1:length(A)
    if A(i) > 6
        B(i) = 2 * A(i);
    else
        B(i) = A(i) + 3;
    end
end

disp(A)
disp(B)
fprintf('soma %f \n',sum(B))
fprintf('media %f \n',mean(B))
fprintf('max %f \n',max(B))
fprintf('min %f \n',min(B))

%% 3

A = [14 7 20 9 6 11 18 5];
B = zeros(size(A));
par = 0;

for i = 1:length(A)
    resto = rem(A(i),2);
    if resto == 0
        B(i) = A(i);
        par = par + 1;
    else
        B(i) = 0;
    end
end

disp(B)
disp(par)

%% 4

valor1 = input('A: ');
valor2 = input('B: ');

fprintf('1 - Soma \n2 - Subtracao \n3 - Multiplicacao \n4 - Divisao \n');
var = input('Opcao: ');

switch var
    case 1
        fprintf('A+B= %f \n', valor1+valor2)
    case 2
        fprintf('A-B= %f \n', valor1-valor2)
    case 3
        fprintf('A*B= %f \n', valor1*valor2)
    case 4
        if valor2 ~= 0
            fprintf('A/B= %f \n', valor1/valor2)
        else
            fprintf('Divisao por 0 \n')
        end
    otherwise
        fprintf('Opcao invalida \n')

end

%% 5 

soma = 0;
contador = 0;

while soma <= 4
    r = rand(1);
    soma = soma + r;
    contador = contador + 1;
    disp(r)
    disp(soma)
end

if contador > 8
    disp('Muitas repetiçoes')
else
    disp('Poucas repeticoes')
end

disp(contador)

%% 6

A = [2 7 4 9;
    6 1 8 3];
B = zeros(size(A));

for j = 1:size(A,1)
    for i = 1:size(A,2)
        if A(j,i) > 5
            B(j,i) = A(j,i) * 2;
        else
            B(j,i) = A(j,i) + 5;
        end
    end
end
disp('A')
disp(A)
disp('B')
disp(B)
disp('B transposta')
disp(B')
disp('linha 1')
disp(B(1,:))
disp('coluna 3')
disp(B(:,3))

%% 7
A = [5 12 7 3 9 14];
[soma, media] = analisa_vetor(A);

if media >= 8
    disp('Media elevada')
else
    disp('Media abaixo de 8')
end

fprintf('Soma: %f \n', soma)
fprintf('Media: %f \n', media)
 
%% 8
A = [1 5 3 8;
    6 2 7 4];
B = zeros(size(A));
C = transforma_matriz(A,B);
disp(C)

%% 9
valor1 = input('A: ','s');
valor2 = input('B: ','s');

disp(valor1)
disp(valor2)

valor1 = str2num(valor1);
valor2 = str2num(valor2);

soma = valor2 + valor1;
mult = valor1 * valor2;

fprintf('soma: %f \n', soma)
fprintf('multiplicacao: %f \n', mult)

if soma > 20
    disp('soma alta')
elseif soma < 20 
    disp('soma baixa')
else
    disp('soma igual a 20')
end

%%
dados = [12 18 10 25 15];
soma = sum(dados)
media = mean(dados)
maxi = max(dados)
mini = min(dados)

med = 0;
for i=1:length(dados)
    if dados(i) >= media
        med = med + 1;
    end
end

fprintf('1 - Barras \n2 - Pizza \n');
var = input('Op: ');
switch var
    case 1
        bar(dados)
        title('Dados')
    case 2
        pie3(dados)
        title('Pizza')

    otherwise
        warning('Opcao invalida')

end

if med >= 5
    disp('maioria acima ou igual a media')
else
    disp('menos da metade dos valores acima da media')
end