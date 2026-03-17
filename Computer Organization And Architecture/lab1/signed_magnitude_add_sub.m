% ---------------------------------------------------------
% Experiment: Signed Magnitude Addition and Subtraction
% Method    : Signed Magnitude Representation
% Course    : Computer Organization and Architecture
% Level     : 5th Semester Computer Engineering (IOE / TU)
% ---------------------------------------------------------

clc;    % Clear command window
clear;  % Clear workspace variables

% ---------------- INPUT SECTION ----------------
A = input('Enter magnitude of A: ');  % Input magnitude of first number
B = input('Enter magnitude of B: ');  % Input magnitude of second number

% Signs: 1 for +, -1 for -
signs = [1, -1];  % Array containing possible signs for each number

% Number of bits to represent signed magnitude
n = ceil(log2(max(A,B)+1)) + 1; % Compute total bits:
% 
%  magnitude bits + 1 sign bit

max_magnitude = 2^(n-1) - 1; 

% Maximum representable magnitude in signed magnitude

fprintf('\n--- SIGNED MAGNITUDE OPERATIONS ---\n');

% ---------------- MAIN LOOP ----------------
% Loop through all possible combinations of signs for A and B
for signA = signs
    for signB = signs
        
        % ---------------- ADDITION ----------------
        if signA == 1 && signB == 1
            sum_val = A + B;  % +A + +B → simply add magnitudes
        elseif signA == 1 && signB == -1
            if A > B
                sum_val = A - B;   % +A + -B → subtract B from A
            elseif A < B
                sum_val = -(B - A); % Result is negative if B > A
            else
                sum_val = 0;        % Equal magnitudes cancel each other
            end
        elseif signA == -1 && signB == 1
            if A > B
                sum_val = -(A - B); % Result is negative if |A| > |B|
            elseif A < B
                sum_val = B - A;    % Result positive if |B| > |A|
            else
                sum_val = 0;        % Equal magnitudes cancel each other
            end
        else % -A + -B
            sum_val = -(A + B);     % Sum of two negatives → negative
        end
        
        % ---------------- SUBTRACTION ----------------
        if signA == 1 && signB == 1
            if A > B
                diff_val = A - B;  
                
                % +A - +B → subtract smaller from larger
            elseif A < B
                diff_val = -(B - A); % Result negative if B > A
            else
                diff_val = 0;        % Equal magnitudes → 0
            end
        elseif signA == 1 && signB == -1
            diff_val = A + B;        % +A - (-B) → addition
        elseif signA == -1 && signB == 1
            diff_val = -(A + B);     % -A - (+B) → negative addition
        else % -A - -B
            if A > B
                diff_val = -(A - B); % Result negative if |A| > |B|
            elseif A < B
                diff_val = B - A;    % Result positive if |B| > |A|
            else
                diff_val = 0;        % Equal magnitudes → 0
            end
        end
        
        % ---------------- OVERFLOW CHECK ----------------
        if abs(sum_val) > max_magnitude
            sum_overflow = true;  
            % Addition overflow if magnitude exceeds max
        else
            sum_overflow = false;  % No overflow
        end
        
        if abs(diff_val) > max_magnitude
            diff_overflow = true;  % Subtraction overflow if magnitude 
            % exceeds max
        else
            diff_overflow = false; % No overflow
        end
        
        % ---------------- BINARY REPRESENTATION ----------------
        % Convert decimal results to n-bit binary (including sign)
        sum_bin = dec2bin(mod(sum_val, 2^n), n);
        diff_bin = dec2bin(mod(diff_val, 2^n), n);
        
        % ---------------- DISPLAY RESULTS ----------------
        % Assign characters for signs to display
        signA_char = '+';
        signB_char = '+';
        if signA == -1, signA_char = '-'; end
        if signB == -1, signB_char = '-'; end
        
        % Display addition result
        fprintf('\nOperation: (%sA) + (%sB)\n', signA_char, signB_char);
        fprintf('Sum (Decimal) : %d  Sum (Binary) : %s', sum_val, sum_bin);
        if sum_overflow
            fprintf('  **OVERFLOW**'); % Display overflow warning if needed
        end
        fprintf('\n');
        
        % Display subtraction result
        fprintf('Operation: (%sA) - (%sB)\n', signA_char, signB_char);
        fprintf('Difference (Decimal) : %d  Difference (Binary) : %s', diff_val, diff_bin);
        if diff_overflow
            fprintf('  **OVERFLOW**');
            % Display overflow warning if needed
        end
        fprintf('\n');
    end
end
