clc;
clear variables;
close all force;

s = tf('s')
% K = 344828;
% W = tf ([500 7256.71 222220], [50000 1088506.5 83333333 724671000 22222000000 1]);
% % % T1=0.01; T2=0.15; T3=0.09; %для степа
% T1=0.01; T2=0.25; T3=0.15; %для запасов
% W3=(T1*s+1)/((T2*s+1)*(T3*s+1));

% figure (2)
% bode(W*K*W3)
% %step(feedback(W, K*W3))
% grid on; grid minor;

% % -------
% Kst = 344828;
% W_open = tf([1.724e8 2.502e9 7.663e10] / Kst, [50000 1.089e6 8.333e7 7.247e8 2.222e10 0])
% % W_open = W_open / Kst
% T1 = 0.25; T2 = 0.001; T3 = 0.15;
% W_kk = (T2*s+1)/((T1*s+1)*(T3*s+1));
% W = W_open*Kst*W_kk;
% W = feedback(W_open, W_kk*Kst);
% step(W);
% W = W_open*Kst;
% W = W_kk;
    
% -------
% -------
% Kst = 103132
% 
% W_open = tf([100000 2.372e5 4.132e6], [2e6 5.219e6 1.909e8 2.372e8 4.132e9 1]);
% 
% T1 = 1003; T2 = 0.8; T3 = 1.3; T4 = 10^(-6);
% W_kk = (T2*s+1)*(T4*s+1)/((T1*s+1)*(T3*s+1));
% % W = feedback(W_open, W_kk*Kst, -1);
% W = W_open * Kst*W_kk;
% -------

w = logspace(-1,4,1000);

% Kst = 2.063e6
Kst = 3.463e6
% Kst = 9.063e3
W_open = (1/s)* (10^5*s^2 + 1.861e7*s + 13.89e9) / ...
    (5e3*s^4 + 1.1166e6*s^3 + 1.8334e9*s^2 + 1.861e11*s + 1.389e14)
% W_open = W_open / Kst;
% T1 = 1; T2 = 0.45; T3 = 0.008; T4=0.001
% T1 = 1.5; T2 = 0.45; T3 = 0.01; T4=0.002
T1 = 0.316; T2 = 0.07; T3 = 0.008; T4=0.001
% W_kk = (T2*s+1)/((T1*s+1)*(T3*s+1));
% W_kk = (T2*s+1)/(T1*s+1)/(T3*s+1)*(T4*s+1)
W_kk = (T2*s+1)/(T1*s+1)/(T3*s+1)*(T4*s+1)

% W = feedback(W_open, W_kk * Kst)
W = W_open*W_kk*Kst;

% W0 = feedback(W_open, Kst*W_kk, -1)
% % W1 = W0 * 
% t=0:0.00001:8;
% [y, t] = step(W0, t);
% sn = 1.9e-6*sin(59*t);
% figure(1000)
% plot(t, y+sn); hold on; grid on; grid minor;
% plot(t, y);

a = 1

% bode(W); grid on;
% bode(W_kk); grid on;

% W = W_kk

% bode(W_open*Kst, W_kk, W); grid on;
% hold on;
% plot(1/T1, 0,'xr', 1/T2, 0, 'xg', 1/T3, 0, 'xb', 1/T4, 0, 'xm', 'LineWidth', 3)

Kst = 3.663e4
% Kst = 2.063e6
W0 = feedback(W_open, Kst*W_kk, -1)


opt = stepDataOptions('StepAmplitude',1.768);
step(W0,opt)

% f = @(s) 
a=1;
% [mag, phase, wout] = bode(W_open*Kst, w);
% [mag_c, phase_c, wout_c] = bode(W, w);
% [mag_r, phase_r, wout_r] = bode(W_kk, w)
% 
% % bode(W)
% xlim([10^(-1) 10^4]);
% grid on;
% grid minor;
% 
% figure(1);
% f = @(x) 20*log10(squeeze(x));
% subplot(2, 1, 1);
% semilogx(wout, f(mag), 'r')
% hold on;
% semilogx(wout_r, f(mag_r), 'g')
% semilogx(wout_c, f(mag_c), 'b')
% % semilogx([10 10000], [0 0], 'LineWidth', 1)
% grid on;
% legend('Разомкнутая', 'Регулятор', 'Скорректированная', '0');
% 
% g = @(x) squeeze(x);
% subplot(2, 1, 2);
% semilogx(wout, squeeze(phase), 'r')
% hold on;
% semilogx(wout_r, squeeze(phase_r), 'g')
% semilogx(wout_c, squeeze(phase_c), 'b')
% grid on;
% legend('Разомкнутая', 'Регулятор', 'Скорректированная');
% xlim([10^(-5) 10^3]);
% grid on;
% grid minor;

% bodemag(W)
% grid on
% xlim([1 10^4])

W_1 = tf([2e3 3.13e5 1.3e8 2.3e8 1e8 0], [2e4 3.15e6 2.9e9 2.15e11 8.4e13 6.9e14 8.45e15]);

a =0.0001:0.0005:100;
% z = -pi*a/20;
q = 12.73./a;
z = -1./q;
f = frd(z,a);
nyquist(W, f)

f = @(s) (1.857e08*s^4 + 1.278e11*s^3 + 4.335e13 *s^2 + 1.299e16*s + 2.866e16) / ...
    (75*s^7 + 24299*s^6 + 2.919e07*s^5 + 5.561e09*s^4 + 2.366e12*s^3 + 2.099e14*s^2 + 1.389e14*s + 1)

res = f(1i*2.37)
W1 = feedback(W_open, Kst*W_kk, -1)

W2 = 1/(1 + W_open*Kst*W_kk)

figure(10)
bodemag(W1)
grid on
figure(11)
% bode(W2)

% step(feedback(W_open, Kst*W_kk, -1))

bodemag(W2); grid on;