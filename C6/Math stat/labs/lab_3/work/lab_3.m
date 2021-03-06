disp("Lab 3")
pkg load statistics

T=[-5.00,-4.80,-4.60,-4.40,-4.20,-4.00,-3.80,-3.60,-3.40,-3.20,-3.00,-2.80,-2.60,-2.40,-2.20,-2.00,-1.80,-1.60,-1.40,-1.20,-1.00,-0.80,-0.60,-0.40,-0.20,0.00,0.20,0.40,0.60,0.80,1.00,1.20,1.40,1.60,1.80,2.00,2.20,2.40,2.60,2.80,3.00,3.20,3.40,3.60,3.80,4.00,4.20,4.40,4.60,4.80,5.00,5.20,5.40,5.60,5.80,6.00,6.20,6.40,6.60,6.80,7.00];
Y=[197.43,183.86,178.27,161.81,140.28,118.66,117.68,103.34,88.89,72.14,67.75,57.64,51.03,39.72,29.88,31.69,17.22,23.26,7.05,4.66,-5.12,0.40,7.94,2.95,-0.36,-7.17,-4.61,10.91,-5.12,13.11,7.01,19.83,19.63,30.48,21.92,39.36,47.14,54.18,64.60,80.99,82.72,110.69,122.67,137.00,153.09,145.66,170.25,197.83,214.42,222.67,251.72,256.63,280.05,302.21,323.86,349.56,367.37,399.31,419.74,442.23,470.16];

function Psi = psiMat(T)
  n = numel(T);
  p = 3;
  Psi = zeros(n, p);
  for i = 1:n
    Psi(i, 1) = 1;
    Psi(i, 2) = T(i);
    Psi(i, 3) = T(i) * T(i);
  endfor
endfunction

function delta = calcDelta(y, y_new)
  n = numel(y);
  sum = 0;
  for i = 1:n
    sum = sum + (y(i) - y_new(i)) * (y(i) - y_new(i)); 
  endfor
  delta = sqrt(sum);
endfunction

psiMatrix = psiMat(T);
theta = (psiMatrix' * psiMatrix) \ (psiMatrix' * Y');
theta

n = numel(Y);
y = zeros(1, n);
for i =  1:n
  y(i) = theta(1) + theta(2) * T(i) + theta(3) * T(i) * T(i);
endfor

delta = calcDelta(Y, y);
delta

figure();
hold on;
plot(T, Y, 'b');
plot(T, y, 'r');
hold off;