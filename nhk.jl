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
NOKNW=A1[rowoknw]/1.46;
TOKNW=A2[rowoknw]/1.46;
DOKNW=A3[rowoknw]/1.46;
XOKNW=X[rowoknw]/1.46;
NDOKNW=zeros(D-441);
for j=1:D-441
    NDOKNW[j]=(XOKNW[j+441]+XOKNW[j+440]+XOKNW[j+439]+XOKNW[j+438]+XOKNW[j+437]+XOKNW[j+436]+XOKNW[j+435])/7
end
# Hokkaido (5.27M): code 1, 
rowhkd=findall(x->x==1,A0);
NHKD=A1[rowhkd]/5.27;
THKD=A2[rowhkd]/5.27;
DHKD=A3[rowhkd]/5.27;
XHKD=X[rowhkd]/5.27;
NDHKD=zeros(D-441);
for j=1:D-441
    NDHKD[j]=(XHKD[j+441]+XHKD[j+440]+XHKD[j+439]+XHKD[j+438]+XHKD[j+437]+XHKD[j+436]+XHKD[j+435])/7
end
# Tokyo (14M): code 13, 
rowtky=findall(x->x==13,A0);
NTKY=A1[rowtky]/14;
TTKY=A2[rowtky]/14;
DTKY=A3[rowtky]/14;
J3TKY=A3[rowtky];
XTKY=X[rowtky]/14;
NDTKY=zeros(D-441);
for j=1:D-441
    NDTKY[j]=(XTKY[j+441]+XTKY[j+440]+XTKY[j+439]+XTKY[j+438]+XTKY[j+437]+XTKY[j+436]+XTKY[j+435])/7
end
# Osaka (8.81M): code 27
rowosk=findall(x->x==27,A0);
NOSK=A1[rowosk]/8.81;
TOSK=A2[rowosk]/8.81;
DOSK=A3[rowosk]/8.81;
J3OSK=A3[rowosk];
XOSK=X[rowosk]/8.81;
NDOSK=zeros(D-441);
for j=1:D-441
    NDOSK[j]=(XOSK[j+441]+XOSK[j+440]+XOSK[j+439]+XOSK[j+438]+XOSK[j+437]+XOSK[j+436]+XOSK[j+435])/7
end
# Japan (126M)
NJPN=J1/126;
TJPN=J2/126;
DJPN=J3/126;
XJPN=XJPN/126;
NDJPN=zeros(D-441);
for j=1:D-441
    NDJPN[j]=(XJPN[j+441]+XJPN[j+440]+XJPN[j+439]+XJPN[j+438]+XJPN[j+437]+XJPN[j+436]+XJPN[j+435])/7
end
# Hyogo (5.43M): code 28, 
rowhyg=findall(x->x==28,A0);
NHYG=A1[rowhyg]/5.43;
THYG=A2[rowhyg]/5.43;
DHYG=A3[rowhyg]/5.43;
XHYG=X[rowhyg]/5.43;
NDHYG=zeros(D-441);
for j=1:D-441
    NDHYG[j]=(XHYG[j+441]+XHYG[j+440]+XHYG[j+439]+XHYG[j+438]+XHYG[j+437]+XHYG[j+436]+XHYG[j+435])/7
end
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
# SCK (7.34+6.28+9.22=22.84)
NSCK=(A1[rowstm]+A1[rowchb]+A1[rowkng])/22.84;
TSCK=(A2[rowstm]+A2[rowchb]+A2[rowkng])/22.84;
DSCK=(A3[rowstm]+A3[rowchb]+A3[rowkng])/22.84;
XSCK=(X[rowstm]+X[rowchb]+X[rowkng])/22.84;;
NDSCK=zeros(D-441);
for j=1:D-441
    NDSCK[j]=(XSCK[j+441]+XSCK[j+440]+XSCK[j+439]+XSCK[j+438]+XSCK[j+437]+XSCK[j+436]+XSCK[j+435])/7
end
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
# Fukuoka (5.11M): code 40
rowfuk=findall(x->x==40,A0);
NFUK=A1[rowfuk]/5.11;
TFUK=A2[rowfuk]/5.11;
DFUK=A3[rowfuk]/5.11;
# Saga (0.807M): code 41
rowsag=findall(x->x==41,A0);
NSAG=A1[rowsag]/0.807;
TSAG=A2[rowsag]/0.807;
DSAG=A3[rowsag]/0.807;
# Nagasaki (1.31M): code 42
rownsk=findall(x->x==42,A0);
NNSK=A1[rownsk]/1.31;
TNSK=A2[rownsk]/1.31;
DNSK=A3[rownsk]/1.31;
# Kumamoto (1.73M): code 43
rowkum=findall(x->x==43,A0);
NKUM=A1[rowkum]/1.73;
TKUM=A2[rowkum]/1.73;
DKUM=A3[rowkum]/1.73;
# Oita (1.12M): code 44
rowoit=findall(x->x==44,A0);
NOIT=A1[rowoit]/1.12;
TOIT=A2[rowoit]/1.12;
DOIT=A3[rowoit]/1.12;
# Miyazaki (1.06M): code 45
rowmzk=findall(x->x==45,A0);
NMZK=A1[rowmzk]/1.06;
TMZK=A2[rowmzk]/1.06;
DMZK=A3[rowmzk]/1.06;
# Kagoshima (1.58M): code 46
rowkgm=findall(x->x==46,A0);
NKGM=A1[rowkgm]/1.58;
TKGM=A2[rowkgm]/1.58;
DKGN=A3[rowkgm]/1.58;
# Kyushu (5.11+0.81+1.31+1.73+1.12+1.06+1.58=12.72)
NKYU=(A1[rowfuk]+A1[rowsag]+A1[rownsk]+A1[rowkum]+A1[rowoit]+A1[rowmzk]+A1[rowkgm])/12.72;
TKYU=(A2[rowfuk]+A2[rowsag]+A2[rownsk]+A2[rowkum]+A2[rowoit]+A2[rowmzk]+A2[rowkgm])/12.72;
DKYU=(A3[rowfuk]+A3[rowsag]+A3[rownsk]+A3[rowkum]+A3[rowoit]+A3[rowmzk]+A3[rowkgm])/12.72;

p1=plot([TJPN TTKY TOSK TOKNW THYG THKD TSCK], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Saitama Chiba Kanagawa"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)

p2=plot([DJPN DTKY DOSK DOKNW DHYG DHKD DSCK], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Saitama Chiba Kanagawa"],
    palette = :seaborn_bright, 
    legend = :topleft)

p3=plot([NJPN NTKY NOSK NOKNW NHYG], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo"], 
    palette = :seaborn_bright, 
    legend = :topleft)

p4=plot([NDJPN NDTKY NDOSK NDOKNW NDHYG NDHKD NDSCK], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (7-day average deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Saitama Chiba Kanagawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_deaths.png") 

plot(p1, p2, p3, p4, 
     layout=(2,2), 
     size=(1260,840), 
     margin=Plots.Measures.Length(:mm, 5.0))
savefig("nhk.png") 

plot([NDJPN NDTKY NDOSK NDOKNW NDHYG NDHKD NDSCK], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (7-day average deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Saitama Chiba Kanagawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_deaths.png") 

plot([NJPN NTKY NOSK NOKNW NHYG], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases.png") 

plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases_okinawa.png") 

plot([NJPN NTKY NOSK], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Osaka"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases_osaka.png") 

plot([NJPN NTKY NHYG], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Hyogo"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases_hyogo.png") 

plot([NJPN NTKY NFUK], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Fukuoka"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases_fukuoka.png") 

plot([NJPN NTKY NKYU], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Kyushu"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_new_cases_kyushu.png") 

plot([TJPN TTKY TOSK TOKNW THYG THKD TKNG TSTM TCHB TKYT TKYU], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Kanagawa" "Saitama" "Chiba" "Kyoto" "Kyushu"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_cases_1.png") 

plot([DJPN DTKY DOSK DOKNW DHYG DHKD DKNG DSTM DCHB DKYT DKYU], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Kanagawa" "Saitama" "Chiba" "Kyoto" "Kyushu"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_deaths_1.png") 

plot([TJPN TTKY TOSK TOKNW], 
    grid=false,
    linewidth=2, 
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_cases_2.png") 

plot([DJPN DTKY DOSK DOKNW], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_deaths_2.png") 

plot([TJPN TTKY TOSK TOKNW THYG THKD TSCK], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Saitama Chiba Kanagawa"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_cases_3.png") 

plot([DJPN DTKY DOSK DOKNW DHYG DHKD DSCK], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido" "Saitama Chiba Kanagawa"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_deaths_3.png") 

plot([J3 J3TKY J3OSK], 
    grid=false,
    linewidth=3, 
    title="COVID-19 in Japan (death toll) \n data sourced by NHK (Japan Broadcasting Corporation)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths",
    legendfont=font(14), 
    label=["Japan" "Tokyo" "Osaka"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("nhk_japan_deaths.png") 
