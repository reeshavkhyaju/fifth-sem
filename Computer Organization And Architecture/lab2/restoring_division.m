clc;
clear;

%% User Input
dividend = input('Enter the dividend (non-negative integer): ');
divisor = input('Enter the divisor  (non-negative integer): ');

if divisor == 0
    error('Division by zero is not allowed.');
end

%% Determine number of bits
n = ceil(log2(dividend + 1));  % Bits needed for dividend

%% Initialize registers
A = 0;                 % Remainder accumulator (n bits)
Q = dividend;          % Dividend/Quotient (n bits)
M = divisor;           % Divisor

%% Display header
fprintf('\nRestoring Division Algorithm\n');
fprintf('==============================\n');
fprintf('Dividend: %d, Divisor: %d (%d bits)\n', dividend, divisor, n);
fprintf('Initial: A = %s, Q = %s\n', dec2bin(A, n), dec2bin(Q, n));
fprintf('\nStep | Operation     | A          | Q          | Q0\n');
fprintf('-------------------------------------------------------\n');

%% Main algorithm loop
for step = 1:n
    fprintf('%4d | Left shift AQ | ', step);
    
    % Shift A and Q left by 1 bit
    A = bitshift(A, 1);  % Shift A left by 1
    A = bitor(A, bitshift(Q, -(n-1)));  % Get MSB of Q into LSB of A
    Q = bitshift(Q, 1);  % Shift Q left by 1
    Q = bitand(Q, 2^n - 1);  % Keep only n bits
    
    fprintf('%s | %s | - \n', dec2bin(A, n), dec2bin(Q, n));
    
    % Subtract M from A
    A = A - M;
    fprintf('     | A = A - M     | %s | %s |   \n', ...
            dec2bin(mod(A, 2^n), n), dec2bin(Q, n));
    
    % Check if A is negative
    if A < 0
        % Restore A (add M back) and set Q0 = 0
        A = A + M;
        Q0 = 0;
        fprintf('     | Restore (A+M) | %s | %s | %d \n', ...
                dec2bin(A, n), dec2bin(Q, n), Q0);
    else
        % Don't restore, set Q0 = 1
        Q0 = 1;
        fprintf('     | No restore    | %s | %s | %d \n', ...
                dec2bin(A, n), dec2bin(Q, n), Q0);
    end
    
    % Set LSB of Q to Q0
    Q = bitshift(Q, -1);  % First clear the LSB (by shifting right then left)
    Q = bitshift(Q, 1);
    Q = bitor(Q, Q0);  % Set LSB to Q0
    
    fprintf('     | Set Q0=%d      | %s | %s |   \n', ...
            Q0, dec2bin(A, n), dec2bin(Q, n));
    fprintf('     %s\n', repmat('-', 1, 55));
end

%% Final results
quotient = Q;
remainder = A;

fprintf('\n%s\n', repmat('=', 1, 40));
fprintf('Quotient:  %d\n', quotient);
fprintf('Remainder: %d\n', remainder);
fprintf('\nVerification:\n');
fprintf('%d / %d = %d with remainder %d\n', ...
        dividend, divisor, quotient, remainder);
fprintf('%d = %d × %d + %d\n', ...
        dividend, divisor, quotient, remainder);