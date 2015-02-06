header='C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data';
load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14320\E200_14320.mat');

n_imgs_14320=data.raw.images.IP2A.N_IMGS;
x_low_14320=1;
x_high_14320=538;
y_low_14320=1;
y_high_14320=400;
x_range_14320=x_high_14320-x_low_14320+1;
y_range_14320=y_high_14320-y_low_14320+1;
x_np_14320=data.raw.images.IP2A.ROI_XNP(1);
y_np_14320=data.raw.images.IP2A.ROI_YNP(1);
y_projection_14320=zeros(n_imgs_14320,y_range_14320);
mu_total_14320=0;
shot=175;
A_total_14320=0;




for i=1:n_imgs_14320
    x_14320=imread([header data.raw.images.IP2A.dat{i}]);
    y_14320=x_14320(y_low_14320:y_high_14320,x_low_14320:x_high_14320);
    %imagesc(y_14320);
    %pause(1);
    y_projection_14320(i,:)=mean(y_14320,2);  
end

res_14320=data.raw.images.IP2A.RESOLUTION(1);

for j=1:n_imgs_14320
max_y_14320=max(y_projection_14320(j,:));
frac_maxy_14320=0.2;
good_yproj_14320=[];
xaxis1_14320=linspace(1*res_14320,x_range_14320*res_14320,x_range_14320);
good_xaxis1_14320=[];
    for i=1:y_range_14320
        if y_projection_14320(j,i)>frac_maxy_14320*max_y_14320
        good_yproj_14320=[good_yproj_14320,y_projection_14320(j,i)];
        good_xaxis1_14320=[good_xaxis1_14320,xaxis1_14320(i)];
        end
    end

logy_proj_14320=log(good_yproj_14320(1,:));

[Coeff_14320]=polyfit(good_xaxis1_14320,logy_proj_14320,2);
sig_14320=sqrt(-1/(2*Coeff_14320(1)));
mu_14320=Coeff_14320(2)*sig_14320^2;
A_14320=exp(Coeff_14320(3)+mu_14320^2/(2*sig_14320^2));

Gauss_yproj_14320=A_14320*exp(-(good_xaxis1_14320-mu_14320).^2/(2*sig_14320^2));

mu_total_14320=mu_total_14320+mu_14320;
A_total_14320=A_total_14320+A_14320;
end

IP_OTR=mu_total_14320/n_imgs_14320;
Peak_yIntens_14320=A_total_14320/n_imgs_14320;



load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14321\E200_14321.mat');

n_imgs_14321=data.raw.images.IP2A.N_IMGS;
x_low_14321=1;
x_high_14321=538;
y_low_14321=1;
y_high_14321=400;
x_range_14321=x_high_14321-x_low_14321+1;
y_range_14321=y_high_14321-y_low_14321+1;
x_np_14321=data.raw.images.IP2A.ROI_XNP(1);
y_np_14321=data.raw.images.IP2A.ROI_YNP(1);
y_projection_14321=zeros(n_imgs_14321,y_range_14321);
mu_total_14321=0;
shot=177;
A_total_14321=0;



for i=1:n_imgs_14321
    x_14321=imread([header data.raw.images.IP2A.dat{i}]);
    y_14321=x_14321(y_low_14321:y_high_14321,x_low_14321:x_high_14321);
    %imagesc(y_14321);
    %pause(1);
    y_projection_14321(i,:)=mean(y_14321,2);  
end

res_14321=data.raw.images.IP2A.RESOLUTION(1);

for j=1:n_imgs_14321
[A_14321,a_14321]=max(y_projection_14321(j,:));
%frac_maxy_14321=0.2;
good_yproj_14321=[];
xaxis1_14321=linspace(1*res_14321,y_range_14321*res_14321,y_range_14321);
good_xaxis1_14321=[];
    for i=a_14321:y_range_14321
        %if y_projection_14321(j,i)>frac_maxy_14321*max_y_14321
        good_yproj_14321=[good_yproj_14321,y_projection_14321(j,i)];
        good_xaxis1_14321=[good_xaxis1_14321,xaxis1_14321(i)];
        %end
    end
    
    
logy_proj_14321=log(good_yproj_14321(1,:));

[Coeff_14321]=polyfit(good_xaxis1_14321,logy_proj_14321,2);
sig_14321=sqrt(-1/(2*Coeff_14321(1)));
mu_14321=Coeff_14321(2)*sig_14321^2;
A_14321=exp(Coeff_14321(3)+mu_14321^2/(2*sig_14321^2));

Gauss_yproj_14321=A_14321*exp(-(good_xaxis1_14321-mu_14321).^2/(2*sig_14321^2));

mu_total_14321=mu_total_14321+mu_14321;
A_total_14321=A_total_14321+A_14321;    

end

IP_ODR_14321=mu_total_14321/n_imgs_14321;
Peak_yIntens_14321=A_total_14321/n_imgs_14321;

figure(2);
plot(xaxis1_14321,y_projection_14321(shot,:));
hold on;
plot(good_xaxis1_14321,Gauss_yproj_14321,'-r');
title('Projected y Intensity (ODR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;





load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14322\E200_14322.mat');

n_imgs_14322=data.raw.images.IP2A.N_IMGS;
x_low_14322=1;
x_high_14322=538;
y_low_14322=1;
y_high_14322=400;
x_range_14322=x_high_14322-x_low_14322+1;
y_range_14322=y_high_14322-y_low_14322+1;
x_np_14322=data.raw.images.IP2A.ROI_XNP(1);
y_np_14322=data.raw.images.IP2A.ROI_YNP(1);
y_projection_14322=zeros(n_imgs_14322,y_range_14322);
mu_total_14322=0;
shot=177;
A_total_14322=0;



for i=1:n_imgs_14322
    x_14322=imread([header data.raw.images.IP2A.dat{i}]);
    y_14322=x_14322(y_low_14322:y_high_14322,x_low_14322:x_high_14322);
    %imagesc(y_14322);
    %pause(1);
    y_projection_14322(i,:)=mean(y_14322,2);  
end

res_14322=data.raw.images.IP2A.RESOLUTION(1);

for j=1:n_imgs_14322
[A_14322,a_14322]=max(y_projection_14322(j,:));
%frac_maxy_14322=0.2;
good_yproj_14322=[];
xaxis1_14322=linspace(1*res_14322,y_range_14322*res_14322,y_range_14322);
good_xaxis1_14322=[];
    for i=a_14322:y_range_14322
        %if y_projection_14322(j,i)>frac_maxy_14322*max_y_14322
        good_yproj_14322=[good_yproj_14322,y_projection_14322(j,i)];
        good_xaxis1_14322=[good_xaxis1_14322,xaxis1_14322(i)];
        %end
    end

logy_proj_14322=log(good_yproj_14322(1,:));

[Coeff_14322]=polyfit(good_xaxis1_14322,logy_proj_14322,2);
sig_14322=sqrt(-1/(2*Coeff_14322(1)));
mu_14322=Coeff_14322(2)*sig_14322^2;
A_14322=exp(Coeff_14322(3)+mu_14322^2/(2*sig_14322^2));

Gauss_yproj_14322=A_14322*exp(-(good_xaxis1_14322-mu_14322).^2/(2*sig_14322^2));

mu_total_14322=mu_total_14322+mu_14322;
A_total_14322=A_total_14322+A_14322;

end

IP_ODR_14322=mu_total_14322/n_imgs_14322;
Peak_yIntens_14322=A_total_14322/n_imgs_14322;

figure(3);
plot(xaxis1_14322,y_projection_14322(shot,:));
hold on;
plot(good_xaxis1_14322,Gauss_yproj_14322,'-r');
title('Projected y Intensity (ODR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;





load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14323\E200_14323.mat');

n_imgs_14323=data.raw.images.IP2A.N_IMGS;
x_low_14323=1;
x_high_14323=538;
y_low_14323=1;
y_high_14323=400;
x_range_14323=x_high_14323-x_low_14323+1;
y_range_14323=y_high_14323-y_low_14323+1;
x_np_14323=data.raw.images.IP2A.ROI_XNP(1);
y_np_14323=data.raw.images.IP2A.ROI_YNP(1);
y_projection_14323=zeros(n_imgs_14323,y_range_14323);
mu_total_14323=0;
shot=177;
A_total_14323=0;



for i=1:n_imgs_14323
    x_14323=imread([header data.raw.images.IP2A.dat{i}]);
    y_14323=x_14323(y_low_14323:y_high_14323,x_low_14323:x_high_14323);
    %imagesc(y_14323);
    %pause(1);
    y_projection_14323(i,:)=mean(y_14323,2);  
end

res_14323=data.raw.images.IP2A.RESOLUTION(1);

for j=1:n_imgs_14323
[A_14323,a_14323]=max(y_projection_14323(j,:));
%frac_maxy_14323=0.2;
good_yproj_14323=[];
xaxis1_14323=linspace(1*res_14323,y_range_14323*res_14323,y_range_14323);
good_xaxis1_14323=[];
    for i=a_14323:y_range_14323
        %if y_projection_14323(j,i)>frac_maxy_14323*max_y_14323
        good_yproj_14323=[good_yproj_14323,y_projection_14323(j,i)];
        good_xaxis1_14323=[good_xaxis1_14323,xaxis1_14323(i)];
        %end
    end

logy_proj_14323=log(good_yproj_14323(1,:));

[Coeff_14323]=polyfit(good_xaxis1_14323,logy_proj_14323,2);
sig_14323=sqrt(-1/(2*Coeff_14323(1)));
mu_14323=Coeff_14323(2)*sig_14323^2;
A_14323=exp(Coeff_14323(3)+mu_14323^2/(2*sig_14323^2));

Gauss_yproj_14323=A_14323*exp(-(good_xaxis1_14323-mu_14323).^2/(2*sig_14323^2));

mu_total_14323=mu_total_14323+mu_14323;
A_total_14323=A_total_14323+A_14323;

end

IP_ODR_14323=mu_total_14323/n_imgs_14323;
Peak_yIntens_14323=A_total_14323/n_imgs_14323;

figure(4);
plot(xaxis1_14323,y_projection_14323(shot,:));
hold on;
plot(good_xaxis1_14323,Gauss_yproj_14323,'-r');
title('Projected y Intensity (ODR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;



load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14317\E200_14317.mat');

n_imgs_14317=data.raw.images.IP2A.N_IMGS;
x_low_14317=1;
x_high_14317=538;
y_low_14317=1;
y_high_14317=400;
x_range_14317=x_high_14317-x_low_14317+1;
y_range_14317=y_high_14317-y_low_14317+1;
x_np_14317=data.raw.images.IP2A.ROI_XNP(1);
y_np_14317=data.raw.images.IP2A.ROI_YNP(1);
y_projection_14317=zeros(n_imgs_14317,y_range_14317);
mu_total_14317=0;
shot=177;
A_total_14317=0;



for i=1:n_imgs_14317
    x_14317=imread([header data.raw.images.IP2A.dat{i}]);
    y_14317=x_14317(y_low_14317:y_high_14317,x_low_14317:x_high_14317);
    %imagesc(y_14317);
    %pause(1);
    y_projection_14317(i,:)=mean(y_14317,2);  
end

res_14317=data.raw.images.IP2A.RESOLUTION(1);

for j=1:n_imgs_14317
[A_14317,a_14317]=max(y_projection_14317(j,:));
%frac_maxy_14317=0.2;
good_yproj_14317=[];
xaxis1_14317=linspace(1*res_14317,y_range_14317*res_14317,y_range_14317);
good_xaxis1_14317=[];
    for i=a_14317:y_range_14317
        %if y_projection_14317(j,i)>frac_maxy_14317*max_y_14317
        good_yproj_14317=[good_yproj_14317,y_projection_14317(j,i)];
        good_xaxis1_14317=[good_xaxis1_14317,xaxis1_14317(i)];
        %end
    end

logy_proj_14317=log(good_yproj_14317(1,:));

[Coeff_14317]=polyfit(good_xaxis1_14317,logy_proj_14317,2);
sig_14317=sqrt(-1/(2*Coeff_14317(1)));
mu_14317=Coeff_14317(2)*sig_14317^2;
A_14317=exp(Coeff_14317(3)+mu_14317^2/(2*sig_14317^2));

Gauss_yproj_14317=A_14317*exp(-(good_xaxis1_14317-mu_14317).^2/(2*sig_14317^2));

mu_total_14317=mu_total_14317+mu_14317;
A_total_14317=A_total_14317+A_14317;

end

IP_ODR_14317=mu_total_14317/n_imgs_14317;
Peak_yIntens_14317=A_total_14317/n_imgs_14317;

figure(6);
plot(xaxis1_14317,y_projection_14317(shot,:));
hold on;
plot(good_xaxis1_14317,Gauss_yproj_14317,'-r');
title('Projected y Intensity (ODR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;



load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14318\E200_14318.mat');

n_imgs_14318=data.raw.images.IP2A.N_IMGS;
x_low_14318=1;
x_high_14318=538;
y_low_14318=1;
y_high_14318=400;
x_range_14318=x_high_14318-x_low_14318+1;
y_range_14318=y_high_14318-y_low_14318+1;
x_np_14318=data.raw.images.IP2A.ROI_XNP(1);
y_np_14318=data.raw.images.IP2A.ROI_YNP(1);
y_projection_14318=zeros(n_imgs_14318,y_range_14318);
mu_total_14318=0;
shot=177;
A_total_14318=0;



for i=1:n_imgs_14318
    x_14318=imread([header data.raw.images.IP2A.dat{i}]);
    y_14318=x_14318(y_low_14318:y_high_14318,x_low_14318:x_high_14318);
    %imagesc(y_14318);
    %pause(1);
    y_projection_14318(i,:)=mean(y_14318,2);  
end

res_14318=data.raw.images.IP2A.RESOLUTION(1);

for j=1:n_imgs_14318
[A_14318,a_14318]=max(y_projection_14318(j,:));
%frac_maxy_14318=0.2;
good_yproj_14318=[];
xaxis1_14318=linspace(1*res_14318,y_range_14318*res_14318,y_range_14318);
good_xaxis1_14318=[];
    for i=a_14318:y_range_14318
        %if y_projection_14318(j,i)>frac_maxy_14318*max_y_14318
        good_yproj_14318=[good_yproj_14318,y_projection_14318(j,i)];
        good_xaxis1_14318=[good_xaxis1_14318,xaxis1_14318(i)];
        %end
    end

logy_proj_14318=log(good_yproj_14318(1,:));

[Coeff_14318]=polyfit(good_xaxis1_14318,logy_proj_14318,2);
sig_14318=sqrt(-1/(2*Coeff_14318(1)));
mu_14318=Coeff_14318(2)*sig_14318^2;
A_14318=exp(Coeff_14318(3)+mu_14318^2/(2*sig_14318^2));

Gauss_yproj_14318=A_14318*exp(-(good_xaxis1_14318-mu_14318).^2/(2*sig_14318^2));

mu_total_14318=mu_total_14318+mu_14318;
A_total_14318=A_total_14318+A_14318;

end

IP_ODR_14318=mu_total_14318/n_imgs_14318;
Peak_yIntens_14318=A_total_14318/n_imgs_14318;

figure(7);
plot(xaxis1_14318,y_projection_14318(shot,:));
hold on;
plot(good_xaxis1_14318,Gauss_yproj_14318,'-r');
title('Projected y Intensity (ODR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;



load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14319\E200_14319.mat');

n_imgs_14319=data.raw.images.IP2A.N_IMGS;
x_low_14319=1;
x_high_14319=538;
y_low_14319=1;
y_high_14319=400;
x_range_14319=x_high_14319-x_low_14319+1;
y_range_14319=y_high_14319-y_low_14319+1;
x_np_14319=data.raw.images.IP2A.ROI_XNP(1);
y_np_14319=data.raw.images.IP2A.ROI_YNP(1);
y_projection_14319=zeros(n_imgs_14319,y_range_14319);
mu_total_14319=0;
shot=177;
A_total_14319=0;



for i=1:n_imgs_14319
    x_14319=imread([header data.raw.images.IP2A.dat{i}]);
    y_14319=x_14319(y_low_14319:y_high_14319,x_low_14319:x_high_14319);
    %imagesc(y_14319);
    %pause(1);
    y_projection_14319(i,:)=mean(y_14319,2);  
end

res_14319=data.raw.images.IP2A.RESOLUTION(1);

for j=1:n_imgs_14319
[A_14319,a_14319]=max(y_projection_14319(j,:));
%frac_maxy_14319=0.2;
good_yproj_14319=[];
xaxis1_14319=linspace(1*res_14319,y_range_14319*res_14319,y_range_14319);
good_xaxis1_14319=[];
    for i=a_14319:y_range_14319
        %if y_projection_14319(j,i)>frac_maxy_14319*max_y_14319
        good_yproj_14319=[good_yproj_14319,y_projection_14319(j,i)];
        good_xaxis1_14319=[good_xaxis1_14319,xaxis1_14319(i)];
        %end
    end

logy_proj_14319=log(good_yproj_14319(1,:));

[Coeff_14319]=polyfit(good_xaxis1_14319,logy_proj_14319,2);
sig_14319=sqrt(-1/(2*Coeff_14319(1)));
mu_14319=Coeff_14319(2)*sig_14319^2;
A_14319=exp(Coeff_14319(3)+mu_14319^2/(2*sig_14319^2));

Gauss_yproj_14319=A_14319*exp(-(good_xaxis1_14319-mu_14319).^2/(2*sig_14319^2));

mu_total_14319=mu_total_14319+mu_14319;
A_total_14319=A_total_14319+A_14319;

end

IP_ODR_14319=mu_total_14319/n_imgs_14319;
Peak_yIntens_14319=A_total_14319/n_imgs_14319;

figure(8);
plot(xaxis1_14319,y_projection_14319(shot,:));
hold on;
plot(good_xaxis1_14319,Gauss_yproj_14319,'-r');
title('Projected y Intensity (ODR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;



IP_14317=IP_ODR_14317-IP_OTR;
IP_14318=IP_ODR_14318-IP_OTR;
IP_14319=IP_ODR_14319-IP_OTR;
IP_14320=IP_OTR-IP_OTR;
IP_14321=IP_ODR_14321-IP_OTR;
IP_14322=IP_ODR_14322-IP_OTR;
IP_14323=IP_ODR_14323-IP_OTR;

Norm_Peak_yIntens_14317=Peak_yIntens_14317/Peak_yIntens_14320;
Norm_Peak_yIntens_14318=Peak_yIntens_14318/Peak_yIntens_14320;
Norm_Peak_yIntens_14319=Peak_yIntens_14319/Peak_yIntens_14320;
Norm_Peak_yIntens_14320=Peak_yIntens_14320/Peak_yIntens_14320;
Norm_Peak_yIntens_14321=Peak_yIntens_14321/Peak_yIntens_14320;
Norm_Peak_yIntens_14322=Peak_yIntens_14322/Peak_yIntens_14320;
Norm_Peak_yIntens_14323=Peak_yIntens_14323/Peak_yIntens_14320;