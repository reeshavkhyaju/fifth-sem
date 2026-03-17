% ---------------------------------------------------------
% Experiment: Unsigned Multiplication
% Method    : Unsigned Magnitude Representation
% Course    : Computer Organization and Architecture
% Level     : 5th Semester Computer Engineering (IOE / TU)
% ---------------------------------------------------------

clc;            % Clear command window
clear;          % Clear workspace

% ---------------- INPUT SECTION ----------------

A = input('Enter first unsigned number A: ');   % Input first unsigned integer
B = input('Enter second unsigned number B: ');  % Input second unsigned integer

n = 8;          % Number of bits (8-bit system)

% ---------------- BINARY REPRESENTATION ----------------

% For unsigned, we use dec2bin directly. 
% mod(A, 2^n) ensures it stays within n-bit bounds.
A_bin = dec2bin(mod(A, 2^n), n);   
B_bin = dec2bin(mod(B, 2^n), n);   

disp(' ');
disp('--- INPUT VALUES (UNSIGNED) ---');
disp(['A (Decimal): ', num2str(A), '    A (Binary): ', A_bin]);
disp(['B (Decimal): ', num2str(B), '    B (Binary): ', B_bin]);

% ---------------- UNSIGNED MULTIPLICATION ----------------

Product = A * B;                               % Perform unsigned multiplication
Product_bin = dec2bin(mod(Product, 2^n), n);   % Convert product to n-bit binary

% Overflow detection for unsigned multiplication
% Valid range for n-bit unsigned number: 0 to 2^n - 1
if Product < 0 || Product > (2^n - 1)
    mul_overflow = 'YES';
else
    mul_overflow = 'NO';
end

% ---------------- OUTPUT SECTION ----------------

disp(' ');
disp('--- UNSIGNED MULTIPLICATION RESULT ---');
disp(['Product (Decimal) : ', num2str(Product)]);
disp(['Product (Binary)  : ', Product_bin]);
disp(['Overflow (8-bit)  : ', mul_overflow]);

% ---------------- END OF PROGRAM ----------------