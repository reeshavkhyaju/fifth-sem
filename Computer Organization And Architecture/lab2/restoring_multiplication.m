clc;
clear;

%% User Input
multiplicand = input('Enter the multiplicand (non-negative integer): ');
multiplier   = input('Enter the multiplier   (non-negative integer): ');

%% Determine number of bits
n = ceil(log2(max(multiplicand, multiplier) + 1));

%% Initialize registers
A = 0;           % Accumulator
Q = multiplier;  % Multiplier register
M = multiplicand; % Multiplicand

fprintf('\nRestoring Multiplication Algorithm\n');
fprintf('==============================\n');
fprintf('Multiplicand: %d, Multiplier: %d (%d bits)\n', multiplicand, multiplier, n);
fprintf('Initial: A = %s, Q = %s\n', dec2bin(A, n), dec2bin(Q, n));

fprintf('\nStep | Operation         | A (bin/dec)   | Q (bin/dec)   | Action\n');
fprintf('---------------------------------------------------------------\n');

%% Main loop – n iterations
for step = 1:n
    fprintf('%4d | Shift A left      | ', step);
    
    % Shift A left
    A = bitshift(A, 1);
    
    % Shift Q left and bring in carry from A if needed (logical shift)
    Q = bitshift(Q, 1);
    Q = bitand(Q, 2^n - 1);  % Keep only n bits
    
    fprintf('%s / %-3d | %s / %-3d | -\n', dec2bin(A, n), A, dec2bin(Q, n), Q);
    
    % Add M to A if LSB of Q (original before shift) was 1
    Q0 = bitand(Q,1);  % LSB of Q after shift
    if Q0 == 1
        A = A + M;
        action = 'A = A + M';
    else
        action = 'No Add';
    end
    
    fprintf('     | %-17s | %s / %-3d | %s / %-3d | %s\n', ...
        action, dec2bin(A, n), A, dec2bin(Q, n), Q, action);
    
    % Optional: restore if A exceeds max bits (not needed for unsigned small numbers)
    
    fprintf('     %s\n', repmat('-',1,55));
end

%% Final Product
product = A + Q; % Combine accumulator and multiplier logically

fprintf('\nFINAL RESULT:\n');
fprintf('Product = %d (%s)\n', product, dec2bin(product, 2*n));
fprintf('Verification: %d × %d = %d\n', multiplicand, multiplier, product);