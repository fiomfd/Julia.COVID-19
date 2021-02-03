# jhu2.jl
#######################

# Load packages. 
using Plots, CSV, Dates, HTTP, DataFrames

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
PMYS=32;
AMYS=parse.(Float64,Array(Acsv[176,5:qa]))/PMYS;
BMYS=parse.(Float64,Array(Bcsv[176,5:qa]))/PMYS;
CMYS=parse.(Float64,Array(Acsv[176,5:qa]));
RMYS=parse.(Float64,Array(Ccsv[161,5:qa]));
IMYS=CMYS-RMYS;
# Indonesia
PIND=271;
AIND=parse.(Float64,Array(Acsv[149,5:qa]))/PIND;
BIND=parse.(Float64,Array(Bcsv[149,5:qa]))/PIND;
CIND=parse.(Float64,Array(Acsv[149,5:qa]));
RIND=parse.(Float64,Array(Ccsv[134,5:qa]));
IIND=CIND-RIND;
# Singapore
PSIN=5.7;
ASIN=parse.(Float64,Array(Acsv[228,5:qa]))/PSIN;
BSIN=parse.(Float64,Array(Bcsv[228,5:qa]))/PSIN;
CSIN=parse.(Float64,Array(Acsv[228,5:qa]));
RSIN=parse.(Float64,Array(Ccsv[213,5:qa]));
ISIN=CSIN-RSIN;

D=qa-4;
d0=Date(2020,1,22);
d1=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/4))));
l2=string(d0+Day(Int(floor((D-1)/2))));
l3=string(d0+Day(Int(floor(3*(D-1)/4))));
l4=string(d0+Day(D-1));

plot([APHI AMYS AIND AKOR AJPN ASIN],  
    grid=false,
    linewidth=3, 
    title="COVID-19 in Asia: Confirmed Cases per 1M \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Philippines" "Malaysia" "Indonesia" "South Korea" "Japan" "Singapore"],
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_cases2.png") 

plot([BPHI BMYS BIND BKOR BJPN BSIN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Asia: Deaths per 1M \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(14), 
    label=["Philippines" "Malaysia" "Indonesia" "South Korea" "Japan" "Singapore"],
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_deaths2.png") 

plot([CJPN IJPN RJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (126M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["Total Cases" "Active Cases" "Discharged"], 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_japan.png") 

plot([CKOR IKOR RKOR], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in South Korea (51.3M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["Total Cases" "Active Cases" "Discharged"], 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_south_korea.png")

plot([CPHI IPHI RPHI], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Philippines (108M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["Total Cases" "Active Cases" "Discharged"], 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_philippines.png")

plot([CMYS IMYS RMYS], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Malaysia (32M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["Total Cases" "Active Cases" "Discharged"], 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_malaysia.png")

plot([CIND IIND RIND], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Indonesia (271M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["Total Cases" "Active Cases" "Discharged"], 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_indonesia.png")

plot([CSIN ISIN RSIN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Singapore (5.7M) \n data sourced by JHU Coronavirus Resource Center", 
    xlabel="date",
    yaxis="cases",
    legendfont=font(14), 
    label=["Total Cases" "Active Cases" "Discharged"], 
    legend = :right)
plot!(xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D-2;], [l0 l1 l2 l3 l4]))
savefig("jhu_singapore.png")