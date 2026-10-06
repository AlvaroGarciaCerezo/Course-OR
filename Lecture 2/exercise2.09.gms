* Course OR
* Álvaro García Cerezo
* 2026
* Lecture 2
* Exercise 9

options mip = cplex, optcr = 0;

sets
g       Generating units                        /g1*g3/
l       Transmission lines                      /l1*l5/
lOld(l) Existing generating units               /l1*l2/
lNew(l) Candidate generating units              /l3*l5/
n       Node                                    /n1*n3/
mapGN   Location of generating units            /g1.n1, g2.n2, g3.n2/
ref(n)  Reference node                          /n1/
t       Representative time periods             /t1/
;

Scalars
CLS     Load-shedding cost [€\MWh]  /100000/
CRF     Capital recovery factor     /0.10086/
CImax   Investment budget [€]       /40000/
M       Large constant              /1e4/
Sbase   Power base [MVA]            /100/
;
CLS = CLS*Sbase;

parameter Rho(t) Weight of representative time period t [h]
/
t1  8760
/
;

parameter CLI(l) Investment cost of transmission line l [€]
/
l3  100000
l4  80000
l5  250000
/
;

parameter CGV(g) Variable cost of generating unit g [€\MWh]
/
g1  10
g2  15
g3  8
/
;
CGV(g) = CGV(g)*Sbase;

parameter FR(l) Node from which the power flow goes through transmission line l
/
l1  1
l2  1
l3  1
l4  1
l5  2
/
;

parameter PD(n,t) Power demanded in node n and representative time period t [MW]
/
n1.t1   300
n2.t1   200
* Case a
n3.t1   450
* Case b
*n3.t1   460
* Case c
*n3.t1   470
/
;
PD(n,t) = PD(n,t)/Sbase;

parameter PGmax(g) Capacity of generating unit g [MW]
/
g1  300
g2  400
g3  500
/
;
PGmax(g) = PGmax(g)/Sbase;

parameter PLmax(l) Capacity of transmission line l [MW]
/
l1  200
l2  200
l3  250
l4  200
l5  300
/
;
PLmax(l) = PLmax(l)/Sbase;

parameter TO(l) Node towards which the power flow goes through transmission line l
/
l1  2
l2  3
l3  2
l4  3
l5  3
/
;

parameter XL(l) Reactance of transmission line l [p.u.]
/
l1  0.010
l2  0.020
l3  0.010
l4  0.020
l5  0.015
/
;

variables
zOF         Objective function value [€]
thetaN(n,t) Voltage angle in node n and representative time period t [rad] 
pL(l,t)     Power flow through transmission line l in representative time period t [p.u.]
;

positive variables
pG(g,t)     Power produced by generating unit g in representative time period t [p.u.]
pLS(n,t)    Load-shedding power in node n and representative time period t [p.u.]
;

binary variables
vL(l)       Binary variable associated with the investment in transmission line l

equations
of      Objective function
eq1     Investment cost limit
eq2     Energy balance equation
eq3     Upper limit of pG
eq4     Upper limit of pLS
eq5     Lower limit of pL for existing transmission lines
eq6     Upper limit of pL for existing transmission lines
eq7     Definition of pL for existing transmission lines
eq8     Lower limit of pL for candidate transmission lines
eq9     Upper limit of pL for candidate transmission lines
eq10    Lower limit of big M linearization
eq11    Upper limit of big M linearization
eq12    Definition of the reference node
;
