clc;
clear;

% User inputs
multiplicand = input('Enter the multiplicand (unsigned integer): ');
multiplier   = input('Enter the multiplier   (unsigned integer): ');

% Initialization
M = multiplicand;
Q = multiplier;
A = 0;                         % Accumulator
n = length(dec2bin(Q));        % Number of bits in multiplier

fprintf('\nUnsigned Shift-Add Multiplication\n');
fprintf('--------------------------------\n');
fprintf('Multiplicand (M) = %d (%s)\n', M, dec2bin(M,8));
fprintf('Multiplier   (Q) = %d (%s)\n', Q, dec2bin(Q,n));
fprintf('Accumulator  (A) = %s\n\n', dec2bin(A,8));

fprintf('Step | Q        | Q0 | Operation        | A (Accumulator) | M (Multiplicand)\n');
fprintf('--------------------------------------------------------------------------------\n');

for step = 1:n
    
    Q0 = bitand(Q,1);   % LSB of multiplier
    
    if Q0 == 1
        A = A + M;
        operation = 'A = A + M';
    else
        operation = 'No Add';
    end
    
    fprintf('%4d | %8s |  %d | %-15s | %15s | %15s\n', ...
        step, dec2bin(Q,n), Q0, operation, dec2bin(A,8), dec2bin(M,8));
    
    % Shift operations
    M = bitshift(M,1);   % Left shift multiplicand
    Q = bitshift(Q,-1);  % Right shift multiplier
end

fprintf('\nFinal Result:\n');
fprintf('Product = %d\n', A);
fprintf('Binary  = %s\n', dec2bin(A,8));
