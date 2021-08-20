# nhk_data.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

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
X=parse.(Float64,Acsv[2:pa,6]);
(pj,qj)=size(Jcsv);
J1=parse.(Float64,Jcsv[2:pj,2]);
J2=parse.(Float64,Jcsv[2:pj,3]);
J3=parse.(Float64,Jcsv[2:pj,5]);
XJPN=parse.(Float64,Jcsv[2:pj,4]);

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

dd0=Date(2021,4,1);
DD=length(J1)-441;
ll0=string(dd0);
ll1=string(dd0+Day(Int(floor((DD-1)/2))));
ll2=string(dd0+Day(Int(floor(DD-1))));

# Okinawa (1.46M): code 47
rowoknw=findall(x->x==47,A0);
NOKNW=A1[rowoknw]/1.458870;
TOKNW=A2[rowoknw]/1.458870;
DOKNW=A3[rowoknw]/1.458870;
XOKNW=X[rowoknw]/1.458870;
NDOKNW=zeros(D-441);
for j=1:D-441
    NDOKNW[j]=(XOKNW[j+441]+XOKNW[j+440]+XOKNW[j+439]+XOKNW[j+438]+XOKNW[j+437]+XOKNW[j+436]+XOKNW[j+435])/7
end
# Hokkaido (5.27M): code 1, 
rowhkd=findall(x->x==1,A0);
NHKD=A1[rowhkd]/5.207185;
THKD=A2[rowhkd]/5.207185;
DHKD=A3[rowhkd]/5.207185;
XHKD=X[rowhkd]/5.207185;
NDHKD=zeros(D-441);
for j=1:D-441
    NDHKD[j]=(XHKD[j+441]+XHKD[j+440]+XHKD[j+439]+XHKD[j+438]+XHKD[j+437]+XHKD[j+436]+XHKD[j+435])/7
end
# Tokyo (14M): code 13, 
rowtky=findall(x->x==13,A0);
NTKY=A1[rowtky]/14.049146;
TTKY=A2[rowtky]/14.049146;
DTKY=A3[rowtky]/14.049146;
J3TKY=A3[rowtky];
XTKY=X[rowtky]/14.049146;
NDTKY=zeros(D-441);
for j=1:D-441
    NDTKY[j]=(XTKY[j+441]+XTKY[j+440]+XTKY[j+439]+XTKY[j+438]+XTKY[j+437]+XTKY[j+436]+XTKY[j+435])/7
end
# Osaka (8.81M): code 27
rowosk=findall(x->x==27,A0);
NOSK=A1[rowosk]/8.798545;
TOSK=A2[rowosk]/8.798545;
DOSK=A3[rowosk]/8.798545;
J3OSK=A3[rowosk];
XOSK=X[rowosk]/8.798545;
NDOSK=zeros(D-441);
for j=1:D-441
    NDOSK[j]=(XOSK[j+441]+XOSK[j+440]+XOSK[j+439]+XOSK[j+438]+XOSK[j+437]+XOSK[j+436]+XOSK[j+435])/7
end
# Japan (126M)
NJPN=J1/125.36;
TJPN=J2/125.36;
DJPN=J3/125.36;
XJPN=XJPN/125.36;
NDJPN=zeros(D-441);
for j=1:D-441
    NDJPN[j]=(XJPN[j+441]+XJPN[j+440]+XJPN[j+439]+XJPN[j+438]+XJPN[j+437]+XJPN[j+436]+XJPN[j+435])/7
end
# Hyogo (5.43M): code 28, 
rowhyg=findall(x->x==28,A0);
NHYG=A1[rowhyg]/5.446455;
THYG=A2[rowhyg]/5.446455;
DHYG=A3[rowhyg]/5.446455;
XHYG=X[rowhyg]/5.446455;
NDHYG=zeros(D-441);
for j=1:D-441
    NDHYG[j]=(XHYG[j+441]+XHYG[j+440]+XHYG[j+439]+XHYG[j+438]+XHYG[j+437]+XHYG[j+436]+XHYG[j+435])/7
end

p1=plot([TJPN TTKY TOKNW], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japanese Public TV)",
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)

p2=plot([DJPN DTKY DOKNW DOSK DHYG DHKD], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"],
    palette = :seaborn_bright, 
    legend = :topleft)

p3=plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido"], 
    palette = :seaborn_bright, 
    legend = :topleft)

p4=plot([NDJPN NDTKY NDOKNW NDOSK NDHYG NDHKD], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (7-day average deaths per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"], 
    palette = :seaborn_bright, 
    legend = :topleft)

plot(p1, p2, p3, p4, 
     layout=(2,2), 
     size=(1260,840), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("nhk.png") 

plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases_okinawa.png") 

plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases_okinawa.png") 

plot([J3 J3TKY J3OSK], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (death toll) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Osaka"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_japan_deaths.png") 

plot([TJPN TTKY TOKNW], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japanese Public TV)",
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_cases.png") 

plot([DJPN DTKY DOKNW DOSK DHYG DHKD], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_deaths.png") 

plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases.png") 

plot([NDJPN NDTKY NDOKNW NDOSK NDHYG NDHKD], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (7-day average deaths per 1M) \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_deaths.png") 
