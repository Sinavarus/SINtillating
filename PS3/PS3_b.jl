#Barituziga Banuna
#CHEME 7770 PS3 Part B

using LinearAlgebra

STOIC = 
[
0	0	0	-1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
-1	0	0	1	2	-2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
-1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0;
1	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	1	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0	0;
0	1	-1	0	-2	2	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	1	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
-1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0;
0	0	1	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	1	0	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0;
1	0	0	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0	0;
1	0	0	0	0	0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0;
0	0	0	0	2	-2	0	0	0	0	0	0	0	0	0	0	0	-1	0	0	0;
0	0	0	0	-4	4	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0;
0	0	0	0	-3	3	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0;
0	0	0	0	-3	3	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0;
0	0	0	0	3	-3	0	0	0	0	0	0	0	0	0	0	0	0	-1	0	0;
0	0	-1	0	4	-4	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	1
];

REACT = 
[
0	0	0	-1	0	0;
-1	0	0	1	2	-2;
-1	0	0	0	0	0;
1	-1	0	0	0	0;
0	1	0	0	0	0;
0	1	-1	0	-2	2;
0	0	1	-1	0	0;
-1	0	0	0	0	0;
0	0	1	0	0	0;
0	0	0	1	0	0;
1	0	0	0	0	0;
1	0	0	0	0	0;
0	0	0	0	2	-2;
0	0	0	0	-4	4;
0	0	0	0	-3	3;
0	0	0	0	-3	3;
0	0	0	0	3	-3;
0	0	-1	0	4	-4
];

TRANS = 
[
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	1	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	-1	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	1	0	0	0	0	0	0	0	0	0	0;
0	0	0	-1	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	-1	0	0	0	0	0	0	0;
0	0	0	0	0	-1	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	-1	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	-1	0	0	0;
0	0	0	0	0	0	0	0	1	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	1	0	0	0	0;
0	0	0	0	0	0	0	0	0	1	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	-1	0	0;
0	0	0	0	0	0	0	0	0	0	0	0	0	-1	1
];

ATOM = 
[
1	4	1	5	1	0;
6	13	3	3	0	0;
4	7	1	4	0	0;
10	18	4	6	0	0;
4	4	0	4	0	0;
6	14	4	2	0	0;
5	12	2	2	0	0;
10	16	5	13	3	0;
1	4	2	1	0	0;
0	3	0	4	1	0;
10	14	5	7	1	0;
0	4	0	7	2	0;
0	0	1	1	0	0;
0	0	0	2	0	0;
0	1	0	0	0	0;
21	30	7	17	3	0;
21	29	7	17	3	0;
0	2	0	1	0	0
];

E_reactions = transpose(ATOM)*REACT
E_transport = transpose(ATOM)*TRANS
E_stoic = transpose(ATOM)*STOIC

println("Reaction Set")
println(E_reactions)
println()
println("Transport Set")
println(E_transport)
println()
println("Stoiciometric Matrix")
println(E_stoic)