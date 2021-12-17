# crisis.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://covid19.mhlw.go.jp/public/opendata/confirmed_cases_cumulative_daily.csv","./csv/mhlw_cases.csv");
download("https://covid19.mhlw.go.jp/public/opendata/deaths_cumulative_daily.csv","./csv/mhlw_deaths.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","./csv/jhu_cases.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv","./csv/jhu_deaths.csv");

# Shape up the data.
Ccsv=DataFrame(CSV.File("./csv/mhlw_cases.csv", header=false, delim=','));
Dcsv=DataFrame(CSV.File("./csv/mhlw_deaths.csv", header=false, delim=','));
Wcsv=DataFrame(CSV.File("./csv/jhu_cases.csv", header=false, delim=','));
Xcsv=DataFrame(CSV.File("./csv/jhu_deaths.csv", header=false, delim=','));
(pa,qa)=size(Ccsv);
l=Int64(floor((pa-1)/48));
(pw,qw)=size(Wcsv);

# Plot the data
# d0: the initial date
# df: the final day
dd0=Date(2021,8,1)
DD=Int64(qw-561);
dd1=dd0+Day(floor((DD-1)/3));
dd2=dd0+Day(floor(2*(DD-1)/3));
dd3=dd0+Day(DD-1);
ll0=string(dd0);
ll1=string(dd1);
ll2=string(dd2);
ll3=string(dd3);

J=parse.(Float64,Ccsv[2:pa,2:qa]);
K=parse.(Float64,Dcsv[2:pa,2:qa]);

# Okinawa
POKNW=1.458870;
COKNW=J[:,48]/POKNW
NOKNW=zeros(DD);
for j=1:DD
    NOKNW[j]=(COKNW[j+449]-COKNW[j+442])/7
end
DOKNW=K[:,48]/POKNW
NDOKNW=zeros(DD);
for j=1:DD
    NDOKNW[j]=(DOKNW[j+449]-DOKNW[j+442])/7
end

# Tokyo
PTKY=14.049146;
CTKY=J[:,14]/PTKY
NTKY=zeros(DD);
for j=1:DD
    NTKY[j]=(CTKY[j+449]-CTKY[j+442])/7
end

# Argentina
PARG=45.670451;
BARG=parse.(Float64,Array(Xcsv[8,5:qw]))/PARG;
NDARG=zeros(DD);
for j=1:DD
    NDARG[j]=(BARG[j+557]-BARG[j+550])/7
end

# NSW
PNSW=8.196;
ANSW=parse.(Float64,Array(Wcsv[11,5:qw]))/PNSW;
NNSW=zeros(DD);
for j=1:DD
    NNSW[j]=(ANSW[557+j]-ANSW[550+j])/7
end

# Victoria
PVIC=6.7;
AVIC=parse.(Float64,Array(Wcsv[16,5:qw]))/PVIC;
NVIC=zeros(DD);
for j=1:DD
    NVIC[j]=(AVIC[557+j]-AVIC[550+j])/7
end

# Brazil 
PBRA=214.289417;
BBRA=parse.(Float64,Array(Xcsv[32,5:qw]))/PBRA;
NDBRA=zeros(DD);
for j=1:DD
    NDBRA[j]=(BBRA[j+557]-BBRA[j+550])/7
end

# Brunei Darussalam
PBWN=0.442205;
ABWN=parse.(Float64,Array(Wcsv[33,5:qw]))/PBWN;
NBWN=zeros(DD);
for j=1:DD
    NBWN[j]=(ABWN[557+j]-ABWN[550+j])/7
end

# Colombia 
PCOL=51.503463;
BCOL=parse.(Float64,Array(Xcsv[94,5:qw]))/PCOL;
NDCOL=zeros(DD);
for j=1:DD
    NDCOL[j]=(BCOL[j+557]-BCOL[j+550])/7
end

# Indonesia
PIDN=276.833206;
AIDN=parse.(Float64,Array(Wcsv[150,5:qw]))/PIDN;
NIDN=zeros(DD);
for j=1:DD
    NIDN[j]=(AIDN[557+j]-AIDN[550+j])/7
end
BIDN=parse.(Float64,Array(Xcsv[150,5:qw]))/PIDN;
NDIDN=zeros(DD);
for j=1:DD
    NDIDN[j]=(BIDN[j+557]-BIDN[j+550])/7
end

# Israel
PISR=8.789774;
AISR=parse.(Float64,Array(Wcsv[154,5:qw]))/PISR;
NISR=zeros(DD);
for j=1:DD
    NISR[j]=(AISR[557+j]-AISR[550+j])/7
end
BISR=parse.(Float64,Array(Xcsv[154,5:qw]))/PISR;
NDISR=zeros(DD);
for j=1:DD
    NDISR[j]=(BISR[j+557]-BISR[j+550])/7
end

# Japan
PJPN=125.36;
AJPN=parse.(Float64,Array(Wcsv[157,5:qw]))/PJPN;
NJPN=zeros(DD);
for j=1:DD
    NJPN[j]=(AJPN[557+j]-AJPN[550+j])/7
end

# South Korea
PKOR=51.318552;
AKOR=parse.(Float64,Array(Wcsv[162,5:qw]))/PKOR;
NKOR=zeros(DD);
for j=1:DD
    NKOR[j]=(AKOR[557+j]-AKOR[550+j])/7
end

# Malaysia
PMYS=32.66;
AMYS=parse.(Float64,Array(Wcsv[178,5:qw]))/PMYS;
NMYS=zeros(DD);
for j=1:DD
    NMYS[j]=(AMYS[557+j]-AMYS[550+j])/7
end

# Mexico 
PMEX=130.482814;
BMEX=parse.(Float64,Array(Xcsv[185,5:qw]))/PMEX;
NDMEX=zeros(DD);
for j=1:DD
    NDMEX[j]=(BMEX[j+557]-BMEX[j+550])/7
end

# Peru
PPER=33.510887;
APER=parse.(Float64,Array(Wcsv[213,5:qw]))/PPER;
NPER=zeros(DD);
for j=1:DD
    NPER[j]=(APER[557+j]-APER[550+j])/7
end
BMYS=parse.(Float64,Array(Xcsv[178,5:qw]))/PMYS;
NDMYS=zeros(DD);
for j=1:DD
    NDMYS[j]=(BMYS[j+557]-BMYS[j+550])/7
end
BPER=parse.(Float64,Array(Xcsv[213,5:qw]))/PPER;
NDPER=zeros(DD);
for j=1:DD
    NDPER[j]=(BPER[j+557]-BPER[j+550])/7
end

# Philippines
PPHI=111.249116;
APHI=parse.(Float64,Array(Wcsv[214,5:qw]))/PPHI;
NPHI=zeros(DD);
for j=1:DD
    NPHI[j]=(APHI[557+j]-APHI[550+j])/7
end
BPHI=parse.(Float64,Array(Xcsv[214,5:qw]))/PPHI;
NDPHI=zeros(DD);
for j=1:DD
    NDPHI[j]=(BPHI[j+557]-BPHI[j+550])/7
end

# Russia
PRUS=146.013169;
ARUS=parse.(Float64,Array(Wcsv[219,5:qw]))/PRUS;
NRUS=zeros(DD);
for j=1:DD
    NRUS[j]=(ARUS[557+j]-ARUS[550+j])/7
end
BRUS=parse.(Float64,Array(Xcsv[219,5:qw]))/PRUS;
NDRUS=zeros(DD);
for j=1:DD
    NDRUS[j]=(BRUS[j+557]-BRUS[j+550])/7
end

# Singapore
PSIN=5.902011;
ASIN=parse.(Float64,Array(Wcsv[232,5:qw]))/PSIN;
NSIN=zeros(DD);
for j=1:DD
    NSIN[j]=(ASIN[557+j]-ASIN[550+j])/7
end
BSIN=parse.(Float64,Array(Xcsv[232,5:qw]))/PSIN;
NDSIN=zeros(DD);
for j=1:DD
    NDSIN[j]=(BSIN[j+557]-BSIN[j+550])/7
end

# Sri Lanka
PLKA=21.516097;
ALKA=parse.(Float64,Array(Wcsv[240,5:qw]))/PLKA;
NLKA=zeros(DD);
for j=1:DD
    NLKA[j]=(ALKA[557+j]-ALKA[550+j])/7
end
BLKA=parse.(Float64,Array(Xcsv[240,5:qw]))/PLKA;
NDLKA=zeros(DD);
for j=1:DD
    NDLKA[j]=(BLKA[j+557]-BLKA[j+550])/7
end

# Thailand
PTHA=70.000662;
ATHA=parse.(Float64,Array(Wcsv[250,5:qw]))/PTHA;
NTHA=zeros(DD);
for j=1:DD
    NTHA[j]=(ATHA[557+j]-ATHA[550+j])/7
end
BTHA=parse.(Float64,Array(Xcsv[250,5:qw]))/PTHA;
NDTHA=zeros(DD);
for j=1:DD
    NDTHA[j]=(BTHA[j+557]-BTHA[j+550])/7
end

# United Staes 
PUSA=333.225477;
AUSA=parse.(Float64,Array(Wcsv[257,5:qw]))/PUSA;
NUSA=zeros(DD);
for j=1:DD
    NUSA[j]=(AUSA[557+j]-AUSA[550+j])/7
end
BUSA=parse.(Float64,Array(Xcsv[257,5:qw]))/PUSA;
NDUSA=zeros(DD);
for j=1:DD
    NDUSA[j]=(BUSA[j+557]-BUSA[j+550])/7
end

# United Kingdom 
PGBR=68.294438;
AGBR=parse.(Float64,Array(Wcsv[272,5:qw]))/PGBR;
NGBR=zeros(DD);
for j=1:DD
    NGBR[j]=(max(AGBR[557+j]-AGBR[550+j],0))/7
end
BGBR=parse.(Float64,Array(Xcsv[272,5:qw]))/PGBR;
NDGBR=zeros(DD);
for j=1:DD
    NDGBR[j]=(BGBR[j+557]-BGBR[j+550])/7
end

# Vietnam
PVNM=98.341025;
AVNM=parse.(Float64,Array(Wcsv[277,5:qw]))/PVNM;
NVNM=zeros(DD);
for j=1:DD
    NVNM[j]=(AVNM[557+j]-AVNM[550+j])/7
end

p=plot([NKOR NMYS NVNM NSIN NNSW NVIC NRUS NIDN NGBR NUSA], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/3) floor(2*DD/3) DD;], [ll0 ll1 ll2 ll3]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["South Korea" "Malaysia" "Vietnam" "Singapore" "New South Wales" "Victoria" "Indonesia" "United Kingdom" "United States"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/cases.png") 

q=plot([NJPN NTKY NOKNW NPHI NBWN NTHA], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU and MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/3) floor(2*DD/3) DD;], [ll0 ll1 ll2 ll3]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Philippines" "Brunei Darussalam" "Thailand" ], 
    palette = :seaborn_bright, 
    legend = :topright)
savefig("./crisis/delta.png") 

r=plot([NDMYS NDBRA NDOKNW NDSIN NDMEX NDLKA NDRUS NDTHA NDGBR NDUSA],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/3) floor(2*DD/3) DD;], [ll0 ll1 ll2 ll3]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(8), 
    label=["Malaysia" "Brazil" "Okinawa" "Singapore" "Mexico" "Sri Lanka" "Russia" "Thailand" "United Kingdam" "United States"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/deaths.png") 

plot(p, q, r,
     layout=3, 
     size=(1260,840), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./crisis/crisis.png") 