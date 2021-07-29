# mhlw.jl
#######################

# Load packages. 
using Plots, CSV, Dates, HTTP, DataFrames, DifferentialEquations

# Download data from the MHLW web site. 
download("https://www.mhlw.go.jp/content/pcr_positive_daily.csv","pcr_positive_daily.csv");
download("https://www.mhlw.go.jp/content/recovery_total.csv","recovery_total.csv");

# Shape up the data.
# N: the number of days 
# A[n]: total cases on the n-th day
# B[n]: the number of total discharged individuals on the n-the day
# C[n]=A[n]-B[n]: active cases and deaths  
Acsv=DataFrame(CSV.File("pcr_positive_daily.csv", header=false, delim=','));
Bcsv=DataFrame(CSV.File("recovery_total.csv", header=false, delim=','));
(pa,qa)=size(Acsv);
AA=parse.(Float64,Acsv[2:pa,2]);
(pb,qb)=size(Bcsv);
BB=parse.(Float64,Bcsv[2:pb,2]);
aa=length(AA);
bb=length(BB);

L=aa-16;
A=zeros(L);
B=zeros(L);
A17=zeros(17);
A17[1]=AA[1];
for l=2:17
    A17[l]=AA[l]+A17[l-1];
end
A[1]=A17[17];
for k=2:L
    A[k]=AA[16+k]+A[k-1];
end
for k=1:L
    B[k]=BB[k+3];
end
C=A-B;

# Plot the data
# d0: the initial date
# d0+Day(L-1): the date of update.
d0=Date(2020,2,1);
l0=string(d0);
l1=string(d0+Day(Int(floor((L-1)/3))));
l2=string(d0+Day(Int(floor(2*(L-1)/3))));
l3=string(d0+Day(L-1));
plot([A C B], 
     grid=false,
     linewidth=3, 
     title="COVID-19 in Japan (125M) \n data sourced by Japanese Ministry of Health", 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0),
     xlabel="date",
     xticks=([1 floor(L/3)  floor(2*L/3) L;], [l0 l1 l2 l3]),
     yaxis="cases",
     legendfont=font(14), 
     label=["total cases" "active cases" "discharged"], 
     palette = :seaborn_bright, 
     legend = :topleft)
savefig("mhlw_data.png") 

# d00: the initial date. 
# T0=AA[aa] the total cases
# R0=BB[bb] the total discharged individuals
dBBrow1=Date(2020,1,29);
d00=dBBrow1+Day(bb-1);
AS=zeros(aa);
AS[1]=AA[1];
for k=2:aa
    AS[k]=AA[k]+AS[k-1]
end
T0=AS[aa];
R0=BB[bb];

# D: the simulation period [days] 
D=Float64(4*7);
# N: the total population
N=Float64(125360000);

# d22: 7 days befor the initial date
# T2: the total cases
# R2: the total discharged individuals 
T2=AS[aa-7];
R2=BB[bb-7];

# Set the constants beta and gamma in the SIR model
T1=(T0-T2)/7;
R1=(R0-R2)/7;
beta=T1/(T0-R0)/(N-T0);
gamma=R1/(T0-R0);
tspan=(0,D);

# Set the SIR system of ordinary differential equations
f(u,p,t) = [beta*u[2]*(N-u[1]); u[2]*(beta*(N-u[1])-gamma); gamma*u[2]];
# Set the initial data
u0=[T0;T0-R0;R0];
# Set the initial value problem
prob = ODEProblem(f,u0,tspan);

# Solve the initial value problem
sol = solve(prob);

# Plot the results. 
l00=string(d00);
l11=string(d00+Day(2*7));
l22=string(d00+Day(4*7));

plot(sol, 
     grid=false,
     linewidth=3, 
     title="SIR model for COVID-19 in Japan (125M)\n data sourced by Japanese Ministry of Health", 
     left_margin=Plots.Measures.Length(:mm, 5.0),
     right_margin=Plots.Measures.Length(:mm, 15.0),
     top_margin=Plots.Measures.Length(:mm, 5.0),
     bottom_margin=Plots.Measures.Length(:mm, 5.0),
     xlabel="date",
     xticks = ([0 2*7  4*7;], [l00 l11 l22]),
     yaxis="cases",
     legendfont=font(14), 
     label=["total cases" "active cases" "discharged"], 
     palette = :seaborn_bright, 
     legend = :right)
savefig("mhlw_sir.png") 
