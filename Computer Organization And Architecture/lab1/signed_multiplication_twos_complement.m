% ---------------------------------------------------------
% Experiment: Signed Multiplication
% Method    : Two's Complement Representation
% Course    : Computer Organization and Architecture
% Level     : 5th Semester Computer Engineering (IOE / TU)
% ---------------------------------------------------------

clc;            % Clear command window
clear;          % Clear workspace

% ---------------- INPUT SECTION ----------------

A = input('Enter first signed number A: ');   % Input first signed integer
B = input('Enter second signed number B: ');  % Input second signed integer

n = 8;          % Number of bits (8-bit signed system)

% ---------------- TWO'S COMPLEMENT REPRESENTATION ----------------

A_bin = dec2bin(mod(A, 2^n), n);   % Convert A to n-bit two's complement
B_bin = dec2bin(mod(B, 2^n), n);   % Convert B to n-bit two's complement

disp(' ');
disp('--- INPUT VALUES ---');
disp(['A (Decimal): ', num2str(A), '   A (Binary): ', A_bin]);
disp(['B (Decimal): ', num2str(B), '   B (Binary): ', B_bin]);

% ---------------- SIGNED MULTIPLICATION ----------------

Product = A * B;                       % Perform signed multiplication
Product_bin = dec2bin(mod(Product, 2^n), n);   % Convert product to binary

% Overflow detection for signed multiplication
% Valid range for n-bit signed number: -2^(n-1) to 2^(n-1)-1
if Product < -2^(n-1) || Product > 2^(n-1)-1
    mul_overflow = 'YES';
else
    mul_overflow = 'NO';
end

% ---------------- OUTPUT SECTION ----------------

disp(' ');
disp('--- SIGNED MULTIPLICATION RESULT ---');
disp(['Product (Decimal) : ', num2str(Product)]);
disp(['Product (Binary)  : ', Product_bin]);
disp(['Overflow          : ', mul_overflow]);

% ---------------- END OF PROGRAM ----------------