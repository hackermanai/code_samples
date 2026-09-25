% demo.m
% Koi Editor MATLAB lexer test.

classdef (Sealed) SignalProcessor < handle
    properties
        Name = "Default"
        Samples = []
    end

    properties (Access = private)
        SampleRate = 44100
    end

    methods
        function obj = SignalProcessor(name, sampleRate)
            obj.Name = name;
            obj.SampleRate = sampleRate;
        end

        function addSamples(obj, values)
            obj.Samples = [obj.Samples, values];
        end

        function result = meanValue(obj)
            if isempty(obj.Samples)
                result = 0;
                return;
            end

            result = mean(obj.Samples);
        end

        function result = normalize(obj)
            peak = max(abs(obj.Samples));

            if peak > 0
                result = obj.Samples ./ peak;
            else
                result = obj.Samples;
            end
        end

        function printSummary(obj)
            fprintf("Signal: %s\n", obj.Name);
            fprintf('Samples: %d\n', length(obj.Samples));
            fprintf('Mean: %.3f\n', obj.meanValue());
        end
    end

    methods (Static)
        function result = fromFile(filename)
            data = load(filename);
            result = SignalProcessor(filename, 44100);
            result.addSamples(data);
        end
    end
end


function result = processSignal(values, scale)
    arguments
        values (1,:) double
        scale (1,1) double = 1.0
    end

    processor = SignalProcessor("Demo", 48000);
    processor.addSamples(values .* scale);

    normalized = processor.normalize();
    result = normalized;
end


function [minimum, maximum] = findRange(values)
    minimum = min(values);
    maximum = max(values);
end


function demoOperations()
    % Numeric literals
    integerValue = 42;
    floatValue = 3.14159;
    scientificValue = 1.25e-3;
    complexValue = 2.5i;

    % Character vectors and strings
    oldStyleText = 'MATLAB character vector';
    escapedText = 'It''s a character vector';
    modernText = "MATLAB string";
    quotedText = "Say ""hello""";

    % Function call / array indexing ambiguity.
    values = [1, 2, 3, 4, 5];
    first = values(1);
    total = sum(values);

    % Matrix operations and transpose.
    matrix = [1 2 3; 4 5 6];
    transposed = matrix';
    nonConjugate = matrix.';

    % Cell indexing.
    items = {'alpha', 'beta', 'gamma'};
    item = items{2};

    % Line continuation.
    longValue = integerValue + ...
                floatValue + ...
                scientificValue;

    if longValue > 10
        disp("Large value");
    elseif longValue > 0
        disp("Positive value");
    else
        disp("Non-positive value");
    end

    for index = 1:length(values)
        fprintf("values(%d) = %g\n", index, values(index));
    end

    switch first
        case 1
            disp("First value is one");
        otherwise
            disp("Something else");
    end

    try
        result = processSignal(values, 2.0);
        [minimum, maximum] = findRange(result);

        fprintf("Range: %g to %g\n", minimum, maximum);
    catch exception
        fprintf("Error: %s\n", exception.message);
    end
end


%{
This is a MATLAB block comment.

Braces and keywords here should not affect folding:

if true
    function fake()
    end
end
%}


demoOperations();

