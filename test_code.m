% Problem 3
close all; clearvars; clc;

% Define poles and zeros
z1 = exp(1j*pi/2);
z2 = exp(-1j*pi/2);
p1 = 0+1j*0.85;
p2 = 0-1j*0.85;

zeros_Hz = [z1 z2];
poles_Hz = [p1 p2];

fs = 240; % Hz - sampling frequency
omega = 0:0.01:2*pi;
z = exp(1j*omega);
L = length(omega);
f = fs*(0:(L/2))/L;

% Calculate transfer function
H_z = ( (z-z1).*(z-z2) )./( (z-p2).*(z-p1) );

P2 = abs(H_z)./L;
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

P22 = rad2deg(atan2(imag(H_z),real(H_z)));
P11 = P22(1:L/2+1); 
P11(2:end-1) = 2*P11(2:end-1);

figure(1); clf;
% zplane(zeros_Hz,poles_Hz,100); hold on; grid on;
% set(gca,'FontWeight','bold','FontSize',12);
% title('Pole-Zero Plot H(z)')
% unit circle 
n=1024; %nn=-1.5:0.01:1.5;
angle = 0:2*pi/n:2*pi; %y=zeros(length(nn),1); x=y;             
plot(cos(angle),sin(angle),'k-'); grid on; hold on; axis equal;
yline(0,'k--'); xline(0,'k--');
l1 =plot(real(zeros_Hz),imag(zeros_Hz),'og','LineWidth',2);
l2 =plot(real(poles_Hz),imag(poles_Hz),'xm','LineWidth',2);
set(gca,'FontWeight','bold','FontSize',12,'XTick',-1.6:.2:1.6,'YTick',-1.6:0.2:1.6);
ylabel('Imaginary Component'); xlabel('Real Component');
title('Pole-Zero Plot H(z)'); legend([l1 l2],'zeros','poles','location','northeast');


figure(2); clf;
subplot(2,1,1)
plot(f,20*log10(P1),'b','LineWidth',2)
ax = gca;
%ax.YLim =[-130 1];
%ax.XTick = 0:.2:2;
grid on; box on;
set(gca,'FontWeight','bold','FontSize',10);
xlabel('Frequency, Hz');
ylabel('Magnitude (dB)'); legend('Magnitude Response (DTFT) H(z) evaluated at z=e^{j\omega}','location','northwest')
subplot(2,1,2)
plot(f,P11 ,'g.','LineWidth',2); 
grid on; set(gca,'FontWeight','bold','FontSize',10);
xlabel('Frequency, Hz');
ylabel('Phase Angle (deg)'); legend('Phase Response (DTFT) - H(z) evaluated at z=e^{j\omega}','location','best')

