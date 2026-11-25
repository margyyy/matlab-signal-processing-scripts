clear
clc
close all

[y, fs] = audioread("/home/daniel/Documents/segnali_mt/signal and filters/campionamento_audio/MUMBLING-_Sound_Effect_(FREE_TO_USE)(NO_COPYRIGHT).wav")
dt = 1/fs;
T = length(y)/fs;
t = 0:dt:T-dt;

figure;
subplot(4,1,1);
plot(t,y);
title("segnale originale");
grid on;

Z = fft(y)

N = length(y)
length(Z)

% scegliamo un modo di fourier

k = 80
ck = Z(k+1)
fk = k*fs/N

phi = exp(1i*2*pi*fk*t);
xk = 2*real((ck/N)*phi);


subplot(4,1,2)
plot(t,real(xk))
grid on
title('Sinusoide del modo k = 80')
xlabel('Time (s)')

% visualizziamo la FFT
subplot(4,1,3)
frequency = (0:floor(N/2))*fs/N;
A = abs(Z(1:floor(N/2)+1))/N;

if mod(N,2) == 0
    A(2:end-1) = 2*A(2:end-1);
else
    A(2:end) = 2*A(2:end);
end

plot(frequency,A)
grid on
xlabel('Frequency (Hz)')
title('Spettro FFT')

fprintf('k = %d, frequenza = %.2f Hz\n',k,fk);

% prendiamo i primi 5000 coefficenti di fourier
Zfiltered = zeros(size(Z));

Zfiltered(2:5001) = Z(2:5001);
Zfiltered(N-4999:N) = Z(N-4999:N);

% ricostruiamo il segnale in modo parziale
yestimated = ifft(Zfiltered);

subplot(4,1,4)
plot(t, yestimated)
title("audio ricostruito con solo i primi 5000 coefficenti di fourier")
grid on
audiowrite('audio_ricostruito.wav', real(yestimated), fs);