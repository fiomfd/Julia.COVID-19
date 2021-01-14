# nhk_data.jl
#######################

# Load packages. 
using Plots, CSV, Dates, HTTP, DataFrames

# Download data from the MHLW web site. 
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv","nhk_news_covid19_prefectures_daily_data.csv");
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_domestic_daily_data.csv","nhk_news_covid19_domestic_daily_data.csv");

# Shape up the data.
# N: the number of days 
# A[n]: total cases on the n-th day
# B[n]: the number of total discharged individuals on the n-the day
# C[n]=A[n]-B[n]: active cases and deaths  
Acsv=DataFrame(CSV.File("nhk_news_covid19_prefectures_daily_data.csv", header=false, delim=','));
Jcsv=DataFrame(CSV.File("nhk_news_covid19_domestic_daily_data.csv", header=false, delim=','));
(pa,qa)=size(Acsv);
A1=parse.(Int64,Acsv[2:pa,2]);
A2=parse.(Float64,Acsv[2:pa,5]);
A3=parse.(Float64,Acsv[2:pa,7]);
(pj,qj)=size(Jcsv);
J2=parse.(Float64,Jcsv[2:pj,3]);
J3=parse.(Float64,Jcsv[2:pj,5]);

# Plot the data
# d0: the initial date
# df: the final day
d0=Date(2020,1,16);
D=length(J2);
df=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/3))));
l2=string(d0+Day(Int(floor(2*(D-1)/3))));
l3=string(df);

# Okinawa (1.46M): code 47
rowoknw=findall(x->x==47,A1);
TOKNW=A2[rowoknw]/1.46;
DOKNW=A3[rowoknw]/1.46;
# Hokkaido (5.27M): code 1, 
rowhkd=findall(x->x==1,A1);
THKD=A2[rowhkd]/5.27;
DHKD=A3[rowhkd]/5.27;
# Tokyo (14M): code 13, 
rowtky=findall(x->x==13,A1);
TTKY=A2[rowtky]/14;
DTKY=A3[rowtky]/14;
# Osaka (8.81M): code 27
rowosk=findall(x->x==27,A1);
TOSK=A2[rowoknw]/8.81;
DOSK=A3[rowoknw]/8.81;
# Japan (126M)
TJPN=J2/126;
DJPN=J3/126;

plot([TOKNW THKD TTKY TOSK TJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="cases/1M",
    label=["Okinawa" "Hokkaido" "Tokyo" "Osaka" "Japan"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("nhk_cases.png") 

plot([DOKNW DHKD DTKY DOSK DJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="deaths/1M",
    label=["Okinawa" "Hokkaido" "Tokyo" "Osaka" "Japan"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("nhk_deaths.png") 
