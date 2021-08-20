websave('nhk_news_covid19_prefectures_daily_data.csv','https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv');
A=importdata('nhk_news_covid19_prefectures_daily_data.csv');
l=length(A.data(:,2));
B=str2double(A.textdata(2:l+1,2));

websave('nhk_news_covid19_domestic_daily_data.csv','https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_domestic_daily_data.csv');
JP=importdata('nhk_news_covid19_domestic_daily_data.csv');

dd0=strrep(A.textdata(2,1),'/','-');
d0=datetime(dd0);
dd1=strrep(A.textdata(l+1,1),'/','-');
d1=datetime(dd1);
D=days(d1-d0);
l0=datestr(d0,'yyyy-mm-dd');
l1=datestr(d0+days(floor(D/3)),'yyyy-mm-dd');
l2=datestr(d0+days(floor(2*D/3)),'yyyy-mm-dd');
lf=datestr(d1,'yyyy-mm-dd');

ddd0=datetime('2021-04-01');
DD=days(d1-ddd0);
ll0=string('2021-04-01');
ll1=datestr(ddd0+days(floor(DD/2)),'yyyy-mm-dd');
ll2=datestr(d1,'yyyy-mm-dd');

% Japan (125M)
JPN1=JP.data(:,2)/125.36;
JPN2=JP.data(:,4)/125.36;
JPN3=JP.data(:,1)/125.36;
NDJPN=zeros(D-441,1);
for j=1:D-441
    NDJPN(j,1)=(JPN2(j+441,1)-JPN2(j+434,1))/7;
end


% Okinawa (1.46M): code 47
rowoknw=find(B(:)==47);
OKNW1=A.data(rowoknw,2)/1.458870;
OKNW2=A.data(rowoknw,4)/1.458870;
OKNW3=A.data(rowoknw,1)/1.458870;
NDOKNW=zeros(D-441,1);
for j=1:D-441
    NDOKNW(j,1)=(OKNW2(j+441,1)-OKNW2(j+434,1))/7;
end

% Hokkaido (5.27M): code 1,
rowhkd=find(B(:)==1);
HKD1=A.data(rowhkd,2)/5.207185;
HKD2=A.data(rowhkd,4)/5.207185;
HKD3=A.data(rowhkd,1)/5.207185;
NDHKD=zeros(D-441,1);
for j=1:D-441
    NDHKD(j,1)=(HKD2(j+441,1)-HKD2(j+434,1))/7;
end

% Tokyo (14M): code 13, 
rowtky=find(B(:)==13);
TKY1=A.data(rowtky,2)/14.049146;
TKY2=A.data(rowtky,4)/14.049146;
TKY3=A.data(rowtky,1)/14.049146;
NDTKY=zeros(D-441,1);
for j=1:D-441
    NDTKY(j,1)=(TKY2(j+441,1)-TKY2(j+434,1))/7;
end

% Osaka (8.81M): code 27
rowosk=find(B(:)==27);
OSK1=A.data(rowosk,2)/8.798545;
OSK2=A.data(rowosk,4)/8.798545;
OSK3=A.data(rowosk,1)/8.798545;
NDOSK=zeros(D-441,1);
for j=1:D-441
    NDOSK(j,1)=(OSK2(j+441,1)-OSK2(j+434,1))/7;
end

% Hyogo (5.43M): code 28
rowhyg=find(B(:)==28);
HYG1=A.data(rowhyg,2)/5.446455;
HYG2=A.data(rowhyg,4)/5.446455;
HYG3=A.data(rowhyg,1)/5.446455;
NDHYG=zeros(D-441,1);
for j=1:D-441
    NDHYG(j,1)=(HYG2(j+441,1)-HYG2(j+434,1))/7;
end

% Saitama (7.34M): code 11,
rowstm=find(B(:)==11);
STM1=A.data(rowstm,2)/7.34;
STM2=A.data(rowstm,4)/7.34;
% STM3=A.data(rowstm,1)/7.34;
% kanagawa (9.22M): code 14
rowkng=find(B(:)==14);
KNG1=A.data(rowkng,2)/9.22;
KNG2=A.data(rowkng,4)/9.22;
% KNG3=A.data(rowkng,1)/9.22;
% Chiba (6.28M): code 12
rowchb=find(B(:)==12);
CHB1=A.data(rowchb,2)/6.28;
CHB2=A.data(rowchb,4)/6.28;
% CHB3=A.data(rowchb,1)/6.28;
% Saitama Chiba Kanagawa (7.34+6.28+9.22=22.84)
SCK1=(A.data(rowstm,2)+A.data(rowchb,2)+A.data(rowkng,2))/22.84;
SCK2=(A.data(rowstm,4)+A.data(rowchb,4)+A.data(rowkng,4))/22.84;
% Saitama+Chiba+Kanagawa 7.34+6.28+9.22=22.84
SCK1=(A.data(rowstm,2)+A.data(rowchb,2)+A.data(rowkng,2))/22.84;
SCK2=(A.data(rowstm,4)+A.data(rowchb,4)+A.data(rowkng,4))/22.84;
% Kyoto (2.57M): code 26
rowkyt=find(B(:)==26);
KYT1=A.data(rowkyt,2)/2.57;
KYT2=A.data(rowkyt,4)/2.57;
% KYT3=A.data(rowkyt,1)/2.57;

newcolors = [0 0 1; 
             1 131/255 0; 
             0 1 0; 
             1 0 0; 
             138/255 43/255 226/255; 
             169/255 80/255 69/255;
             1 0 1; 
             220/255 220/255 220/255; 
             1 191/255 17/255; 
             0 191/255 1];
colororder(newcolors)         
% c=hsv(6);
% colororder(c);

% plot
subplot(2,2,1)
plot([JPN1,TKY1,OKNW1],'LineWidth',2)
title('COVID-19 in Japan (total cases per 1M)','data sourced by NHK (Japanese Public TV)')
xlabel('date');
ylabel('cases/1M');
xticks([0 floor(D/3) floor(2*D/3) D])
xticklabels({[l0],[l1],[l2],[lf]})
legend('Japan','Tokyo','Okinawa','Location','northwest');
% plot
subplot(2,2,2)
plot([JPN2,TKY2,OKNW2,OSK2,HYG2,HKD2],'LineWidth',2)
title('COVID-19 in Japan (death toll per 1M)','data sourced by NHK (Japanese Public TV)')
xlabel('date');
ylabel('deaths/1M');
xticks([0 floor(D/3) floor(2*D/3) D])
xticklabels({[l0],[l1],[l2],[lf]})
legend('Japan','Tokyo','Okinawa','Osaka','Hyogo','Hokkaido','Location','northwest');
% plot
subplot(2,2,3)
plot([JPN3,TKY3,OKNW3],'LineWidth',1)
title('COVID-19 in Japan (daily new cases per 1M)','data sourced by NHK (Japanese Public TV)')
xlabel('date');
ylabel('cases/1M');
xticks([0 floor(D/3) floor(2*D/3) D])
xticklabels({[l0],[l1],[l2],[lf]})
legend('Japan','Tokyo','Okinawa','Location','northwest');
subplot(2,2,4)
plot([NDJPN,NDTKY,NDOKNW,NDOSK,NDHYG,NDHKD],'LineWidth',2)
title('COVID-19 in Japan (7-day average deaths per 1M)','data sourced by NHK (Japanese Public TV)')
xlabel('date');
ylabel('deaths/1M');
xticks([0 floor(DD/2) DD])
xticklabels({[ll0],[ll1],[ll2]})
legend('Japan','Tokyo','Okinawa','Osaka','Hyogo','Hokkaido','Location','northwest');
