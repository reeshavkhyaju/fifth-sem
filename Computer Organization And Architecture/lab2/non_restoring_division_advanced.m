clc;
clear;

%% ASCII Art Header
fprintf('╔══════════════════════════════════════════════════════════════╗\n');
fprintf('║              NON-RESTORING DIVISION ALGORITHM                ║\n');
fprintf('╚══════════════════════════════════════════════════════════════╝\n\n');

%% User Input with validation
while true
    dividend = input('Enter dividend (non-negative integer): ');
    if dividend >= 0
        break;
    else
        fprintf('❌ Dividend must be ≥ 0. Please try again.\n');
    end
end

while true
    divisor = input('Enter divisor (positive integer): ');
    if divisor > 0
        break;
    else
        fprintf('❌ Divisor must be > 0. Please try again.\n');
    end
end

%% Determine number of bits
n = ceil(log2(dividend + 1));

%% Initialize Registers as int32
A = int32(0);           % Accumulator/Remainder
Q = int32(dividend);    % Dividend/Quotient
M = int32(divisor);     % Divisor

%% Display Setup Information
fprintf('\n┌────────────────────────────────────────────────────────────┐\n');
fprintf('│                         SETUP                               │\n');
fprintf('├────────────────────────────────────────────────────────────┤\n');
fprintf('│ Dividend: %6d  → Binary: %-10s                  │\n', dividend, dec2bin(Q, n));
fprintf('│ Divisor : %6d  → Binary: %-10s                  │\n', divisor, dec2bin(M, n));
fprintf('│ Bits    : %6d bits                                      │\n', n);
fprintf('└────────────────────────────────────────────────────────────┘\n');

%% Display Algorithm Rules
fprintf('\n┌────────────────────────────────────────────────────────────┐\n');
fprintf('│                    ALGORITHM RULES                          │\n');
fprintf('├────────────────────────────────────────────────────────────┤\n');
fprintf('│ 1. If A ≥ 0: Shift → A = A - M → Q0 = 1                     │\n');
fprintf('│ 2. If A < 0: Shift → A = A + M → Q0 = 0                     │\n');
fprintf('│ 3. After n steps, if A < 0: A = A + M (final restoration)   │\n');
fprintf('└────────────────────────────────────────────────────────────┘\n');

%% Main Non-Restoring Division Loop
fprintf('\n┌─────┬────────────┬────────────┬────────────┬─────┬────────┐\n');
fprintf('│ Step│  Shift AQ   │     A      │     Q      │ Q0  │ Action │\n');
fprintf('├─────┼────────────┼────────────┼────────────┼─────┼────────┤\n');

% Store previous A for decision making
prev_A_sign = 0;  % 0 for ≥0, 1 for <0 (initial A=0 ≥0)

for step = 1:n
    % Save original values for display
    orig_A = A;
    orig_Q = Q;
    
    % Left shift [A Q] by 1
    combined = bitshift(A, n) + Q;         % Combine A (upper n bits) and Q (lower n bits)
    combined = bitshift(combined, 1);      % Shift left by 1
    A = bitshift(combined, -n);            % Extract upper n bits (new A)
    Q = bitand(combined, 2^n - 1);         % Extract lower n bits (new Q)
    
    fprintf('│ %3d │ AQ<<1      │ %4d (%3s) │ %4d (%3s) │     │        │\n', ...
            step, A, dec2bin(A, n), Q, dec2bin(Q, n));
    
    % Use PREVIOUS A's sign to decide operation
    if prev_A_sign == 0  % Previous A ≥ 0
        A = A - M;      % Subtract M
        operation = 'A-M';
    else                % Previous A < 0
        A = A + M;      % Add M
        operation = 'A+M';
    end
    
    % Determine Q0 based on CURRENT A's sign
    if A >= 0
        Q0 = 1;
    else
        Q0 = 0;
    end
    
    % Set LSB of Q to Q0
    Q = bitshift(Q, -1);  % Clear LSB
    Q = bitshift(Q, 1);
    Q = bitor(Q, Q0);
    
    fprintf('│     │ %-10s │ %4d (%3s) │ %4d (%3s) │  %d  │ %-6s │\n', ...
            operation, A, dec2bin(A, n), Q, dec2bin(Q, n), Q0, operation);
    
    % Update previous A sign for next iteration
    prev_A_sign = (A < 0);
    
    if step < n
        fprintf('├─────┼────────────┼────────────┼────────────┼─────┼────────┤\n');
    end
end

%% Final Restoration if A < 0
fprintf('├─────┼────────────┼────────────┼────────────┼─────┼────────┤\n');
if A < 0
    A = A + M;
    fprintf('│Final│ A = A + M  │ %4d (%3s) │ %4d (%3s) │     │Restore │\n', ...
            A, dec2bin(A, n), Q, dec2bin(Q, n));
else
    fprintf('│Final│ No Restore │ %4d (%3s) │ %4d (%3s) │     │        │\n', ...
            A, dec2bin(A, n), Q, dec2bin(Q, n));
end
fprintf('└─────┴────────────┴────────────┴────────────┴─────┴────────┘\n');

%% Final Results Display
fprintf('\n╔══════════════════════════════════════════════════════════════╗\n');
fprintf('║                        FINAL RESULTS                         ║\n');
fprintf('╠══════════════════════════════════════════════════════════════╣\n');
fprintf('║                                                              ║\n');
fprintf('║     Quotient (Q):  %4d                                       ║\n', Q);
fprintf('║                                                              ║\n');
fprintf('║     Remainder (A): %4d                                       ║\n', A);
fprintf('║                                                              ║\n');
fprintf('╠══════════════════════════════════════════════════════════════╣\n');
fprintf('║                    VERIFICATION CHECK                        ║\n');
fprintf('╠══════════════════════════════════════════════════════════════╣\n');

% Calculate expected results
expected_Q = idivide(int32(dividend), int32(divisor));  % Integer division
expected_R = mod(dividend, divisor);

if (Q == expected_Q) && (A == expected_R)
    fprintf('║    ✅ SUCCESS: Algorithm produced correct results!           ║\n');
else
    fprintf('║    ❌ ERROR: Results do not match expected values!           ║\n');
end

fprintf('║                                                              ║\n');
fprintf('║    Expected: %d ÷ %d = %d remainder %d                  ║\n', ...
        dividend, divisor, expected_Q, expected_R);
fprintf('║                                                              ║\n');
fprintf('║    %d = (%d × %d) + %d                               ║\n', ...
        dividend, divisor, Q, A);
fprintf('║                                                              ║\n');
fprintf('╚══════════════════════════════════════════════════════════════╝\n');