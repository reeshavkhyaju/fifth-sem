clc;
clear;

%% User Inputs
multiplicand = input('Enter the multiplicand (signed integer): ');
multiplier   = input('Enter the multiplier   (signed integer): ');

% Determine number of bits needed (including sign bit)
n = max(length(dec2bin(abs(multiplicand))), length(dec2bin(abs(multiplier)))) + 1;

% Convert to 2's complement representation for negative numbers
if multiplicand < 0
    M = 2^n + multiplicand;  % Two's complement
else
    M = multiplicand;
end

if multiplier < 0
    Q = 2^n + multiplier;    % Two's complement
else
    Q = multiplier;
end

A = 0;  % Accumulator

fprintf('\nSigned Shift-Add Multiplication\n');
fprintf('--------------------------------\n');
fprintf('Multiplicand (M) = %d (%s)\n', multiplicand, dec2bin(M,n));
fprintf('Multiplier   (Q) = %d (%s)\n', multiplier, dec2bin(Q,n));
fprintf('Accumulator  (A) = %s\n\n', dec2bin(A,n));

fprintf('Step | Q          | Q0 | Operation        | A (Accumulator) | M (Multiplicand)\n');
fprintf('---------------------------------------------------------------------------------\n');

for step = 1:n
    Q0 = bitand(Q,1);  % LSB of multiplier
    
    if Q0 == 1
        A = A + M;
        % Keep only n bits (simulate overflow)
        A = bitand(A, 2^n - 1);
        operation = 'A = A + M';
    else
        operation = 'No Add';
    end
    
    fprintf('%4d | %10s |  %d | %-15s | %15s | %15s\n', ...
        step, dec2bin(Q,n), Q0, operation, dec2bin(A,n), dec2bin(M,n));
    
    % Shift operations
    M = bitshift(M,1);   % Left shift multiplicand
    M = bitand(M, 2^n - 1);  % Keep n bits
    
    Q = bitshift(Q,-1);  % Right shift multiplier
end

% Determine final product in decimal
% Convert back from two's complement if necessary
if bitget(A,n) == 1  % Negative number
    product = A - 2^n;
else
    product = A;
end

fprintf('\nFinal Result:\n');
fprintf('Product = %d\n', product);
fprintf('Binary  = %s\n', dec2bin(A,n));