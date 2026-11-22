
clear
clc
close all

fs = 1000;
T = 5;
dt = 1/fs;
t = (0:dt:T-dt)';

signal = cos(2*pi*3*t) .* cos(2*pi*2*t) ...
         + sin(2*pi*20*t);

figure

subplot(3,1,1)
plot(t, signal)
grid on
xlabel("Time (s)")
ylabel("Amplitude")
title("Original signal")

% applichiamo la fft
Z = fft(signal);

N = length(signal);

frequency = (0:N/2)' * fs/N;

% calcoliamo lo spettro delle ampiezze
A = abs(Z(1:N/2+1))/N;
A(2:end-1) = 2*A(2:end-1);

subplot(3,1,2)
plot(frequency, A)
grid on
xlabel("Frequency (Hz)")
ylabel("Amplitude")
title("Single-sided amplitude spectrum")
xlim([0 40])

% ricostruiamo il segnale con la ifft
signalEstimated = ifft(Z);

subplot(3,1,3)
plot(t, signal, 'b')
hold on
plot(t, real(signalEstimated), 'r--')
grid on
xlabel("Time (s)")
ylabel("Amplitude")
title("Original vs reconstructed signal")
legend("Original", "Reconstructed")

% calcoliamo l'errore
errore = max(abs(signal-signalEstimated));

fprintf("Errore massimo: %.3e\n", errore);
