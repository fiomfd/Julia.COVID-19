# mhlw.jl
####################### 

# Load packages. 
using Plots, CSV, Dates, DataFrames, DifferentialEquations

# Download data from the MHLW web site. 
download("https://covid19.mhlw.go.jp/public/opendata/newly_confirmed_cases_daily.csv","mhlw_new_cases.csv");
download("https://covid19.mhlw.go.jp/public/opendata/confirmed_cases_cumulative_daily.csv","mhlw_cases.csv");
download("https://covid19.mhlw.go.jp/public/opendata/deaths_cumulative_daily.csv","mhlw_deaths.csv");
download("https://covid19.mhlw.go.jp/public/opendata/requiring_inpatient_care_etc_daily.csv","mhlw_recovered.csv");

Ncsv=DataFrame(CSV.File("mhlw_new_cases.csv", header=false, delim=','));
Ccsv=DataFrame(CSV.File("mhlw_cases.csv", header=false, delim=','));
Dcsv=DataFrame(CSV.File("mhlw_deaths.csv", header=false, delim=','));
Rcsv=DataFrame(CSV.File("mhlw_recovered.csv", header=false, delim=','));
(pa,qa)=size(Ccsv);
I1=Ncsv[4994:pa+4992,2];
N1=parse.(Float64,Ncsv[4994:pa+4992,3]);
C1=parse.(Float64,Ccsv[2:pa,3]);
D1=parse.(Float64,Dcsv[2:pa,3]);
R1=parse.(Float64,Rcsv[2:pa,4]);

d0=Date(2020,5,9)
D=Int64(floor((pa-1)/48));
df=d0+Day(D-1);
l0=string(d0);
l1=string(d0+Day(Int(floor((D-1)/4))));
l2=string(d0+Day(Int(floor((D-1)/2))));
l3=string(d0+Day(Int(floor(3*(D-1)/4))));
l4=string(df);

dd0=Date(2021,4,1);
DD=D-327;
ll0=string(dd0);
ll1=string(dd0+Day(Int(floor((DD-1)/2))));
ll2=string(dd0+Day(Int(floor(DD-1))));

# Japan 
ROWJPN=findall(x->x=="ALL",I1);
PJPN=125.36;
NJPN=N1[ROWJPN]/PJPN;
CJPN=C1[ROWJPN]/PJPN;
DJPN=D1[ROWJPN]/PJPN;
RJPN=R1[ROWJPN]/PJPN;
AJPN=CJPN-RJPN-DJPN;
NDJPN=zeros(Int(D-327));
for j=1:D-327
    NDJPN[j]=(DJPN[j+327]-DJPN[j+321])/7
end

# Tokyo
ROWTKY=findall(x->x=="Tokyo",I1);
PTKY=14.049146;
NTKY=N1[ROWTKY]/PTKY;
CTKY=C1[ROWTKY]/PTKY;
DTKY=D1[ROWTKY]/PTKY;
RTKY=R1[ROWTKY]/PTKY;
ATKY=CTKY-RTKY-DTKY;
NDTKY=zeros(Int(D-327));
for j=1:D-327
    NDTKY[j]=(DTKY[j+327]-DTKY[j+321])/7
end

# Okinawa
ROWOKNW=findall(x->x=="Okinawa",I1);
POKNW=1.458870;
NOKNW=N1[ROWOKNW]/POKNW;
COKNW=C1[ROWOKNW]/POKNW;
DOKNW=D1[ROWOKNW]/POKNW;
ROKNW=R1[ROWOKNW]/POKNW;
AOKNW=COKNW-ROKNW-DOKNW;
NDOKNW=zeros(Int(D-327));
for j=1:D-327
    NDOKNW[j]=(DOKNW[j+327]-DOKNW[j+321])/7
end

# Osaka
ROWOSK=findall(x->x=="Osaka",I1);
POSK=8.798545;
NOSK=N1[ROWOSK]/POSK;
COSK=C1[ROWOSK]/POSK;
DOSK=D1[ROWOSK]/POSK;
ROSK=R1[ROWOSK]/POSK;
AOSK=COSK-ROSK-DOSK;
NDOSK=zeros(Int(D-327));
for j=1:D-327
    NDOSK[j]=(DOSK[j+327]-DOSK[j+321])/7
end

# Hyogo
ROWHYG=findall(x->x=="Hyogo",I1);
PHYG=5.446455;
NHYG=N1[ROWHYG]/PHYG;
CHYG=C1[ROWHYG]/PHYG;
DHYG=D1[ROWHYG]/PHYG;
RHYG=R1[ROWHYG]/PHYG;
AHYG=CHYG-RHYG-DHYG;
NDHYG=zeros(Int(D-327));
for j=1:D-327
    NDHYG[j]=(DHYG[j+327]-DHYG[j+321])/7
end
 
# Hokkaido
ROWHKD=findall(x->x=="Hokkaido",I1);
PHKD=5.207185;
NHKD=N1[ROWHKD]/PHKD;
CHKD=C1[ROWHKD]/PHKD;
DHKD=D1[ROWHKD]/PHKD;
RHKD=R1[ROWHKD]/PHKD;
AHKD=CHKD-RHKD-DHKD;
NDHKD=zeros(Int(D-327));
for j=1:D-327
    NDHKD[j]=(DHKD[j+327]-DHKD[j+321])/7
end

q1=plot([CJPN AJPN RJPN], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (125.36M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
#
plot([CJPN AJPN RJPN], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (125.36M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhlw_japan.png") 

q2=plot([CTKY ATKY RTKY], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Tokyo (14.049146M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
#
plot([CTKY ATKY RTKY], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Tokyo (14.049146M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhlw_tokyo.png") 

q3=plot([COKNW AOKNW ROKNW], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Okinawa (1.458870M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
#
plot([COKNW AOKNW ROKNW], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Okinawa (1.458870M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhlw_okinawa.png") 

p1=plot([CJPN CTKY COKNW], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by MOH of Japan",
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
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by MOH of Japan", 
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
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)

p4=plot([NDJPN NDTKY NDOKNW NDOSK NDHYG NDHKD], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (7-day average deaths per 1M) \n data sourced by MOH of Japan", 
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
savefig("mhwl.png") 

plot([CJPN CTKY COKNW], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
    title="COVID-19 in Japan (total cases per 1M) \n data sourced by MOH of Japan",
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",    
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhwl_cases.png") 

plot([DJPN DTKY DOKNW DOSK DHYG DHKD], 
    grid=false,
    linewidth=2, 
    legendfont=font(10), 
    title="COVID-19 in Japan (deaths per 1M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="deaths/1M",
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"],
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhwl_deaths.png") 

plot([NJPN NTKY NOKNW], 
    grid=false,
    linewidth=1, 
    title="COVID-19 in Japan (daily new cases per 1M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/4)  floor(D/2) floor(3*D/4) D;], [l0 l1 l2 l3 l4]),
    xlabel="date",
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhwl_new_cases.png") 

plot([NDJPN NDTKY NDOKNW NDOSK NDHYG NDHKD], 
    grid=false,
    linewidth=2, 
    title="COVID-19 in Japan (7-day average deaths per 1M) \n data sourced by MOH of Japan", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(DD/2) DD;], [ll0 ll1 ll2]),
    xlabel="date",
    yaxis="deaths/1M",
    legendfont=font(10), 
    label=["Japan" "Tokyo" "Okinawa" "Osaka" "Hyogo" "Hokkaido"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhwl_recent_deaths.png") 


# 
# SIR
#
W=Float64(4*7);
w0=string(df);
w1=string(df+Day(2*7));
w2=string(df+Day(4*7));

# Japan
T0=CJPN[D];
R0=RJPN[D];
T2=CJPN[D-6];
R2=RJPN[D-6];
POP=1000000*PJPN;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(POP-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(POP-u[1]);u[2]*(beta*(POP-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));
#
q4=plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19/1M in Japan (125M) \n data sourced by MOH of Japan", 
    xlabel="date",
    xticks = ([0 2*7 4*7;], [w0, w1, w2]), 
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
#
plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19/1M in Japan (125M) \n data sourced by MOH of Japan", 
    xlabel="date",
    xticks = ([0 2*7 4*7;], [w0, w1, w2]), 
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhlw_sir_japan.png")

# Tokyo
T0=CTKY[D];
R0=RTKY[D];
T2=CTKY[D-6];
R2=RTKY[D-6];
POP=1000000;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(POP-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(POP-u[1]);u[2]*(beta*(POP-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));
#
q5=plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19/1M in Tokyo (14M) \n data sourced by MOH of Japan", 
    xlabel="date",
    xticks = ([0 2*7 4*7;], [w0, w1, w2]), 
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
#
plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19/1M in Tokyo (14M) \n data sourced by MOH of Japan", 
    xlabel="date",
    xticks = ([0 2*7 4*7;], [w0, w1, w2]), 
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhlw_sir_tokyo.png")

# Okinawa
T0=COKNW[D];
R0=ROKNW[D];
T2=COKNW[D-6];
R2=ROKNW[D-6];
POP=1000000;
T1=(T0-T2)/Float64(7);
R1=(R0-R2)/Float64(7);
beta=T1/(T0-R0)/(POP-T0);
gamma=R1/(T0-R0);
tspan=(0,W);
f(u,p,t) = [beta*u[2]*(POP-u[1]);u[2]*(beta*(POP-u[1])-gamma); gamma*u[2]];
u0=[T0;T0-R0;R0];
prob = ODEProblem(f,u0,tspan);
sol = solve(prob, maxiters=Int(1e6));
#
q6=plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19/1M in Okinawa (1.46M) \n data sourced by MOH of Japan", 
    xlabel="date",
    xticks = ([0 2*7 4*7;], [w0, w1, w2]), 
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
#
plot(sol, 
    grid=false,
    linewidth=3, 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    left_margin=Plots.Measures.Length(:mm, 5.0),
    title="SIR model for COVID-19/1M in Okinawa (1.46M) \n data sourced by MOH of Japan", 
    xlabel="date",
    xticks = ([0 2*7 4*7;], [w0, w1, w2]), 
    yaxis="cases/1M",
    legendfont=font(10), 
    label=["total cases" "active cases" "discharged"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("mhlw_sir_okinawa.png")

plot(q1, q2, q3, q4, q5, q6,  
     layout=(2,3), 
     size=(1680,840), 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0))
savefig("mhwl_sir.png") 