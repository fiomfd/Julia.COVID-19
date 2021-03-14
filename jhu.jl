# jhu.jl
#######################

# Load packages. 
using Plots, CSV, Dates, HTTP, DataFrames, DifferentialEquations

# Download data from the MHLW web site. 
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv","time_series_covid19_confirmed_global.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv","time_series_covid19_deaths_global.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv","time_series_covid19_recovered_global.csv");

Acsv=DataFrame(CSV.File("time_series_covid19_confirmed_global.csv", header=false, delim=','));
Bcsv=DataFrame(CSV.File("time_series_covid19_deaths_global.csv", header=false, delim=','));
Ccsv=DataFrame(CSV.File("time_series_covid19_recovered_global.csv", header=false, delim=','));
(pa,qa)=size(Acsv);

# Japan
PJPN=126;
AJPN=parse.(Float64,Array(Acsv[156,5:qa]))/PJPN;
BJPN=parse.(Float64,Array(Bcsv[156,5:qa]))/PJPN;
CJPN=parse.(Float64,Array(Acsv[156,5:qa]));
RJPN=parse.(Float64,Array(Ccsv[141,5:qa]));
IJPN=CJPN-RJPN;
# South Korea
PKOR=51.3;
AKOR=parse.(Float64,Array(Acsv[160,5:qa]))/PKOR;
BKOR=parse.(Float64,Array(Bcsv[160,5:qa]))/PKOR;
CKOR=parse.(Float64,Array(Acsv[160,5:qa]));
RKOR=parse.(Float64,Array(Ccsv[145,5:qa]));
IKOR=CKOR-RKOR;
# Philippines
PPHI=108;
APHI=parse.(Float64,Array(Acsv[210,5:qa]))/PPHI;
BPHI=parse.(Float64,Array(Bcsv[210,5:qa]))/PPHI;
CPHI=parse.(Float64,Array(Acsv[210,5:qa]));
RPHI=parse.(Float64,Array(Ccsv[195,5:qa]));
IPHI=CPHI-RPHI;
# Malaysia
PMYS=32.6;
AMYS=parse.(Float64,Array(Acsv[176,5:qa]))/PMYS;
BMYS=parse.(Float64,Array(Bcsv[176,5:qa]))/PMYS;
CMYS=parse.(Float64,Array(Acsv[176,5:qa]));
RMYS=parse.(Float64,Array(Ccsv[161,5:qa]));
IMYS=CMYS-RMYS;
# Indonesia
PIDN=271;
AIDN=parse.(Float64,Array(Acsv[149,5:qa]))/PIDN;
BIDN=parse.(Float64,Array(Bcsv[149,5:qa]))/PIDN;
CIDN=parse.(Float64,Array(Acsv[149,5:qa]));
RIDN=parse.(Float64,Array(Ccsv[134,5:qa]));
IIDN=CIDN-RIDN;
# Singapore
PSIN=5.7;
ASIN=parse.(Float64,Array(Acsv[228,5:qa]))/PSIN;
BSIN=parse.(Float64,Array(Bcsv[228,5:qa]))/PSIN;
CSIN=parse.(Float64,Array(Acsv[228,5:qa]));
RSIN=parse.(Float64,Array(Ccsv[213,5:qa]));
ISIN=CSIN-RSIN;
# New Zealand
PNZL=4.9;
ANZL=parse.(Float64,Array(Acsv[198,5:qa]))/PNZL;
BNZL=parse.(Float64,Array(Bcsv[198,5:qa]))/PNZL;
CNZL=parse.(Float64,Array(Acsv[198,5:qa]));
RNZL=parse.(Float64,Array(Ccsv[183,5:qa]));
INZL=CNZL-RNZL;
# Hubei
PHubei=58.5;
AHubei=parse.(Float64,Array(Acsv[73,5:qa]))/PHubei;
BHubei=parse.(Float64,Array(Bcsv[73,5:qa]))/PHubei;
CHubei=parse.(Float64,Array(Acsv[73,5:qa]));
RHubei=parse.(Float64,Array(Ccsv[58,5:qa]));
IHubei=CHubei-RHubei;
# Victoria
PVIC=6.4;
AVIC=parse.(Float64,Array(Acsv[16,5:qa]))/PVIC;
BVIC=parse.(Float64,Array(Bcsv[16,5:qa]))/PVIC;
CVIC=parse.(Float64,Array(Acsv[16,5:qa]));
RVIC=parse.(Float64,Array(Ccsv[16,5:qa]));
IVIC=CVIC-RVIC;
# Victoria
PNSW=7.5;
ANSW=parse.(Float64,Array(Acsv[11,5:qa]))/PNSW;
BNSW=parse.(Float64,Array(Bcsv[11,5:qa]))/PNSW;
CNSW=parse.(Float64,Array(Acsv[11,5:qa]));
RNSW=parse.(Float64,Array(Ccsv[11,5:qa]));
INSW=CNSW-RNSW;
# India 148 133
PIND=1380;
AIND=parse.(Float64,Array(Acsv[148,5:qa]))/PIND;
BIND=parse.(Float64,Array(Bcsv[148,5:qa]))/PIND;
CIND=parse.(Float64,Array(Acsv[148,5:qa]));
RIND=parse.(Float64,Array(Ccsv[133,5:qa]));
IIND=CIND-RIND;
# Nepal 192 177
PNPL=29.5;
ANPL=parse.(Float64,Array(Acsv[192,5:qa]))/PNPL;
BNPL=parse.(Float64,Array(Bcsv[192,5:qa]))/PNPL;
CNPL=parse.(Float64,Array(Acsv[192,5:qa]));
RNPL=parse.(Float64,Array(Ccsv[177,5:qa]));
INPL=CNPL-RNPL;
# Pakistan 205 190
PPAK=221;
APAK=parse.(Float64,Array(Acsv[205,5:qa]))/PPAK;
BPAK=parse.(Float64,Array(Bcsv[205,5:qa]))/PPAK;
CPAK=parse.(Float64,Array(Acsv[205,5:qa]));
RPAK=parse.(Float64,Array(Ccsv[190,5:qa]));
IPAK=CPAK-RPAK;
# Bangladesh 22 22
PBGD=165;
ABGD=parse.(Float64,Array(Acsv[22,5:qa]))/PBGD;
BBGD=parse.(Float64,Array(Bcsv[22,5:qa]))/PBGD;
CBGD=parse.(Float64,Array(Acsv[22,5:qa]));
RBGD=parse.(Float64,Array(Ccsv[22,5:qa]));
IBGD=CBGD-RBGD;
# Sri Lanka 236 221
PLKA=21.5;
ALKA=parse.(Float64,Array(Acsv[236,5:qa]))/PLKA;
BLKA=parse.(Float64,Array(Bcsv[236,5:qa]))/PLKA;
CLKA=parse.(Float64,Array(Acsv[236,5:qa]));
RLKA=parse.(Float64,Array(Ccsv[221,5:qa]));
ILKA=CLKA-RLKA;
# South Africa 233 218
PZAF=58.8;
AZAF=parse.(Float64,Array(Acsv[233,5:qa]))/PZAF;
BZAF=parse.(Float64,Array(Bcsv[233,5:qa]))/PZAF;
CZAF=parse.(Float64,Array(Acsv[233,5:qa]));
RZAF=parse.(Float64,Array(Ccsv[218,5:qa]));
IZAF=CZAF-RZAF;
# Argentina 8 8
PARG=45.2;
AARG=parse.(Float64,Array(Acsv[8,5:qa]))/PARG;
BARG=parse.(Float64,Array(Bcsv[8,5:qa]))/PARG;
CARG=parse.(Float64,Array(Acsv[8,5:qa]));
RARG=parse.(Float64,Array(Ccsv[8,5:qa]));
IARG=CARG-RARG;
# Brazil 32 32
PBRA=213;
ABRA=parse.(Float64,Array(Acsv[32,5:qa]))/PBRA;
BBRA=parse.(Float64,Array(Bcsv[32,5:qa]))/PBRA;
CBRA=parse.(Float64,Array(Acsv[32,5:qa]));
RBRA=parse.(Float64,Array(Ccsv[32,5:qa]));
IBRA=CBRA-RBRA;
# Colombia 93 78
PCOL=50.9;
ACOL=parse.(Float64,Array(Acsv[93,5:qa]))/PCOL;
BCOL=parse.(Float64,Array(Bcsv[93,5:qa]))/PCOL;
CCOL=parse.(Float64,Array(Acsv[93,5:qa]));
RCOL=parse.(Float64,Array(Ccsv[78,5:qa]));
ICOL=CCOL-RCOL;
# France 131 116
PFRA=65.3;
AFRA=parse.(Float64,Array(Acsv[131,5:qa]))/PFRA;
BFRA=parse.(Float64,Array(Bcsv[131,5:qa]))/PFRA;
CFRA=parse.(Float64,Array(Acsv[131,5:qa]));
RFRA=parse.(Float64,Array(Ccsv[116,5:qa]));
IFRA=CFRA-RFRA;
# Italia 154 139
PITA=60.5;
AITA=parse.(Float64,Array(Acsv[154,5:qa]))/PITA;
BITA=parse.(Float64,Array(Bcsv[154,5:qa]))/PITA;
CITA=parse.(Float64,Array(Acsv[154,5:qa]));
RITA=parse.(Float64,Array(Ccsv[139,5:qa]));
IITA=CITA-RITA;
# Mexico 183 168
PMEX=129;
AMEX=parse.(Float64,Array(Acsv[183,5:qa]))/PMEX;
BMEX=parse.(Float64,Array(Bcsv[183,5:qa]))/PMEX;
CMEX=parse.(Float64,Array(Acsv[183,5:qa]));
RMEX=parse.(Float64,Array(Ccsv[168,5:qa]));
IMEX=CMEX-RMEX;
# Mexico 183 168
PMEX=129;
AMEX=parse.(Float64,Array(Acsv[183,5:qa]))/PMEX;
BMEX=parse.(Float64,Array(Bcsv[183,5:qa]))/PMEX;
CMEX=parse.(Float64,Array(Acsv[183,5:qa]));
RMEX=parse.(Float64,Array(Ccsv[168,5:qa]));
IMEX=CMEX-RMEX;
# Spain 235 220
PESP=46.8;
AESP=parse.(Float64,Array(Acsv[235,5:qa]))/PESP;
BESP=parse.(Float64,Array(Bcsv[235,5:qa]))/PESP;
CESP=parse.(Float64,Array(Acsv[235,5:qa]));
RESP=parse.(Float64,Array(Ccsv[220,5:qa]));
IESP=CESP-RESP;
# United Staes 251 236
PUSA=331;
AUSA=parse.(Float64,Array(Acsv[251,5:qa]))/PUSA;
BUSA=parse.(Float64,Array(Bcsv[251,5:qa]))/PUSA;
CUSA=parse.(Float64,Array(Acsv[251,5:qa]));
RUSA=parse.(Float64,Array(Ccsv[236,5:qa]));
IUSA=CUSA-RUSA;
# United Kingdom 266 251
PGBR=67.9;
AGBR=parse.(Float64,Array(Acsv[266,5:qa]))/PGBR;
BGBR=parse.(Float64,Array(Bcsv[266,5:qa]))/PGBR;
CGBR=parse.(Float64,Array(Acsv[266,5:qa]));
RGBR=parse.(Float64,Array(Ccsv[251,5:qa]));
IGBR=CGBR-RGBR;

D=qa-4;
d0=Date(2020,1,22);
d1=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/4))));
l2=string(d0+Day(Int(floor((D-1)/2))));
l3=string(d0+Day(Int(floor(3*(D-1)/4))));
l4=string(d0+Day(D-1));

plot([AJPN APHI AMYS AIDN AKOR AIND ANPL APAK ABGD ALKA],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(12), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "South Korea" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka"],
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_asia_cases.png") 

plot([BJPN BPHI BMYS BIDN BKOR BIND BNPL BPAK BBGD BLKA], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Asia: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(12), 
    label=["Japan" "Philippines" "Malaysia" "Indonesia" "South Korea" "India" "Nepal" "Pakistan" "Bangladesh" "Sri Lanka"],
   palette = :seaborn_bright, 
     legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_asia_deaths.png") 

plot([AARG ABRA ACOL AFRA AITA AMEX AESP AUSA AGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Confirmed cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_world_cases.png") 

plot([BARG BBRA BCOL BFRA BITA BMEX BESP BUSA BGBR],  
    grid=false,
    linewidth=2, 
    title="COVID-19 in the World: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Argentina" "Brazil" "Colombia" "France" "Italy" "Mexico" "Spain" "United States" "United Kingdom"],
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_world_deaths.png") 

plot([CJPN IJPN RJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (126M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
   legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_japan.png") 

plot([CKOR IKOR RKOR], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in South Korea (51.3M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_south_korea.png")

plot([CPHI IPHI RPHI], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Philippines (108M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_philippines.png")

plot([CMYS IMYS RMYS], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_malaysia.png")

plot([CIDN IIDN RIDN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Indonesia (271M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_indonesia.png")

plot([CSIN ISIN RSIN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Singapore (5.7M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_singapore.png")

plot([CNZL INZL RNZL], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in New Zealand (4.9M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_new_zealand.png")

plot([CHubei IHubei RHubei], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Hubei Province (58.5M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_hubei.png")

plot([CVIC IVIC RVIC], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Victoria (AUS) (6.4M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_victoria.png")

plot([CNSW INSW RNSW], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in New South Wales (AUS) (7.5M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_new_south_wales.png")

plot([CIND IIND RIND], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in India (1380M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_india.png")

plot([CNPL INPL RNPL], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Nepal (29.5M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_nepal.png")

plot([CPAK IPAK RPAK], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Pakistan (221M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_pakistan.png")

plot([CBGD IBGD RBGD], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Bangladesh (165M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_bangladesh.png")

plot([CLKA ILKA RLKA], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Sri Lanka (21.5M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_sri_lanka.png")

plot([CZAF IZAF RZAF], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in South Africa (58.8M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_south_africa.png")

plot([CARG IARG RARG], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Argentina (45.2M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_argentina.png")

plot([CBRA IBRA RBRA], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Brazil (213M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_brazil.png")

plot([CCOL ICOL RCOL], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Colombia (50.9M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_colombia.png")

plot([CFRA IFRA RFRA], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in France (65.3M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_france.png")

plot([CITA IITA RITA], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Italy (60.5M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_italy.png")

plot([CMEX IMEX RMEX], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Mexico (129M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_mexico.png")

plot([CESP IESP RESP], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Spain (46.8M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_spain.png")

plot([CUSA IUSA RUSA], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in United States (331M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_usa.png")

plot([CGBR IGBR RGBR], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in United Kingdom (67.9M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("jhu_uk.png")

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
W=Float64(5*7)
w0=string(d1);
w1=string(d1+Day(2*7));
w2=string(d1+Day(4*7));
        
# Japan
T0=A1T0;
R0=A1R0;
T2=A1T2;
R2=A1R2;
N=A1N;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Japan (126M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_japan.png")

# South Korea
T0=A2T0;
R0=A2R0;
T2=A2T2;
R2=A2R2;
N=A2N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in South Korea (51.3M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_south_Korea.png")

# Philippines
T0=A3T0;
R0=A3R0;
T2=A3T2;
R2=A3R2;
N=A3N
T1=(T0-T2)/Float64(28);
R1=(R0-R2)/Float64(28);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Philippines (108M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_philippines.png")

# Malaysia
T0=A4T0;
R0=A4R0;
T2=A4T2;
R2=A4R2;
N=A4N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Malaysia (32.6M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_malaysia.png")

# Indonesia
T0=A5T0;
R0=A5R0;
T2=A5T2;
R2=A5R2;
N=A5N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Indonesia (271M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_indonesia.png")

# India
T0=A6T0;
R0=A6R0;
T2=A6T2;
R2=A6R2;
N=A6N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in India (1380M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_india.png")

# Nepal
T0=A7T0;
R0=A7R0;
T2=A7T2;
R2=A7R2;
N=A7N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Nepal (29.5M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_nepal.png")

# Pakistan
T0=A8T0;
R0=A8R0;
T2=A8T2;
R2=A8R2;
N=A8N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Pakistan (221M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_pakistan.png")

# Bangladesh
T0=A9T0;
R0=A9R0;
T2=A9T2;
R2=A9R2;
N=A9N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Bangladesh (165M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_bangladesh.png")

# Sri Lanka
T0=A10T0;
R0=A10R0;
T2=A10T2;
R2=A10R2;
N=A10N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Sri Lanka (21.5M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_sri_lanka.png")

# Brazil
T0=A11T0;
R0=A11R0;
T2=A11T2;
R2=A11R2;
N=A11N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Brazil (213M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_brazil.png")

# South Africa
T0=A12T0;
R0=A12R0;
T2=A12T2;
R2=A12R2;
N=A12N
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(N-u[1]);u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob);
# plotting
plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in South Africa (58.8M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :right)
plot!(xticks = ([1 2*7 4*7;], [w0, w1, w2]))
savefig("sir_south_africa.png")
