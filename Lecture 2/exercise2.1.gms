* Course OR
* Álvaro García Cerezo
* 2026
* Lecture 2
* Exercise 1

options mip = cplex, optcr = 0;

sets
g Generating units      /g1*g2/
t Hourly time periods   /t1*t5/
;

parameter CGF(g) Fixed cost of generating unit g [€]
/
g1  4
g2  5
/
;

parameter CGSD(g) Shut-down cost of generating unit g [€]
/
g1  1
g2  0.5
/
;

parameter CGSU(g) Start-up cost of generating unit g [€]
/
g1  20
g2  15
/
;

parameter CGV(g) Variable cost of generating unit g [€\MWh]
/
g1  0.1
g2  0.15
/
;

parameter PD(t) Power demanded in time period t [MW]
/
t1  40
t2  200
t3  150
t4  300
t5  130
/
;

parameter PG0(g) Initial power produced of generating unit g [MW]
/
g1  0
g2  0
/
;

parameter PGmin(g) Minimum power output of generating unit g [MW]
/
g1  30
g2  40
/
;

parameter PGmax(g) Capacity of generating unit g [MW]
/
g1  300
g2  400
/
;

parameter RGD(g) Ramping-down limit of generating unit g [MW\h]
/
g1  120
g2  180
/
;

parameter RGSD(g) Shut-down ramping limit of generating unit g [MW\h]
/
g1  80
g2  100
/
;

parameter RGSU(g) Start-up ramping limit of generating unit g [MW\h]
/
g1  50
g2  60
/
;

parameter RGU(g) Ramping-up limit of generating unit g [MW\h]
/
g1  100
g2  120
/
;

parameter UG0(g) Initial commitment status of generating unit g
/
g1  0
g2  0
/
;

variables
zOF Objective function value [€]
;

positive variables
pG(g,t) Power produced by generating unit g in time period t [MW]
;

binary variables
uG(g,t) Commitment status of generating unit g in time period t
yG(g,t) Start-up status of generating unit g in time period t
zG(g,t) Shut-down status of generating unit g in time period t
;

equations
of  Objective function
eq1 Relationship of uG yG and zG
eq2 Constraint to impose that yG + zG <= 1
eq3 Lower limit of pG
eq4 Upper limit of pG
eq5 Ramping-up and start-up ramping limits
eq6 Ramping-down and shut-down ramping limits
eq7 Energy balance equation
;
