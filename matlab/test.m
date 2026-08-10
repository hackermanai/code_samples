%% MATLAB Lexer Syntax Demo
% Syntax test file for Koi Editor.

clear;
clc;

enabled = true;
finished = false;

integerValue = 42;
decimalValue = 3.14159265;
leadingDecimal = .125;
scientificValue = 6.022e23;
smallValue = 1.5e-9;
complexI = 2.5i;
complexJ = -4.2e3j;

name = "Koi Editor";
message = "MATLAB syntax highlighting";
charVector = 'hello world';
escapedCharVector = 'don''t stop';
escapedString = "She said ""hello"".";

%% Arrays and matrices

row = [1 2 3 4 5];
column = [1; 2; 3; 4; 5];

A = [
    1 2 3;
    4 5 6;
    7 8 9
];

B = A';
C = A.';
D = A + B;
E = A .* B;
F = A ./ (B + 1);
G = A .^ 2;

seq = [seq 'def'];
cell_data = {A 'text'};
combo = [A' 'text'];

values = [1, 2, 3, ...
          4, 5, 6, ...
          7, 8, 9];

longExpression = firstValue + secondValue + ...
                 thirdValue + fourthValue;

%% Comments

% Normal line comment.
x = 10; % Inline comment.

%% Section comment
% More comments under a section.

%{
This is a MATLAB block comment.

The opening and closing delimiters are on standalone lines.

function fakeFunction()
    this_should_not_be_code = true;
end
%}

x = x + 1;

% This is NOT a block delimiter: %{
y = 20;

%% Conditions

if enabled && x > 0
    status = "enabled";
elseif x == 0
    status = "zero";
else
    status = "disabled";
end

if ~finished
    finished = true;
end

%% Loops

total = 0;

for index = 1:10
    total = total + index;
end

while total < 100
    total = total + 5;

    if total > 80
        break;
    end
end

%% Switch

mode = "fast";

switch mode
    case "fast"
        delay = 0.01;

    case "normal"
        delay = 0.1;

    otherwise
        delay = 1.0;
end

%% Try / catch

try
    result = sqrt(total);
    fprintf('Result: %.3f\n', result);
catch exception
    warning("Calculation failed: " + exception.message);
end

%% Function calls

angles = linspace(0, 2*pi, 100);
signal = sin(angles) + 0.5 * cos(2 * angles);

meanValue = mean(signal);
maximumValue = max(signal);
minimumValue = min(signal);

fprintf("Mean: %.4f\n", meanValue);
disp(signal(1:5));

%% Indexing

first = signal(1);
last = signal(end);
subset = signal(2:2:end);

matrixValue = A(2, 3);
cellValue = cell_data{1};

%% Transpose and character-vector ambiguity

vector = [1 2 3];

transpose1 = vector';
transpose2 = vector.';

combined1 = [vector' 'text'];
combined2 = [vector 'text'];
combined3 = {vector' 'another string'};

result1 = calculateValue(vector');
result2 = calculateValue(vector.');

label = 'result';
label2 = ['value: ' label];

%% Anonymous functions

square = @(x) x.^2;
distance = @(x, y) sqrt(x.^2 + y.^2);

squaredValues = square(1:5);
d = distance(3, 4);

%% Structures and cells

config.name = "demo";
config.enabled = true;
config.iterations = 10;

items = {
    "one", 1;
    "two", 2;
    "three", 3
};

%% Function declarations

function foo
    disp("foo");
end

function fooWithArgs(x)
    disp(x);
end

function y = doubleValue(x)
    y = x * 2;
end

function y = calculateValue(x)
    y = sum(x(:));
end

function [minimum, maximum] = getRange(values)
    minimum = min(values);
    maximum = max(values);
end

function [meanValue, stdValue] = statistics(values)
    arguments
        values
    end

    meanValue = mean(values);
    stdValue = std(values);
end

function result = processData(data, scale)
    persistent callCount

    if isempty(callCount)
        callCount = 0;
    end

    callCount = callCount + 1;

    result = data .* scale;

    for index = 1:numel(result)
        if result(index) < 0
            result(index) = 0;
        end
    end
end

