% ---------------------------------------------------------
% Experiment: Signed Magnitude Multiplication
% Method    : Signed Magnitude Representation
% Course    : Computer Organization and Architecture
% Level     : 5th Semester Computer Engineering (IOE / TU)
% ---------------------------------------------------------

clc;    % Clear command window
clear;  % Clear workspace variables

% ---------------- INPUT SECTION ----------------
A = input('Enter magnitude of A: ');   % Magnitude of first number
B = input('Enter magnitude of B: ');   % Magnitude of second number

% Signs: 1 for +, -1 for -
signs = [1, -1];

% Number of bits (1 sign bit + magnitude bits)
n = ceil(log2(max(A,B)+1)) + 1;

% Maximum magnitude allowed
max_magnitude = 2^(n-1) - 1;

fprintf('\n--- SIGNED MAGNITUDE MULTIPLICATION ---\n');

% ---------------- MAIN LOOP ----------------
% Loop through all sign combinations
for signA = signs
    for signB = signs
        
        % ---------------- MULTIPLICATION ----------------
        magnitude_product = A * B;      % Multiply magnitudes
        result_sign = signA * signB;    % Determine sign
        
        if magnitude_product == 0
            prod_val = 0;
        else
            prod_val = result_sign * magnitude_product;
        end
        
        % ---------------- OVERFLOW CHECK ----------------
        if abs(prod_val) > max_magnitude
            overflow = true;
        else
            overflow = false;
        end
        
        % ---------------- BINARY REPRESENTATION ----------------
        prod_bin = dec2bin(mod(prod_val, 2^n), n);
        
        % ---------------- DISPLAY RESULTS ----------------
        signA_char = '+';
        signB_char = '+';
        if signA == -1, signA_char = '-'; end
        if signB == -1, signB_char = '-'; end
        
        fprintf('\nOperation: (%sA) * (%sB)\n', signA_char, signB_char);
        fprintf('Product (Decimal) : %d  Product (Binary) : %s', prod_val, prod_bin);
        
        if overflow
            fprintf('  **OVERFLOW**');
        end
        fprintf('\n');
        
    end
end