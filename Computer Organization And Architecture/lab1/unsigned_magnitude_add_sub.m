% ---------------------------------------------------------
% Experiment: Unsigned Magnitude Addition and Subtraction
% Method    : Unsigned Representation
% Course    : Computer Organization and Architecture
% Level     : 5th Semester Computer Engineering (IOE / TU)
% ---------------------------------------------------------

clc;    % Clear command window
clear;  % Clear workspace variables

% ---------------- INPUT SECTION ----------------
A = input('Enter magnitude of A: ');  % Input first unsigned number
B = input('Enter magnitude of B: ');  % Input second unsigned number

% Number of bits required for representation
% For unsigned, we use enough bits to represent the maximum value
n = ceil(log2(max(A,B)+1)); 

max_val = 2^n - 1; % Maximum representable value in n bits

fprintf('\n--- UNSIGNED MAGNITUDE OPERATIONS ---\n');

% ---------------- ADDITION ----------------
sum_val = A + B;

% Check for Overflow (Carry out)
if sum_val > max_val
    sum_overflow = true;
else
    sum_overflow = false;
end

% Convert to binary (limiting to n bits for visualization of overflow)
sum_bin = dec2bin(mod(sum_val, 2^n), n);

% ---------------- SUBTRACTION ----------------
% In unsigned arithmetic, A - B where B > A leads to Underflow
if A >= B
    diff_val = A - B;
    diff_underflow = false;
else
    % Result is technically negative, which unsigned can't store
    diff_val = A - B; 
    diff_underflow = true;
end

% Convert to binary
diff_bin = dec2bin(mod(diff_val, 2^n), n);

% ---------------- DISPLAY RESULTS ----------------

% Display addition result
fprintf('\nOperation: A + B\n');
fprintf('Sum (Decimal) : %d  Sum (Binary) : %s', sum_val, sum_bin);
if sum_overflow
    fprintf('  **OVERFLOW (Carry Out)**'); 
end
fprintf('\n');

% Display subtraction result
fprintf('Operation: A - B\n');
fprintf('Difference (Decimal) : %d  Difference (Binary) : %s', diff_val, diff_bin);
if diff_underflow
    fprintf('  **UNDERFLOW (Negative Result)**');
end
fprintf('\n');