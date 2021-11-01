# vac.jl
#######################

# Load packages. 
using Plots, CSV, Dates, DataFrames

# Download data from the MHLW web site. 
download("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/global_data/time_series_covid19_vaccine_global.csv","./csv/jhu_vaccinated.csv");

Vcsv=DataFrame(CSV.File("./csv/jhu_vaccinated.csv", header=false, delim=','));
(m,n)=size(Vcsv);
ROW=Vcsv[2:m,1];
UID=Vcsv[2:m,7];
VAC=Vcsv[2:m,5];

# Plot the data
# d0: the initial date
# df: the final day
d0=Date(2021,7,1)
d2=Date(Vcsv[m,2]);
diff = d2-d0; 
D = 1+Dates.value(diff)
d1=d0+Day(floor((D-1)/2));

l0=string(d0);
l1=string(d1);
l2=string(d2);

# Okinawa
POKNW=1.458870;

# Tokyo
PTKY=14.049146;

# Japan
PJPN=1253600
ROWJPN=findall(x->x=="Japan",ROW);
VACJPN=VAC[ROWJPN];
(DJPN,)=size(VACJPN);
FVACJPN=zeros(DJPN);
for j=1:DJPN
    FVACJPN[j]=parse(Float64,VACJPN[j]);
end
VJPN=FVACJPN[DJPN-D+1:DJPN]/PJPN;

# NSW
#PNSW=8.196;

# Brunei Darussalam
PBWN=0.442205;

# Indonesia
PIDN=2768332.06;
ROWIDN=findall(x->x=="Indonesia",ROW);
PVACIDN=VAC[ROWIDN];
PUIDIDN=UID[ROWIDN];
UIDIDN=findall(x->x=="360",PUIDIDN);
VACIDN=PVACIDN[UIDIDN];
(DIDN,)=size(VACIDN);
FVACIDN=zeros(DIDN);
for j=1:DIDN
    FVACIDN[j]=parse(Float64,VACIDN[j]);
end
VIDN=FVACIDN[DIDN-D+1:DIDN]/PIDN;


# South Korea
#PKOR=51.318552;

# Malaysia
PMYS=326600;
ROWMYS=findall(x->x=="Malaysia",ROW);
PVACMYS=VAC[ROWMYS];
PUIDMYS=UID[ROWMYS];
UIDMYS=findall(x->x=="458",PUIDMYS);
VACMYS=PVACMYS[UIDMYS];
(DMYS,)=size(VACMYS);
FVACMYS=zeros(DMYS);
for j=1:DMYS
    FVACMYS[j]=parse(Float64,VACMYS[j]);
end
VMYS=FVACMYS[DMYS-D+1:DMYS]/PMYS;

# Philippines
PPHI=1112491.16;
ROWPHI=findall(x->x=="Philippines",ROW);
VACPHI=VAC[ROWPHI];
(DPHI,)=size(VACPHI);
FVACPHI=zeros(DPHI);
for j=1:DPHI
    FVACPHI[j]=parse(Float64,VACPHI[j]);
end
VPHI=FVACPHI[DPHI-D+1:DPHI]/PPHI;

# Thailand
PTHA=700006.62;
ROWTHA=findall(x->x=="Thailand",ROW);
VACTHA=VAC[ROWTHA];
(DTHA,)=size(VACTHA);
FVACTHA=zeros(DTHA);
for j=1:DTHA
    FVACTHA[j]=parse(Float64,VACTHA[j]);
end
VTHA=FVACTHA[DTHA-D+1:DTHA]/PTHA;

# NSW
#PNSW=8.196;

# Brunei Darussalam
PBWN=0.442205;

# Singapore
#PSIN=5.902011;
# Sri Lanka
#PLKA=21.516097;
# United Staes 
#PUSA=333.225477;
# United Kingdom 
#PGBR=68.294438;
# Vietnam
#PVNM=98.341025;

plot([VJPN VPHI VIDN VMYS VTHA], 
    grid=false,
    linewidth=2, 
    title="COVID-19 fully vaccinated \n data sourced by JHU", 
    right_margin=Plots.Measures.Length(:mm, 10.0),
    xticks = ([1 floor(D/2) D;], [l0 l1 l2]),
    xlabel="date",
    yaxis="%",
    legendfont=font(8), 
    label=["Japan" "Philippines" "Indonesia" "Malaysia" "Thailand"], 
    palette = :seaborn_bright, 
    legend = :topleft)
savefig("./jhu/vaccination_asia.png") 
