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
    NJPN[j]=TJPN[j]/j
end
for j=8:D
    NJPN[j]=(TJPN[j]-TJPN[j-7])/7
end
DJPN=J3/PJPN;
NDJPN=zeros(DD);
for j=1:DD
    NDJPN[j]=(DJPN[j+532]-DJPN[j+525])/7
end

# Okinawa (1.46M): code 47
ROWOKNW=findall(x->x==47,A0);
POKNW=1.458870;    
TOKNW=A2[ROWOKNW]/POKNW;
NOKNW=zeros(D)
for j=1:7
    NOKNW[j]=TOKNW[j]/j
end
for j=8:D
    NOKNW[j]=(TOKNW[j]-TOKNW[j-7])/7
end
DOKNW=A3[ROWOKNW]/POKNW;
NDOKNW=zeros(DD);
for j=1:DD
    NDOKNW[j]=(DOKNW[j+532]-DOKNW[j+525])/7
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
NDTKY=zeros(DD);
for j=1:DD
    NDTKY[j]=(DTKY[j+532]-DTKY[j+525])/7
end

# Osaka (8.81M): code 27
POSK=8.798545;
ROWOSK=findall(x->x==27,A0);
NOSK=A1[ROWOSK]/POSK;
TOSK=A2[ROWOSK]/POSK;
DOSK=A3[ROWOSK]/POSK;
NDOSK=zeros(DD);
for j=1:DD
    NDOSK[j]=(DOSK[j+532]-DOSK[j+525])/7
end

# Hyogo (5.43M): code 28, 
PHYG=5.446455;
rowhyg=findall(x->x==28,A0);
NHYG=A1[rowhyg]/PHYG;
THYG=A2[rowhyg]/PHYG;
DHYG=A3[rowhyg]/PHYG;
NDHYG=zeros(DD);
for j=1:DD
    NDHYG[j]=(DHYG[j+532]-DHYG[j+525])/7
end

# Hokkaido (5.27M): code 1, 
PHKD=5.207185;
ROWHKD=findall(x->x==1,A0);
NHKD=A1[ROWHKD]/PHKD;
THKD=A2[ROWHKD]/PHKD;
DHKD=A3[ROWHKD]/PHKD;
NDHKD=zeros(DD);
for j=1:DD
    NDHKD[j]=(DHKD[j+532]-DHKD[j+525])/7
end

p1=plot([TJPN TTKY TOKNW], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
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

p3=plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average of new cases per 1M \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Osaka" "Okinawa" "Hyogo" "Hokkaido"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./nhk/nhk_new_cases.png") 

p4=plot([NDJPN NDTKY NDOKNW NDOSK NDHYG NDHKD], 
    grid=false,
    linewidth=2, 
    title="COVID-19: 7-day average deaths per 1M \n data sourced by NHK (Japanese Public TV)", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
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

