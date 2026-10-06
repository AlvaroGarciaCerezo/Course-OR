* Course OR
* Álvaro García Cerezo
* 2026
* Lecture 2
* Exercise 5
*
* One time period is considered for the sake of simplicity.
* Neglect ramping limits along with start-up and shut-down costs.

options mip = cplex, optcr = 0;

sets
g   Generating units    /g1/
i   Intervals           /i1*i3/;

scalar
* Case a)
PD  Power demanded [MW] /80/
* Case b)
*PD  Power demanded [MW] /140/
* Case c)
*PD  Power demanded [MW] /260/
;

parameter CGF(g) fixed cost of generating unit g [€]
/
g1  10
/
;

parameter CGV(g,i) Variable cost of generating unit g associated with interval i [€\MWh]
/
g1.i1   0.35
g1.i2   0.10
g1.i3   0.20
/
;

parameter PGmin(g) Minimum power output of generating unit g [MW]
/
g1  30
/
;

parameter PGmax(g) Capacity of generating unit g [MW]
/
g1  300
/
;

parameter PGmaxI(g,i) Capacity of generating unit g associated with interval i [MW]
/
g1.i1   100
g1.i2   150
g1.i3   300
/
;

variables
zOF Objective function value [€]
;

positive variables
pG(g)       Power produced by generating unit g [MW]
pGI(g,i)    Power produced by generating unit g associated with interval i [MW]
;

binary variables
uG(g) Commitment status of generating unit g
;

equations
of  Objective function
eq1 Definition of pg
eq2 Upper limit of pGI
eq3 Lower limit of pG
eq4 Upper limit of pG
eq5 Energy balance equation
;
