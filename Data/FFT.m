%FFT of Beam Sizes

figure(1);

plot(fft(sig_nimgs_14322),'*');
hold on;
plot(fft(sig_nimgs_otr_14322),'r*');
title('FFT of Beam Sizes IP = 0.320 mm');
legend('ODR','OTR');
xlabel('Frequency (Hz)');
ylabel('');
hold off;

saveas(1, '../Figures/FFT_320', 'png');


figure(2);

plot(fft(sig_nimgs_14321),'*');
hold on;
plot(fft(sig_nimgs_otr_14321),'r*');
title('FFT of Beam Sizes IP = 0.370 mm');
legend('ODR','OTR');
xlabel('Frequency (Hz)');
ylabel('');
hold off;

saveas(2, '../Figures/FFT_370', 'png');


figure(3);

plot(fft(sig_nimgs_14319),'*');
hold on;
plot(fft(sig_nimgs_otr_14319),'r*');
title('FFT of Beam Sizes IP = 0.420 mm');
legend('ODR','OTR');
xlabel('Frequency (Hz)');
ylabel('');
hold off;

saveas(3, '../Figures/FFT_420', 'png');


figure(4);

plot(fft(sig_nimgs_14317),'*');
hold on;
plot(fft(sig_nimgs_otr_14317),'r*');
title('FFT of Beam Sizes IP = 0.470 mm');
legend('ODR','OTR');
xlabel('Frequency (Hz)');
ylabel('');
hold off;

saveas(4, '../Figures/FFT_470', 'png');


figure(5);

plot(fft(sig_nimgs_14318),'*');
hold on;
plot(fft(sig_nimgs_otr_14318),'r*');
title('FFT of Beam Sizes IP = 0.520 mm');
legend('ODR','OTR');
xlabel('Frequency (Hz)');
ylabel('');
hold off;

saveas(5, '../Figures/FFT_520', 'png');


figure(6);

plot(fft(sig_nimgs_14323),'*');
hold on;
plot(fft(sig_nimgs_otr_14323),'r*');
title('FFT of Beam Sizes IP = 0.570 mm');
legend('ODR','OTR');
xlabel('Frequency (Hz)');
ylabel('');
hold off;

saveas(6, '../Figures/FFT_570', 'png');


figure(7);

plot(fft(sig_nimgs_14320),'*');
hold on;
title('FFT of Beam Sizes IP = 0 mm');
xlabel('Frequency (Hz)');
ylabel('');
hold off;

saveas(7, '../Figures/FFT_0', 'png');