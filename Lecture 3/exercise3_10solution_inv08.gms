* Course OR
* Álvaro García Cerezo
* 2026
* Lecture 3
* Exercise 10 - Investment plan obtained in exercise 8

options optcr = 0;

sets
c       Options of candidate generating units   /c1*c5/
d       Representative days                     /d1*d365/
g       Generating units                        /g1*g6/
gOld(g) Existing generating units               /g1*g3/
gNew(g) Candidate generating units              /g4*g6/
h       Hours                                   /h1*h24/
;

Scalars
CLS     Load-shedding cost [€\MWh]  /10000/
CRF     Capital recovery factor     /0.10086/
CImax   Investment budget [€]       /100000/
;

* Include the values of Rho(d) included in file dataRho_3_10.
$include dataRho_3_10.gms

parameter CGI(g) Investment cost of generating unit g [€\MW]
/
g4  2000
g5  3500
g6  2800
/
;

parameter CGV(g) Variable cost of generating unit g [€\MWh]
/
g1  13
g2  17
g3  10
g4  15
g5  8
g6  12
/
;

* Include the values of PD(d,h) included in file dataPD_3_10.
$include dataPD_3_10.gms

parameter PGmaxOld(g) Capacity of existing generating unit g [MW]
/
g1  300
g2  200
g3  150
/
;

parameter PGmaxNew(g,c) Maximum capacity of candidate generating unit g and option c [MW]
/
g4.c1   50
g4.c2   100
g4.c3   150
g5.c1   100
g5.c2   150
g5.c3   200
g5.c4   250
g6.c1   50
g6.c2   100
g6.c3   150
g6.c4   200
g6.c5   250
/
;

variables
zOF Objective function value [€]
;

positive variables
pG(g,d,h)   Power produced by generating unit g in representative day d and hour h [MW]
pGmax(g)    Capacity built of generating unit g [MW]
pLS(d,h)    Load-shedding power in representative day d and hour h [MW]
;

binary variables
vG(g,c)     Binary variable associated with the investment in option c of candidate generating unit g
;

equations
of  Objective function
eq1 Investment cost limit
eq2 Definition of pGmax
eq3 Upper limit of the sum of vG
eq4 Energy balance equation
eq5 Upper limit of pLS
eq6 Upper limit of pG for existing generating units
eq7 Upper limit of pG for candidate generating units
;

of..                    zOF =E= sum(d, Rho(d) * sum(h, CLS*pLS(d,h) + sum(g, CGV(g)*pG(g,d,h) ) ) ) + sum(g$gNew(g), CGI(g)*CRF*pGmax(g) );
eq1..                   sum(g$gNew(g), CGI(g)*CRF*pGmax(g) ) =L= CImax;
eq2(g)$gNew(g)..        pGmax(g) =E= sum(c, PGmaxNew(g,c)*vG(g,c) );
eq3(g)$gNew(g)..        sum(c, vG(g,c) ) =L= 1;
eq4(d,h)..              sum(g, pG(g,d,h) ) =E= PD(d,h) - pLS(d,h);
eq5(d,h)..              pLS(d,h) =L= PD(d,h);
eq6(g,d,h)$gOld(g)..    pG(g,d,h) =L= PGmaxOld(g);
eq7(g,d,h)$gNew(g)..    pG(g,d,h) =L= pGmax(g);

model exercise3_10 /all/;

* Fix the investment decisions.
pGmax.fx('g4') = 50;
pGmax.fx('g5') = 250;
pGmax.fx('g6') = 0;
solve exercise3_10 minimizing zOF using mip;

display zOF.L;
