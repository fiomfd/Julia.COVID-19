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
l1=string(d0+Day(Int(floor((D-1)/4))));
l2=string(d0+Day(Int(floor((D-1)/2))));
l3=string(d0+Day(Int(floor(3*(D-1)/4))));
l4=string(df);

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
# Saitama (7.34M): code 11, 
rowstm=findall(x->x==11,A0);
NSTM=A1[rowstm]/7.34;
TSTM=A2[rowstm]/7.34;
DSTM=A3[rowstm]/7.34;
# Chiba (6.28M): code 12
rowchb=findall(x->x==12,A0);
NCHB=A1[rowchb]/6.28;
TCHB=A2[rowchb]/6.28;
DCHB=A3[rowchb]/6.28;
# kanagawa (9.22M): code 14
rowkng=findall(x->x==14,A0);
NKNG=A1[rowkng]/9.22;
TKNG=A2[rowkng]/9.22;
DKNG=A3[rowkng]/9.22;
# Miyagi (2.29M): code 4
rowmyg=findall(x->x==4,A0);
NMYG=A1[rowmyg]/2.29;
TMYG=A2[rowmyg]/2.29;
DMYG=A3[rowmyg]/2.29;
# Aomori (1.23M): code 2
rowamr=findall(x->x==2,A0);
NAMR=A1[rowamr]/1.23;
TAMR=A2[rowamr]/1.23;
DAMR=A3[rowamr]/1.23;

plot([NJPN NTKY NOSK NOKNW NHYG], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_new_cases.png") 

plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_new_cases_okinawa.png") 

plot([NJPN NTKY NMYG], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Miyagi"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_new_cases_miyagi.png") 

plot([NJPN NTKY NOSK], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Osaka"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_new_cases_osaka.png") 

plot([NJPN NTKY NAMR], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Aomori"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_new_cases_aomori.png") 

plot([NJPN NTKY NHYG], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Hyogo"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_new_cases_hyogo.png") 

plot([TJPN TTKY TOSK TOKNW THKD TKNG TSTM TCHB THYG TKYT], 
    grid=false,
    linewidth=2, 
    legendfont=font(12), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hokkaido" "Kanagawa" "Saitama" "Chiba" "Hyogo" "Kyoto"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_cases.png") 

plot([DJPN DTKY DOSK DOKNW DHKD DKNG DSTM DCHB DHYG DKYT], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(12), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hokkaido" "Kanagawa" "Saitama" "Chiba" "Hyogo" "Kyoto"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_deaths.png") 

plot([TJPN TTKY TMYG], 
    grid=false,
    linewidth=2, 
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Miyagi"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk2_cases.png") 

plot([DJPN DTKY DMYG], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Miyagi"], 
    palette = :seaborn_bright, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk2_deaths.png") 

plot(J3, 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (death toll) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    xlabel="date",
    yaxis="deaths",
    legendfont=font(14), 
    label=false, 
    palette = :Set1_3, 
    legend = :topleft)
plot!(xticks = ([1 floor(D/4) floor(D/2) floor(3*D/4) D-3;], [l0 l1 l2 l3 l4]))
savefig("nhk_japan_deaths.png") 
