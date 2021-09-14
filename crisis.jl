# crisis.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://covid19.mhlw.go.jp/public/opendata/confirmed_cases_cumulative_daily.csv","./csv/mhlw_cases.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","./csv/jhu_cases.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv","./csv/jhu_deaths.csv");

# Shape up the data.
Ccsv=DataFrame(CSV.File("./csv/mhlw_cases.csv", header=false, delim=','));
Wcsv=DataFrame(CSV.File("./csv/jhu_cases.csv", header=false, delim=','));
Xcsv=DataFrame(CSV.File("./csv/jhu_deaths.csv", header=false, delim=','));
(pa,qa)=size(Ccsv);
l=Int64(floor((pa-1)/48));
(pw,qw)=size(Wcsv);

# Plot the data
# d0: the initial date
# df: the final day
dd0=Date(2021,7,1)
DD=Int64(qw-530);
dd1=dd0+Day(floor((DD-1)/2));
dd2=dd0+Day(DD-1);
ll0=string(dd0);
ll1=string(dd1);
ll2=string(dd2);

L=Ccsv[2:pa,2];
J=parse.(Float64,Ccsv[2:pa,3]);

# Okinawa
POKNW=1.458870;
ROWOKNW=findall(x->x=="Okinawa",L);
COKNW=J[ROWOKNW]/POKNW
NOKNW=zeros(DD);
for j=1:DD
    NOKNW[j]=(COKNW[j+418]-COKNW[j+411])/7
end

# Tokyo
PTKY=14.049146;
ROWTKY=findall(x->x=="Tokyo",L);
CTKY=J[ROWTKY]/PTKY
NTKY=zeros(DD);
for j=1:DD
    NTKY[j]=(CTKY[j+418]-CTKY[j+411])/7
end

# Argentina
PARG=45.670451;
BARG=parse.(Float64,Array(Xcsv[8,5:qw]))/PARG;
NDARG=zeros(DD);
for j=1:DD
    NDARG[j]=(BARG[j+526]-BARG[j+519])/7
end

# NSW
PNSW=8.196;
ANSW=parse.(Float64,Array(Wcsv[11,5:qw]))/PNSW;
NNSW=zeros(DD);
for j=1:DD
    NNSW[j]=(ANSW[526+j]-ANSW[519+j])/7
end

# Victoria
PVIC=6.7;
AVIC=parse.(Float64,Array(Wcsv[16,5:qw]))/PVIC;
NVIC=zeros(DD);
for j=1:DD
    NVIC[j]=(AVIC[526+j]-AVIC[519+j])/7
end

# Brazil 
PBRA=214.289417;
BBRA=parse.(Float64,Array(Xcsv[32,5:qw]))/PBRA;
NDBRA=zeros(DD);
for j=1:DD
    NDBRA[j]=(BBRA[j+526]-BBRA[j+519])/7
end

# Brunei Darussalam
PBWN=0.442205;
ABWN=parse.(Float64,Array(Wcsv[33,5:qw]))/PBWN;
NBWN=zeros(DD);
for j=1:DD
    NBWN[j]=(ABWN[526+j]-ABWN[519+j])/7
end

# Colombia 
PCOL=51.503463;
BCOL=parse.(Float64,Array(Xcsv[94,5:qw]))/PCOL;
NDCOL=zeros(DD);
for j=1:DD
    NDCOL[j]=(BCOL[j+526]-BCOL[j+519])/7
end

# Indonesia
PIDN=276.833206;
AIDN=parse.(Float64,Array(Wcsv[150,5:qw]))/PIDN;
NIDN=zeros(DD);
for j=1:DD
    NIDN[j]=(AIDN[526+j]-AIDN[519+j])/7
end
BIDN=parse.(Float64,Array(Xcsv[150,5:qw]))/PIDN;
NDIDN=zeros(DD);
for j=1:DD
    NDIDN[j]=(BIDN[j+526]-BIDN[j+519])/7
end

# Israel
PISR=8.789774;
AISR=parse.(Float64,Array(Wcsv[154,5:qw]))/PISR;
NISR=zeros(DD);
for j=1:DD
    NISR[j]=(AISR[526+j]-AISR[519+j])/7
end
BISR=parse.(Float64,Array(Xcsv[154,5:qw]))/PISR;
NDISR=zeros(DD);
for j=1:DD
    NDISR[j]=(BISR[j+526]-BISR[j+519])/7
end


# Japan
PJPN=125.36;
AJPN=parse.(Float64,Array(Wcsv[157,5:qw]))/PJPN;
NJPN=zeros(DD);
for j=1:DD
    NJPN[j]=(AJPN[526+j]-AJPN[519+j])/7
end

# South Korea
PKOR=51.318552;
AKOR=parse.(Float64,Array(Wcsv[162,5:qw]))/PKOR;
NKOR=zeros(DD);
for j=1:DD
    NKOR[j]=(AKOR[526+j]-AKOR[519+j])/7
end

# Malaysia
PMYS=32.66;
AMYS=parse.(Float64,Array(Wcsv[178,5:qw]))/PMYS;
NMYS=zeros(DD);
for j=1:DD
    NMYS[j]=(AMYS[526+j]-AMYS[519+j])/7
end

# Mexico 
PMEX=130.482814;
BMEX=parse.(Float64,Array(Xcsv[185,5:qw]))/PMEX;
NDMEX=zeros(DD);
for j=1:DD
    NDMEX[j]=(BMEX[j+526]-BMEX[j+519])/7
end

# Peru
PPER=33.510887;
APER=parse.(Float64,Array(Wcsv[213,5:qw]))/PPER;
NPER=zeros(DD);
for j=1:DD
    NPER[j]=(APER[526+j]-APER[519+j])/7
end
BMYS=parse.(Float64,Array(Xcsv[178,5:qw]))/PMYS;
NDMYS=zeros(DD);
for j=1:DD
    NDMYS[j]=(BMYS[j+526]-BMYS[j+519])/7
end
BPER=parse.(Float64,Array(Xcsv[213,5:qw]))/PPER;
NDPER=zeros(DD);
for j=1:DD
    NDPER[j]=(BPER[j+526]-BPER[j+519])/7
end

# Philippines
PPHI=111.249116;
APHI=parse.(Float64,Array(Wcsv[214,5:qw]))/PPHI;
NPHI=zeros(DD);
for j=1:DD
    NPHI[j]=(APHI[526+j]-APHI[519+j])/7
end
BMYS=parse.(Float64,Array(Xcsv[178,5:qw]))/PMYS;
NDMYS=zeros(DD);
for j=1:DD
    NDMYS[j]=(BMYS[j+526]-BMYS[j+519])/7
end
BPHI=parse.(Float64,Array(Xcsv[214,5:qw]))/PPHI;
NDPHI=zeros(DD);
for j=1:DD
    NDPHI[j]=(BPHI[j+526]-BPHI[j+519])/7
end

# Singapore
PSIN=5.902011;
ASIN=parse.(Float64,Array(Wcsv[232,5:qw]))/PSIN;
NSIN=zeros(DD);
for j=1:DD
    NSIN[j]=(ASIN[526+j]-ASIN[519+j])/7
end

# Sri Lanka
PLKA=21.516097;
ALKA=parse.(Float64,Array(Wcsv[240,5:qw]))/PLKA;
NLKA=zeros(DD);
for j=1:DD
    NLKA[j]=(ALKA[526+j]-ALKA[519+j])/7
end
BLKA=parse.(Float64,Array(Xcsv[240,5:qw]))/PLKA;
NDLKA=zeros(DD);
for j=1:DD
    NDLKA[j]=(BLKA[j+526]-BLKA[j+519])/7
end

# Thailand
PTHA=70.000662;
ATHA=parse.(Float64,Array(Wcsv[250,5:qw]))/PTHA;
NTHA=zeros(DD);
for j=1:DD
    NTHA[j]=(ATHA[526+j]-ATHA[519+j])/7
end
BTHA=parse.(Float64,Array(Xcsv[250,5:qw]))/PTHA;
NDTHA=zeros(DD);
for j=1:DD
    NDTHA[j]=(BTHA[j+526]-BTHA[j+519])/7
end

# United Staes 
PUSA=333.225477;
AUSA=parse.(Float64,Array(Wcsv[256,5:qw]))/PUSA;
NUSA=zeros(DD);
for j=1:DD
    NUSA[j]=(AUSA[526+j]-AUSA[519+j])/7
end
BUSA=parse.(Float64,Array(Xcsv[256,5:qw]))/PUSA;
NDUSA=zeros(DD);
for j=1:DD
    NDUSA[j]=(BUSA[j+526]-BUSA[j+519])/7
end

# United Kingdom 
PGBR=68.294438;
AGBR=parse.(Float64,Array(Wcsv[271,5:qw]))/PGBR;
NGBR=zeros(DD);
for j=1:DD
    NGBR[j]=(max(AGBR[526+j]-AGBR[519+j],0))/7
end

# Vietnam
PVNM=98.341025;
AVNM=parse.(Float64,Array(Wcsv[276,5:qw]))/PVNM;
NVNM=zeros(DD);
for j=1:DD
    NVNM[j]=(AVNM[526+j]-AVNM[519+j])/7
end

p=plot([NUSA NPHI NOKNW NMYS NTHA NBWN NNSW NLKA NISR NGBR], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU and MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["United States" "Philippines" "Okinawa" "Malaysia" "Thailand" "Brunei" "New South Wales" "Sri Lanka" "Israel" "United Kingdom"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/cases.png") 

q=plot([NJPN NTKY NSIN NKOR NVNM NVIC NIDN], 
    grid=false,
    linewidth=2, 
    title="COVID-19 7-day average of daily new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(8), 
    label=["Japan" "Tokyo" "Singapore" "South Korea" "Vietnam" "Victoria" "Indonesia"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/delta.png") 

r=plot([NDARG NDBRA NDIDN NDMYS NDMEX NDPER NDLKA NDTHA NDUSA NDISR],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(8), 
    label=["Argentina" "Brazil" "Indonesia" "Malaysia" "Mexico" "Peru" "Sri Lanka" "Thailand" "United States" "Israel"],
   palette = :seaborn_bright, 
     legend = :topleft)
savefig("./crisis/deaths.png") 

# Download data from the MHLW web site. 
download("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/global_data/time_series_covid19_vaccine_global.csv","./csv/jhu_vaccinated.csv");

Vcsv=DataFrame(CSV.File("./csv/jhu_vaccinated.csv", header=false, delim=','));
(m,n)=size(Vcsv);
ROW=Vcsv[2:m,1];
UID=Vcsv[2:m,7];
VAC=Vcsv[2:m,5];

# Plot the data
# d0: the initial date
# df: the final day
d0=Date(2021,7,1)
d2=Date(Vcsv[m,2]);
diff = d2-d0; 
D = 1+Dates.value(diff)
d1=d0+Day(floor((D-1)/2));

l0=string(d0);
l1=string(d1);
l2=string(d2);

# Okinawa
POKNW=1.458870;

# Tokyo
PTKY=14.049146;

# Japan
PJPN=1253600
ROWJPN=findall(x->x=="Japan",ROW);
VACJPN=VAC[ROWJPN];
(DJPN,)=size(VACJPN);
FVACJPN=zeros(DJPN);
for j=1:DJPN
    FVACJPN[j]=parse(Float64,VACJPN[j]);
end
VJPN=FVACJPN[DJPN-D+1:DJPN]/PJPN;

# NSW
#PNSW=8.196;

# Brunei Darussalam
PBWN=0.442205;

# Indonesia
PIDN=2768332.06;
ROWIDN=findall(x->x=="Indonesia",ROW);
PVACIDN=VAC[ROWIDN];
PUIDIDN=UID[ROWIDN];
UIDIDN=findall(x->x=="360",PUIDIDN);
VACIDN=PVACIDN[UIDIDN];
(DIDN,)=size(VACIDN);
FVACIDN=zeros(DIDN);
for j=1:DIDN
    FVACIDN[j]=parse(Float64,VACIDN[j]);
end
VIDN=FVACIDN[DIDN-D+1:DIDN]/PIDN;


# South Korea
#PKOR=51.318552;

# Malaysia
PMYS=326600;
ROWMYS=findall(x->x=="Malaysia",ROW);
PVACMYS=VAC[ROWMYS];
PUIDMYS=UID[ROWMYS];
UIDMYS=findall(x->x=="458",PUIDMYS);
VACMYS=PVACMYS[UIDMYS];
(DMYS,)=size(VACMYS);
FVACMYS=zeros(DMYS);
for j=1:DMYS
    FVACMYS[j]=parse(Float64,VACMYS[j]);
end
VMYS=FVACMYS[DMYS-D+1:DMYS]/PMYS;

# Philippines
PPHI=1112491.16;
ROWPHI=findall(x->x=="Philippines",ROW);
VACPHI=VAC[ROWPHI];
(DPHI,)=size(VACPHI);
FVACPHI=zeros(DPHI);
for j=1:DPHI
    FVACPHI[j]=parse(Float64,VACPHI[j]);
end
VPHI=FVACPHI[DPHI-D+1:DPHI]/PPHI;

# Thailand
PTHA=700006.62;
ROWTHA=findall(x->x=="Thailand",ROW);
VACTHA=VAC[ROWTHA];
(DTHA,)=size(VACTHA);
FVACTHA=zeros(DTHA);
for j=1:DTHA
    FVACTHA[j]=parse(Float64,VACTHA[j]);
end
VTHA=FVACTHA[DTHA-D+1:DTHA]/PTHA;

# NSW
#PNSW=8.196;

# Brunei Darussalam
PBWN=4422.05;
ROWBWN=findall(x->x=="Brunei",ROW);
VACBWN=VAC[ROWBWN];
(DBWN,)=size(VACBWN);
FVACBWN=zeros(DBWN);
for j=1:DBWN
    FVACBWN[j]=parse(Float64,VACBWN[j]);
end
VBWN=FVACBWN[DBWN-D+1:DBWN]/PBWN;

# Singapore
PSIN=59020.11;
ROWSIN=findall(x->x=="Singapore",ROW);
VACSIN=VAC[ROWSIN];
(DSIN,)=size(VACSIN);
FVACSIN=zeros(DSIN);
for j=1:DSIN
    FVACSIN[j]=parse(Float64,VACSIN[j]);
end
VSIN=FVACSIN[DSIN-D+1:DSIN]/PSIN;

# Vietnam
#PVNM=983410.25;
PVNM=59020.11;
ROWVNM=findall(x->x=="Vietnam",ROW);
VACVNM=VAC[ROWVNM];
(DVNM,)=size(VACVNM);
FVACVNM=zeros(DVNM);
for j=1:DVNM
    FVACVNM[j]=parse(Float64,VACVNM[j]);
end
VVNM=FVACVNM[DVNM-D+1:DVNM]/PVNM;

# Sri Lanka
#PLKA=21.516097;
# United Staes 
#PUSA=333.225477;
# United Kingdom 
#PGBR=68.294438;


s=plot([VJPN VPHI VBWN VIDN VMYS VSIN VTHA VVNM], 
    grid=false,
    linewidth=2, 
    title="COVID-19 fully vaccinated \n data sourced by JHU", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/2) D;], [l0 l1 l2]),
    xlabel="date",
    yaxis="%",
    legendfont=font(8), 
    label=["Japan" "Philippines" "Brunei Darussalam" "Indonesia" "Malaysia" "Singapore" "Thailand" "Vietnam"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/vaccination_asia.png") 

plot(p, q, s, r,
     layout=4, 
     size=(1260,840), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./crisis/crisis.png") 