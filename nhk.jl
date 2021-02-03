# nhk_data.jl
#######################

# Load packages. 
using Plots, CSV, Dates, HTTP, DataFrames

# Download data from the MHLW web site. 
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv","nhk_news_covid19_prefectures_daily_data.csv");
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_domestic_daily_data.csv","nhk_news_covid19_domestic_daily_data.csv");

# Shape up the data.
Acsv=DataFrame(CSV.File("nhk_news_covid19_prefectures_daily_data.csv", header=false, delim=','));
Jcsv=DataFrame(CSV.File("nhk_news_covid19_domestic_daily_data.csv", header=false, delim=','));
(pa,qa)=size(Acsv);
A0=parse.(Int64,Acsv[2:pa,2]);
A1=parse.(Float64,Acsv[2:pa,4]);
A2=parse.(Float64,Acsv[2:pa,5]);
A3=parse.(Float64,Acsv[2:pa,7]);
(pj,qj)=size(Jcsv);
J1=parse.(Float64,Jcsv[2:pj,2]);
J2=parse.(Float64,Jcsv[2:pj,3]);
J3=parse.(Float64,Jcsv[2:pj,5]);

# Plot the data
# d0: the initial date
# df: the final day
d0=Date(2020,1,16)
D=length(J1);
df=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/3))));
l2=string(d0+Day(Int(floor(2*(D-1)/3))));
l3=string(df);

# Okinawa (1.46M): code 47
rowoknw=findall(x->x==47,A0);
NOKNW=A1[rowoknw]/1.46;
TOKNW=A2[rowoknw]/1.46;
DOKNW=A3[rowoknw]/1.46;
# Hokkaido (5.27M): code 1, 
rowhkd=findall(x->x==1,A0);
NHKD=A1[rowhkd]/5.27;
THKD=A2[rowhkd]/5.27;
DHKD=A3[rowhkd]/5.27;
# Tokyo (14M): code 13, 
rowtky=findall(x->x==13,A0);
NTKY=A1[rowtky]/14;
TTKY=A2[rowtky]/14;
DTKY=A3[rowtky]/14;
# Osaka (8.81M): code 27
rowosk=findall(x->x==27,A0);
NOSK=A1[rowosk]/8.81;
TOSK=A2[rowosk]/8.81;
DOSK=A3[rowosk]/8.81;
# Japan (126M)
NJPN=J1/126;
TJPN=J2/126;
DJPN=J3/126;
# Hyogo (5.43M): code 28, 
rowhyg=findall(x->x==28,A0);
NHYG=A1[rowhyg]/5.43;
THYG=A2[rowhyg]/5.43;
DHYG=A3[rowhyg]/5.43;
# Kyoto (2.57M): code 26
rowkyt=findall(x->x==26,A0);
NKYT=A1[rowkyt]/2.57;
TKYT=A2[rowkyt]/2.57;
DKYT=A3[rowkyt]/2.57;
# Saitama (5.27M): code 11, 
row1=findall(x->x==11,A0);
N1=7.34;
C1=A1[row1]/N1;
T1=A2[row1]/N1;
D1=A3[row1]/N1;
# Chiba (6.28M): code 12
row2=findall(x->x==12,A0);
N2=6.28;
C2=A1[row2]/N2;
T2=A2[row2]/N2;
D2=A3[row2]/N2;
# Tokyo (14M): code 13, 
row3=findall(x->x==13,A0);
N3=14;
C3=A1[row3]/N3;
T3=A2[row3]/N3;
D3=A3[row3]/N3;
# kanagawa (8.81M): code 14
row4=findall(x->x==14,A0);
N4=9.22;
C4=A1[row4]/N4;
T4=A2[row4]/N4;
D4=A3[row4]/N4;
# Kanto (126M)
N=N1+N2+N3+N4;
CT=(N1*C1+N2*C2+N3*C3+N4*C4)/N;
TT=(N1*T1+N2*T2+N3*T3+N4*T4)/N;
DT=(N1*D1+N2*D2+N3*D3+N4*D4)/N;

plot([NOKNW NHKD NTKY NOSK NJPN NHYG], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Okinawa" "Hokkaido" "Tokyo" "Osaka" "Japan" "Hyogo"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("nhk_new_cases.png") 

plot([TOKNW THKD TTKY TOSK TJPN THYG], 
    grid=false,
    linewidth=3, 
    legendfont=font(14), 
    label=["Okinawa" "Hokkaido" "Tokyo" "Osaka" "Japan" "Hyogo"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="cases/1M",    
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("nhk_cases.png") 

plot([DOKNW DHKD DTKY DOSK DJPN DHYG], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(14), 
    label=["Okinawa" "Hokkaido" "Tokyo" "Osaka" "Japan" "Hyogo"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("nhk_deaths.png") 

plot([NKYT NHYG NTKY NOSK NJPN], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in KEIHANSHIN (daily new cases per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Kyoto" "Hyogo" "Tokyo" "Osaka" "Japan"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("kansai_new_cases.png") 

plot([TKYT THYG TTKY TOSK TJPN], 
    grid=false,
    linewidth=3, 
    legendfont=font(14), 
    label=["Kyoto" "Hyogo" "Tokyo" "Osaka" "Japan"], 
    title="COVID-19 in KEIHANSHIN (total cases per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="cases/1M",    
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("kansai_cases.png") 

plot([DKYT DHYG DTKY DOSK DJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in KEIHANSHIN (deaths per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(14), 
    label=["Kyoto" "Hyogo" "Tokyo" "Osaka" "Japan"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("kansai_deaths.png") 

plot([C1 C2 C3 C4 CT], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Tokyo (daily new cases per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Saitama" "Chiba" "Tokyo" "Kanagawa" "SCTK"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("kanto_new_cases.png") 
plot([T1 T2 T3 T4 TJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Tokyo (total cases per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Saitama" "Chiba" "Tokyo" "Kanagawa" "Japan"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("kanto_cases.png") 

plot([D1 D2 D3 D4 DJPN], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Tokyo (deaths per 1M) \n data sourced by NHK", 
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(14), 
    label=["Saitama" "Chiba" "Tokyo" "Kanagawa" "Japan"], 
    legend = :topleft)
plot!(xticks = ([0 floor((D-1)/3)  floor(2*(D-1)/3) D-3;], [l0 l1 l2 l3]))
savefig("kanto_deaths.png") 
