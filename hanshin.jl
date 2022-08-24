# hanshin.jl
#######################
# Load packages. 
using Plots, CSV, Dates, DataFrames

download("https://covid19.mhlw.go.jp/public/opendata/deaths_cumulative_daily.csv","./csv/mhlw_deaths.csv");
download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv","./csv/jhu_deaths.csv");

# Shape up the data.
Dcsv=DataFrame(CSV.File("./csv/mhlw_deaths.csv", header=false, delim=','));
Xcsv=DataFrame(CSV.File("./csv/jhu_deaths.csv", header=false, delim=','));
(pa,qa)=size(Dcsv);
(pw,qw)=size(Xcsv);

# Plot the data
# d0: the initial date
# df: the final day
d0=Date(2020,5,9)
D=Int64(qw-112);
d1=d0+Day(floor((D-1)/4));
d2=d0+Day(floor(2*(D-1)/4));
d3=d0+Day(floor(3*(D-1)/4));
d4=d0+Day(D-1);
l0=string(d0);
l1=string(d1);
l2=string(d2);
l3=string(d3);
l4=string(d4);

K=parse.(Float64,Dcsv[2:pa,2:qa]);

# Tokyo
PTKY=13.988129;
TKY=K[:,14]/PTKY;

# Okinawa
POKNW=1.469335;    
OKNW=K[:,48]/POKNW;

# Osaka
POSK=8.797153;
OSK=K[:,28]/POSK;

# India 
PIND=1402.124607;
IND=parse.(Float64,Array(Xcsv[150,113:qw]))/PIND;

# Indonesia
PIDN=278.239007;
IDN=parse.(Float64,Array(Xcsv[151,113:qw]))/PIDN;

# Japan
PJPN=125.845010;
JPN=parse.(Float64,Array(Xcsv[158,113:qw]))/PJPN;

# Malaysia
PMYS=33.060794;
MYS=parse.(Float64,Array(Xcsv[180,113:qw]))/PMYS;

r=plot([JPN TKY OKNW OSK IND IDN MYS],  
    grid=false,
    linewidth=2, 
    title="COVID-19: total deaths per 1M \n data sourced by JHU and MoH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(8), 
   label=["Japan" "Tokyo" "Okinawa" "Osaka" "India" "Indonesia" "Malaysia"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./crisis/osaka.png") 