# crisis.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv","nhk_news_covid19_prefectures_daily_data.csv");
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_domestic_daily_data.csv","nhk_news_covid19_domestic_daily_data.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","time_series_covid19_confirmed_global.csv");

# Shape up the data.
Acsv=DataFrame(CSV.File("nhk_news_covid19_prefectures_daily_data.csv", header=false, delim=','));
Jcsv=DataFrame(CSV.File("nhk_news_covid19_domestic_daily_data.csv", header=false, delim=','));
Wcsv=DataFrame(CSV.File("time_series_covid19_confirmed_global.csv", header=false, delim=','));
(pa,qa)=size(Acsv);
A0=parse.(Int64,Acsv[2:pa,2]);
A1=parse.(Float64,Acsv[2:pa,4]);
X=parse.(Float64,Acsv[2:pa,6]);
(pj,qj)=size(Jcsv);
(pw,qw)=size(Wcsv);

# Plot the data
# d0: the initial date
# df: the final day
d0=Date(2021,7,1)
D=qw-530;
d1=d0+Day(floor((D-1)/2));
d2=d0+Day(D-1);
l0=string(d0);
l1=string(d1);
l2=string(d2);

# Okinawa (1.46M): code 47
rowoknw=findall(x->x==47,A0);
XNOKNW=A1[rowoknw]/1.458870;
NOKNW=XNOKNW[533:qw+2];

# Tokyo (14M): code 13, 
rowtky=findall(x->x==13,A0);
XNTKY=A1[rowtky]/14.049146;
NTKY=XNTKY[533:qw+2];

# Japan (125.36M)
XNJPN=parse.(Float64,Jcsv[534:qw+3,2]);
NJPN=XNJPN/125.36

# Indonesia
PIDN=271;
AIDN=parse.(Float64,Array(Wcsv[150,5:qw]))/PIDN;
NIDN=zeros(qw-530);
for j=1:qw-530
    NIDN[j]=AIDN[526+j]-AIDN[525+j]
end

# Malaysia
PMYS=32.6;
AMYS=parse.(Float64,Array(Wcsv[178,5:qw]))/PMYS;
NMYS=zeros(qw-530);
for j=1:qw-530
    NMYS[j]=AMYS[526+j]-AMYS[525+j]
end

# Thailand
PTHA=70.0;
ATHA=parse.(Float64,Array(Wcsv[250,5:qw]))/PTHA;
NTHA=zeros(qw-530);
for j=1:qw-530
    NTHA[j]=ATHA[526+j]-ATHA[525+j]
end

# United Staes 
PUSA=331;
AUSA=parse.(Float64,Array(Wcsv[256,5:qw]))/PUSA;
NUSA=zeros(qw-530);
for j=1:qw-530
    NUSA[j]=AUSA[526+j]-AUSA[525+j]
end

# United Kingdom 
PGBR=67.9;
AGBR=parse.(Float64,Array(Wcsv[271,5:qw]))/PGBR;
NGBR=zeros(qw-530);
for j=1:qw-530
    NGBR[j]=max(AGBR[526+j]-AGBR[525+j],0)
end

plot([NJPN NTKY NOKNW NMYS NTHA NUSA NGBR], 
    grid=false,
    linewidth=1, 
    title="COVID-19 daily new cases per 1M \n data sourced by JHU and NHK", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/2) D;], [l0 l1 l2]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Malaysia" "Thailand" "United States" "United Kingdom"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("new_cases.png") 

################################################

# NSW
PNSW=8.2;
ANSW=parse.(Float64,Array(Wcsv[11,5:qw]))/PNSW;
NNSW=zeros(qw-530);
for j=1:qw-530
    NNSW[j]=ANSW[526+j]-ANSW[525+j]
end

# South Korea
PKOR=51.318552;
AKOR=parse.(Float64,Array(Wcsv[162,5:qw]))/PKOR;
NKOR=zeros(qw-530);
for j=1:qw-530
    NKOR[j]=AKOR[526+j]-AKOR[525+j]
end

# Singapore
PSIN=5.902011;
ASIN=parse.(Float64,Array(Wcsv[232,5:qw]))/PSIN;
NSIN=zeros(qw-530);
for j=1:qw-530
    NSIN[j]=ASIN[526+j]-ASIN[525+j]
end

# Vietnam
PVNM=98.32;
AVNM=parse.(Float64,Array(Wcsv[276,5:qw]))/PVNM;
NVNM=zeros(qw-530);
for j=1:qw-530
    NVNM[j]=AVNM[526+j]-AVNM[525+j]
end

plot([NJPN NNSW NSIN NKOR NVNM NIDN], 
    grid=false,
    linewidth=1, 
    title="COVID-19 daily new cases per 1M \n data sourced by JHU", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/2) D;], [l0 l1 l2]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "New South Wales" "Singapore" "South Korea" "Vietnam" "Indonesia"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("new_delta.png") 
