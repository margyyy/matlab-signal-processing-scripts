fs = 1000
dt = 1/fs
T = 2

t = 0:dt:T-dt

f = 2
A = 1

x1 = A*sin(2*pi*f*t)
x2 = 0.35*sin(2*pi*120*t)

figure
subplot(4,1,1)
plot(t,x1)
grid on

xlabel("tempo")
ylabel("ampiezza")
title("s1")

subplot(4,1,2)
plot(t,x2)
xlabel("tempo")
ylabel("ampiezza")
title("s2")

subplot(4,1,3)
plot(t,x1 + x2)
xlabel("tempo")
ylabel("ampiezza")
title("s1 + s2")


subplot(4,1,4)
plot(t,x1.*x2)
xlabel("tempo")
ylabel("ampiezza")
title("s1 * s2")