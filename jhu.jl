# jhu.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames, DifferentialEquations

# Download data from the MHLW web site. 
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","time_series_covid19_confirmed_global.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv","time_series_covid19_deaths_global.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv","time_series_covid19_recovered_global.csv");

Acsv=DataFrame(CSV.File("time_series_covid19_confirmed_global.csv", header=false, delim=','));
Bcsv=DataFrame(CSV.File("time_series_covid19_deaths_global.csv", header=false, delim=','));
Ccsv=DataFrame(CSV.File("time_series_covid19_recovered_global.csv", header=false, delim=','));
(pa,qa)=size(Acsv);

# Argentina 8 8
PARG=45.2;
AARG=parse.(Float64,Array(Acsv[8,5:qa]))/PARG;
NARG=zeros(qa-4);
NARG[1]=AARG[1];
for j=2:qa-4
    NARG[j]=AARG[j]-AARG[j-1]
end
BARG=parse.(Float64,Array(Bcsv[8,5:qa]))/PARG;
CARG=parse.(Float64,Array(Acsv[8,5:qa]));
RARG=parse.(Float64,Array(Ccsv[8,5:qa]));
IARG=CARG-RARG;
NDARG=zeros(qa-439);
for j=1:qa-439
    NDARG[j]=(BARG[j+435]-BARG[j+428])/7
end

# NSW
PNSW=7.5;
ANSW=parse.(Float64,Array(Acsv[11,5:qa]))/PNSW;
BNSW=parse.(Float64,Array(Bcsv[11,5:qa]))/PNSW;
CNSW=parse.(Float64,Array(Acsv[11,5:qa]));
RNSW=parse.(Float64,Array(Ccsv[11,5:qa]));
INSW=CNSW-RNSW;

# Victoria
PVIC=6.4;
AVIC=parse.(Float64,Array(Acsv[16,5:qa]))/PVIC;
BVIC=parse.(Float64,Array(Bcsv[16,5:qa]))/PVIC;
CVIC=parse.(Float64,Array(Acsv[16,5:qa]));
RVIC=parse.(Float64,Array(Ccsv[16,5:qa]));
IVIC=CVIC-RVIC;

# Bangladesh 22 22
PBGD=165;
ABGD=parse.(Float64,Array(Acsv[22,5:qa]))/PBGD;
NBGD=zeros(qa-4);
NBGD[1]=ABGD[1];
for j=2:qa-4
    NBGD[j]=ABGD[j]-ABGD[j-1]
end
BBGD=parse.(Float64,Array(Bcsv[22,5:qa]))/PBGD;
CBGD=parse.(Float64,Array(Acsv[22,5:qa]));
RBGD=parse.(Float64,Array(Ccsv[22,5:qa]));
IBGD=CBGD-RBGD;
NDBGD=zeros(qa-439);
for j=1:qa-439
    NDBGD[j]=(BBGD[j+435]-BBGD[j+428])/7
end

# Brazil 32 32
PBRA=213;
ABRA=parse.(Float64,Array(Acsv[32,5:qa]))/PBRA;
NBRA=zeros(qa-4);
NBRA[1]=ABRA[1];
for j=2:qa-4
    NBRA[j]=max(ABRA[j]-ABRA[j-1],0)
end
BBRA=parse.(Float64,Array(Bcsv[32,5:qa]))/PBRA;
CBRA=parse.(Float64,Array(Acsv[32,5:qa]));
RBRA=parse.(Float64,Array(Ccsv[32,5:qa]));
IBRA=CBRA-RBRA;
NDBRA=zeros(qa-439);
for j=1:qa-439
    NDBRA[j]=(BBRA[j+435]-BBRA[j+428])/7
end

# Hubei
PHubei=58.5;
AHubei=parse.(Float64,Array(Acsv[73,5:qa]))/PHubei;
BHubei=parse.(Float64,Array(Bcsv[73,5:qa]))/PHubei;
CHubei=parse.(Float64,Array(Acsv[73,5:qa]));
RHubei=parse.(Float64,Array(Ccsv[58,5:qa]));
IHubei=CHubei-RHubei;

# Colombia 93 78
PCOL=50.9;
ACOL=parse.(Float64,Array(Acsv[94,5:qa]))/PCOL;
NCOL=zeros(qa-4);
NCOL[1]=ACOL[1];
for j=2:qa-4
    NCOL[j]=ACOL[j]-ACOL[j-1]
end
BCOL=parse.(Float64,Array(Bcsv[94,5:qa]))/PCOL;
CCOL=parse.(Float64,Array(Acsv[94,5:qa]));
RCOL=parse.(Float64,Array(Ccsv[79,5:qa]));
ICOL=CCOL-RCOL;
NDCOL=zeros(qa-439);
for j=1:qa-439
    NDCOL[j]=(BCOL[j+435]-BCOL[j+428])/7
end

# France 131 116
PFRA=65.3;
AFRA=parse.(Float64,Array(Acsv[132,5:qa]))/PFRA;
NFRA=zeros(qa-4);
NFRA[1]=AFRA[1];
for j=2:qa-4
    NFRA[j]=max(AFRA[j]-AFRA[j-1],0)
end
BFRA=parse.(Float64,Array(Bcsv[132,5:qa]))/PFRA;
CFRA=parse.(Float64,Array(Acsv[132,5:qa]));
RFRA=parse.(Float64,Array(Ccsv[117,5:qa]));
IFRA=CFRA-RFRA;
NDFRA=zeros(qa-439);
for j=1:qa-439
    NDFRA[j]=(BFRA[j+435]-BFRA[j+428])/7
end


# India 148 133
PIND=1380;
AIND=parse.(Float64,Array(Acsv[149,5:qa]))/PIND;
NIND=zeros(qa-4);
NIND[1]=AIND[1];
for j=2:qa-4
    NIND[j]=AIND[j]-AIND[j-1]
end
BIND=parse.(Float64,Array(Bcsv[149,5:qa]))/PIND;
CIND=parse.(Float64,Array(Acsv[149,5:qa]));
RIND=parse.(Float64,Array(Ccsv[134,5:qa]));
IIND=CIND-RIND;
NDIND=zeros(qa-439);
for j=1:qa-439
    NDIND[j]=(BIND[j+435]-BIND[j+428])/7
end

# Indonesia
PIDN=271;
AIDN=parse.(Float64,Array(Acsv[150,5:qa]))/PIDN;
NIDN=zeros(qa-4);
NIDN[1]=AIDN[1];
for j=2:qa-4
    NIDN[j]=AIDN[j]-AIDN[j-1]
end
BIDN=parse.(Float64,Array(Bcsv[150,5:qa]))/PIDN;
CIDN=parse.(Float64,Array(Acsv[150,5:qa]));
RIDN=parse.(Float64,Array(Ccsv[135,5:qa]));
IIDN=CIDN-RIDN;
NDIDN=zeros(qa-439);
for j=1:qa-439
    NDIDN[j]=(BIDN[j+435]-BIDN[j+428])/7
end

# Italia 154 139
PITA=60.5;
AITA=parse.(Float64,Array(Acsv[155,5:qa]))/PITA;
NITA=zeros(qa-4);
NITA[1]=AITA[1];
for j=2:qa-4
    NITA[j]=AITA[j]-AITA[j-1]
end
BITA=parse.(Float64,Array(Bcsv[155,5:qa]))/PITA;
CITA=parse.(Float64,Array(Acsv[155,5:qa]));
RITA=parse.(Float64,Array(Ccsv[140,5:qa]));
IITA=CITA-RITA;
NDITA=zeros(qa-439);
for j=1:qa-439
    NDITA[j]=(BITA[j+435]-BITA[j+428])/7
end

# Japan
PJPN=125.36;
AJPN=parse.(Float64,Array(Acsv[157,5:qa]))/PJPN;
NJPN=zeros(qa-4);
NJPN[1]=AJPN[1];
for j=2:qa-4
    NJPN[j]=AJPN[j]-AJPN[j-1]
end
BJPN=parse.(Float64,Array(Bcsv[157,5:qa]))/PJPN;
CJPN=parse.(Float64,Array(Acsv[157,5:qa]));
RJPN=parse.(Float64,Array(Ccsv[142,5:qa]));
IJPN=CJPN-RJPN;
NDJPN=zeros(qa-439);
for j=1:qa-439
    NDJPN[j]=(BJPN[j+435]-BJPN[j+428])/7
end

# South Korea
PKOR=51.3;
AKOR=parse.(Float64,Array(Acsv[162,5:qa]))/PKOR;
NKOR=zeros(qa-4);
NKOR[1]=AKOR[1];
for j=2:qa-4
    NKOR[j]=AKOR[j]-AKOR[j-1]
end
BKOR=parse.(Float64,Array(Bcsv[162,5:qa]))/PKOR;
CKOR=parse.(Float64,Array(Acsv[162,5:qa]));
RKOR=parse.(Float64,Array(Ccsv[147,5:qa]));
IKOR=CKOR-RKOR;
NDKOR=zeros(qa-439);
for j=1:qa-439
    NDKOR[j]=(BKOR[j+435]-BKOR[j+428])/7
end

# Malaysia
PMYS=32.6;
AMYS=parse.(Float64,Array(Acsv[178,5:qa]))/PMYS;
NMYS=zeros(qa-4);
NMYS[1]=AMYS[1];
for j=2:qa-4
    NMYS[j]=AMYS[j]-AMYS[j-1]
end
BMYS=parse.(Float64,Array(Bcsv[178,5:qa]))/PMYS;
CMYS=parse.(Float64,Array(Acsv[178,5:qa]));
RMYS=parse.(Float64,Array(Ccsv[163,5:qa]));
IMYS=CMYS-RMYS;
NDMYS=zeros(qa-439);
for j=1:qa-439
    NDMYS[j]=(BMYS[j+435]-BMYS[j+428])/7
end

# Mexico 183 168
PMEX=129;
AMEX=parse.(Float64,Array(Acsv[185,5:qa]))/PMEX;
NMEX=zeros(qa-4);
NMEX[1]=AMEX[1];
for j=2:qa-4
    NMEX[j]=AMEX[j]-AMEX[j-1]
end
BMEX=parse.(Float64,Array(Bcsv[185,5:qa]))/PMEX;
CMEX=parse.(Float64,Array(Acsv[185,5:qa]));
RMEX=parse.(Float64,Array(Ccsv[170,5:qa]));
IMEX=CMEX-RMEX;
NDMEX=zeros(qa-439);
for j=1:qa-439
    NDMEX[j]=(BMEX[j+435]-BMEX[j+428])/7
end

# Nepal 192 177
PNPL=29.5;
ANPL=parse.(Float64,Array(Acsv[194,5:qa]))/PNPL;
NNPL=zeros(qa-4);
NNPL[1]=ANPL[1];
for j=2:qa-4
    NNPL[j]=ANPL[j]-ANPL[j-1]
end
BNPL=parse.(Float64,Array(Bcsv[194,5:qa]))/PNPL;
CNPL=parse.(Float64,Array(Acsv[194,5:qa]));
RNPL=parse.(Float64,Array(Ccsv[179,5:qa]));
INPL=CNPL-RNPL;
NDNPL=zeros(qa-439);
for j=1:qa-439
    NDNPL[j]=(BNPL[j+435]-BNPL[j+428])/7
end

# Netherland
PNLD=17.2;
ANLD=parse.(Float64,Array(Acsv[199,5:qa]))/PNLD;
NNLD=zeros(qa-4);
NNLD[1]=ANLD[1];
for j=2:qa-4
    NNLD[j]=ANLD[j]-ANLD[j-1]
end
BNLD=parse.(Float64,Array(Bcsv[199,5:qa]))/PNLD;
CNLD=parse.(Float64,Array(Acsv[199,5:qa]));
RNLD=parse.(Float64,Array(Ccsv[199,5:qa]));
INLD=CNLD-RNLD;
NDNLD=zeros(qa-439);
for j=1:qa-439
    NDNLD[j]=(BNLD[j+435]-BNLD[j+428])/7
end

# New Zealand
PNZL=4.9;
ANZL=parse.(Float64,Array(Acsv[201,5:qa]))/PNZL;
BNZL=parse.(Float64,Array(Bcsv[201,5:qa]))/PNZL;
CNZL=parse.(Float64,Array(Acsv[201,5:qa]));
RNZL=parse.(Float64,Array(Ccsv[186,5:qa]));
INZL=CNZL-RNZL;

# Pakistan 205 190
PPAK=221;
APAK=parse.(Float64,Array(Acsv[208,5:qa]))/PPAK;
NPAK=zeros(qa-4);
NPAK[1]=APAK[1];
for j=2:qa-4
    NPAK[j]=APAK[j]-APAK[j-1]
end
BPAK=parse.(Float64,Array(Bcsv[208,5:qa]))/PPAK;
CPAK=parse.(Float64,Array(Acsv[208,5:qa]));
RPAK=parse.(Float64,Array(Ccsv[193,5:qa]));
IPAK=CPAK-RPAK;
NDPAK=zeros(qa-439);
for j=1:qa-439
    NDPAK[j]=(BPAK[j+435]-BPAK[j+428])/7
end

# Philippines
PPHI=108;
APHI=parse.(Float64,Array(Acsv[214,5:qa]))/PPHI;
NPHI=zeros(qa-4);
NPHI[1]=APHI[1];
for j=2:qa-4
    NPHI[j]=APHI[j]-APHI[j-1]
end
BPHI=parse.(Float64,Array(Bcsv[214,5:qa]))/PPHI;
CPHI=parse.(Float64,Array(Acsv[214,5:qa]));
RPHI=parse.(Float64,Array(Ccsv[199,5:qa]));
IPHI=CPHI-RPHI;
NDPHI=zeros(qa-439);
for j=1:qa-439
    NDPHI[j]=(BPHI[j+435]-BPHI[j+428])/7
end

# Singapore
PSIN=5.7;
ASIN=parse.(Float64,Array(Acsv[232,5:qa]))/PSIN;
NSIN=zeros(qa-4);
NSIN[1]=ASIN[1];
for j=2:qa-4
    NSIN[j]=ASIN[j]-ASIN[j-1]
end
BSIN=parse.(Float64,Array(Bcsv[232,5:qa]))/PSIN;
CSIN=parse.(Float64,Array(Acsv[232,5:qa]));
RSIN=parse.(Float64,Array(Ccsv[217,5:qa]));
ISIN=CSIN-RSIN;

# South Africa 233 218
PZAF=58.8;
AZAF=parse.(Float64,Array(Acsv[237,5:qa]))/PZAF;
BZAF=parse.(Float64,Array(Bcsv[237,5:qa]))/PZAF;
CZAF=parse.(Float64,Array(Acsv[237,5:qa]));
RZAF=parse.(Float64,Array(Ccsv[222,5:qa]));
IZAF=CZAF-RZAF;

# Spain
PESP=46.8;
AESP=parse.(Float64,Array(Acsv[239,5:qa]))/PESP;
NESP=zeros(qa-4);
NESP[1]=AESP[1];
for j=2:qa-4
    NESP[j]=max(AESP[j]-AESP[j-1],0)
end
BESP=parse.(Float64,Array(Bcsv[239,5:qa]))/PESP;
CESP=parse.(Float64,Array(Acsv[239,5:qa]));
RESP=parse.(Float64,Array(Ccsv[224,5:qa]));
IESP=CESP-RESP;
NDESP=zeros(qa-439);
for j=1:qa-439
    NDESP[j]=(BESP[j+435]-BESP[j+428])/7
end

# Sri Lanka 
PLKA=21.5;
ALKA=parse.(Float64,Array(Acsv[240,5:qa]))/PLKA;
NLKA=zeros(qa-4);
NLKA[1]=ALKA[1];
for j=2:qa-4
    NLKA[j]=max(ALKA[j]-ALKA[j-1],0)
end
BLKA=parse.(Float64,Array(Bcsv[240,5:qa]))/PLKA;
CLKA=parse.(Float64,Array(Acsv[240,5:qa]));
RLKA=parse.(Float64,Array(Ccsv[225,5:qa]));
ILKA=CLKA-RLKA;
NDLKA=zeros(qa-439);
for j=1:qa-439
    NDLKA[j]=(BLKA[j+435]-BLKA[j+428])/7
end

# Thailand
PTHA=70.0;
ATHA=parse.(Float64,Array(Acsv[250,5:qa]))/PTHA;
NTHA=zeros(qa-4);
NTHA[1]=ATHA[1];
for j=2:qa-4
    NTHA[j]=max(ATHA[j]-ATHA[j-1],0)
end
BTHA=parse.(Float64,Array(Bcsv[250,5:qa]))/PTHA;
CTHA=parse.(Float64,Array(Acsv[250,5:qa]));
RTHA=parse.(Float64,Array(Ccsv[235,5:qa]));
ITHA=CTHA-RTHA;
NDTHA=zeros(qa-439);
for j=1:qa-439
    NDTHA[j]=(BTHA[j+435]-BTHA[j+428])/7
end

# United Staes 
PUSA=331;
AUSA=parse.(Float64,Array(Acsv[256,5:qa]))/PUSA;
NUSA=zeros(qa-4);
NUSA[1]=AUSA[1];
for j=2:qa-4
    NUSA[j]=AUSA[j]-AUSA[j-1]
end
BUSA=parse.(Float64,Array(Bcsv[256,5:qa]))/PUSA;
CUSA=parse.(Float64,Array(Acsv[256,5:qa]));
RUSA=parse.(Float64,Array(Ccsv[241,5:qa]));
IUSA=CUSA-RUSA;
NDUSA=zeros(qa-439);
for j=1:qa-439
    NDUSA[j]=(BUSA[j+435]-BUSA[j+428])/7
end

# United Kingdom 
PGBR=67.9;
AGBR=parse.(Float64,Array(Acsv[271,5:qa]))/PGBR;
NGBR=zeros(qa-4);
NGBR[1]=AGBR[1];
for j=2:qa-4
    NGBR[j]=max(AGBR[j]-AGBR[j-1],0)
end
BGBR=parse.(Float64,Array(Bcsv[271,5:qa]))/PGBR;
CGBR=parse.(Float64,Array(Acsv[271,5:qa]));
RGBR=parse.(Float64,Array(Ccsv[256,5:qa]));
IGBR=CGBR-RGBR;
NDGBR=zeros(qa-439);
for j=1:qa-439
    NDGBR[j]=(BGBR[j+435]-BGBR[j+428])/7
end

D=qa-4;
d0=Date(2020,1,22);
d1=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/4))));
l2=string(d0+Day(Int(floor((D-1)/2))));
l3=string(d0+Day(Int(floor(3*(D-1)/4))));
l4=string(d0+Day(D-1));
DD=qa-439;
dd0=Date(2021,4,1);
dd1=d0+Day(DD-1);
ll0=string(dd0);
ll1=string(dd0+Day(Int(floor((DD-1)/2))));
ll2=string(dd0+Day(DD-1));

p1=plot([AJPN APHI AMYS AIDN AIND ANPL APAK ABGD ALKA ATHA],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xlabel="date",
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
    palette = :seaborn_bright, 
    legend = :topleft)
size(600,900)

p2=plot([BJPN BPHI BMYS BIDN BIND BNPL BPAK BBGD BLKA BTHA], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
   palette = :seaborn_bright, 
     legend = :topleft)

p3=plot([NJPN NPHI NMYS NIDN NIND NNPL NPAK NBGD NLKA NTHA],  
    grid=false,
    linewidth=1, 
    title="COVID-19 in Asia: daily new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xlabel="date",
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
    palette = :seaborn_bright, 
    legend = :topleft)

p4=plot([NDJPN NDPHI NDMYS NDIDN NDIND NDNPL NDPAK NDBGD NDLKA NDTHA],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
   palette = :seaborn_bright, 
     legend = :topleft)

p5=plot([AARG ABRA ACOL AFRA AITA AMEX AESP AUSA AGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 15.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)

p6=plot([BARG BBRA BCOL BFRA BITA BMEX BESP BUSA BGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)

p7=plot([NARG NBRA NCOL NFRA NITA NMEX NESP NUSA NGBR],  
    grid=false,
    linewidth=1, 
    title="COVID-19 in the World: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)

p8=plot([NDARG NDBRA NDCOL NDFRA NDITA NDMEX NDESP NDUSA NDGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
   palette = :seaborn_bright, 
     legend = :topleft)

plot(p1, p2, p3, p4,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("jhu_asia.png") 

plot(p5, p6, p7, p8,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("jhu_world.png") 

plot(p5, p6, p7, p8,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("jhu_world.png") 

plot([AJPN APHI AMYS AIDN AIND ANPL APAK ABGD ALKA ATHA],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xlabel="date",
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_asia_cases.png") 

plot([NJPN NPHI NMYS NIDN NIND NNPL NPAK NBGD NLKA NTHA],  
    grid=false,
    linewidth=1, 
    title="COVID-19 in Asia: daily new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
   xlabel="date",
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_asia_new_cases.png") 

plot([BJPN BPHI BMYS BIDN BIND BNPL BPAK BBGD BLKA BTHA], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
   palette = :seaborn_bright, 
     legend = :topleft)
savefig("jhu_asia_deaths.png") 

plot([NDJPN NDPHI NDMYS NDIDN NDIND NDNPL NDPAK NDBGD NDLKA NDTHA],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka" "Thailand"],
   palette = :seaborn_bright, 
     legend = :topleft)
savefig("jhu_asia_new_deaths.png") 

plot([AARG ABRA ACOL AFRA AITA AMEX AESP AUSA AGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_world_cases.png") 

plot([NARG NBRA NCOL NFRA NITA NMEX NESP NUSA NGBR],  
    grid=false,
    linewidth=1, 
    title="COVID-19 in the World: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_world_new_cases.png") 

plot([NDARG NDBRA NDCOL NDFRA NDITA NDMEX NDESP NDUSA NDGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
   palette = :seaborn_bright, 
     legend = :topleft)
savefig("jhu_world_new_deaths.png") 

plot([BARG BBRA BCOL BFRA BITA BMEX BESP BUSA BGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_world_deaths.png") 

plot([CJPN IJPN RJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (125M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
   legend = :topleft)
savefig("jhu_japan.png") 

plot([CKOR IKOR RKOR], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in South Korea (51.3M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_south_korea.png")

plot([CPHI IPHI RPHI], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Philippines (108M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_philippines.png")

plot([CMYS IMYS RMYS], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_malaysia.png")

plot([CIDN IIDN RIDN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Indonesia (271M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_indonesia.png")

q1=plot([CMYS IMYS RMYS], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)

q2=plot([CIDN IIDN RIDN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Indonesia (271M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)

plot([CSIN ISIN RSIN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Singapore (5.7M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
savefig("jhu_singapore.png")

plot([CNZL INZL RNZL], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in New Zealand (4.9M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
savefig("jhu_new_zealand.png")

plot([CHubei IHubei RHubei], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Hubei Province (58.5M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
savefig("jhu_hubei.png")

plot([CVIC IVIC RVIC], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Victoria (AUS) (6.4M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_victoria.png")

plot([CIND IIND RIND], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in India (1380M) \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("jhu_india.png")

# Japan
A1T0=CJPN[qa-4];
A1R0=RJPN[qa-4];
A1T2=CJPN[qa-10];
A1R2=RJPN[qa-10];
A1N=PJPN;
# South Korea
A2T0=CKOR[qa-4];
A2R0=RKOR[qa-4];
A2T2=CKOR[qa-10];
A2R2=RKOR[qa-10];
A2N=PKOR;
# Philippines
A3T0=CPHI[qa-4];
A3R0=RPHI[qa-4];
A3T2=CPHI[qa-31];
A3R2=RPHI[qa-31];
A3N=PPHI;
# Malaysia
A4T0=CMYS[qa-4];
A4R0=RMYS[qa-4];
A4T2=CMYS[qa-10];
A4R2=RMYS[qa-10];
A4N=PMYS;
# Indonesia
A5T0=CIDN[qa-4];
A5R0=RIDN[qa-4];
A5T2=CIDN[qa-10];
A5R2=RIDN[qa-10];
A5N=PIDN;
# India
A6T0=CIND[qa-4];
A6R0=RIND[qa-4];
A6T2=CIND[qa-10];
A6R2=RIND[qa-10];
A6N=PIND;
# Nepal
A7T0=CNPL[qa-4];
A7R0=RNPL[qa-4];
A7T2=CNPL[qa-10];
A7R2=RNPL[qa-10];
A7N=PNPL;
# Pakistan
A8T0=CPAK[qa-4];
A8R0=RPAK[qa-4];
A8T2=CPAK[qa-10];
A8R2=RPAK[qa-10];
A8N=PPAK;
# Bangladesh
A9T0=CBGD[qa-4];
A9R0=RBGD[qa-4];
A9T2=CBGD[qa-10];
A9R2=RBGD[qa-10];
A9N=PBGD;
# Sri Lanka
A10T0=CLKA[qa-4];
A10R0=RLKA[qa-4];
A10T2=CLKA[qa-10];
A10R2=RLKA[qa-10];
A10N=PLKA;
# Brazil
A11T0=CBRA[qa-4];
A11R0=RBRA[qa-4];
A11T2=CBRA[qa-10];
A11R2=RBRA[qa-10];
A11N=PBRA;
# South Africa
A12T0=CZAF[qa-4];
A12R0=RZAF[qa-4];
A12T2=CZAF[qa-10];
A12R2=RZAF[qa-10];
A12N=PZAF;

# interval 
W=Float64(4*7)
w0=string(d1);
w1=string(d1+Day(2*7));
w2=string(d1+Day(4*7));
        
# Japan
T0=A1T0;
R0=A1R0;
T2=A1T2;
R2=A1R2;
N=A1N*1000000;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19 in Japan (126M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("jhu_zsir_japan.png")

# Philippines
T0=A3T0;
R0=A3R0;
T2=A3T2;
R2=A3R2;
N=A3N*1000000;
T1=(T0-T2)/Float64(28);
R1=(R0-R2)/Float64(28);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19 in Philippines (108M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("jhu_zsir_philippines.png")

# Malaysia
T0=A4T0;
R0=A4R0;
T2=A4T2;
R2=A4R2;
N=A4N*1000000;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("jhu_zsir_malaysia.png")

q3=plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    xticks = ([1 2*7 4*7;], [w0, w1, w2]),
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)

# Indonesia
T0=A5T0;
R0=A5R0;
T2=A5T2;
R2=A5R2;
N=A5N*1000000;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19 in Indonesia (271M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("jhu_zsir_indonesia.png")

q4=plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19 in Indonesia (271M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    xticks = ([1 2*7 4*7;], [w0, w1, w2]), 
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)

# India
# T0=A6T0;
# R0=A6R0;
# T2=A6T2;
# R2=A6R2;
# N=A6N
# T1=(T0-T2)/Float64(7);
# R1=(R0-R2)/Float64(7);
# beta=T1/(T0-R0)/(N-T0);
# gamma=R1/(T0-R0);
# tspan=(0,W);
# f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
# u0=[T0;T0-R0;R0];
# prob = ODEProblem(f,u0,tspan);
# sol = solve(prob, maxiters=Int(1e6));
# plotting
# plot(sol, 
#     grid=false,
#     linewidth=3, 
#     title="SIR model for COVID-19 in India (1380M) \n data sourced by JHU Coronavirus Resource Center", 
#     xlabel="date",
#     yaxis="cases",
#     legendfont=font(10), 
#     label=["total cases" "active cases" "discharged"], 
#     palette = :seaborn_bright, 
#     legend = :right)
# plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
# savefig("jhu_zsir_india.png")

# ##Nepal
# T0=A7T0;
# R0=A7R0;
# T2=A7T2;
# R2=A7R2;
# N=A7N
# T1=(T0-T2)/Float64(7);
# R1=(R0-R2)/Float64(7);
# beta=T1/(T0-R0)/(N-T0);
# gamma=R1/(T0-R0);
# tspan=(0,W);
# f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
# u0=[T0;T0-R0;R0];
# prob = ODEProblem(f,u0,tspan);
# sol = solve(prob, maxiters=Int(1e6));
# ##plotting
# plot(sol, 
#     grid=false,
#     linewidth=3, 
#     title="SIR model for COVID-19 in Nepal (29.5M) \n data sourced by JHU Coronavirus Resource Center", 
#     xlabel="date",
#     yaxis="cases",
#     legendfont=font(10), 
#     label=["total cases" "active cases" "discharged"], 
#     palette = :seaborn_bright, 
#     legend = :right)
# plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
# savefig("jhu_zsir_nepal.png")

# Pakistan
# T0=A8T0;
# R0=A8R0;
# T2=A8T2;
# R2=A8R2;
# N=A8N
# T1=(T0-T2)/Float64(7);
# R1=(R0-R2)/Float64(7);
# beta=T1/(T0-R0)/(N-T0);
# gamma=R1/(T0-R0);
# tspan=(0,W);
# f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
# u0=[T0;T0-R0;R0];
# prob = ODEProblem(f,u0,tspan);
# sol = solve(prob, maxiters=Int(1e6));
# plotting
# plot(sol, 
#     grid=false,
#     linewidth=3, 
#     title="SIR model for COVID-19 in Pakistan (221M) \n data sourced by JHU Coronavirus Resource Center", 
#     xlabel="date",
#     yaxis="cases",
#     legendfont=font(10), 
#     label=["total cases" "active cases" "discharged"], 
#     palette = :seaborn_bright, 
#     legend = :right)
# plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
# savefig("jhu_zsir_pakistan.png")

# Bangladesh
# T0=A9T0;
# R0=A9R0;
# T2=A9T2;
# R2=A9R2;
# N=A9N
# T1=(T0-T2)/Float64(7);
# R1=(R0-R2)/Float64(7);
# beta=T1/(T0-R0)/(N-T0);
# gamma=R1/(T0-R0);
# tspan=(0,W);
# f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
# u0=[T0;T0-R0;R0];
# prob = ODEProblem(f,u0,tspan);
# sol = solve(prob, maxiters=Int(1e6));
# plotting
# plot(sol, 
#     grid=false,
#     linewidth=3, 
#     title="SIR model for COVID-19 in Bangladesh (165M) \n data sourced by JHU Coronavirus Resource Center", 
#     xlabel="date",
#     yaxis="cases",
#     legendfont=font(10), 
#     label=["total cases" "active cases" "discharged"], 
#     palette = :seaborn_bright, 
#     legend = :right)
# plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
# savefig("jhu_zsir_bangladesh.png")

# ##Sri Lanka
# T0=A10T0;
# R0=A10R0;
# T2=A10T2;
# R2=A10R2;
# N=A10N
# T1=(T0-T2)/Float64(7);
# R1=(R0-R2)/Float64(7);
# beta=T1/(T0-R0)/(N-T0);
# gamma=R1/(T0-R0);
# tspan=(0,W);
# f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
# u0=[T0;T0-R0;R0];
# prob = ODEProblem(f,u0,tspan);
# sol = solve(prob, maxiters=Int(1e6));
##plotting
# plot(sol, 
#     grid=false,
#     linewidth=3, 
#     title="SIR model for COVID-19 in Sri Lanka (21.5M) \n data sourced by JHU Coronavirus Resource Center", 
#     xlabel="date",
#     yaxis="cases",
#     legendfont=font(10), 
#     label=["total cases" "active cases" "discharged"], 
#     palette = :seaborn_bright, 
#     legend = :right)
# plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
# savefig("jhu_zsir_sri_lanka.png")

# ##Brazil
# T0=A11T0;
# R0=A11R0;
# T2=A11T2;
# R2=A11R2;
# N=A11N
# T1=(T0-T2)/Float64(7);
# R1=(R0-R2)/Float64(7);
# beta=T1/(T0-R0)/(N-T0);
# gamma=R1/(T0-R0);
# tspan=(0,W);
# f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
# u0=[T0;T0-R0;R0];
# prob = ODEProblem(f,u0,tspan);
# sol = solve(prob, maxiters=Int(1e6));
# ##plotting
# plot(sol, 
#     grid=false,
#     linewidth=3, 
#     title="SIR model for COVID-19 in Brazil (213M) \n data sourced by JHU Coronavirus Resource Center", 
#     xlabel="date",
#     yaxis="cases",
#     legendfont=font(10), 
#     label=["total cases" "active cases" "discharged"], 
#     palette = :seaborn_bright, 
#     legend = :right)
# plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
# savefig("jhu_zsir_brazil.png")

plot(q1, q2, q3, q4,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("jhu_asia_crisis.png") 

# Malaysia SIR-SD 1
T0=A4T0;
R0=A4R0;
T2=A4T2;
R2=A4R2;
N=A4N*1000000;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
omega=0.5;
kappa=1/2;
Csd=1;
C1=50;
f(u,p,t) = [beta*(N-u[1]-u[4])*u[2]; beta*(N-u[1]-u[4])*u[2]-gamma*u[2]; gamma*u[2]; omega*(1-u[4]/(N-u[1]))*u[4]*tanh(kappa*(-Csd+C1*(1-exp(-beta*u[2]))))];
# Set the initial data
SD0=0.05*(N-T0);
u0=[T0;T0-R0;R0;SD0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));

plot(sol, 
     grid=false,
     linewidth=3, 
     right_margin=Plots.Measures.Length(:mm, 10.0),
     left_margin=Plots.Measures.Length(:mm, 5.0),
     title="SIR-SD model for COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
     xlabel="date (omega=0.5, kappa=1, Csd=1, C1=50, E0=0.05)",
     yaxis="cases",
     legendfont=font(10), 
     label=["total cases" "active cases" "discharged" "SD"], 
     palette = :seaborn_bright, 
     legend = :topleft)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("jhu_zsir-sd_1_malaysia.png")

q5=plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR-SD model for COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date (omega=0.5, kappa=1, Csd=1, C1=50, E0=0.05)",
    xticks = ([1 2*7 4*7;], [w0, w1, w2]),
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged" "SD"], 
    palette = :seaborn_bright, 
    legend = :topleft)

# Malaysia SIR-SD 2
T0=A4T0;
R0=A4R0;
T2=A4T2;
R2=A4R2;
N=A4N*1000000;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
omega=1;
kappa=1/2;
Csd=1;
C1=500;
f(u,p,t) = [beta*(N-u[1]-u[4])*u[2]; beta*(N-u[1]-u[4])*u[2]-gamma*u[2]; gamma*u[2]; omega*(1-u[4]/(N-u[1]))*u[4]*tanh(kappa*(-Csd+C1*(1-exp(-beta*u[2]))))];
# Set the initial data
SD0=0.05*(N-T0);
u0=[T0;T0-R0;R0;SD0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));

plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR-SD model for COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date (omega=1, kappa=1, Csd=1, C1=500, E0=0.05)",
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged" "SD"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("jhu_zsir-sd_2_malaysia.png")

q6=plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR-SD model for COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date (omega=1, kappa=1, Csd=1, C1=500, E0=0.05)",
    xticks = ([1 2*7 4*7;], [w0, w1, w2]),
    yaxis="cases",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged" "SD"], 
    palette = :seaborn_bright, 
    legend = :topleft)

plot(q1, q3, q5, q6, 
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("jhu_malaysia_crisis.png") 