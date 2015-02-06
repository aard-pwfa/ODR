%Plots

%%
%Impact_Parameter;
Total_Intensity;
data_analysis_14317;
data_analysis_14318;
data_analysis_14319;
data_analysis_14320;
data_analysis_14321;
data_analysis_14322;
data_analysis_14323;
%%

IP=[0,320,370,420,470,520,570];

%Plot Total Intensity
OTR_TI=0.167/2;
IP_calcs_TI=[0,10,20,50,100,200,500,1000];%,2000,5000];
TI_calcs=1/OTR_TI*[OTR_TI,0.0201594,0.0149631,0.00942189,0.00761167,0.00607768,0.00414657,0.00278473];%,0.00158497,0.00043979];

%IP_data=[0,IP_14322,IP_14321,IP_14319,IP_14317,IP_14318,IP_14323];
TI_data=[Intensity_Norm_14320,Intensity_Norm_14322,Intensity_Norm_14321,Intensity_Norm_14319,Intensity_Norm_14317,Intensity_Norm_14318,Intensity_Norm_14323];

figure(1);
plot(IP,TI_data,'*');
hold on;
plot(IP_calcs_TI,TI_calcs,'-r');
title('Total Normalized Intensity');
xlabel('Impact Parameter (microns)');
ylabel('Relative Intensity');
hold off;

saveas(1, '../Figures/Total_Intensity', 'png');

%Plot Peak Intensity

PeakI_data=[A_14322,A_14321,A_14319,A_14317,A_14318,A_14323]/A_14322;
IP1=[320,370,420,470,520,570];
PeakI_calcs=zeros(1,length(IP1));
for i=1:length(IP1)
    PeakI_calcs(i)=exp(-4*pi*10^-6/(40000*300*10^-9).*IP1(i));
end

figure(2);
plot(IP1,PeakI_data,'*');

hold on;
plot(IP1,PeakI_calcs,'-r');
title('Normalized Peak Intensity');
xlabel('Impact Parameter (microns)');
ylabel('Peak Intensity');
hold off;

saveas(2, '../Figures/PeakY_ODR', 'png');

%Plot Proj-X Intensity



figure(3);

plot(xaxis1_14320,x_projection_14320);
hold on;
plot(xaxis1_14322,x_projection_14322,'-r');
plot(xaxis1_14321,x_projection_14321,'-g');
plot(xaxis1_14319,x_projection_14319,'-k');
plot(xaxis1_14317,x_projection_14317,'-c');
plot(xaxis1_14318,x_projection_14318,'-m');
plot(xaxis1_14323,x_projection_14323,'-y');
title('Projected X Intensity');
legend('OTR','IP = 320 mm','IP = 370 mm','IP = 420 mm','IP = 470 mm','IP = 520 mm','IP = 570 mm');
xlabel('x (microns)');
ylabel('Intensity (AU)');
hold off;

saveas(3, '../Figures/XProj_ODR', 'png');

%Plot Proj-X Intensity Normalized

figure(4);

plot(xaxis1_14320,x_projection_14320./max(x_projection_14320));
hold on;
plot(xaxis1_14322,x_projection_14322./max(x_projection_14322),'-r');
plot(xaxis1_14321,x_projection_14321./max(x_projection_14321),'-g');
plot(xaxis1_14319,x_projection_14319./max(x_projection_14319),'-k');
plot(xaxis1_14317,x_projection_14317./max(x_projection_14317),'-c');
plot(xaxis1_14318,x_projection_14318./max(x_projection_14318),'-m');
plot(xaxis1_14323,x_projection_14323./max(x_projection_14323),'-y');
title('Normalized Projected X Intensity');
legend('OTR','IP = 320 mm','IP = 370 mm','IP = 420 mm','IP = 470 mm','IP = 520 mm','IP = 570 mm');
xlabel('x (microns)');
ylabel('Normalized Intensity');
hold off;

saveas(4, '../Figures/XProj_Norm_ODR', 'png');