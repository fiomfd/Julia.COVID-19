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
J1=parse.(Float64,Jcsv[2:pj,2]);
(pw,qw)=size(Wcsv);

# Plot the data
# d0: the initial date
# df: the final day
pj=min(pj,qw+3);
d0=Date(2021,4,1)
D=pj-442;
d1=d0+Day(floor((D-1)/2));
d2=d0+Day(D-1);
l0=string(d0);
l1=string(d1);
l2=string(d2);

# Okinawa (1.46M): code 47
rowoknw=findall(x->x==47,A0);
XNOKNW=A1[rowoknw]/1.458870;
NOKNW=XNOKNW[442:pj-1];

# Tokyo (14M): code 13, 
rowtky=findall(x->x==13,A0);
XNTKY=A1[rowtky]/14.049146;
NTKY=XNTKY[442:pj-1];

# Japan (125.36M)
XNJPN=parse.(Float64,Jcsv[443:pj,2]);
NJPN=XNJPN/125.36

# Indonesia
PIDN=271;
AIDN=parse.(Float64,Array(Wcsv[150,5:qw]))/PIDN;
NIDN=zeros(qw-439);
for j=1:qw-439
    NIDN[j]=AIDN[435+j]-AIDN[434+j]
end

# Malaysia
PMYS=32.6;
AMYS=parse.(Float64,Array(Wcsv[178,5:qw]))/PMYS;
NMYS=zeros(qw-439);
for j=1:qw-439
    NMYS[j]=AMYS[435+j]-AMYS[434+j]
end

# Thailand
PTHA=70.0;
ATHA=parse.(Float64,Array(Wcsv[250,5:qw]))/PTHA;
NTHA=zeros(qw-439);
for j=1:qw-439
    NTHA[j]=ATHA[435+j]-ATHA[434+j]
end

# United Staes 
PUSA=331;
AUSA=parse.(Float64,Array(Wcsv[256,5:qw]))/PUSA;
NUSA=zeros(qw-439);
for j=1:qw-439
    NUSA[j]=AUSA[435+j]-AUSA[434+j]
end

# United Kingdom 
PGBR=67.9;
AGBR=parse.(Float64,Array(Wcsv[271,5:qw]))/PGBR;
NGBR=zeros(qw-439);
for j=1:qw-439
    NGBR[j]=max(AGBR[435+j]-AGBR[434+j],0)
end

plot([NJPN NTKY NOKNW NIDN NMYS NTHA NUSA NGBR], 
    grid=false,
    linewidth=1, 
    title="COVID-19 daily new cases per 1M \n data sourced by JHU and NHK", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/2) D;], [l0 l1 l2]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa" "Indonesia" "Malaysia" "Thailand" "United States" "United Kingdom"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("new_cases.png") 