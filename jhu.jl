# jhu.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","./csv/jhu_cases.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv","./csv/jhu_deaths.csv");
#download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv","./csv/jhu_recovered.csv");

Acsv=DataFrame(CSV.File("./csv/jhu_cases.csv", header=false, delim=','));
Bcsv=DataFrame(CSV.File("./csv/jhu_deaths.csv", header=false, delim=','));
#Ccsv=DataFrame(CSV.File("./csv/jhu_recovered.csv", header=false, delim=','));
(pw,qw)=size(Acsv);

D=Int64(qw-4);
d0=Date(2020,1,22);
d1=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/4))));
l2=string(d0+Day(Int(floor((D-1)/2))));
l3=string(d0+Day(Int(floor(3*(D-1)/4))));
l4=string(d0+Day(D-1));

# Argentina
PARG=45.870820;
AARG=parse.(Float64,Array(Acsv[9,5:qw]))/PARG;
NARG=zeros(D);
for j=1:7
    NARG[j]=AARG[j]/7
end
for j=8:D
    NARG[j]=(AARG[j]-AARG[j-7])/7
end
BARG=parse.(Float64,Array(Bcsv[9,5:qw]))/PARG;
NDARG=zeros(D);
for j=1:7
    NDARG[j]=BARG[j]/7
end
for j=8:D
    NDARG[j]=(BARG[j]-BARG[j-7])/7
end

# Australia
PAUS=25.981402;
AACT=parse.(Float64,Array(Acsv[11,5:qw]));
ANSW=parse.(Float64,Array(Acsv[12,5:qw]));
ANT=parse.(Float64,Array(Acsv[13,5:qw]));
AQLD=parse.(Float64,Array(Acsv[14,5:qw]));
ASA=parse.(Float64,Array(Acsv[15,5:qw]));
ATAS=parse.(Float64,Array(Acsv[16,5:qw]));
AVIC=parse.(Float64,Array(Acsv[17,5:qw]));
AWA=parse.(Float64,Array(Acsv[18,5:qw]));
AAUS=(AACT+ANSW+ANT+AQLD+ASA+ATAS+AVIC+AWA)/PAUS;
NAUS=zeros(D);
for j=1:7
    NAUS[j]=AAUS[j]/7
end
for j=8:D
    NAUS[j]=(AAUS[j]-AAUS[j-7])/7
end
BACT=parse.(Float64,Array(Bcsv[11,5:qw]));
BNSW=parse.(Float64,Array(Bcsv[12,5:qw]));
BNT=parse.(Float64,Array(Bcsv[13,5:qw]));
BQLD=parse.(Float64,Array(Bcsv[14,5:qw]));
BSA=parse.(Float64,Array(Bcsv[15,5:qw]));
BTAS=parse.(Float64,Array(Bcsv[16,5:qw]));
BVIC=parse.(Float64,Array(Bcsv[17,5:qw]));
BWA=parse.(Float64,Array(Bcsv[18,5:qw]));
BAUS=(BACT+BNSW+BNT+BQLD+BSA+BTAS+BVIC+BWA)/PAUS;
NDAUS=zeros(D);
for j=1:7
    NDAUS[j]=BAUS[j]/7
end
for j=8:D
    NDAUS[j]=(BAUS[j]-BAUS[j-7])/7
end

# Brazil 
PBRA=215.019011;
ABRA=parse.(Float64,Array(Acsv[33,5:qw]))/PBRA;
NBRA=zeros(D);
for j=1:7
    NBRA[j]=ABRA[j]/7
end
for j=8:D
    NBRA[j]=(ABRA[j]-ABRA[j-7])/7
end
BBRA=parse.(Float64,Array(Bcsv[33,5:qw]))/PBRA;
NDBRA=zeros(D);
for j=1:7
    NDBRA[j]=BBRA[j]/7
end
for j=8:D
    NDBRA[j]=(BBRA[j]-BBRA[j-7])/7
end

# Brunei Darussalam
PBWN=0.4435;
ABWN=parse.(Float64,Array(Acsv[34,5:qw]))/PBWN;
NBWN=zeros(D);
for j=1:7
    NBWN[j]=ABWN[j]/7
end
for j=8:D
    NBWN[j]=(ABWN[j]-ABWN[j-7])/7
end
BBWN=parse.(Float64,Array(Bcsv[34,5:qw]))/PBWN;
NDBWN=zeros(D);
for j=1:7
    NDBWN[j]=BBWN[j]/7
end
for j=8:D
    NDBWN[j]=(BBWN[j]-BBWN[j-7])/7
end

# Hong Kong
PHKG=7.600852;
AHKG=parse.(Float64,Array(Acsv[73,5:qw]))/PHKG;
NHKG=zeros(D);
for j=1:7
    NHKG[j]=AHKG[j]/7
end
for j=8:D
    NHKG[j]=(AHKG[j]-AHKG[j-7])/7
end
BHKG=parse.(Float64,Array(Bcsv[73,5:qw]))/PHKG;
NDHKG=zeros(D);
for j=1:7
    NDHKG[j]=BHKG[j]/7
end
for j=8:D
    NDHKG[j]=(BHKG[j]-BHKG[j-7])/7
end

# Colombia 
PCOL=51.765589;
ACOL=parse.(Float64,Array(Acsv[95,5:qw]))/PCOL;
NCOL=zeros(D);
for j=1:7
    NCOL[j]=ACOL[j]/7
end
for j=8:D
    NCOL[j]=(ACOL[j]-ACOL[j-7])/7
end
BCOL=parse.(Float64,Array(Bcsv[95,5:qw]))/PCOL;
NDCOL=zeros(D);
for j=1:7
    NDCOL[j]=BCOL[j]/7
end
for j=8:D
    NDCOL[j]=(BCOL[j]-BCOL[j-7])/7
end

# France Italy Spain 
PFRA=65.508662;
PITA=60.317073;
PESP=46.784213;
PFIE=PFRA+PITA+PESP;
CFRA=parse.(Float64,Array(Acsv[133,5:qw]));
CITA=parse.(Float64,Array(Acsv[156,5:qw]));
CESP=parse.(Float64,Array(Acsv[240,5:qw]));
AFIE=(CFRA+CITA+CESP)/PFIE;
NFIE=zeros(D);
for j=1:7
    NFIE[j]=AFIE[j]/7
end
for j=8:D
    NFIE[j]=max(0,(AFIE[j]-AFIE[j-7])/7)
end
DFRA=parse.(Float64,Array(Bcsv[133,5:qw]))
DITA=parse.(Float64,Array(Bcsv[156,5:qw]));
DESP=parse.(Float64,Array(Bcsv[240,5:qw]));
BFIE=(DFRA+DITA+DESP)/PFIE;
NDFIE=zeros(D);
for j=1:7
    NDFIE[j]=BFIE[j]/7
end
for j=8:D
    NDFIE[j]=(BFIE[j]-BFIE[j-7])/7
end

# India 
PIND=1402.124607;
AIND=parse.(Float64,Array(Acsv[150,5:qw]))/PIND;
NIND=zeros(D);
for j=1:7
    NIND[j]=AIND[j]/7
end
for j=8:D
    NIND[j]=(AIND[j]-AIND[j-7])/7
end
BIND=parse.(Float64,Array(Bcsv[150,5:qw]))/PIND;
NDIND=zeros(D);
for j=1:7
    NDIND[j]=BIND[j]/7
end
for j=8:D
    NDIND[j]=(BIND[j]-BIND[j-7])/7
end

# Indonesia
PIDN=278.239007;
AIDN=parse.(Float64,Array(Acsv[151,5:qw]))/PIDN;
NIDN=zeros(D);
for j=1:7
    NIDN[j]=AIDN[j]/7
end
for j=8:D
    NIDN[j]=(AIDN[j]-AIDN[j-7])/7
end
BIDN=parse.(Float64,Array(Bcsv[151,5:qw]))/PIDN;
NDIDN=zeros(D);
for j=1:7
    NDIDN[j]=BIDN[j]/7
end
for j=8:D
    NDIDN[j]=(BIDN[j]-BIDN[j-7])/7
end

# Japan
PJPN=125.845010;
AJPN=parse.(Float64,Array(Acsv[158,5:qw]))/PJPN;
NJPN=zeros(D);
for j=1:7
    NJPN[j]=AJPN[j]/7
end
for j=8:D
    NJPN[j]=(AJPN[j]-AJPN[j-7])/7
end
BJPN=parse.(Float64,Array(Bcsv[158,5:qw]))/PJPN;
NDJPN=zeros(D);
for j=1:7
    NDJPN[j]=BJPN[j]/7
end
for j=8:D
    NDJPN[j]=(BJPN[j]-BJPN[j-7])/7
end

# South Korea
PKOR=51.341022;
AKOR=parse.(Float64,Array(Acsv[164,5:qw]))/PKOR;
NKOR=zeros(D);
for j=1:7
    NKOR[j]=AKOR[j]/7
end
for j=8:D
    NKOR[j]=(AKOR[j]-AKOR[j-7])/7
end
BKOR=parse.(Float64,Array(Bcsv[164,5:qw]))/PKOR;
NDKOR=zeros(D);
for j=1:7
    NDKOR[j]=BKOR[j]/7
end
for j=8:D
    NDKOR[j]=(BKOR[j]-BKOR[j-7])/7
end

# Malaysia
PMYS=33.060794;
AMYS=parse.(Float64,Array(Acsv[180,5:qw]))/PMYS;
NMYS=zeros(D);
for j=1:7
    NMYS[j]=AMYS[j]/7
end
for j=8:D
    NMYS[j]=(AMYS[j]-AMYS[j-7])/7
end
BMYS=parse.(Float64,Array(Bcsv[180,5:qw]))/PMYS;
NDMYS=zeros(D);
for j=1:7
    NDMYS[j]=BMYS[j]/7
end
for j=8:D
    NDMYS[j]=(BMYS[j]-BMYS[j-7])/7
end

# Mexico 
PMEX=131.137507;
AMEX=parse.(Float64,Array(Acsv[187,5:qw]))/PMEX;
NMEX=zeros(D);
for j=1:7
    NMEX[j]=AMEX[j]/7
end
for j=8:D
    NMEX[j]=(AMEX[j]-AMEX[j-7])/7
end
BMEX=parse.(Float64,Array(Bcsv[187,5:qw]))/PMEX;
NDMEX=zeros(D);
for j=1:7
    NDMEX[j]=BMEX[j]/7
end
for j=8:D
    NDMEX[j]=(BMEX[j]-BMEX[j-7])/7
end

# Philippines
PPHI=112.027348;
APHI=parse.(Float64,Array(Acsv[218,5:qw]))/PPHI;
NPHI=zeros(D);
for j=1:7
    NPHI[j]=APHI[j]/7
end
for j=8:D
    NPHI[j]=(APHI[j]-APHI[j-7])/7
end
BPHI=parse.(Float64,Array(Bcsv[218,5:qw]))/PPHI;
NDPHI=zeros(D);
for j=1:7
    NDPHI[j]=BPHI[j]/7
end
for j=8:D
    NDPHI[j]=(BPHI[j]-BPHI[j-7])/7
end

# Singapore 
PSIN=5.925237;
ASIN=parse.(Float64,Array(Acsv[236,5:qw]))/PSIN;
NSIN=zeros(D);
for j=1:7
    NSIN[j]=ASIN[j]/7
end
for j=8:D
    NSIN[j]=(ASIN[j]-ASIN[j-7])/7
end
BSIN=parse.(Float64,Array(Bcsv[236,5:qw]))/PSIN;
NDSIN=zeros(D);
for j=1:7
    NDSIN[j]=BSIN[j]/7
end
for j=8:D
    NDSIN[j]=(BSIN[j]-BSIN[j-7])/7
end

# Sri Lanka 
PLKA=21.559415;
ALKA=parse.(Float64,Array(Acsv[244,5:qw]))/PLKA;
NLKA=zeros(D);
for j=1:7
    NLKA[j]=ALKA[j]/7
end
for j=8:D
    NLKA[j]=(ALKA[j]-ALKA[j-7])/7
end
BLKA=parse.(Float64,Array(Bcsv[244,5:qw]))/PLKA;
NDLKA=zeros(D);
for j=1:7
    NDLKA[j]=BLKA[j]/7
end
for j=8:D
    NDLKA[j]=(BLKA[j]-BLKA[j-7])/7
end

# Taiwan
PTWN=23.61;
ATWN=parse.(Float64,Array(Acsv[251,5:qw]))/PTWN;
NTWN=zeros(D);
for j=1:7
    NTWN[j]=ATWN[j]/7
end
for j=8:D
    NTWN[j]=(ATWN[j]-ATWN[j-7])/7
end
BTWN=parse.(Float64,Array(Bcsv[251,5:qw]))/PTWN;
NDTWN=zeros(D);
for j=1:7
    NDTWN[j]=BTWN[j]/7
end
for j=8:D
    NDTWN[j]=(BTWN[j]-BTWN[j-7])/7
end


# Thailand
PTHA=70.085127;
ATHA=parse.(Float64,Array(Acsv[254,5:qw]))/PTHA;
NTHA=zeros(D);
for j=1:7
    NTHA[j]=ATHA[j]/7
end
for j=8:D
    NTHA[j]=(ATHA[j]-ATHA[j-7])/7
end
BTHA=parse.(Float64,Array(Bcsv[254,5:qw]))/PTHA;
NDTHA=zeros(D);
for j=1:7
    NDTHA[j]=BTHA[j]/7
end
for j=8:D
    NDTHA[j]=(BTHA[j]-BTHA[j-7])/7
end

# United Staes 
PUSA=334.207212;
AUSA=parse.(Float64,Array(Acsv[262,5:qw]))/PUSA;
NUSA=zeros(D);
for j=1:7
    NUSA[j]=AUSA[j]/7
end
for j=8:D
    NUSA[j]=(AUSA[j]-AUSA[j-7])/7
end
BUSA=parse.(Float64,Array(Bcsv[262,5:qw]))/PUSA;
NDUSA=zeros(D);
for j=1:7
    NDUSA[j]=BUSA[j]/7
end
for j=8:D
    NDUSA[j]=(BUSA[j]-BUSA[j-7])/7
end

# United Kingdom 
PGBR=68.466544;
AGBR=parse.(Float64,Array(Acsv[280,5:qw]))/PGBR;
NGBR=zeros(D);
for j=1:7
    NGBR[j]=AGBR[j]/7
end
for j=8:D
    NGBR[j]=(AGBR[j]-AGBR[j-7])/7
end
BGBR=parse.(Float64,Array(Bcsv[280,5:qw]))/PGBR;
NDGBR=zeros(D);
for j=1:7
    NDGBR[j]=BGBR[j]/7
end
for j=8:D
    NDGBR[j]=max(0,(BGBR[j]-BGBR[j-7]))/7
end

# Vietnam
PVNM=98.953541;
AVNM=parse.(Float64,Array(Acsv[285,5:qw]))/PVNM;
NVNM=zeros(D);
for j=1:7
    NVNM[j]=AVNM[j]/7
end
for j=8:D
    NVNM[j]=(AVNM[j]-AVNM[j-7])/7
end
BVNM=parse.(Float64,Array(Bcsv[285,5:qw]))/PVNM;
NDVNM=zeros(D);
for j=1:7
    NDVNM[j]=BVNM[j]/7
end
for j=8:D
    NDVNM[j]=(BVNM[j]-BVNM[j-7])/7
end

p1=plot([AJPN APHI AMYS ATWN AAUS AVNM AKOR AHKG ATHA ASIN],  
    grid=false,
    linewidth=2, 
    title="COVID-19: cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xlabel="date",
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Taiwan" "Australia" "Vietnam" "South Korea" "Hong Kong" "Thailand" "Singapore"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./jhu/asia_cases.png") 

p2=plot([BJPN BPHI BMYS BTWN BAUS BVNM BKOR BHKG BTHA BSIN], 
    grid=false,
    linewidth=2, 
    title="COVID-19: deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Taiwan" "Australia" "Vietnam" "South Korea" "Hong Kong" "Thailand" "Singapore"],
   palette = :seaborn_bright, 
     legend = :topleft)
savefig("./jhu/asia_deaths.png") 

p3=plot([NJPN NPHI NMYS NTWN NAUS NVNM NKOR NHKG NTHA NSIN],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average of new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xlabel="date",
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Taiwan" "Australia" "Vietnam" "South Korea" "Hong Kong" "Thailand" "Singapore"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./jhu/asia_new_cases.png") 

p4=plot([NDJPN NDPHI NDMYS NDTWN NDAUS NDVNM NDKOR NDHKG NDTHA NDSIN],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Philippines" "Malaysia" "Taiwan" "South Korea" "Vietnam" "Brunei" "Australia" "Thailand" "Singapore"],
   palette = :seaborn_bright, 
     legend = :topleft)
savefig("./jhu/asia_recent_deaths.png") 

p5=plot([AUSA AGBR AARG ABRA ACOL AMEX AFIE],  
    grid=false,
    linewidth=2, 
    title="COVID-19: cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 15.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FRA+ITA+ESP"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./jhu/world_cases.png") 

p6=plot([BUSA BGBR BARG BBRA BCOL BMEX BFIE],  
    grid=false,
    linewidth=2, 
    title="COVID-19: deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FRA+ITA+ESP"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./jhu/world_deaths.png") 

p7=plot([NUSA NGBR NARG NBRA NCOL NMEX NFIE],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day-average of new cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FRA+ITA+ESP"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./jhu/world_new_cases.png") 

p8=plot([NDUSA NDGBR NDARG NDBRA NDCOL NDMEX NDFIE],  
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D], [l0,l1,l2,l3,l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["United States" "United Kingdom" "Argentina" "Brazil" "Colombia" "Mexico" "FRA+ITA+ESP"],
   palette = :seaborn_bright, 
     legend = :topleft)
savefig("./jhu/world_recent_deaths.png") 

plot(p1, p2, p3, p4,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./asia.png") 

plot(p5, p6, p7, p8,
     layout=(2,2), 
     size=(1200,800), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./world.png") 
