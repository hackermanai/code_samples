%% Sensor Signal Analysis Demo
% Generate a synthetic sensor signal, apply smoothing,
% detect peaks, and report basic statistics.

clear;
clc;
close all;

%% Configuration

sampleRate = 200;
duration = 8;
noiseLevel = 0.18;
smoothWindow = 9;
peakThreshold = 0.65;

showRawSignal = true;
showDetectedPeaks = true;

%% Generate time axis

time = 0:1/sampleRate:duration;
sampleCount = numel(time);

fprintf("Samples: %d\n", sampleCount);
fprintf("Duration: %.2f seconds\n", duration);
fprintf("Sample rate: %d Hz\n", sampleRate);

%% Generate synthetic signal

baseSignal = ...
    0.55 * sin(2 * pi * 1.2 * time) + ...
    0.25 * sin(2 * pi * 3.5 * time) + ...
    0.10 * cos(2 * pi * 7.0 * time);

% Add a slow trend.
trend = 0.04 * time;

% Add several transient pulses.
pulseCenters = [1.2, 2.8, 4.4, 6.1, 7.2];
pulseWidths = [0.08, 0.12, 0.10, 0.09, 0.11];
pulseAmplitudes = [0.8, 1.0, 0.7, 1.1, 0.9];

pulseSignal = zeros(size(time));

for index = 1:numel(pulseCenters)
    center = pulseCenters(index);
    width = pulseWidths(index);
    amplitude = pulseAmplitudes(index);

    pulseSignal = pulseSignal + ...
        amplitude * exp(-((time - center).^2) / (2 * width^2));
end

%% Add random noise

rng(42);

noise = noiseLevel * randn(size(time));

rawSignal = baseSignal + trend + pulseSignal + noise;

%% Smooth signal

smoothedSignal = movingAverage(rawSignal, smoothWindow);

%% Detect local peaks

[peakIndices, peakValues] = detectPeaks( ...
    smoothedSignal, ...
    peakThreshold ...
);

peakTimes = time(peakIndices);

%% Compute statistics

statistics = calculateStatistics(smoothedSignal);

fprintf("\nSignal statistics\n");
fprintf("-----------------\n");
fprintf("Mean:       %.4f\n", statistics.mean);
fprintf("Std dev:    %.4f\n", statistics.std);
fprintf("Minimum:    %.4f\n", statistics.minimum);
fprintf("Maximum:    %.4f\n", statistics.maximum);
fprintf("RMS:        %.4f\n", statistics.rms);
fprintf("Peak count: %d\n", numel(peakIndices));

%% Print detected peaks

if isempty(peakIndices)
    fprintf("\nNo peaks detected above %.2f\n", peakThreshold);
else
    fprintf("\nDetected peaks\n");
    fprintf("-----------------\n");

    for index = 1:numel(peakIndices)
        fprintf( ...
            "%2d: time = %6.3f s, value = %6.3f\n", ...
            index, ...
            peakTimes(index), ...
            peakValues(index) ...
        );
    end
end

%% Compare raw and smoothed data

difference = rawSignal - smoothedSignal;
noiseEstimate = std(difference);

fprintf("\nEstimated residual noise: %.4f\n", noiseEstimate);

correlation = corrcoef(rawSignal, smoothedSignal);

if size(correlation, 1) >= 2
    fprintf( ...
        "Raw/smoothed correlation: %.4f\n", ...
        correlation(1, 2) ...
    );
end

%% Plot signal

figure( ...
    "Name", "Sensor Signal Analysis", ...
    "Color", "white" ...
);

hold on;

if showRawSignal
    plot( ...
        time, ...
        rawSignal, ...
        "DisplayName", "Raw signal" ...
    );
end

plot( ...
    time, ...
    smoothedSignal, ...
    "LineWidth", 1.5, ...
    "DisplayName", "Smoothed signal" ...
);

if showDetectedPeaks && ~isempty(peakIndices)
    scatter( ...
        peakTimes, ...
        peakValues, ...
        45, ...
        "filled", ...
        "DisplayName", "Detected peaks" ...
    );
end

yline( ...
    peakThreshold, ...
    "--", ...
    "Peak threshold", ...
    "DisplayName", "Threshold" ...
);

xlabel("Time (s)");
ylabel("Amplitude");
title("Synthetic Sensor Signal");

grid on;
legend("Location", "best");

hold off;

%% Plot residual

figure( ...
    "Name", "Residual Noise", ...
    "Color", "white" ...
);

plot(time, difference);

xlabel("Time (s)");
ylabel("Residual");
title("Raw Signal - Smoothed Signal");

grid on;

%% Export summary

summary = struct();

summary.sampleRate = sampleRate;
summary.duration = duration;
summary.sampleCount = sampleCount;
summary.noiseEstimate = noiseEstimate;
summary.peakCount = numel(peakIndices);
summary.statistics = statistics;

summary.peakTimes = peakTimes;
summary.peakValues = peakValues;

disp(summary);

%% Local functions

function output = movingAverage(input, windowSize)
    if windowSize <= 1
        output = input;
        return;
    end

    windowSize = round(windowSize);

    if mod(windowSize, 2) == 0
        windowSize = windowSize + 1;
    end

    kernel = ones(1, windowSize) / windowSize;

    output = conv(input, kernel, "same");
end

function [indices, values] = detectPeaks(signal, threshold)
    indices = [];
    values = [];

    if numel(signal) < 3
        return;
    end

    for index = 2:numel(signal) - 1
        current = signal(index);
        previous = signal(index - 1);
        next = signal(index + 1);

        isLocalMaximum = ...
            current > previous && ...
            current >= next;

        if isLocalMaximum && current >= threshold
            indices(end + 1) = index;
            values(end + 1) = current;
        end
    end
end

function result = calculateStatistics(signal)
    result.mean = mean(signal);
    result.std = std(signal);

    result.minimum = min(signal);
    result.maximum = max(signal);

    result.rms = sqrt(mean(signal.^2));
end

