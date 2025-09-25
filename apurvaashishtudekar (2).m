%% EXE 1
%1.a
C=[10 20 30, 40 50 60, 70 80 90];
A=[5 5 5 ,5 5 5 ,5 5 5 ];
K=C-A
%1.b
C.*[1;3;1]
%1.C
 C(:,3)=sqrt(C(:,3))
 D=zeros(3, 3)
 D=C'
%% EXE 2
E=[-1,2 -3;4 -5 6;-7 8 -9];
%2.b
eig_E = eig(E);
%2.c
rank(E)
%2.d
X=inv(E)
%2.a
v=[0:0.2:10];
S = std(v)
J=mean(v)
%% EXE 3p
height = (5);
    base = (10);
    calculateTriangleArea = 0.5*height*base
    %Q6
syms x y 
eq1Ex2 = x + 2*y == 5;
eq2Ex2 = 3*x - 4*y== -2;
solutionsSystemEx2 = solve([eq1Ex2, eq2Ex2], [x, y]);
disp('Solutions to the system of equations:');
disp([solutionsSystemEx2.x, solutionsSystemEx2.y]);
%Q7
%The fmincon function helps in finding the global minima function. 
% For non linear optimization fminunc is recommended more than the fmincon to find the local minima of the funciton
%code = optimalproblem( 'ObjectiveSense' , 'max' ); finds the max insteadof a minimum by replacing min with max
    
%8
x1=1,x2=1,x3=1;  % assume some input values 
R = @(x1,x2,x3) 10*x1+10*x2+10*x3;  % use funciton handle to define the equations
C = @(x1,x2,x3) 1*x1^2+1.5*x2^2+0.5*x3^3;
P = R(x1,x2,x3) - C(x1,x2,x3)  % apply the profit equation
%% 4 p
X = normrnd(0,10,[1000 1]);
while X <= 100
disp(X);
X = X + 1;
if X==100.1
break
end
end
histogram(X); % Creating a histogram
title('Histogram of Generated Values');
xlabel('Value');
ylabel('Frequency');