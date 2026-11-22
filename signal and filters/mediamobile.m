
clear
clc
close all

fs = 1000;
T = 5;
dt = 1/fs;
t = (0:dt:T-dt)';

signal = sin(2*pi*5*t) + 0.35 * sin(2*pi*120*t)


mm = 10
y = zeros(size(signal))

for n = 1:length(signal)
    for k = 0:mm-1
        if n-k >= 1
            y(n) = y(n) + signal(n-k)/mm; % filtro media mobile
        end
    end
end


figure
subplot(3,1,1)
plot(t, signal, 'b')
xlabel('Tempo (s)')
ylabel('Ampiezza')
xlim([0 0.2])
hold on
subplot(3,1,2)
plot(t, y, 'r', 'LineWidth', 1.5)
grid on
xlabel('Tempo (s)')
ylabel('Ampiezza')
xlim([0 0.2])

% ricaviamo la risposta impulsiva

delta = zeros(20,1)
delta(1) = 1;
h = zeros(size(delta));

for n = 1:length(delta)
    for k = 0:mm-1
        if n-k >= 1
            h(n) = h(n) + delta(n-k)/mm;
        end
    end
end

y_conv = conv(signal, h) % convoluzione segnale e risposta impulsiva
y_conv = y(1:length(signal))


subplot(3,1,3)
plot(t, y_conv, 'r', 'LineWidth', 1.5)
grid on
xlabel('Tempo (s)')
ylabel('Ampiezza')
xlim([0 0.2])
title("segnale usando la risposta impulsiva")
