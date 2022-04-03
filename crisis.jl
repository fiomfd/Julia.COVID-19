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
dd0=Date(2022,1,1)
DD=Int64(qw-714);
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
POKNW=1.469335;    
COKNW=J[:,48]/POKNW
NOKNW=zeros(DD);
for j=1:DD
    NOKNW[j]=(COKNW[j+602]-COKNW[j+595])/7
end
DOKNW=K[:,48]/POKNW
NDOKNW=zeros(DD);
for j=1:DD
    NDOKNW[j]=(DOKNW[j+602]-DOKNW[j+595])/7
end

# Tokyo
PTKY=13.988129;
CTKY=J[:,14]/PTKY
NTKY=zeros(DD);
for j=1:DD
    NTKY[j]=(CTKY[j+602]-CTKY[j+595])/7
end

# Osaka
POSK=8.797153;
COSK=J[:,28]/POSK
NOSK=zeros(DD);
for j=1:DD
    NOSK[j]=(COSK[j+602]-COSK[j+595])/7
end
DOSK=K[:,28]/POSK
NDOSK=zeros(DD);
for j=1:DD
    NDOSK[j]=(DOSK[j+602]-DOSK[j+595])/7
end

# Argentina
PARG=45.870820;
AARG=parse.(Float64,Array(Wcsv[9,5:qw]))/PARG;
NARG=zeros(DD);
for j=1:DD
    NARG[j]=(AARG[710+j]-AARG[703+j])/7
end
BARG=parse.(Float64,Array(Xcsv[9,5:qw]))/PARG;
NDARG=zeros(DD);
for j=1:DD
    NDARG[j]=(BARG[j+710]-BARG[j+703])/7
end

# NSW
PNSW=8.21;
ANSW=parse.(Float64,Array(Wcsv[12,5:qw]))/PNSW;
NNSW=zeros(DD);
for j=1:DD
    NNSW[j]=(ANSW[710+j]-ANSW[703+j])/7
end

# Victoria
PVIC=6.64;
AVIC=parse.(Float64,Array(Wcsv[17,5:qw]))/PVIC;
NVIC=zeros(DD);
for j=1:DD
    NVIC[j]=(AVIC[710+j]-AVIC[703+j])/7
end

# Australia
PAUS=25.981402;
AACT=parse.(Float64,Array(Wcsv[11,5:qw]));
ANSW=parse.(Float64,Array(Wcsv[12,5:qw]));
ANT=parse.(Float64,Array(Wcsv[13,5:qw]));
AQLD=parse.(Float64,Array(Wcsv[14,5:qw]));
ASA=parse.(Float64,Array(Wcsv[15,5:qw]));
ATAS=parse.(Float64,Array(Wcsv[16,5:qw]));
AVIC=parse.(Float64,Array(Wcsv[17,5:qw]));
AWA=parse.(Float64,Array(Wcsv[18,5:qw]));
AAUS=(AACT+ANSW+ANT+AQLD+ASA+ATAS+AVIC+AWA)/PAUS;
NAUS=zeros(DD);
for j=1:DD
    NAUS[j]=(AAUS[710+j]-AAUS[703+j])/7
end
BACT=parse.(Float64,Array(Xcsv[11,5:qw]));
BNSW=parse.(Float64,Array(Xcsv[12,5:qw]));
BNT=parse.(Float64,Array(Xcsv[13,5:qw]));
BQLD=parse.(Float64,Array(Xcsv[14,5:qw]));
BSA=parse.(Float64,Array(Xcsv[15,5:qw]));
BTAS=parse.(Float64,Array(Xcsv[16,5:qw]));
BVIC=parse.(Float64,Array(Xcsv[17,5:qw]));
BWA=parse.(Float64,Array(Xcsv[18,5:qw]));
BAUS=(BACT+BNSW+BNT+BQLD+BSA+BTAS+BVIC+BWA)/PAUS;
NDAUS=zeros(DD);
for j=1:DD
    NDAUS[j]=(BAUS[710+j]-BAUS[703+j])/7
end

# Brazil 
PBRA=215.019011;
BBRA=parse.(Float64,Array(Xcsv[33,5:qw]))/PBRA;
NDBRA=zeros(DD);
for j=1:DD
    NDBRA[j]=(BBRA[j+710]-BBRA[j+703])/7
end

# Brunei Darussalam
PBWN=0.4435;
ABWN=parse.(Float64,Array(Wcsv[34,5:qw]))/PBWN;
NBWN=zeros(DD);
for j=1:DD
    NBWN[j]=(ABWN[710+j]-ABWN[703+j])/7
end
BBWN=parse.(Float64,Array(Xcsv[34,5:qw]))/PBWN;
NDBWN=zeros(DD);
for j=1:DD
    NDBWN[j]=(BBWN[j+710]-BBWN[j+703])/7
end

# Hong Kong
PHKG=7.600852;
AHKG=parse.(Float64,Array(Wcsv[73,5:qw]))/PHKG;
NHKG=zeros(DD);
for j=1:DD
    NHKG[j]=(AHKG[710+j]-AHKG[703+j])/7
end
BHKG=parse.(Float64,Array(Xcsv[73,5:qw]))/PHKG;
NDHKG=zeros(DD);
for j=1:DD
    NDHKG[j]=(BHKG[j+710]-BHKG[j+703])/7
end


# Colombia 
PCOL=51.765589;
BCOL=parse.(Float64,Array(Xcsv[95,5:qw]))/PCOL;
NDCOL=zeros(DD);
for j=1:DD
    NDCOL[j]=(BCOL[j+710]-BCOL[j+703])/7
end

# India 
PIND=1402.124607;
AIND=parse.(Float64,Array(Wcsv[150,5:qw]))/PIND;
NIND=zeros(DD);
for j=1:DD
    NIND[j]=(AIND[710+j]-AIND[703+j])/7
end
BIND=parse.(Float64,Array(Xcsv[150,5:qw]))/PIND;
NDIND=zeros(DD);
for j=1:DD
    NDIND[j]=(BIND[j+710]-BIND[j+703])/7
end

# Indonesia
PIDN=278.239007;
AIDN=parse.(Float64,Array(Wcsv[151,5:qw]))/PIDN;
NIDN=zeros(DD);
for j=1:DD
    NIDN[j]=(AIDN[710+j]-AIDN[703+j])/7
end
BIDN=parse.(Float64,Array(Xcsv[151,5:qw]))/PIDN;
NDIDN=zeros(DD);
for j=1:DD
    NDIDN[j]=(BIDN[j+710]-BIDN[j+703])/7
end

# Japan
PJPN=125.845010;
AJPN=parse.(Float64,Array(Wcsv[158,5:qw]))/PJPN;
NJPN=zeros(DD);
for j=1:DD
    NJPN[j]=(AJPN[710+j]-AJPN[703+j])/7
end
BJPN=parse.(Float64,Array(Xcsv[158,5:qw]))/PJPN;
NDJPN=zeros(DD);
for j=1:DD
    NDJPN[j]=(BJPN[j+710]-BJPN[j+703])/7
end

# South Korea
PKOR=51.341022;
AKOR=parse.(Float64,Array(Wcsv[163,5:qw]))/PKOR;
NKOR=zeros(DD);
for j=1:DD
    NKOR[j]=(AKOR[710+j]-AKOR[703+j])/7
end
BKOR=parse.(Float64,Array(Xcsv[158,5:qw]))/PKOR;
NDKOR=zeros(DD);
for j=1:DD
    NDKOR[j]=(BKOR[j+710]-BKOR[j+703])/7
end

# Malaysia
PMYS=33.060794;
AMYS=parse.(Float64,Array(Wcsv[179,5:qw]))/PMYS;
NMYS=zeros(DD);
for j=1:DD
    NMYS[j]=(AMYS[710+j]-AMYS[703+j])/7
end
BMYS=parse.(Float64,Array(Xcsv[179,5:qw]))/PMYS;
NDMYS=zeros(DD);
for j=1:DD
    NDMYS[j]=(BMYS[j+710]-BMYS[j+703])/7
end

# Mexico 
PMEX=131.137507;
BMEX=parse.(Float64,Array(Xcsv[186,5:qw]))/PMEX;
NDMEX=zeros(DD);
for j=1:DD
    NDMEX[j]=(BMEX[j+710]-BMEX[j+703])/7
end

# Peru
PPER=33.719259;
APER=parse.(Float64,Array(Wcsv[214,5:qw]))/PPER;
NPER=zeros(DD);
for j=1:DD
    NPER[j]=(APER[710+j]-APER[703+j])/7
end
BPER=parse.(Float64,Array(Xcsv[214,5:qw]))/PPER;
NDPER=zeros(DD);
for j=1:DD
    NDPER[j]=(BPER[j+710]-BPER[j+703])/7
end

# Philippines
PPHI=112.027348;
APHI=parse.(Float64,Array(Wcsv[215,5:qw]))/PPHI;
NPHI=zeros(DD);
for j=1:DD
    NPHI[j]=(APHI[710+j]-APHI[703+j])/7
end
BPHI=parse.(Float64,Array(Xcsv[215,5:qw]))/PPHI;
NDPHI=zeros(DD);
for j=1:DD
    NDPHI[j]=(BPHI[j+710]-BPHI[j+703])/7
end

# Russia
PRUS=146.036343;
ARUS=parse.(Float64,Array(Wcsv[220,5:qw]))/PRUS;
NRUS=zeros(DD);
for j=1:DD
    NRUS[j]=(ARUS[710+j]-ARUS[703+j])/7
end
BRUS=parse.(Float64,Array(Xcsv[220,5:qw]))/PRUS;
NDRUS=zeros(DD);
for j=1:DD
    NDRUS[j]=(BRUS[j+710]-BRUS[j+703])/7
end

# Singapore
PSIN=5.925237;
ASIN=parse.(Float64,Array(Wcsv[233,5:qw]))/PSIN;
NSIN=zeros(DD);
for j=1:DD
    NSIN[j]=(ASIN[710+j]-ASIN[703+j])/7
end
BSIN=parse.(Float64,Array(Xcsv[233,5:qw]))/PSIN;
NDSIN=zeros(DD);
for j=1:DD
    NDSIN[j]=(BSIN[j+710]-BSIN[j+703])/7
end

# Sri Lanka
PLKA=21.559415;
ALKA=parse.(Float64,Array(Wcsv[241,5:qw]))/PLKA;
NLKA=zeros(DD);
for j=1:DD
    NLKA[j]=(ALKA[710+j]-ALKA[703+j])/7
end
BLKA=parse.(Float64,Array(Xcsv[241,5:qw]))/PLKA;
NDLKA=zeros(DD);
for j=1:DD
    NDLKA[j]=(BLKA[j+710]-BLKA[j+703])/7
end

# Thailand
PTHA=70.085127;
ATHA=parse.(Float64,Array(Wcsv[251,5:qw]))/PTHA;
NTHA=zeros(DD);
for j=1:DD
    NTHA[j]=(ATHA[710+j]-ATHA[703+j])/7
end
BTHA=parse.(Float64,Array(Xcsv[251,5:qw]))/PTHA;
NDTHA=zeros(DD);
for j=1:DD
    NDTHA[j]=(BTHA[j+710]-BTHA[j+703])/7
end

# United Staes 
PUSA=334.207212;
AUSA=parse.(Float64,Array(Wcsv[258,5:qw]))/PUSA;
NUSA=zeros(DD);
for j=1:DD
    NUSA[j]=(AUSA[710+j]-AUSA[703+j])/7
end
BUSA=parse.(Float64,Array(Xcsv[258,5:qw]))/PUSA;
NDUSA=zeros(DD);
for j=1:DD
    NDUSA[j]=(BUSA[j+710]-BUSA[j+703])/7
end

# United Kingdom 
PGBR=68.466544;
AGBR=parse.(Float64,Array(Wcsv[275,5:qw]))/PGBR;
NGBR=zeros(DD);
for j=1:DD
    NGBR[j]=(max(AGBR[710+j]-AGBR[703+j],0))/7
end
BGBR=parse.(Float64,Array(Xcsv[275,5:qw]))/PGBR;
NDGBR=zeros(DD);
for j=1:DD
    NDGBR[j]=(BGBR[j+710]-BGBR[j+703])/7
end

# Vietnam
PVNM=98.953541;
AVNM=parse.(Float64,Array(Wcsv[280,5:qw]))/PVNM;
NVNM=zeros(DD);
for j=1:DD
    NVNM[j]=(AVNM[710+j]-AVNM[703+j])/7
end

# France Italy Spain 
PFRA=65.508662;
PITA=60.317073;
PESP=46.784213;
PFIE=PFRA+PITA+PESP;
AFRA=parse.(Float64,Array(Wcsv[133,5:qw]));
AITA=parse.(Float64,Array(Wcsv[156,5:qw]));
AESP=parse.(Float64,Array(Wcsv[240,5:qw]));
AFIE=(AFRA+AITA+AESP)/PFIE;
NFIE=zeros(DD);
for j=1:DD
    NFIE[j]=(AFIE[710+j]-AFIE[703+j])/7
end
BFRA=parse.(Float64,Array(Xcsv[133,5:qw]))
BITA=parse.(Float64,Array(Xcsv[156,5:qw]));
BESP=parse.(Float64,Array(Xcsv[240,5:qw]));
BFIE=(BFRA+BITA+BESP)/PFIE;
NDFIE=zeros(DD);
for j=1:DD
    NDFIE[j]=max((BFIE[j+710]-BFIE[j+703]),0)/7
end

p=plot([NHKG NAUS NOKNW NMYS NKOR NVNM NBWN NNSW NVIC NSIN], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/3) floor(2*DD/3) DD;], [ll0 ll1 ll2 ll3]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Hong Kong" "Australia" "Okinawa" "Malaysia" "South Korea" "Vietnam" "Brunei" "New South Wales" "Victoria" "Singapore"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/cases.png") 

q=plot([NJPN NTKY NOKNW NOSK NTHA NVNM NIDN NIND NPHI NSIN], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU and MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/3) floor(2*DD/3) DD;], [ll0 ll1 ll2 ll3]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Thailand" "VNM" "Indonesia" "India" "Philippines" "Singapore"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/delta.png") 

r=plot([NDJPN NDAUS NDUSA NDOSK NDKOR NDGBR NDBWN NDRUS NDBRA NDSIN],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/3) floor(2*DD/3) DD;], [ll0 ll1 ll2 ll3]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(8), 
   label=["Japan" "Australia" "United States" "Osaka" "South Korea" "United Kingdom" "Brunei" "Russia" "Brazil" "Singapore"], 
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