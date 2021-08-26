# jhu.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","./csv/jhu_cases.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv","./csv/jhu_deaths.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv","./csv/jhu_recovered.csv");

Acsv=DataFrame(CSV.File("./csv/jhu_cases.csv", header=false, delim=','));
Bcsv=DataFrame(CSV.File("./csv/jhu_deaths.csv", header=false, delim=','));
Ccsv=DataFrame(CSV.File("./csv/jhu_recovered.csv", header=false, delim=','));
(pa,qa)=size(Acsv);

D=Int64(qa-4);
d0=Date(2020,1,22);
d1=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/4))));
l2=string(d0+Day(Int(floor((D-1)/2))));
l3=string(d0+Day(Int(floor(3*(D-1)/4))));
l4=string(d0+Day(D-1));
DD=Int64(D-526);
dd0=Date(2021,7,1);
dd1=d0+Day(DD-1);
ll0=string(dd0);
ll1=string(dd0+Day(Int(floor((DD-1)/2))));
ll2=string(dd0+Day(DD-1));


# Argentina
PARG=45.670451;
AARG=parse.(Float64,Array(Acsv[8,5:qa]))/PARG;
NARG=zeros(D);
NARG[1]=AARG[1];
for j=2:D
    NARG[j]=AARG[j]-AARG[j-1]
end
BARG=parse.(Float64,Array(Bcsv[8,5:qa]))/PARG;
NDARG=zeros(DD);
for j=1:DD
    NDARG[j]=(BARG[j+526]-BARG[j+519])/7
end

# Bangladesh
PBGD=166.567052;
ABGD=parse.(Float64,Array(Acsv[22,5:qa]))/PBGD;
NBGD=zeros(D);
NBGD[1]=ABGD[1];
for j=2:D
    NBGD[j]=ABGD[j]-ABGD[j-1]
end
BBGD=parse.(Float64,Array(Bcsv[22,5:qa]))/PBGD;
NDBGD=zeros(DD);
for j=1:DD
    NDBGD[j]=(BBGD[j+526]-BBGD[j+519])/7
end

# Brazil 32 32
PBRA=214.289417;
ABRA=parse.(Float64,Array(Acsv[32,5:qa]))/PBRA;
NBRA=zeros(D);
NBRA[1]=ABRA[1];
for j=2:D
    NBRA[j]=max(ABRA[j]-ABRA[j-1],0)
end
BBRA=parse.(Float64,Array(Bcsv[32,5:qa]))/PBRA;
NDBRA=zeros(DD);
for j=1:DD
    NDBRA[j]=(BBRA[j+526]-BBRA[j+519])/7
end

# Colombia 
PCOL=51.503463;
ACOL=parse.(Float64,Array(Acsv[94,5:qa]))/PCOL;
NCOL=zeros(D);
NCOL[1]=ACOL[1];
for j=2:D
    NCOL[j]=ACOL[j]-ACOL[j-1]
end
BCOL=parse.(Float64,Array(Bcsv[94,5:qa]))/PCOL;
NDCOL=zeros(DD);
for j=1:DD
    NDCOL[j]=(BCOL[j+526]-BCOL[j+519])/7
end

# France Italy Spain 
PFRA=65.439014;
PITA=60.359899;
PESP=46.775535;
PFIE=PFRA+PITA+PESP;
CFRA=parse.(Float64,Array(Acsv[132,5:qa]));
CITA=parse.(Float64,Array(Acsv[155,5:qa]));
CESP=parse.(Float64,Array(Acsv[239,5:qa]));
AFIE=(CFRA+CITA+CESP)/PFIE;
NFIE=zeros(D);
NFIE[1]=AFIE[1];
for j=2:D
    NFIE[j]=max(AFIE[j]-AFIE[j-1],0);
end
DFRA=parse.(Float64,Array(Bcsv[132,5:qa]))
DITA=parse.(Float64,Array(Bcsv[155,5:qa]));
DESP=parse.(Float64,Array(Bcsv[239,5:qa]));
BFIE=(DFRA+DITA+DESP)/PFIE;
NDFIE=zeros(DD);
for j=1:DD
    NDFIE[j]=(BFIE[j+526]-BFIE[j+519])/7
end

# India 
PIND=1395.531433;
AIND=parse.(Float64,Array(Acsv[149,5:qa]))/PIND;
NIND=zeros(D);
NIND[1]=AIND[1];
for j=2:D
    NIND[j]=AIND[j]-AIND[j-1]
end
BIND=parse.(Float64,Array(Bcsv[149,5:qa]))/PIND;
NDIND=zeros(DD);
for j=1:DD
    NDIND[j]=(BIND[j+526]-BIND[j+519])/7
end

# Indonesia
PIDN=276.833206;
AIDN=parse.(Float64,Array(Acsv[150,5:qa]))/PIDN;
NIDN=zeros(D);
NIDN[1]=AIDN[1];
for j=2:D
    NIDN[j]=AIDN[j]-AIDN[j-1]
end
BIDN=parse.(Float64,Array(Bcsv[150,5:qa]))/PIDN;
NDIDN=zeros(DD);
for j=1:DD
    NDIDN[j]=(BIDN[j+526]-BIDN[j+519])/7
end

# Japan
PJPN=126.032481;
AJPN=parse.(Float64,Array(Acsv[157,5:qa]))/PJPN;
NJPN=zeros(D);
NJPN[1]=AJPN[1];
for j=2:D
    NJPN[j]=AJPN[j]-AJPN[j-1]
end
BJPN=parse.(Float64,Array(Bcsv[157,5:qa]))/PJPN;
NDJPN=zeros(DD);
for j=1:DD
    NDJPN[j]=(BJPN[j+526]-BJPN[j+519])/7
end

# South Korea
PKOR=51.319753;
AKOR=parse.(Float64,Array(Acsv[162,5:qa]))/PKOR;
NKOR=zeros(D);
NKOR[1]=AKOR[1];
for j=2:D
    NKOR[j]=AKOR[j]-AKOR[j-1]
end
BKOR=parse.(Float64,Array(Bcsv[162,5:qa]))/PKOR;
NDKOR=zeros(DD);
for j=1:DD
    NDKOR[j]=(BKOR[j+526]-BKOR[j+519])/7
end

# Malaysia
PMYS=32.7;
AMYS=parse.(Float64,Array(Acsv[178,5:qa]))/PMYS;
NMYS=zeros(D);
NMYS[1]=AMYS[1];
for j=2:D
    NMYS[j]=AMYS[j]-AMYS[j-1]
end
BMYS=parse.(Float64,Array(Bcsv[178,5:qa]))/PMYS;
NDMYS=zeros(DD);
for j=1:DD
    NDMYS[j]=(BMYS[j+526]-BMYS[j+519])/7
end

# Mexico 
PMEX=130.482814;
AMEX=parse.(Float64,Array(Acsv[185,5:qa]))/PMEX;
NMEX=zeros(D);
NMEX[1]=AMEX[1];
for j=2:D
    NMEX[j]=AMEX[j]-AMEX[j-1]
end
BMEX=parse.(Float64,Array(Bcsv[185,5:qa]))/PMEX;
NDMEX=zeros(DD);
for j=1:DD
    NDMEX[j]=(BMEX[j+526]-BMEX[j+519])/7
end

# Nepal
PNPL=29.735589;
ANPL=parse.(Float64,Array(Acsv[194,5:qa]))/PNPL;
NNPL=zeros(D);
NNPL[1]=ANPL[1];
for j=2:D
    NNPL[j]=ANPL[j]-ANPL[j-1]
end
BNPL=parse.(Float64,Array(Bcsv[194,5:qa]))/PNPL;
NDNPL=zeros(DD);
for j=1:DD
    NDNPL[j]=(BNPL[j+526]-BNPL[j+519])/7
end

# Pakistan 205 190
PPAK=225.791619;
APAK=parse.(Float64,Array(Acsv[208,5:qa]))/PPAK;
NPAK=zeros(D);
NPAK[1]=APAK[1];
for j=2:D
    NPAK[j]=APAK[j]-APAK[j-1]
end
BPAK=parse.(Float64,Array(Bcsv[208,5:qa]))/PPAK;
NDPAK=zeros(DD);
for j=1:DD
    NDPAK[j]=(BPAK[j+526]-BPAK[j+519])/7
end

# Philippines
PPHI=111.249116;
APHI=parse.(Float64,Array(Acsv[214,5:qa]))/PPHI;
NPHI=zeros(D);
NPHI[1]=APHI[1];
for j=2:D
    NPHI[j]=APHI[j]-APHI[j-1]
end
BPHI=parse.(Float64,Array(Bcsv[214,5:qa]))/PPHI;
NDPHI=zeros(DD);
for j=1:DD
    NDPHI[j]=(BPHI[j+526]-BPHI[j+519])/7
end

# Sri Lanka 
PLKA=21.516097;
ALKA=parse.(Float64,Array(Acsv[240,5:qa]))/PLKA;
NLKA=zeros(D);
NLKA[1]=ALKA[1];
for j=2:D
    NLKA[j]=max(ALKA[j]-ALKA[j-1],0)
end
BLKA=parse.(Float64,Array(Bcsv[240,5:qa]))/PLKA;
NDLKA=zeros(DD);
for j=1:DD
    NDLKA[j]=(BLKA[j+526]-BLKA[j+519])/7
end

# Thailand
PTHA=70.000662;
ATHA=parse.(Float64,Array(Acsv[250,5:qa]))/PTHA;
NTHA=zeros(D);
NTHA[1]=ATHA[1];
for j=2:D
    NTHA[j]=max(ATHA[j]-ATHA[j-1],0)
end
BTHA=parse.(Float64,Array(Bcsv[250,5:qa]))/PTHA;
NDTHA=zeros(DD);
for j=1:DD
    NDTHA[j]=(BTHA[j+526]-BTHA[j+519])/7
end

# United Staes 
PUSA=333.225477;
AUSA=parse.(Float64,Array(Acsv[256,5:qa]))/PUSA;
NUSA=zeros(D);
NUSA[1]=AUSA[1];
for j=2:D
    NUSA[j]=AUSA[j]-AUSA[j-1]
end
BUSA=parse.(Float64,Array(Bcsv[256,5:qa]))/PUSA;
NDUSA=zeros(DD);
for j=1:DD
    NDUSA[j]=(BUSA[j+526]-BUSA[j+519])/7
end

# United Kingdom 
PGBR=68.294438;
AGBR=parse.(Float64,Array(Acsv[271,5:qa]))/PGBR;
NGBR=zeros(D);
NGBR[1]=AGBR[1];
for j=2:D
    NGBR[j]=max(AGBR[j]-AGBR[j-1],0)
end
BGBR=parse.(Float64,Array(Bcsv[271,5:qa]))/PGBR;
NDGBR=zeros(DD);
for j=1:DD
    NDGBR[j]=(BGBR[j+526]-BGBR[j+519])/7
end

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

p5=plot([AUSA AGBR AARG ABRA ACOL AMEX AFIE],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 15.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FRA+ITA+ESP"],
    palette = :seaborn_bright, 
    legend = :topleft)

p6=plot([BUSA BGBR BARG BBRA BCOL BMEX BFIE],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FR+IT+ES"],
    palette = :seaborn_bright, 
    legend = :topleft)

p7=plot([NUSA NGBR NARG NBRA NCOL NMEX NFIE],  
    grid=false,
    linewidth=1, 
    title="COVID-19 in the World: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FR+IT+ES"],
    palette = :seaborn_bright, 
    legend = :topleft)

p8=plot([NDUSA NDGBR NDARG NDBRA NDCOL NDMEX NDFIE],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FR+IT+ES"],
   palette = :seaborn_bright, 
     legend = :topleft)

plot(p1, p2, p3, p4,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./jhu/jhu_asia.png") 

plot(p5, p6, p7, p8,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./jhu/jhu_world.png") 

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
savefig("./jhu/jhu_asia_cases.png") 

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
savefig("./jhu/jhu_asia_new_cases.png") 

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
savefig("./jhu/jhu_asia_deaths.png") 

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
savefig("./jhu/jhu_asia_new_deaths.png") 
