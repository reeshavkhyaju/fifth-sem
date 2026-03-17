clc;
clear;

%% User Input
M = input('Enter the multiplicand (signed integer): ');
Q = input('Enter the multiplier   (signed integer): ');

%% Determine number of bits needed
% We need enough bits for the largest absolute value + sign bit
max_val = max(abs([M, Q]));
n = ceil(log2(max_val + 1)) + 1; % +1 for sign bit
n = max(n, 4); % Minimum 4 bits for meaningful demonstration

fprintf('Using %d-bit representation\n', n);

%% Convert M and Q to n-bit 2's complement representation
if M < 0
    M_bin = 2^n + M;  % 2's complement for negative numbers
else
    M_bin = M;
end

if Q < 0
    Q_bin = 2^n + Q;  % 2's complement for negative numbers
else
    Q_bin = Q;
end

% Convert to binary strings for display
M_bin_str = dec2bin(M_bin, n);
Q_bin_str = dec2bin(Q_bin, n);

%% Initialize Registers
A = 0;          % Accumulator (n bits)
Q_reg = Q_bin;  % Multiplier (n bits)
M_reg = M_bin;  % Multiplicand (n bits)
Q_minus1 = 0;   % Q_{-1} bit

fprintf('\nBooth''s Algorithm Step-by-Step\n');
fprintf('=========================================\n');
fprintf('M = %d (binary: %s), Q = %d (binary: %s)\n', M, M_bin_str, Q, Q_bin_str);
fprintf('Initial values: A = 0, Q = %d, Q_{-1} = 0\n\n', Q_bin);

fprintf('Step |  Q0  | Q_{-1} | Operation     |       A (dec)       |       Q (dec)       \n');
fprintf('--------------------------------------------------------------------------------\n');

%% Booth's Algorithm - n iterations
for step = 1:n
    % Get Q0 (LSB of Q)
    Q0 = bitand(Q_reg, 1);
    
    % Debug: Show current state before operation
    fprintf('%4d |   %d  |   %d    ', step, Q0, Q_minus1);
    
    % Perform operation based on Q0 and Q_{-1}
    if Q0 == 0 && Q_minus1 == 1
        % A = A + M
        A = A + M_reg;
        if A >= 2^n
            A = A - 2^n;  % Handle overflow
        end
        fprintf('| A = A + M   ');
    elseif Q0 == 1 && Q_minus1 == 0
        % A = A - M
        A = A - M_reg;
        if A < 0
            A = A + 2^n;  % Handle underflow (2's complement wrap)
        end
        fprintf('| A = A - M   ');
    else
        fprintf('| No Operation');
    end
    
    % Display current A and Q values in decimal and hex
    fprintf(' | %12d (0x%s)', A, dec2hex(A, ceil(n/4)));
    fprintf(' | %12d (0x%s)', Q_reg, dec2hex(Q_reg, ceil(n/4)));
    fprintf('\n');
    
    % Save LSB of Q for next iteration's Q_{-1}
    next_Q_minus1 = Q0;
    
    % Get LSB of A
    A_LSB = bitand(A, 1);
    
    % Arithmetic Right Shift of A (preserve sign bit)
    A_sign_bit = bitget(A, n);  % Get current sign bit (MSB)
    A = bitshift(A, -1);  % Arithmetic right shift
    
    % If original A was negative, set new MSB to 1
    if A_sign_bit == 1
        A = bitor(A, bitshift(1, n-1));
    end
    
    % Right shift Q: LSB comes from A's original LSB, shift Q right
    Q_MSB = bitget(Q_reg, n);  % Get current MSB of Q
    Q_reg = bitshift(Q_reg, -1);  % Right shift Q
    
    % Set MSB of Q to the original LSB of A
    if A_LSB == 1
        Q_reg = bitor(Q_reg, bitshift(1, n-1));
    end
    
    % Update Q_{-1} for next iteration
    Q_minus1 = next_Q_minus1;
end

%% Combine A and Q to get final product
% Convert A and Q to unsigned integers for proper combination
A_uint = uint32(A);
Q_uint = uint32(Q_reg);

% Combine A (n bits) and Q (n bits) to get 2n-bit result
combined = bitshift(uint64(A_uint), n) + uint64(Q_uint);
product_bits = 2*n;

% Convert to signed integer (handling 2's complement)
if combined >= bitshift(uint64(1), product_bits - 1)
    % Negative number in 2's complement
    product_signed = double(combined) - double(bitshift(uint64(1), product_bits));
else
    % Positive number
    product_signed = double(combined);
end

%% Display results
fprintf('\n');
fprintf('%s\n', repmat('=', 1, 50));
fprintf('FINAL RESULT\n');
fprintf('%s\n', repmat('=', 1, 50));
fprintf('A (binary): %s\n', dec2bin(A, n));
fprintf('Q (binary): %s\n', dec2bin(Q_reg, n));
fprintf('Combined product (binary): %s\n', dec2bin(combined, 2*n));
fprintf('Product in decimal: %d\n', product_signed);
fprintf('Expected product (M × Q): %d\n', M * Q);

% Verification
if product_signed == M * Q
    fprintf('\nVERIFIED: Booth''s algorithm result matches expected value!\n');
else
    fprintf('\nERROR: Result does not match expected value!\n');
    fprintf('   Difference: %d\n', abs(product_signed - M * Q));
end

% Display in a nice format
fprintf('\n');
fprintf('%s\n', repmat('-', 1, 50));
fprintf('SUMMARY:\n');
fprintf('  %d × %d = %d\n', M, Q, product_signed);
fprintf('%s\n', repmat('-', 1, 50));