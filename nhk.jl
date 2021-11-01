# nhk_data.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv","./csv/nhk_prefectures.csv");
download("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_domestic_daily_data.csv","./csv/nhk_japan.csv");

# Shape up the data.
Acsv=DataFrame(CSV.File("./csv/nhk_prefectures.csv", header=false, delim=','));
Jcsv=DataFrame(CSV.File("./csv/nhk_japan.csv", header=false, delim=','));
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

dd0=Date(2021,7,1);
DD=D-532;
ll0=string(dd0);
ll1=string(dd0+Day(Int(floor((DD-1)/2))));
ll2=string(dd0+Day(Int(floor(DD-1))));

# Japan (126M)
PJPN=125.36;
TJPN=J2/PJPN;
NJPN=zeros(D)
for j=1:7
    NJPN[j]=TJPN[j]/j;
end
for j=8:D
    NJPN[j]=(TJPN[j]-TJPN[j-7])/7;
end
DJPN=J3/PJPN;
NDJPN=zeros(D);
for j=1:7
    NDJPN[j]=(NDJPN[j]-NDJPN[1])/j;
end
for j=8:D
    NDJPN[j]=(DJPN[j]-DJPN[j-7])/7;
end

# Okinawa (1.46M): code 47
ROWOKNW=findall(x->x==47,A0);
POKNW=1.458870;    
TOKNW=A2[ROWOKNW]/POKNW;
NOKNW=zeros(D)
for j=1:7
    NOKNW[j]=TOKNW[j]/j;
end
for j=8:D
    NOKNW[j]=(TOKNW[j]-TOKNW[j-7])/7;
end
DOKNW=A3[ROWOKNW]/POKNW;
NDOKNW=zeros(D);
for j=1:7
    NDOKNW[j]=(NDOKNW[j]-NDOKNW[1])/j;
end
for j=8:D
    NDOKNW[j]=(DOKNW[j]-DOKNW[j-7])/7;
end

# Tokyo (14M): code 13,
PTKY=14.049146;
ROWTKY=findall(x->x==13,A0);
TTKY=A2[ROWTKY]/PTKY;
NTKY=zeros(D)
for j=1:7
    NTKY[j]=TTKY[j]/j
end
for j=8:D
    NTKY[j]=(TTKY[j]-TTKY[j-7])/7
end
DTKY=A3[ROWTKY]/PTKY;
NDTKY=zeros(D);
for j=1:7
    NDTKY[j]=(NDTKY[j]-NDTKY[1])/j;
end
for j=8:D
    NDTKY[j]=(DTKY[j]-DTKY[j-7])/7;
end

# Osaka (8.81M): code 27
POSK=8.798545;
ROWOSK=findall(x->x==27,A0);
TOSK=A2[ROWOSK]/POSK;
NOSK=zeros(D)
for j=1:7
    NOSK[j]=TOSK[j]/j
end
for j=8:D
    NOSK[j]=(TOSK[j]-TOSK[j-7])/7
end
DOSK=A3[ROWOSK]/POSK;
NDOSK=zeros(D);
for j=1:7
    NDOSK[j]=(NDOSK[j]-NDOSK[1])/j;
end
for j=8:D
    NDOSK[j]=(DOSK[j]-DOSK[j-7])/7;
end

# Hyogo (5.43M): code 28, 
PHYG=5.446455;
rowhyg=findall(x->x==28,A0);
THYG=A2[rowhyg]/PHYG;
NHYG=zeros(D)
for j=1:7
    NHYG[j]=THYG[j]/j
end
for j=8:D
    NHYG[j]=(THYG[j]-THYG[j-7])/7
end
DHYG=A3[rowhyg]/PHYG;
NDHYG=zeros(D);
for j=1:7
    NDHYG[j]=(NDHYG[j]-NDHYG[1])/j;
end
for j=8:D
    NDHYG[j]=(DHYG[j]-DHYG[j-7])/7;
end

# Hokkaido (5.27M): code 1, 
PHKD=5.207185;
ROWHKD=findall(x->x==1,A0);
THKD=A2[ROWHKD]/PHKD;
NHKD=zeros(D)
for j=1:7
    NHKD[j]=THKD[j]/j
end
for j=8:D
    NHKD[j]=(THKD[j]-THKD[j-7])/7
end
DHKD=A3[ROWHKD]/PHKD;
NDHKD=zeros(D);
for j=1:7
    NDHKD[j]=(NDHKD[j]-NDHKD[1])/j;
end
for j=8:D
    NDHKD[j]=(DHKD[j]-DHKD[j-7])/7;
end

# Chiba: code 12 
PCHB=6.282457;
ROWCHB=findall(x->x==12,A0);
TCHB=A2[ROWCHB]/PCHB;
NCHB=zeros(D)
for j=1:7
    NCHB[j]=TCHB[j]/j
end
for j=8:D
    NCHB[j]=(TCHB[j]-TCHB[j-7])/7
end
DCHB=A3[ROWCHB]/PCHB;
NDCHB=zeros(D);
for j=1:7
    NDCHB[j]=(NDCHB[j]-NDCHB[1])/j;
end
for j=8:D
    NDCHB[j]=(DCHB[j]-DCHB[j-7])/7;
end

p1=plot([TJPN TTKY TOKNW TOSK], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka"], 
    title="COVID-19: total cases per 1M \n data sourced by NHK (Japanese Public TV)",
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./nhk/nhk_cases.png") 

p2=plot([DJPN DTKY DOKNW DOSK DHYG DHKD], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    title="COVID-19: deaths per 1M \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./nhk/nhk_deaths.png") 

p3=plot([NJPN NTKY NOKNW NOSK], 
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average of new cases per 1M \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./nhk/nhk_new_cases.png") 

p4=plot([NDJPN NDTKY NDOKNW NDOSK NDHYG NDHKD], 
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./nhk/nhk_recent_deaths.png") 

plot(p1, p2, p3, p4, 
     layout=(2,2), 
     size=(1260,840), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("./nhk/nhk.png") 

