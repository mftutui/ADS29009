%Extract from Intuitive probability and random process using MATLAB Steven Kay Springer, 2006. 
%We have two books in the library

clear all;
clc;

rand('state',0)
N=100000;  % set number of samples desired
p0=[1 0 0 0 0 0 0 0 0 0]'; % set initial probability vector
P = [ 
          0.2    0    0.8    0    0    0    0    0    0    0;
          0    0.2    0.3  0.3  0.2  0    0    0    0    0;
          0    0    0.1    0    0    0.9  0    0    0    0;
          0    0    0    0    0    0    1.0  0    0    0;
          0    0    0    0    0    0.3  0.7  0    0    0;
          0    0    0    0    0    0    0    0.2  0    0.8;
          0    0    0    0    0    0    0    0    0.8  0.2;
          1.0  0    0    0    0    0    0    0    0    0;
          0    1.0  0    0    0    0    0    0    0    0;
          0.2 0.6  0    0    0    0    0    0    0    0.2;
         ]; % set transition prob. matrix
     
xi=[0 1 2 3 4 5 6 7 8 9]'; % set values of PMF
X0=PMFdata(1,xi,p0); % generate X[0] (see Appendix 6B for PMFdata.m 
                 % function subprogram)
i=X0+1; % choose appropriate row for PMF
X(1,1)=PMFdata(1,xi,P(i,:)); % generate X[1]
i=X(1,1)+1; % choose appropriate row for PMF

for n=2:N % generate X[n]
    i=X(n-1,1)+1; % choose appropriate row for PMF
    X(n,1)=PMFdata(1,xi,P(i,:)); 
end

states = zeros(1, 10);
flag = 0;
soma = 0;
aux = [];

for i=1:length(X)
    states(X(i)+1) = states(X(i)+1)+1;
    
    if X(i) == 0 && flag == 0
        flag = 1;
        soma = 0;
    elseif X(i) == 5 && flag == 1
        flag = 0;
        soma = soma + 1;
        aux = [aux soma];
    elseif flag == 1 
        soma = soma + 1;
    end
    
end

states = states/N;

bar(xi + 1 ,states * 100)
title('Histograma de ocupacao')
xlabel('Estado')
ylabel('Ocupacao (%)')

[Vmin,Imin] = min(states);
disp(['O estado ', num2str(Imin), ' possui a menor ocupa??o, que corresponde a ', num2str(Vmin * 100), '%.']);

[Vmax,Imax] = max(states);
disp(['O estado ', num2str(Imax), ' possui a maior ocupa??o, que corresponde a ', num2str(Vmax * 100), '%.']);

av_time = sum(aux)/length(aux);
disp(['Tempo m?dio de ocorr?ncia para ir do estado 0 para o estado 5: ', num2str(av_time), ' ?pocas.' ]);