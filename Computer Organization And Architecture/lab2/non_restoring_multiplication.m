clc;
clear;

%% Input
multiplicand = input('Multiplicand: ');
multiplier   = input('Multiplier  : ');

%% Determine number of bits
n = ceil(log2(max(multiplicand, multiplier) + 1));

%% Initialize registers
A = 0;           % Accumulator
Q = multiplier;  % Multiplier register
M = multiplicand; % Multiplicand

fprintf('\nNON-RESTORING MULTIPLICATION: %d × %d\n', multiplicand, multiplier);
fprintf('Bits: %d, A=%d, Q=%d, M=%d\n\n', n, A, Q, M);

fprintf('Step |   Operation    |   A (bin/dec)   |   Q (bin/dec)   | Q0\n');
fprintf('---------------------------------------------------------------\n');

for step = 1:n
    % Save previous A
    prev_A = A;
    
    % Check LSB of Q
    Q0 = bitand(Q,1);
    
    % Operation based on Q0
    if Q0 == 1
        A = A + M;
        op = 'A = A + M';
    else
        op = 'No Add';
    end
    
    fprintf('%3d  | %-13s | %-4s/%-3d | %-4s/%-3d | %d\n', ...
        step, op, dec2bin(A, n), A, dec2bin(Q, n), Q, Q0);
    
    % Shift right Q (logical shift)
    Q = bitshift(Q,-1);
    
    % Shift left A
    A = bitshift(A,1);
    
    % Keep A within n bits
    A = bitand(A, 2^n - 1);
    
    fprintf('     | Shift A left   | %-4s/%-3d | %-4s/%-3d |   \n', ...
        dec2bin(A, n), A, dec2bin(Q, n), Q);
    fprintf('     %s\n', repmat('-',1,55));
end

%% Final Product
product = A + (Q * 2^n);

fprintf('\nFINAL RESULT:\n');
fprintf('Product = %d (%s)\n', product, dec2bin(product,2*n));
fprintf('Verification: %d × %d = %d\n', multiplicand, multiplier, product);