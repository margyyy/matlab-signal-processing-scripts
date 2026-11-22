
clear
clc
close all

fs = 1000;
T = 5;
dt = 1/fs;
t = (0:dt:T-dt)';

% segnale originale
z1 = sin(2*pi*5*t) + 0.35*sin(2*pi*120*t);

figure

subplot(3,1,1)
plot(t, z1)
grid on
xlabel('Time (s)')
ylabel('Amplitude')
title('Signal z1')

% definiamo i 4 modi
modeindex = [-600 -25 25 600];
omegaModes = 2*pi*modeindex/T;

% creiamo le funzioni di Fourier
phi = exp(1i * t(:) * omegaModes(:).') / sqrt(T);

subplot(3,1,2)
plot(t, real(phi), 'LineWidth', 1.5)
grid on
xlabel('Time (s)')
ylabel('Amplitude')
title('Modi di Fourier')

% estraiamo noi i coefficienti
ck = zeros(4,1);

for j = 1:4
    ck(j) = dt * sum(conj(phi(:,j)) .* z1);
end

% ricostruiamo il segnale
z1estimated = phi * ck;

subplot(3,1,3)
plot(t, z1, 'b', 'LineWidth', 1.5)
hold on
plot(t, real(z1estimated), 'r--', 'LineWidth', 1.5)
grid on
xlabel('Time (s)')
ylabel('Amplitude')
title('Ricostruzione del segnale')
legend('Originale', 'Ricostruito')

% controlliamo i coefficienti
disp('Coefficienti di Fourier:')
disp(ck)

% controlliamo l'errore
errore = max(abs(z1-z1estimated));
disp('Errore di ricostruzione:')
disp(errore)
