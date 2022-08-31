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
dd0=Date(2022,7,1)
DD=Int64(qw-895);
dd1=dd0+Day(floor((DD-1)/3));
dd2=dd0+Day(floor(2*(DD-1)/3));
ddf=dd0+Day(DD-1);
ll0=string(dd0);
ll1=string(dd1);
ll2=string(dd2);
llf=string(ddf);

J=parse.(Float64,Ccsv[2:pa,2:qa]);
K=parse.(Float64,Dcsv[2:pa,2:qa]);

# Okinawa
POKNW=1.469335;    
COKNW=J[:,48]/POKNW
NOKNW=zeros(DD);
for j=1:DD
    NOKNW[j]=(COKNW[j+783]-COKNW[j+776])/7
end
DOKNW=K[:,48]/POKNW
NDOKNW=zeros(DD);
for j=1:DD
    NDOKNW[j]=(DOKNW[j+783]-DOKNW[j+776])/7
end

# Tokyo
PTKY=13.988129;
CTKY=J[:,14]/PTKY
NTKY=zeros(DD);
for j=1:DD
    NTKY[j]=(CTKY[j+783]-CTKY[j+776])/7
end

# Osaka
POSK=8.797153;
COSK=J[:,28]/POSK
NOSK=zeros(DD);
for j=1:DD
    NOSK[j]=(COSK[j+783]-COSK[j+776])/7
end
DOSK=K[:,28]/POSK
NDOSK=zeros(DD);
for j=1:DD
    NDOSK[j]=(DOSK[j+783]-DOSK[j+776])/7
end

# Kyushu
PFUK=5.112176;
PSAG=0.805721;
PNAG=1.290992;
PKUM=1.722474;
POIT=1.110553;
PMIY=1.057609;
PKAG=1.571833;
PKYU=PFUK+PSAG+PNAG+PKUM+POIT+PMIY+PKAG;
CFUK=J[:,41];   
CSAG=J[:,42];
CNAG=J[:,43];   
CKUM=J[:,44];
COIT=J[:,45];   
CMIY=J[:,46];  
CKAG=J[:,47];
CKYU=(CFUK+CSAG+CNAG+CKUM+COIT+CMIY+CKAG)/PKYU;
NKYU=zeros(DD);
for j=1:DD
    NKYU[j]=(CKYU[j+783]-CKYU[j+776])/7;
end

NMIY=zeros(DD);
for j=1:DD
    NMIY[j]=(CMIY[j+783]-CMIY[j+776])/PMIY/7;
end

# Argentina
PARG=45.870820;
AARG=parse.(Float64,Array(Wcsv[9,5:qw]))/PARG;
NARG=zeros(DD);
for j=1:DD
    NARG[j]=(AARG[j+891]-AARG[j+884])/7
end
BARG=parse.(Float64,Array(Xcsv[9,5:qw]))/PARG;
NDARG=zeros(DD);
for j=1:DD
    NDARG[j]=(BARG[j+891]-BARG[j+884])/7
end

# NSW
PNSW=8.21;
ANSW=parse.(Float64,Array(Wcsv[12,5:qw]))/PNSW;
NNSW=zeros(DD);
for j=1:DD
    NNSW[j]=(ANSW[j+891]-ANSW[j+884])/7
end

# Victoria
PVIC=6.64;
AVIC=parse.(Float64,Array(Wcsv[17,5:qw]))/PVIC;
NVIC=zeros(DD);
for j=1:DD
    NVIC[j]=(AVIC[j+891]-AVIC[j+884])/7
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
    NAUS[j]=(AAUS[j+891]-AAUS[j+884])/7
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
    NDAUS[j]=(BAUS[j+891]-BAUS[j+884])/7
end

# Western Australia
PWAU=2.69;
AWAU=parse.(Float64,Array(Wcsv[18,5:qw]))/PWAU;
NWAU=zeros(DD);
for j=1:DD
    NWAU[j]=(AWAU[j+891]-AWAU[j+884])/7
end

# Brazil 
PBRA=215.019011;
BBRA=parse.(Float64,Array(Xcsv[33,5:qw]))/PBRA;
NDBRA=zeros(DD);
for j=1:DD
    NDBRA[j]=(BBRA[j+891]-BBRA[j+884])/7
end

# Brunei Darussalam
PBWN=0.4435;
ABWN=parse.(Float64,Array(Wcsv[34,5:qw]))/PBWN;
NBWN=zeros(DD);
for j=1:DD
    NBWN[j]=(ABWN[j+891]-ABWN[j+884])/7
end
BBWN=parse.(Float64,Array(Xcsv[34,5:qw]))/PBWN;
NDBWN=zeros(DD);
for j=1:DD
    NDBWN[j]=(BBWN[j+891]-BBWN[j+884])/7
end

# Hong Kong
PHKG=7.600852;
AHKG=parse.(Float64,Array(Wcsv[73,5:qw]))/PHKG;
NHKG=zeros(DD);
for j=1:DD
    NHKG[j]=(AHKG[j+891]-AHKG[j+884])/7
end
BHKG=parse.(Float64,Array(Xcsv[73,5:qw]))/PHKG;
NDHKG=zeros(DD);
for j=1:DD
    NDHKG[j]=(BHKG[j+891]-BHKG[j+884])/7
end


# Colombia 
PCOL=51.765589;
BCOL=parse.(Float64,Array(Xcsv[95,5:qw]))/PCOL;
NDCOL=zeros(DD);
for j=1:DD
    NDCOL[j]=(BCOL[j+891]-BCOL[j+884])/7
end

# India 
PIND=1402.124607;
AIND=parse.(Float64,Array(Wcsv[150,5:qw]))/PIND;
NIND=zeros(DD);
for j=1:DD
    NIND[j]=(AIND[j+891]-AIND[j+884])/7
end
BIND=parse.(Float64,Array(Xcsv[150,5:qw]))/PIND;
NDIND=zeros(DD);
for j=1:DD
    NDIND[j]=(BIND[j+891]-BIND[j+884])/7
end

# Indonesia
PIDN=278.239007;
AIDN=parse.(Float64,Array(Wcsv[151,5:qw]))/PIDN;
NIDN=zeros(DD);
for j=1:DD
    NIDN[j]=(AIDN[j+891]-AIDN[j+884])/7
end
BIDN=parse.(Float64,Array(Xcsv[151,5:qw]))/PIDN;
NDIDN=zeros(DD);
for j=1:DD
    NDIDN[j]=(BIDN[j+891]-BIDN[j+884])/7
end

# Japan
PJPN=125.845010;
AJPN=parse.(Float64,Array(Wcsv[158,5:qw]))/PJPN;
NJPN=zeros(DD);
for j=1:DD
    NJPN[j]=(AJPN[j+891]-AJPN[j+884])/7
end
BJPN=parse.(Float64,Array(Xcsv[158,5:qw]))/PJPN;
NDJPN=zeros(DD);
for j=1:DD
    NDJPN[j]=(BJPN[j+891]-BJPN[j+884])/7
end

# South Korea
PKOR=51.341022;
AKOR=parse.(Float64,Array(Wcsv[164,5:qw]))/PKOR;
NKOR=zeros(DD);
for j=1:DD
    NKOR[j]=(AKOR[j+891]-AKOR[j+884])/7
end
BKOR=parse.(Float64,Array(Xcsv[164,5:qw]))/PKOR;
NDKOR=zeros(DD);
for j=1:DD
    NDKOR[j]=(BKOR[j+891]-BKOR[j+884])/7
end

# Malaysia
PMYS=33.060794;
AMYS=parse.(Float64,Array(Wcsv[180,5:qw]))/PMYS;
NMYS=zeros(DD);
for j=1:DD
    NMYS[j]=(AMYS[j+891]-AMYS[j+884])/7
end
BMYS=parse.(Float64,Array(Xcsv[180,5:qw]))/PMYS;
NDMYS=zeros(DD);
for j=1:DD
    NDMYS[j]=(BMYS[j+891]-BMYS[j+884])/7
end

# Mexico 
PMEX=131.137507;
BMEX=parse.(Float64,Array(Xcsv[187,5:qw]))/PMEX;
NDMEX=zeros(DD);
for j=1:DD
    NDMEX[j]=(BMEX[j+891]-BMEX[j+884])/7
end

# New Zealand
PNZ1=0.017593;
PNZ2=4.892946;
PNZL=PNZ1+PNZ2;
ANZ1=parse.(Float64,Array(Wcsv[202,5:qw]));
ANZ2=parse.(Float64,Array(Wcsv[203,5:qw]));
ANZL=(ANZ1+ANZ2)/PNZL;
NNZL=zeros(DD);
for j=1:DD
    NNZL[j]=(ANZL[j+891]-ANZL[j+884])/7
end

# Peru
PPER=33.719259;
APER=parse.(Float64,Array(Wcsv[215,5:qw]))/PPER;
NPER=zeros(DD);
for j=1:DD
    NPER[j]=(APER[j+891]-APER[j+884])/7
end
BPER=parse.(Float64,Array(Xcsv[215,5:qw]))/PPER;
NDPER=zeros(DD);
for j=1:DD
    NDPER[j]=(BPER[j+891]-BPER[j+884])/7
end

# Philippines
PPHI=112.027348;
APHI=parse.(Float64,Array(Wcsv[216,5:qw]))/PPHI;
NPHI=zeros(DD);
for j=1:DD
    NPHI[j]=(APHI[j+891]-APHI[j+884])/7
end
BPHI=parse.(Float64,Array(Xcsv[216,5:qw]))/PPHI;
NDPHI=zeros(DD);
for j=1:DD
    NDPHI[j]=(BPHI[j+891]-BPHI[j+884])/7
end

# Russia
PRUS=146.036343;
ARUS=parse.(Float64,Array(Wcsv[221,5:qw]))/PRUS;
NRUS=zeros(DD);
for j=1:DD
    NRUS[j]=(ARUS[j+891]-ARUS[j+884])/7
end
BRUS=parse.(Float64,Array(Xcsv[221,5:qw]))/PRUS;
NDRUS=zeros(DD);
for j=1:DD
    NDRUS[j]=(BRUS[j+891]-BRUS[j+884])/7
end

# Singapore
PSIN=5.925237;
ASIN=parse.(Float64,Array(Wcsv[234,5:qw]))/PSIN;
NSIN=zeros(DD);
for j=1:DD
    NSIN[j]=(ASIN[j+891]-ASIN[j+884])/7
end
BSIN=parse.(Float64,Array(Xcsv[234,5:qw]))/PSIN;
NDSIN=zeros(DD);
for j=1:DD
    NDSIN[j]=(BSIN[j+891]-BSIN[j+884])/7
end

# Sri Lanka
PLKA=21.559415;
ALKA=parse.(Float64,Array(Wcsv[242,5:qw]))/PLKA;
NLKA=zeros(DD);
for j=1:DD
    NLKA[j]=(ALKA[j+891]-ALKA[j+884])/7
end
BLKA=parse.(Float64,Array(Xcsv[242,5:qw]))/PLKA;
NDLKA=zeros(DD);
for j=1:DD
    NDLKA[j]=(BLKA[j+891]-BLKA[j+884])/7
end

# Taiwan
PTWN=23.61;
ATWN=parse.(Float64,Array(Wcsv[249,5:qw]))/PTWN;
NTWN=zeros(DD);
for j=1:DD
    NTWN[j]=(ATWN[j+891]-ATWN[j+884])/7
end

# Thailand
PTHA=70.085127;
ATHA=parse.(Float64,Array(Wcsv[252,5:qw]))/PTHA;
NTHA=zeros(DD);
for j=1:DD
    NTHA[j]=(ATHA[j+891]-ATHA[j+884])/7
end
BTHA=parse.(Float64,Array(Xcsv[252,5:qw]))/PTHA;
NDTHA=zeros(DD);
for j=1:DD
    NDTHA[j]=(BTHA[j+891]-BTHA[j+884])/7
end

# United Staes 
PUSA=334.207212;
AUSA=parse.(Float64,Array(Wcsv[259,5:qw]))/PUSA;
NUSA=zeros(DD);
for j=1:DD
    NUSA[j]=(AUSA[j+891]-AUSA[j+884])/7
end
BUSA=parse.(Float64,Array(Xcsv[259,5:qw]))/PUSA;
NDUSA=zeros(DD);
for j=1:DD
    NDUSA[j]=(BUSA[j+891]-BUSA[j+884])/7
end

# United Kingdom 
PGBR=68.466544;
AGBR=parse.(Float64,Array(Wcsv[276,5:qw]))/PGBR;
NGBR=zeros(DD);
for j=1:DD
    NGBR[j]=(max(AGBR[j+891]-AGBR[j+884],0))/7
end
BGBR=parse.(Float64,Array(Xcsv[276,5:qw]))/PGBR;
NDGBR=zeros(DD);
for j=1:DD
    NDGBR[j]=max(0,(BGBR[j+891]-BGBR[j+884]))/7
end

# Vietnam
PVNM=98.953541;
AVNM=parse.(Float64,Array(Wcsv[281,5:qw]))/PVNM;
NVNM=zeros(DD);
for j=1:DD
    NVNM[j]=(AVNM[j+891]-AVNM[j+884])/7
end

# France Italy Spain 
PFRA=65.508662;
PITA=60.317073;
PESP=46.784213;
PFIE=PFRA+PITA+PESP;
AFRA=parse.(Float64,Array(Wcsv[133,5:qw]));
AITA=parse.(Float64,Array(Wcsv[156,5:qw]));
AESP=parse.(Float64,Array(Wcsv[241,5:qw]));
AFIE=(AFRA+AITA+AESP)/PFIE;
NFIE=zeros(DD);
for j=1:DD
    NFIE[j]=(AFIE[j+891]-AFIE[j+884])/7
end
BFRA=parse.(Float64,Array(Xcsv[133,5:qw]))
BITA=parse.(Float64,Array(Xcsv[156,5:qw]));
BESP=parse.(Float64,Array(Xcsv[240,5:qw]));
BFIE=(BFRA+BITA+BESP)/PFIE;
NDFIE=zeros(DD);
for j=1:DD
    NDFIE[j]=max((BFIE[j+891]-BFIE[j+884]),0)/7
end

p=plot([NJPN NTKY NOKNW NOSK NKYU NMIY NKOR NHKG NTWN NSIN], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 DD;], [ll0 llf]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Kyushu" "Miyazaki" "South Korea" "Hong Kong" "Taiwan" "Singapore"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/cases.png") 

q=plot([NDJPN NDAUS NDOKNW NDOSK NDKOR NDGBR NDUSA NDRUS NDBRA NDSIN],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 DD;], [ll0 llf]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(8), 
   label=["Japan" "Australia" "Okinawa" "Osaka" "South Korea" "United Kingdom" "United States" "Russia" "Brazil" "Singapore"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/deaths.png") 

plot(p, q,
     layout=2, 
     size=(1260,420), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./crisis/crisis.png") 