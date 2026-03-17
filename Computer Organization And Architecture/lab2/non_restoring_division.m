clc;
clear;

%% Input
dividend = input('Dividend: ');
divisor = input('Divisor : ');

if divisor == 0, error('Divisor cannot be zero'); end

%% Setup
n = ceil(log2(dividend + 1));
A = 0;
Q = dividend;
M = divisor;

fprintf('\nNON-RESTORING DIVISION: %d ÷ %d\n', dividend, divisor);
fprintf('Bits: %d, A=%d, Q=%d, M=%d\n\n', n, A, Q, M);
fprintf('Step-by-Step Execution:\n');
fprintf('Step |   Operation    |   A (bin/dec)   |   Q (bin/dec)   | Q0\n');
fprintf('---------------------------------------------------------------\n');

for step = 1:n
    % Save previous A
    prev_A = A;
    
    % Shift operation
    fprintf('%3d  | Shift AQ left  | ', step);
    
    % Get MSB of Q
    msb_Q = floor(Q / (2^(n-1)));
    
    % Shift A left and add MSB of Q
    A = 2 * A + msb_Q;
    
    % Shift Q left
    Q = mod(2 * Q, 2^n);
    
    % Display after shift
    fprintf('%-4s/%-3d | ', dec2bin(A, n), A);
    fprintf('%-4s/%-3d |   \n', dec2bin(Q, n), Q);
    
    % Operation based on previous A
    if prev_A >= 0
        A = A - M;
        op = 'A-M';
    else
        A = A + M;
        op = 'A+M';
    end
    
    % Set Q0
    if A >= 0
        Q0 = 1;
    else
        Q0 = 0;
    end
    
    % Update Q with Q0
    Q = floor(Q / 2) * 2 + Q0;
    
    fprintf('     | %-13s | ', op);
    
    % Display after operation
    if A < 0
        A_display = A + 2^n;
        fprintf('%-4s/%-3d | ', dec2bin(A_display, n), A);
    else
        fprintf('%-4s/%-3d | ', dec2bin(A, n), A);
    end
    
    fprintf('%-4s/%-3d | %d\n', dec2bin(Q, n), Q, Q0);
    
    % Separator
    if step < n
        fprintf('     |---------------|-----------------|-----------------|----\n');
    end
end

%% Final restoration
fprintf('     |---------------|-----------------|-----------------|----\n');
if A < 0
    A = A + M;
    fprintf('Final| Restoration   | %-4s/%-3d | %-4s/%-3d |\n', dec2bin(A, n), A, dec2bin(Q, n), Q);
else
    fprintf('Final| No Restoration| %-4s/%-3d | %-4s/%-3d |\n', dec2bin(A, n), A, dec2bin(Q, n), Q);
end
fprintf('---------------------------------------------------------------\n');

%% Results
fprintf('\nFINAL RESULTS:\n');
fprintf('Quotient  = %d (%s)\n', Q, dec2bin(Q, n));
fprintf('Remainder = %d (%s)\n', A, dec2bin(A, n));
fprintf('\nVerification: %d = %d × %d + %d\n', dividend, divisor, Q, A);