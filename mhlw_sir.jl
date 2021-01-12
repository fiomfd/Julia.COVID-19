# mhlw_sir.jl
######################

# Load packages.
using DifferentialEquations, Plots, Dates, HTTP, CSV, DataFrames

# Download data at the MHLW web site.
download("https://www.mhlw.go.jp/content/pcr_positive_daily.csv","pcr_positive_daily.csv");
download("https://www.mhlw.go.jp/content/recovery_total.csv","recovery_total.csv");

# Pick up information from the data.
Acsv=DataFrame(CSV.File("pcr_positive_daily.csv", header=false, delim=','));
Bcsv=DataFrame(CSV.File("recovery_total.csv", header=false, delim=','));
(pa,qa)=size(Acsv);
AAA=parse.(Float64,Acsv[2:pa,2]);
(pb,qb)=size(Bcsv);
BB=parse.(Float64,Bcsv[2:pb,2]);
aa=length(AA);
bb=length(BB);
dBBrow1=Date(2020,1,29);

# d0: the initial date. 
# T0=AA[aa] the total cases
# R0=BB[bb] the total discharged individuals
d0=dBBrow1+Day(bb-1);
AA=zeros(aa);
AA[1]=AAA[1];
for k=2:aa
    AA[k]=AAA[k]+AA[k-1]
end
T0=AA[aa];
R0=BB[bb];

# D: the simulation period [days] 
D=Float64(5*7);
# N: the total population
N=Float64(125710000);

# d2: 7 days befor the initial date
# T2: the total cases
# R2: the total discharged individuals 
T2=AA[aa-7];
R2=BB[bb-7];

# Set the constants beta and gamma in the SIR model
T1=(T0-T2)/7;
R1=(R0-R2)/7;
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,D);

# Set the SIR system of ordinary differential equations
f(u,p,t) = [beta*u[3]*(N-u[1]); gamma*u[3]; u[3]*(beta*(N-u[1])-gamma)];
# Set the initial data
u0=[T0;R0;T0-R0];
# Set the initial value problem
prob = ODEProblem(f,u0,tspan);

# Solve the initial value problem
sol = solve(prob);

# Plot the results. 
l0=string(d0);
l1=string(d0+Day(2*7));
l2=string(d0+Day(4*7));

plot(sol, 
    grid=false,
    linewidth=3, 
    title="SIR model for COVID-19 in Japan (126M)", 
    xlabel="",
    yaxis="population",
    label=["total cases" "discharged" "active cases"], 
    legend = :topleft)
plot!(xticks = ([0 2*7  4*7;], [l0 l1 l2]))
savefig("sir_mhlw.png") 
