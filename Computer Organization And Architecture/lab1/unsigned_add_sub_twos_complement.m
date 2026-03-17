% ---------------------------------------------------------
% Experiment: Unsigned Addition and Subtraction
% Method     : Unsigned Binary Representation
% Course     : Computer Organization and Architecture
% Level      : 5th Semester Computer Engineering (IOE / TU)
% ---------------------------------------------------------

clc;            % Clear command window
clear;          % Clear workspace

% ---------------- INPUT SECTION ----------------

A = input('Enter first unsigned number A (0-255): '); 
B = input('Enter second unsigned number B (0-255): ');

n = 8;          % Number of bits
max_val = 2^n - 1; % Maximum value for 8-bit (255)

% ---------------- UNSIGNED BINARY REPRESENTATION ----------------

A_bin = dec2bin(A, n);   
B_bin = dec2bin(B, n);   

disp(' ');
disp('--- INPUT VALUES ---');
disp(['A (Decimal): ', num2str(A), '   A (Binary): ', A_bin]);
disp(['B (Decimal): ', num2str(B), '   B (Binary): ', B_bin]);

% ---------------- UNSIGNED ADDITION ----------------

Sum = A + B; 

% Overflow detection for Unsigned Addition
% Occurs if the sum is greater than the maximum representable value
if Sum > max_val
    add_carry_out = 'YES (Carry Generated)';
    Sum_bin = dec2bin(mod(Sum, 2^n), n); % Wrap around
else
    add_carry_out = 'NO';
    Sum_bin = dec2bin(Sum, n);
end

% ---------------- UNSIGNED SUBTRACTION ----------------

Diff = A - B;

% Borrow detection for Unsigned Subtraction
% Occurs if B is larger than A (result goes below zero)
if Diff < 0
    sub_borrow = 'YES (Borrow Required)';
    % In hardware, this is represented by the 2's complement of the absolute difference
    Diff_bin = dec2bin(mod(Diff, 2^n), n); 
else
    sub_borrow = 'NO';
    Diff_bin = dec2bin(Diff, n);
end

% ---------------- OUTPUT SECTION ----------------

disp(' ');
disp('--- UNSIGNED ADDITION RESULT ---');
disp(['Sum (Decimal) : ', num2str(Sum)]);
disp(['Sum (Binary)  : ', Sum_bin]);
disp(['Carry Out     : ', add_carry_out]);

disp(' ');
disp('--- UNSIGNED SUBTRACTION RESULT ---');
disp(['Difference (Decimal) : ', num2str(Diff)]);
disp(['Difference (Binary)  : ', Diff_bin]);
disp(['Borrow        : ', sub_borrow]);

% ---------------- END OF PROGRAM ----------------