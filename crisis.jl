# crisis.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv","./csv/nhk_prefectures.csv");
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_domestic_daily_data.csv","./csv/nhk_japan.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","./csv/jhu_cases.csv");

# Shape up the data.
Acsv=DataFrame(CSV.File("./csv/nhk_prefectures.csv", header=false, delim=','));
Jcsv=DataFrame(CSV.File("./csv/nhk_japan.csv", header=false, delim=','));
Wcsv=DataFrame(CSV.File("./csv/jhu_cases.csv", header=false, delim=','));
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

# NSW
PNSW=8.196;
ANSW=parse.(Float64,Array(Wcsv[11,5:qw]))/PNSW;
NNSW=zeros(qw-530);
for j=1:qw-530
    NNSW[j]=ANSW[526+j]-ANSW[525+j]
end

# Brunei Darussalam
PBWN=0.442205;
ABWN=parse.(Float64,Array(Wcsv[33,5:qw]))/PBWN;
NBWN=zeros(qw-530);
for j=1:qw-530
    NBWN[j]=ABWN[526+j]-ABWN[525+j]
end

# Indonesia
PIDN=276.833206;
AIDN=parse.(Float64,Array(Wcsv[150,5:qw]))/PIDN;
NIDN=zeros(qw-530);
for j=1:qw-530
    NIDN[j]=AIDN[526+j]-AIDN[525+j]
end

# South Korea
PKOR=51.318552;
AKOR=parse.(Float64,Array(Wcsv[162,5:qw]))/PKOR;
NKOR=zeros(qw-530);
for j=1:qw-530
    NKOR[j]=AKOR[526+j]-AKOR[525+j]
end

# Malaysia
PMYS=32.66;
AMYS=parse.(Float64,Array(Wcsv[178,5:qw]))/PMYS;
NMYS=zeros(qw-530);
for j=1:qw-530
    NMYS[j]=AMYS[526+j]-AMYS[525+j]
end

# Singapore
PSIN=5.902011;
ASIN=parse.(Float64,Array(Wcsv[232,5:qw]))/PSIN;
NSIN=zeros(qw-530);
for j=1:qw-530
    NSIN[j]=ASIN[526+j]-ASIN[525+j]
end

# Sri Lanka
PLKA=21.516097;
ALKA=parse.(Float64,Array(Wcsv[240,5:qw]))/PLKA;
NLKA=zeros(qw-530);
for j=1:qw-530
    NLKA[j]=ALKA[526+j]-ALKA[525+j]
end

# Thailand
PTHA=70.000662;
ATHA=parse.(Float64,Array(Wcsv[250,5:qw]))/PTHA;
NTHA=zeros(qw-530);
for j=1:qw-530
    NTHA[j]=ATHA[526+j]-ATHA[525+j]
end

# United Staes 
PUSA=333.225477;
AUSA=parse.(Float64,Array(Wcsv[256,5:qw]))/PUSA;
NUSA=zeros(qw-530);
for j=1:qw-530
    NUSA[j]=AUSA[526+j]-AUSA[525+j]
end

# United Kingdom 
PGBR=68.294438;
AGBR=parse.(Float64,Array(Wcsv[271,5:qw]))/PGBR;
NGBR=zeros(qw-530);
for j=1:qw-530
    NGBR[j]=max(AGBR[526+j]-AGBR[525+j],0)
end

# Vietnam
PVNM=98.341025;
AVNM=parse.(Float64,Array(Wcsv[276,5:qw]))/PVNM;
NVNM=zeros(qw-530);
for j=1:qw-530
    NVNM[j]=AVNM[526+j]-AVNM[525+j]
end

plot([NJPN NTKY NOKNW NMYS NTHA NBWN NLKA NUSA NGBR], 
    grid=false,
    linewidth=1, 
    title="COVID-19 daily new cases per 1M \n data sourced by JHU and NHK", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/2) D;], [l0 l1 l2]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Malaysia" "Thailand" "Brunei" "Sri Lanka" "United States" "United Kingdom"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/new_cases.png") 
#
p=plot([NJPN NTKY NOKNW NMYS NTHA NBWN NLKA NUSA NGBR], 
    grid=false,
    linewidth=1, 
    title="COVID-19 daily new cases per 1M \n data sourced by JHU and NHK", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/2) D;], [l0 l1 l2]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Malaysia" "Thailand" "Brunei" "Sri Lanka" "United States" "United Kingdom"], 
    palette = :seaborn_bright, 
    legend = :topleft)

################################################

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
savefig("./crisis/new_delta.png") 
#
q=plot([NJPN NNSW NSIN NKOR NVNM NIDN], 
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
savefig("./crisis/new_delta.png") 

plot(p, q,  
     layout=(1,2), 
     size=(1260,420), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./crisis/crisis.png") 