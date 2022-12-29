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
DD=Int64(qw-987);
dd0=Date(2022,10,1);
dd1=Date(2022,11,1);
dd2=Date(2022,12,1);
dd3=Date(2023,1,1);
dd4=Date(2023,2,1)
ddf=dd0+Day(DD-1);
ll0=string(dd0);
ll1=string(dd1);
ll2=string(dd2);
ll3=string(dd3);
ll4=string(dd4);
llf=string(ddf);

J=parse.(Float64,Ccsv[2:pa,2:qa]);
K=parse.(Float64,Dcsv[2:pa,2:qa]);

# Okinawa
POKNW=1.469335;    
COKNW=J[:,48]/POKNW;
NOKNW=zeros(DD);
for j=1:DD
    NOKNW[j]=(COKNW[j+875]-COKNW[j+868])/7
end
DOKNW=K[:,48]/POKNW
NDOKNW=zeros(DD);
for j=1:DD
    NDOKNW[j]=(DOKNW[j+875]-DOKNW[j+868])/7
end

# Tokyo
PTKY=13.988129;
CTKY=J[:,14]/PTKY;
NTKY=zeros(DD);
for j=1:DD
    NTKY[j]=(CTKY[j+875]-CTKY[j+868])/7
end
DTKY=K[:,14]/PTKY;
NDTKY=zeros(DD);
for j=1:DD
    NDTKY[j]=(DTKY[j+875]-DTKY[j+868])/7
end

# Osaka
POSK=8.797153;
COSK=J[:,28]/POSK;
NOSK=zeros(DD);
for j=1:DD
    NOSK[j]=(COSK[j+875]-COSK[j+868])/7
end
DOSK=K[:,28]/POSK;
NDOSK=zeros(DD);
for j=1:DD
    NDOSK[j]=(DOSK[j+875]-DOSK[j+868])/7
end

# Hokkaido
PHKD=5.191355;
CHKD=J[:,2]/PHKD;
NHKD=zeros(DD);
for j=1:DD
    NHKD[j]=(CHKD[j+875]-CHKD[j+868])/7
end
DHKD=K[:,2]/PHKD;
NDHKD=zeros(DD);
for j=1:DD
    NDHKD[j]=(DHKD[j+875]-DHKD[j+868])/7
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
    NKYU[j]=(CKYU[j+875]-CKYU[j+868])/7;
end

# NSW
PNSW=8.21;
ANSW=parse.(Float64,Array(Wcsv[12,5:qw]))/PNSW;
NNSW=zeros(DD);
for j=1:DD
    NNSW[j]=(ANSW[j+983]-ANSW[j+976])/7
end

# Victoria
PVIC=6.64;
AVIC=parse.(Float64,Array(Wcsv[17,5:qw]))/PVIC;
NVIC=zeros(DD);
for j=1:DD
    NVIC[j]=(AVIC[j+983]-AVIC[j+976])/7
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
    NAUS[j]=(AAUS[j+983]-AAUS[j+976])/7
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
    NDAUS[j]=(BAUS[j+983]-BAUS[j+976])/7
end

# Western Australia
PWAU=2.69;
AWAU=parse.(Float64,Array(Wcsv[18,5:qw]))/PWAU;
NWAU=zeros(DD);
for j=1:DD
    NWAU[j]=(AWAU[j+983]-AWAU[j+976])/7
end

# Brunei Darussalam
PBWN=0.4435;
ABWN=parse.(Float64,Array(Wcsv[34,5:qw]))/PBWN;
NBWN=zeros(DD);
for j=1:DD
    NBWN[j]=(ABWN[j+983]-ABWN[j+976])/7
end
BBWN=parse.(Float64,Array(Xcsv[34,5:qw]))/PBWN;
NDBWN=zeros(DD);
for j=1:DD
    NDBWN[j]=(BBWN[j+983]-BBWN[j+976])/7
end

# Hong Kong
PHKG=7.600852;
AHKG=parse.(Float64,Array(Wcsv[73,5:qw]))/PHKG;
NHKG=zeros(DD);
for j=1:DD
    NHKG[j]=(AHKG[j+983]-AHKG[j+976])/7
end
BHKG=parse.(Float64,Array(Xcsv[73,5:qw]))/PHKG;
NDHKG=zeros(DD);
for j=1:DD
    NDHKG[j]=(BHKG[j+983]-BHKG[j+976])/7
end

# India 
PIND=1402.124607;
AIND=parse.(Float64,Array(Wcsv[150,5:qw]))/PIND;
NIND=zeros(DD);
for j=1:DD
    NIND[j]=(AIND[j+983]-AIND[j+976])/7
end
BIND=parse.(Float64,Array(Xcsv[150,5:qw]))/PIND;
NDIND=zeros(DD);
for j=1:DD
    NDIND[j]=(BIND[j+983]-BIND[j+976])/7
end

# Indonesia
PIDN=278.239007;
AIDN=parse.(Float64,Array(Wcsv[151,5:qw]))/PIDN;
NIDN=zeros(DD);
for j=1:DD
    NIDN[j]=(AIDN[j+983]-AIDN[j+976])/7
end
BIDN=parse.(Float64,Array(Xcsv[151,5:qw]))/PIDN;
NDIDN=zeros(DD);
for j=1:DD
    NDIDN[j]=(BIDN[j+983]-BIDN[j+976])/7
end

# Japan
PJPN=125.845010;
AJPN=parse.(Float64,Array(Wcsv[158,5:qw]))/PJPN;
NJPN=zeros(DD);
for j=1:DD
    NJPN[j]=(AJPN[j+983]-AJPN[j+976])/7
end
BJPN=parse.(Float64,Array(Xcsv[158,5:qw]))/PJPN;
NDJPN=zeros(DD);
for j=1:DD
    NDJPN[j]=(BJPN[j+983]-BJPN[j+976])/7
end

# South Korea
PKOR=51.341022;
AKOR=parse.(Float64,Array(Wcsv[164,5:qw]))/PKOR;
NKOR=zeros(DD);
for j=1:DD
    NKOR[j]=(AKOR[j+983]-AKOR[j+976])/7
end
BKOR=parse.(Float64,Array(Xcsv[164,5:qw]))/PKOR;
NDKOR=zeros(DD);
for j=1:DD
    NDKOR[j]=(BKOR[j+983]-BKOR[j+976])/7
end

# Malaysia
PMYS=33.060794;
AMYS=parse.(Float64,Array(Wcsv[180,5:qw]))/PMYS;
NMYS=zeros(DD);
for j=1:DD
    NMYS[j]=(AMYS[j+983]-AMYS[j+976])/7
end
BMYS=parse.(Float64,Array(Xcsv[180,5:qw]))/PMYS;
NDMYS=zeros(DD);
for j=1:DD
    NDMYS[j]=(BMYS[j+983]-BMYS[j+976])/7
end

# New Zealand
PNZL=4.892946;
ANZL=parse.(Float64,Array(Wcsv[205,5:qw]))/PNZL;
NNZL=zeros(DD);
for j=1:DD
    NNZL[j]=(ANZL[j+983]-ANZL[j+976])/7
end
BNZL=parse.(Float64,Array(Xcsv[205,5:qw]))/PNZL;
NDNZL=zeros(DD);
for j=1:DD
    NDNZL[j]=(BNZL[j+983]-BNZL[j+976])/7
end

# Philippines
PPHI=112.027348;
APHI=parse.(Float64,Array(Wcsv[218,5:qw]))/PPHI;
NPHI=zeros(DD);
for j=1:DD
    NPHI[j]=(APHI[j+983]-APHI[j+976])/7
end
BPHI=parse.(Float64,Array(Xcsv[218,5:qw]))/PPHI;
NDPHI=zeros(DD);
for j=1:DD
    NDPHI[j]=(BPHI[j+983]-BPHI[j+976])/7
end

# Singapore
PSIN=5.925237;
ASIN=parse.(Float64,Array(Wcsv[236,5:qw]))/PSIN;
NSIN=zeros(DD);
for j=1:DD
    NSIN[j]=(ASIN[j+983]-ASIN[j+976])/7
end
BSIN=parse.(Float64,Array(Xcsv[236,5:qw]))/PSIN;
NDSIN=zeros(DD);
for j=1:DD
    NDSIN[j]=(BSIN[j+983]-BSIN[j+976])/7
end

# Sri Lanka
PLKA=21.559415;
ALKA=parse.(Float64,Array(Wcsv[244,5:qw]))/PLKA;
NLKA=zeros(DD);
for j=1:DD
    NLKA[j]=(ALKA[j+983]-ALKA[j+976])/7
end
BLKA=parse.(Float64,Array(Xcsv[244,5:qw]))/PLKA;
NDLKA=zeros(DD);
for j=1:DD
    NDLKA[j]=(BLKA[j+983]-BLKA[j+976])/7
end

# Taiwan
PTWN=23.61;
ATWN=parse.(Float64,Array(Wcsv[251,5:qw]))/PTWN;
NTWN=zeros(DD);
for j=1:DD
    NTWN[j]=(ATWN[j+983]-ATWN[j+976])/7
end
BTWN=parse.(Float64,Array(Xcsv[251,5:qw]))/PTWN;
NDTWN=zeros(DD);
for j=1:DD
    NDTWN[j]=(BTWN[j+983]-BTWN[j+976])/7
end


# Thailand
PTHA=70.085127;
ATHA=parse.(Float64,Array(Wcsv[254,5:qw]))/PTHA;
NTHA=zeros(DD);
for j=1:DD
    NTHA[j]=(ATHA[j+983]-ATHA[j+976])/7
end
BTHA=parse.(Float64,Array(Xcsv[254,5:qw]))/PTHA;
NDTHA=zeros(DD);
for j=1:DD
    NDTHA[j]=(BTHA[j+983]-BTHA[j+976])/7
end

# Vietnam
PVNM=98.953541;
AVNM=parse.(Float64,Array(Wcsv[285,5:qw]))/PVNM;
NVNM=zeros(DD);
for j=1:DD
    NVNM[j]=(AVNM[j+983]-AVNM[j+976])/7
end

p=plot([NJPN NTKY NOKNW NOSK NHKD NAUS NKOR NHKG NTWN NSIN], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 32 62 DD], [ll0,ll1,ll2,llf]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hokkaido" "Australia" "South Korea" "Hong Kong" "Taiwan" "Singapore"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/cases.png") 

q=plot([NDJPN NDTKY NDOKNW NDOSK NDHKD NDAUS NDKOR NDHKG NDTWN NDSIN],   
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 32 62 DD], [ll0,ll1,ll2,llf]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hokkaido" "Australia" "South Korea" "Hong Kong" "Taiwan" "Singapore"], 
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
savefig("./crisis.png") 