          % ---------------------------------------------------------
% Experiment: Signed Addition and Subtraction
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

% ---------------- SIGNED ADDITION ----------------

Sum = A + B;                                   % Perform signed addition
Sum_bin = dec2bin(mod(Sum, 2^n), n);           % Convert sum to binary

% Overflow detection for signed addition
if (A >= 0 && B >= 0 && Sum < 0) || (A < 0 && B < 0 && Sum >= 0)
    add_overflow = 'YES';
else
    add_overflow = 'NO';
end

% ---------------- SIGNED SUBTRACTION ----------------

Diff = A - B;                                 % Perform signed subtraction
Diff_bin = dec2bin(mod(Diff, 2^n), n);        % Convert difference to binary

% Overflow detection for signed subtraction
if (A >= 0 && B < 0 && Diff < 0) || (A < 0 && B >= 0 && Diff >= 0)
    sub_overflow = 'YES';
else
    sub_overflow = 'NO';
end

% ---------------- OUTPUT SECTION ----------------

disp(' ');
disp('--- SIGNED ADDITION RESULT ---');
disp(['Sum (Decimal) : ', num2str(Sum)]);
disp(['Sum (Binary)  : ', Sum_bin]);
disp(['Overflow      : ', add_overflow]);

disp(' ');
disp('--- SIGNED SUBTRACTION RESULT ---');
disp(['Difference (Decimal) : ', num2str(Diff)]);
disp(['Difference (Binary)  : ', Diff_bin]);
disp(['Overflow             : ', sub_overflow]);

% ---------------- END OF PROGRAM ----------------

