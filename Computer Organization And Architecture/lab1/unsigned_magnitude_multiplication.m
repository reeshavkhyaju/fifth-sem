% ---------------------------------------------------------
% Experiment: Unsigned Magnitude Multiplication
% Method    : Unsigned Representation
% Course    : Computer Organization and Architecture
% Level     : 5th Semester Computer Engineering (IOE / TU)
% ---------------------------------------------------------

clc;    % Clear command window
clear;  % Clear workspace variables

% ---------------- INPUT SECTION ----------------
A = input('Enter magnitude of A: ');  % Input first unsigned number
B = input('Enter magnitude of B: ');  % Input second unsigned number

% Determine number of bits 'n' required for the input magnitudes
if max(A,B) > 0
    n = ceil(log2(max(A,B)+1)); 
else
    n = 1;
end

% In unsigned multiplication, the product can take up to 2*n bits
n_prod = 2 * n; 
max_input_limit = 2^n - 1; 

fprintf('\n--- UNSIGNED MAGNITUDE MULTIPLICATION ---\n');

% ---------------- MULTIPLICATION ----------------
% Direct multiplication of unsigned magnitudes
prod_val = A * B;

% ---------------- BINARY REPRESENTATION ----------------
% The product is represented in 2*n bits as per standard hardware multiplication
prod_bin = dec2bin(prod_val, n_prod);

% ---------------- DISPLAY RESULTS ----------------
fprintf('\nOperation: A * B\n');
fprintf('Product (Decimal) : %d\n', prod_val);
fprintf('Product (Binary)  : %s\n', prod_bin);
fprintf('Bit Width         : %d-bit inputs produced a %d-bit product\n', n, n_prod);

% Optional: Check if the result fits in the original bit-width 'n'
if prod_val > max_input_limit
    fprintf('Note: Product exceeds original %d-bit input width (Normal for multiplication).\n', n);
end