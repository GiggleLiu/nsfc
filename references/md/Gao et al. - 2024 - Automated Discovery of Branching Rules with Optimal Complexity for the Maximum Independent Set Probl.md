**AUTOMATED DISCOVERY OF BRANCHING RULES WITH**
**OPTIMAL COMPLEXITY FOR THE MAXIMUM INDEPENDENT**
**SET PROBLEM** _[∗]_


XUAN-ZHAO GAO _[†]_, YI-JIA WANG _[‡]_, PAN ZHANG _[§]_, AND JIN-GUO LIU _[¶]_


**Abstract.** The branching algorithm is a fundamental technique for designing fast exponentialtime algorithms to solve combinatorial optimization problems exactly. It divides the entire solution
space into independent search branches using predetermined branching rules, and ignores the search
on suboptimal branches to reduce the time complexity. The complexity of a branching algorithm is
primarily determined by the branching rules it employs, which are often designed by human experts.
In this paper, we show how to automate this process with a focus on the maximum independent set
problem. The main contribution is an algorithm that efficiently generate optimal branching rules for a
given sub-graph with tens of vertices. Its efficiency enables us to generate the branching rules on-thefly, which is provably optimal and significantly reduces the number of branches compared to existing
methods that rely on expert-designed branching rules. Numerical experiment on 3-regular graphs
shows an average complexity of _O_ (1 _._ 0441 _[n]_ ) can be achieved, better than any previous methods.


**Key words.** Branching algorithm, Maximum independent set problem, Theorem proving


**AMS subject classifications.** 90C27, 05C69, 68V15


**1. Introduction.** The branching algorithm [39], also called the branch-andbound algorithm, is a standard scheme to produce exact solutions to combinatorial
optimization problems [41]. Its main idea is to divide the solution space into smaller
regions, and conquer each subproblem independently and recursively. Since its birth
in 1960s [31], the branching algorithm has been applied to solving many NP-hard
problems [38], such as the integer programming [32, 29, 22], the maximum satisfiability (MAX-SAT) problem [33, 1, 7], and the traveling salesman problem (TSP) [16, 10].
It is safe to say that at least half of the published fast exponential time algorithms
are based on this scheme [21].
One of the most successful applications of the branching algorithm is exactly
solving the maximum independent set (MIS) problem [43]. With a given graph, the
MIS problem asks for the largest set of vertices such that no two vertices are adjacent.
The MIS problem is classified as NP-complete [38], indicating that no algorithm can
solve it in polynomial time unless P = NP. Furthermore, if the exponential time


_∗_ Submitted to the editors DATE.
**Funding:** This work is partially funded by the National Key R&D Program of China
(Grant No. 2024YFE0102500), National Natural Science Foundation of China (No. 12404568,
12047503, 12325501 and 12247104), the Guangzhou Municipal Science and Technology Project
(No. 2023A03J00904), and project ZDRW-XX-2022-3-02 of the Chinese Academy of Sciences. P.Z.
is partially supported by the Innovation Program for Quantum Science and Technology project
2021ZD0301900.

_†_ Thrust of Advanced Materials, The Hong Kong University of Science and Technology
(Guangzhou), Guangdong, China; and Department of Physics, The Hong Kong University of Science
[and Technology, Hong Kong SAR, China (xz.gao@connect.ust.hk).](mailto:xz.gao@connect.ust.hk)

_‡_ CAS Key Laboratory for Theoretical Physics, Institute of Theoretical Physics, Chinese Academy
of Sciences, Beijing 100190, China; and School of Physical Sciences, University of Chinese Academy
[of Sciences, Beijing 100049, China (wangyijia@itp.ac.cn), contributed equally with Xuan-Zhao Gao](mailto:wangyijia@itp.ac.cn)
to this work.
_§_ CAS Key Laboratory for Theoretical Physics, Institute of Theoretical Physics, Chinese Academy
of Sciences, Beijing 100190, China; and School of Fundamental Physics and Mathematical Sciences,
[Hangzhou Institute for Advanced Study, UCAS, Hangzhou 310024, China (panzhang@itp.ac.cn).](mailto:panzhang@itp.ac.cn)

_¶_ Thrust of Advanced Materials, The Hong Kong University of Science and Technology
[(Guangzhou), Guangdong, China (jinguoliu@hkust-gz.edu.cn).](mailto:jinguoliu@hkust-gz.edu.cn)


1


2


hypothesis holds true, it is widely believed that solving it in sub-exponential time is
impossible [13, 26]. The branching algorithm gives the state-of-the-art complexity of
_O_ (1 _._ 1996 _[n]_ ) [48], where _n_ is the number of vertices in the graph. By upper bounding
the vertex degrees, an even lower complexity can be achieved. For example, the MIS
problem on the 3-regular graphs can be solved in time _O_ (1 _._ 0836 _[n]_ ) [45, 47]. The
branching algorithm studies a given graph by assuming some vertices to be in or out
of the independent set, and then recursively solves each smaller subproblem under
that assumption. Branching rules play a central role in making assumptions. Usually,
the algorithm prepares a fixed table of rules such as the mirror rule [19], the satellite
rule [30], and more specialized rules [28, 19, 9, 42]. The algorithm inspects a subgraph and implements the best-fit rule to divide the solution space into smaller ones.
The complexity of a branching algorithm is typically expressed as _O_ ( _γ_ _[n]_ ), where _γ >_ 1
represents the _branching factor_ . A good set of _branching rules_ gives a smaller _γ_, which
leads to a faster algorithm.
However, these methods exhibit two disadvantages. First, they rely on a fixed
set of rules, which requires human experts to design [47, 48]. Second, these rules are
generic and not optimal for every specific sub-graph under analysis. To address these
issues, we propose to branch in an on-the-fly manner, i.e. automatically generate
branching rules for each sub-graph under consideration, rather than relying on a
finite set of predefined rules. With a branching rule tailored for the given sub-graph,
a provably optimal _γ_ and a faster algorithm can be achieved.
In this paper, an algorithm for automatically generating optimal branching rules
for a given sub-graph is developed, which exhibits provably optimal complexity, i.e.
generating the smallest _γ_ among all possible branching rules. The algorithm first
resolves the local constraints of a sub-graph with existing numerical tools. By establishing a connection between the problem of finding the optimal branching rules and a
weighted minimum set covering problem (WMSC), the optimal branching rule can be
efficiently resolved through integer programming or its linear programming relaxation.
With the MIS problem, we demonstrate that the larger the sub-graph the algorithm
analyzes, the more effective the generated branching rule becomes. By limiting the
sub-graph to the 2-distance neighborhood of a vertex, the numerical result shows a
clear advantage compared to existing methods in terms of reducing the number of
branches. We also show how the developed tool can be used in theorem proving to
reduce human effort. In the past, the efforts to automate the branching algorithm
are mainly focused on dynamically determining branching variables [4, 18]. To the
best of our knowledge, our method is the first one that can dynamically generate new
branching rules based on the variables under consideration.
The rest of the paper is structured as follows. In Section 2, we introduce the
preliminaries of the branching algorithm and the MIS problem. In Section 3, we
show the details of the proposed method and its application to the MIS problem. In
Section 4, we show several examples to demonstrate the effectiveness of the proposed
method in discovering the branching rule. In Section 5, numerical results are provided
to show the efficiency of the proposed method in practice. Finally, we conclude the
paper in Section 6.


**2. Preliminaries.** In this section, we introduce the basic concepts and notations
to be used in this article, including the maximum independent set (MIS) problem,
and the branching algorithm.


**2.1. Maximum Independent Set (MIS) problem.** In graph theory, a graph
_G_ is represented as a tuple of vertices _V_ ( _G_ ) and edges _E_ ( _G_ ). The neighbors of a


3


vertex _v_ in graph _G_ is _N_ ( _v_ ) _⊆_ _V_ ( _G_ ) and the neighbors of a set of vertices _S ⊆_ _V_ ( _G_ )
is _N_ ( _S_ ) = [�] _v∈S_ _[N]_ [(] _[v]_ [)] _[ \][ S]_ [. To simplify the discussion, we also introduce the closed]

neighbor of _S_ as _N_ [ _S_ ] = _N_ ( _S_ ) _∪_ _S_ . Similarly, the _k_ -th order neighbors of _v_ is denoted
as _Nk_ ( _v_ ) = _N_ ( _Nk−_ 1[ _v_ ]), where _N_ 1[ _v_ ] = _N_ [ _v_ ] and _Nk_ [ _v_ ] = _Nk_ ( _v_ ) _∪_ _Nk−_ 1[ _v_ ]. An
independent set of a graph _G_ is a subset of vertices _I ⊆_ _V_ ( _G_ ) such that no two vertices
of _I_ are direct neighbors, i.e. _v, w ∈_ _I ⇒_ _v /∈_ _N_ ( _w_ ). A maximum independent set
(MIS) is an independent set of maximum cardinality, and its size is denoted as _α_ ( _G_ ).
Finding an independent set with size _α_ ( _G_ ) is known as the maximum independent set
problem, which is an NP-hard problem [38]. In the following discussion, we represent
a subset of _V_ as a bit string _**s**_ _V ∈{_ 0 _,_ 1 _}_ _[|][V][ |]_, where _si_ = 1 if the _i_ -th vertex is in the
set, and _si_ = 0 otherwise.


**2.2. The Branching Algorithm.** The branching algorithm is a general algorithmic framework for solving combinatorial optimization problems, including the
MIS problem. It iteratively constructs the solution by breaking the problem down
into smaller sub-problems and then solves the sub-problems independently. To break
down the problem of finding an MIS of a given graph _G_, the branching algorithm
checks the constraints on a sub-graph _R ⊆_ _G_ that is represented as a triple of the
vertex set _V_ ( _R_ ) _⊆_ _V_ ( _G_ ), edge set _E_ ( _R_ ) _⊆_ _E_ ( _G_ ) and the boundary vertices connected
to the rest part of the graph _∂R ⊆_ _V_ ( _R_ ). These constraints determine the specific
subset of the 2 _[|][V]_ [ (] _[R]_ [)] _[|]_ local configurations that require further exploration, referred to
as the _relevant_ configurations in the subsequent discussion. A branching strategy
decides how to divide the search space to get the relevant configurations explored
efficiently. As we denoted a configuration as a bit string, a branching strategy for
bitstring searching can be concisely represented as a boolean formula in disjunctive
normal form (DNF):


Definition 2.1 (Branching strategy for bitstring searching). _A branching strat-_
_egy for bitstring searching denoted as δ, is a function that maps a subgraph R to a_
_boolean formula in disjunctive normal form (DNF) D_ = _c_ 1 _∨_ _c_ 2 _∨_ _. . ._ _∨_ _c|D|, where each_
_clause ck_ = _l_ 1 _∧_ _l_ 2 _∧_ _. . . ∧_ _l|V_ ( _ck_ ) _| is associated with a branch, in which a positive or_
_negative literal li_ = _v or li_ = _¬v represents the vertex v ∈_ _V_ ( _R_ ) _is or isn’t in the set._
_Here, V_ ( _ck_ ) _is the set of vertices involved in the k-th clause ck._


Here, we use a DNF with _|D|_ clauses to divide the solution space into _|D|_ subproblems, each with a reduced problem size due to fixing the values of variables
involved in the clause. In the independent set problem, the size reduction comes
from two aspects: the variables involved in the clause, and the neighbors of the
vertices in the set. Let us denote the vertices associated with a positive literal as
_T_ ( _ck_ ) _⊆_ _V_ ( _ck_ ). Then the problem size reduction should take into account the removal of vertices _V_ ( _ck_ ) _∪_ _N_ ( _T_ ( _ck_ )) and the branching rule corresponding to _δ_ is
_α_ ( _G_ ) = max( _{α_ ( _G\_ ( _V_ ( _ck_ ) _∪_ _N_ ( _T_ ( _ck_ )))) + _|T_ ( _ck_ ) _| | ck ∈D}_ ). To quantify the problem size reduction, we introduce the measure _ρ_ of problem complexity on a graph _G_,
under which the branching complexity is defined as follows:


Definition 2.2 (Branching complexity of MIS). _Given a graph G, a measure_
_of the computational complexity ρ and a branching rule D_ = _c_ 1 _∨_ _c_ 2 _∨_ _. . . ∨_ _c|D|, the_
_branching complexity γ ≥_ 1 _for D is determined by the following relation:_



(2.1) _γ_ _[ρ]_ [(] _[G]_ [)] =



_|D|_

- _γ_ _[ρ]_ [(] _[G]_ [)] _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] _._


_i_ =1



_where the difference of the measure by the i-th clause is defined as_ ∆ _ρ_ ( _ci_ ) = _ρ_ ( _G_ ) _−_


4


_ρ_ ( _G_ _\_ ( _N_ ( _T_ ( _ci_ )) _∪_ _V_ ( _ci_ ))) _, and_ _**b**_ ( _δ, R_ ) = (∆ _ρ_ ( _c_ 1) _,_ ∆ _ρ_ ( _c_ 2) _, . . .,_ ∆ _ρ_ ( _c|D|_ )) _is the branch-_
_ing vector. The optimal branching rule is defined as the one that minimizes branching_
_complexity._


The branching algorithm induced by the branching strategy _δ_ is summarized
in Algorithm 2.1. Its overall complexity is upper bound by the maximum branching
complexity of the branching rules used in the algorithm. The choice of the complexity
measure is highly related to the performance of the algorithm. In this work, two
complexity measures are used, one is the number of vertices in the graph, i.e. _ρ_ ( _G_ ) =
_|V |_, and the other is defined as _ρ_ ( _G_ ) = [�] _v∈V_ [max] _[{]_ [0] _[, d]_ [(] _[v]_ [)] _[ −]_ [2] _[}]_ [, where] _[ d]_ [(] _[v]_ [) =] _[ |][N]_ [(] _[v]_ [)] _[|]_

is the degree of vertex _v_ . In the second measure, a graph with maximum degree 2
has complexity 0. It is because the MIS problem on such a graph can be solved in
polynomial time. Although the vertices selecting strategy `select_subgraph` is also
important for the performance of the branching algorithm, it will not be the focus of
this article.


**Algorithm 2.1** The Branching algorithm for MIS: `mis_branch`
**Input:** The input graph _G_ and the branching strategy _δ_
**Output:** The maximum independent set size _α_ ( _G_ )
**function** `mis_branch(` _G, δ_ `)`

_R ←_ `select_subgraph` ( _G_ ); `// select by some strategy`
_D ←_ _δ_ ( _R_ )
_α ←−∞_
**foreach** clause _c in D_ **do**

_αc ←_ `mis_branch` ( _G \_ ( _V_ ( _c_ ) _∪_ _N_ ( _T_ ( _c_ ))) _, δ_ ) + _|T_ ( _c_ ) _|_
**if** _αc > α_ **then**
_α ←_ _αc_

**return** _α_


**3. Numerical Methods for Optimal Branching.** In this section, we will
introduce our method for finding the optimal branching rule. Since we have formalized
the branching rules as a logic expression in DNF in Definition 2.1, naively, we can
search through all _valid_ logic expressions in DNF, and then evaluate the branching
complexity for each rule to find the optimal one. In the following, we will give a clear
definition of a valid logic branching rule by introducing the concept of the reduced
_α_ -tensor, the minimum subset of local configurations that need to be explored in the
MIS problem. Finally, we will show how to convert the optimal branching problem
to a weighted minimum set covering problem, which can be solved efficiently using
linear programming.


**3.1. Boundary-grouped MISs.** We first introduce the concept of the _α-tensor_
of a subgraph _R_ in _G_ . The _α_ -tensor can be interpreted as a generalization of the scalar
_α_ ( _G_ ), which denotes the MIS size of a graph _G_ .


Definition 3.1 ( _α_ -tensor [35]). _Let R be a subgraph in G and ∂R its inner_
_boundary vertices. The α-tensor of R,_ _**α**_ ( _R_ ) _, is a tensor of rank |∂R|, whose element_
_**α**_ ( _R_ ) _**s**_ _∂R is the size of the largest independent set of R, while fixing the boundary_
_configuration_ _**s**_ _∂R ∈{_ 0 _,_ 1 _}_ _[|][∂R][|]_ _. If the boundary-vertex configuration_ _**s**_ _∂R itself violates_
_the independent set constraint, the corresponding α-tensor element is set to_ _**α**_ ( _R_ ) _**s**_ _∂R_ =
_−∞._


5


This _α_ -tensor is not ideal for designing branching rules, since it unnecessarily
contains many elements that are irrelevant to finding an MIS. In Appendix A, we
show that these irrelevant elements can be removed without leading to a non-optimal
solution. The reduced _α_ -tensor is defined as follows:


Definition 3.2 (reduced _α_ -tensor). _Let_ _**α**_ ( _R_ ) _be an α-tensor for a subgraph R_
_of G, its corresponding reduced α-tensor_ ˜ _**α**_ ( _R_ ) _is defined by setting all entries in_ _**α**_ ( _R_ )
_that correspond to configurations that are irrelevant to finding an MIS to −∞._


Note that each finite element in the reduced _α_ -tensor is associated with a boundary configuration _**s**_ _∂R ∈{_ 0 _,_ 1 _}_ _[|][∂R][|]_, and each such configuration corresponds to one
or more configurations on _V_ ( _R_ ) with the same local MIS size. We group all relevant
local configurations by the boundary configuration as the _boundary-grouped MISs SR_ :


Definition 3.3 (boundary-grouped MISs). _A boundary-grouped MISs on R is a_
_set, each element S_ _**s**_ _∂R being a set of configurations on V_ ( _R_ ) _with the same boundary_
_configuration_ _**s**_ _∂R and the local MIS size_ ˜ _α_ ( _R_ ) _**s**_ _∂R_ _, i.e._


_SR_ = _{S_ _**s**_ _∂R |_ _**s**_ _∂R ∈{_ 0 _,_ 1 _}_ _[|][∂R][|]_ _,_ ˜ _α_ ( _R_ ) _**s**_ _∂R ̸_ = _−∞},_

(3.1)
_S_ _**s**_ _∂R_ = _{_ _**s**_ _|_ Con( _{_ _**s**_ _,_ _**s**_ _∂R}_ ) _,_ ˜ _α_ ( _R_ ) _**s**_ _∂R_ = _|T_ ( _**s**_ ) _|},_


_where_ Con( _{_ _**s**_ _,_ _**s**_ _∂R}_ ) _denotes that the configuration_ _**s**_ _is consistent with the boundary_
_configuration_ _**s**_ _∂R._







_**s**_ _abcde_


_S_ 000 = _{_ 00001 _,_ 00010 _}_


_S_ 001 = _{_ 00101 _}_


_S_ 010 = _{_ 01010 _}_


_S_ 111 = _{_ 11100 _}_


(b)



clauses in _D_


_¬a ∧¬b ∧¬d ∧_ _e_


_¬a ∧_ _b ∧¬c ∧_ _d ∧¬e_


_a ∧_ _b ∧_ _c ∧¬d ∧¬e_







(a)



Fig. 1: Applying a MIS branching strategy on a sub-graph _R_ of the parent graph
_G_ . (a) A sub-graph _R_, with boundary vertices _∂R_ = _{a, b, c}_, where the dashed lines
indicate their connections to vertices in the environment _G\R_ . (b) The left side shows
the boundary-grouped MISs _SR_ = _{S_ 000 _, S_ 001 _, S_ 010 _, S_ 111 _}_ of the sub-graph _R_ . Each
row represents a set _S_ _**s**_ _∂R_ of relevant configurations with the boundary configuration
_**s**_ _∂R_ . The right side shows the clauses in the resulting optimal branching _D_ = _δ_ ( _R_ ).


**Example: Reduced** _α_ **-tensor and boundary-grouped MISs**

The reduced _α_ -tensor of the sub-graph shown in Figure 1 is shown in the following
table. Each row is associated with a boundary-vertex configuration _**s**_ _∂R ∈{_ 0 _,_ 1 _}_ [3] .
The _α_ -tensor is shown in the second column, which corresponds to the local MIS
size of the sub-graph _R_ under the boundary configuration _**s**_ _∂R_ . The third column shows the reduced _α_ -tensor, where the irrelevant entries are set to _−∞_ .
The relevant configurations in the fourth column form the boundary-grouped MISs
_SR_ = _{{_ 00001 _,_ 00010 _}, {_ 00101 _}, {_ 01010 _}, {_ 11100 _}}_ .


6

|s<br>abc|α(R)<br>s∂R|α˜(R)<br>s∂R|s<br>abcde|Configuration index|
|---|---|---|---|---|
|000<br>001<br>010<br>011<br>100<br>101<br>110<br>111|1<br>2<br>2<br>2<br>1<br>2<br>2<br>3|1<br>2<br>2<br>_−∞_<br>_−∞_<br>_−∞_<br>_−∞_<br>3|00001_,_ 00010<br>00101<br>01010<br>-<br>-<br>-<br>-<br>11100|1<br>2<br>3<br>-<br>-<br>-<br>-<br>4|



Table 1: The _α_ -tensor (Definition 3.1) (second column) and the reduced _α_ -tensor
(Definition 3.2) ˜ _**α**_ ( _R_ ) (third column) for the sub-graph _R_ in Figure 1. Each row
corresponds to a local MIS size associated with the boundary-vertex configuration
_**s**_ _abc_ (first column). The fourth column lists the corresponding relevant configurations producing the tensor elements.


Theorem 3.4. _The boundary-grouped MISs SR of a sub-graph R can be obtained_
_in time_ min( _O_ (2 [tw(] _[R]_ [)] ) _, O_ (1 _._ 4423 _[|][V]_ [ (] _[R]_ [)] _[|−|][∂R][|]_ 2 _[|][∂R][|]_ )) _, where R is completion of R by_
_adding a vertex that connecting to all the boundary vertices of R and_ tw( _R_ ) _is the_
_tree-width of R._


_Proof._ The two time complexities are from two methods to obtain the boundarygrouped MISs, the generic tensor network method [34] and a branching algorithm
respectively. The computational complexity of the generic tensor network method is
determined by the topology of the tensor network. For the independent set problem
with open boundary, the complexity of contracting a tensor network is related to
the tree-width of the graph _R_ as _O_ (2 [tw(] _[R]_ [)] ) [37]. The boundary-grouped MISs can
also be obtained with the `mis1` algorithm [21], which has time complexity _O_ (1 _._ 4423 _[n]_ )
for a graph with _n_ vertices. For each of the 2 _[|][∂R][|]_ boundary configurations, a MIS
problem of size _≤|V_ ( _R_ ) _| −|∂R|_ is solved, rendering an overall time complexity
_O_ (1 _._ 4423 _[|][V]_ [ (] _[R]_ [)] _[|−|][∂R][|]_ 2 _[|][∂R][|]_ )).


Empirically, the tensor-network-based approach is favored by sparse graphs and
geometric graphs, since they have small tree widths [20]. The branching algorithm is
favored by the graph with high connectivity, since the branching complexity on vertex
_v_ is related to its degree _d_ ( _v_ ) as _γ ∼_ _d_ ( _v_ ) [1] _[/d]_ [(] _[v]_ [)], i.e. the larger _d_ ( _v_ ), the smaller _γ_ for
_d_ ( _v_ ) _≥_ 3.


**3.2. Optimal Branching via Set Covering.** In this section, we show how
to obtain the optimal branching rule given the boundary-grouped MISs _SR_ . Let
_R_ be a sub-graph to be considered. By fixing the boundary vertices configuration
_**s**_ _∂R_, the optimal solutions in _R_ and the rest part of the graph _G \ R_ are decoupled,
where _G \ R_ denotes the induced subgraph of _V_ ( _G_ ) _\ V_ ( _R_ ). The global maximum
independent set can be obtained by taking an arbitrary maximum independent set
from each of the two components. One naive strategy of branching is by boundary
configurations in _SR_ . For each boundary configuration _**s**_ _∂R_, we create a branch by
fixing the local configurations to an arbitrary configuration in _S_ _**s**_ _∂R_ . Interestingly,
although this strategy fully utilizes the sparsity of reduced _α_ -tensor, it turns out to
be non-optimal with high probability. To achieve optimality, we must allow some
variables in _V_ ( _R_ ) to be undecided in the current branch. Recall that a branching rule
_D_ is a boolean formula in DNF, we just need to search the space of a boolean formula


7


in DNF and choose a _valid_ one with the lowest branching complexity.


Definition 3.5 (Valid branching rule). _A branching rule D is valid on SR if and_
_only if for any set S_ _**s**_ _∂R ∈SR, there exists a configuration_ _**s**_ _V_ ( _R_ ) _∈_ _S_ _**s**_ _∂R that satisfies_
_D, denoted as S_ _**s**_ _∂R ⊢D._

It corresponds to the requirement that for each _S_ _**s**_ _∂R ∈SR_, at least one of its
elements must be explored in one of the branches. Finding the optimal branching
rule via brute-force search is impractical, as the number of boolean formulas in DNF
grows super-exponentially as _O_ (2 [3] _[|][V]_ [ (] _[R]_ [)] _[|]_ ). In the following, we show that enumerating
all valid boolean formulas in DNF can be done efficiently by formulating the problem
as a WMSC problem.


Definition 3.6 (Weighted minimum set covering problem). _A weighted mini-_
_mum set covering (WMSC) problem is a triple_ ( _U, S, w_ ) _, where U is a set of elements,_
_S is a collection of subsets of U_ _, and w is a weight function that assigns a non-negative_
_weight to each element in S. The goal is to find a subset I ⊆S that covers all elements_
_in U and minimizes the total weight of the selected subsets._


To construct a valid branching rule, we first prepare a set of candidate clauses
_C_ . Here, we emphasize that not all 3 _[|][V]_ [ (] _[R]_ [)] _[|]_ possible clauses on _V_ ( _R_ ) can be used in
the optimal branching rule, e.g. if clause _ca_ covers the same set of items in _SR_ with
less number of literals than clause _cb_, then _ca_ can not be used for constructing the
optimal branching rule. One possible way to filter out the infeasible clauses is through
Algorithm 3.1. The algorithm starts with constructing clauses satisfied by exactly one
configuration in one of _S_ _**s**_ _∂R ∈SR_ . This is achieved by the function `single_cover`
that takes a configuration _**s**_ as input and returns a clause _c_ given by

      - ( _v_ if _sv_ = 1 else _¬v_ ) _._


_v∈V_ ( _R_ )


Then, the algorithm iteratively takes the intersection of the clauses with the previously constructed clauses to form new clauses. The function `intersection` takes two
clauses as input and returns a new clause that contains the common literals of the
two clauses. For example, `intersection` ( _¬a ∧_ _b ∧_ _c, ¬a ∧_ _b ∧¬c ∧_ _d_ ) = _¬a ∧_ _b_, such
that any configuration satisfying the two input clauses will also satisfy the new clause.
Although both _¬a_ and _b_ are also satisfied by the same set of configurations, they are
not selected since only the clause with the longest length is kept. This exclusion significantly reduces the number of candidate clauses without sacrificing the optimality
of the branching rule.
Then we represent a candidate solution _D_ as a disjunction of a subset of clauses
in _C_, and the subset can be denoted as a bit string _**x**_ _∈{_ 0 _,_ 1 _}_ _[|C|]_, where we use _xi_ = 1
to denote the _i_ -th clause is included in _D_, and _xi_ = 0 otherwise. To relate the optimal
branching rule with the WMSC problem, we associate each candidate clause _ci_ with
an integer set _Ji_ = _{j | Sj ⊢_ _ci, j_ = 1 _, . . ., |SR|}_ to indicate the elements in _SR_ that
can be satisfied by _ci_ . Then finding the branching rule with the minimum complexity
can be formulated as the following optimization problem:



min s.t.
_γ,_ _**x**_ _[γ]_



_|C|_





- _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] _xi_ = 1 _,_


_i_ =1



(3.2)

        - _Ji_ = _{_ 1 _,_ 2 _, . . ., |SR|}_







_i_ =1 _,...,|C|_
_xi_ =1


8


**Algorithm 3.1** Generating candidate clauses: `candidate_clauses`
**Input:** The boundary-grouped MISs _SR_
**Output:** The candidate clauses _C_
**function** `candidate_clauses(` _SR_ `)`

_C ←∅_
_T ←∅_
**foreach** set of configurations _S in SR_ **do**

**foreach** configuration _**s**_ _in S_ **do**

_c ←_ `single_cover` ( _**s**_ )
_C ←C ∪{c}_
_T ←T ∪{c}_


**while** _T ̸_ = _∅_ **do**

_c ←_ `pop` ( _T_ )
**foreach** set of configurations _S in SR_ **do**

**foreach** configuration _**s**_ _in S_ **do**

_c_ _[′]_ = `intersection` ( _c,_ `single_cover` ( _**s**_ ))
**if** _c_ _[′]_ = _∅_ and _c_ _[′]_ _∈C/_ **then**

_C ←C ∪{c_ _[′]_ _}_
_T ←T ∪{c_ _[′]_ _}_


**return** _C_


where ∆ _ρ_ ( _ci_ ) is the reduction of the problem size in the branch induced by the clause
_ci_ . The first constraint ensures that the branching complexity is the same as the _γ_
defined in Definition 2.2 and the second constraint ensures that the branching rule
explores all the configurations in _SR_ and is valid. To solve Equation (3.2), we first
consider a dual problem: given a fixed branching complexity _γ_, find a solution to _**x**_
that satisfies



_Ji_ = _{_ 1 _,_ 2 _, . . ., |SR|}._



(3.3) min
_**x**_



_|C|_





- _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] _xi_ s.t. 

_i_ =1 _i_ =1 _,...,_



_i_ =1 _,...,|D|_
_xi_ =1



It corresponds to the following WMSC problem (see Definition 3.6):


(3.4) ( _{_ 1 _,_ 2 _, . . ., |SR|}, {J_ 1 _, J_ 2 _, . . ., J|C|}, i �→_ _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] ) _,_


where the weight function is _w_ ( _i_ ) = _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] . With an oracle to solve this problem,
we show the minimum branching complexity _γ_ can be resolved to very high precision
in logarithmic time.


Theorem 3.7. _Let R be a subgraph of G, the branching strategy δ_ ( _R_ ) _with the_
_smallest branching complexity γ can be approximated to precision ϵ in time O_ (log( _ϵ_ _[−]_ [1] )) _._


_Proof._ We define an indicator function _σ_ ( _γ_ ) that returns 1 if the WMSC problem
in Equation (3.4) renders a valid solution, and 0 otherwise:



(3.5) _σ_ ( _γ_ ) =




1 _,_ if _∃_ _**x**_ _[∗]_ _,_ s.t. [�] _**x**_ _[∗]_ _i_ _[|C|]_ =1satisfying the constraints in _[γ][−]_ [∆] _[ρ]_ [(] _[c]_ _i_ _[∗]_ [)] _x_ _[∗]_ _i_ _[≤]_ [1][, where] Equation (3.4)


0 _,_ otherwise _._


9


_σ_ ( _γ_ ) is a step function that monotonically increases with _γ_, the transition point of
which can be found by bisecting the interval [1 _,_ 2] in _O_ (log( _ϵ_ _[−]_ [1] )) time. This transition
point is the minimum branching complexity _γ_ .


The Theorem 3.7 provides an logarithmic time method to obtain an approximation of the minimum branching complexity _γ_ . However, an exact solution is desired
in practice to ensure the optimality of the branching rule. In practice, we utilize
a fixed point iteration method to directly obtain the exact solution of the WMSC
problem, allowing us to converge on the minimum value of _γ_ . This approach is preferred over the logarithmic time method outlined in Theorem 3.7. The corresponding
algorithm is summarized in Algorithm 3.2. The function `boundary_grouped` returns
the boundary-grouped MISs for _R_, which can be implemented with the generic tensor
network method or the most basic branching algorithm as discussed in Theorem 3.4.
The function `wmsc_solver` solves the WMSC problem in Equation (3.2). Although
this problem is NP-complete, it can be solved efficiently in practice by reducing it to
an integer programming problem as will be discussed in the following section. In each
iteration, the solver provides a valid solution _**x**_ for the WMSC problem, parameterized
by _γ_ old. Subsequently, we determine a new value of _γ ≤_ _γ_ old that satisfies the equation

- _|D|_
_i_ =1 _[γ][−]_ [∆] _[ρ]_ [(] _[x][i]_ [)] _[x][i]_ [ = 1][, using a root-finding subroutine. Since the left-hand side of this]
equation is monotonically decreasing within the interval [1 _,_ 2], we can guarantee the
existence and uniqueness of the root. We then update _γ_ old with this new value of
_γ_ and proceed to the next iteration. The minimum value of _γ_ is precisely identified
when both _γ_ and _**x**_ converge to the same value during the fixed point iteration. For
a comprehensive proof of convergence, please refer to Appendix B.


**Algorithm 3.2** The optimal branching strategy: _δ_
**Input:** The input graph _G_ and a sub-graph _R ⊆_ _G_
**Output:** The optimal branching _D_ on _R_
**function** _δ_ `(` _G, R_ `)`

_S ←_ `boundary_grouped` ( _R_ )
_C ←_ `candidate_clauses` ( _S_ )
_**J**_ _←{{j | Sj ⊢_ _ci, j_ = 1 _, . . ., |SR|} | ci ∈C}_
`// search for the optimal branching complexity` _γ_
_γ ←_ 2
_γold ←∞_
**while** _γ < γold_ **do**

`// The triple` ( _{_ 1 _, . . ., |SR|},_ _**J**_ _, i �→_ _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] ) `defines a WMSC problem`
_**x**_ _←_ `wmsc_solver` ( _{_ 1 _, . . ., |SR|},_ _**J**_ _, i �→_ _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] )
_γold ←_ _γ_
_γ ←_ `find_root` ( [�] _[|C|]_ _i_ =1 _[γ][−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] _[x][i][ −]_ [1 = 0)]



_D ←_ 
_i_ =1 _,...,|C|_
_xi_ =1

**return** _D_



_ci_



**Example: Optimal branching**

Continuing the previous example, we consider how to obtain the optimal branching
for the boundary-grouped MISs in Table 1. For simplicity, here we use the number
of vertices as the measure, i.e. ∆ _ρ_ ( _ci_ ) = _|V_ ( _ci_ ) _∪_ _N_ ( _T_ ( _ci_ )) _|_ and ignore the removal


10


of vertices outside of _R_, which provides a lower bound for the reduction. Then we
list the corresponding candidate clauses in Table 2. It can be easily verified that
the solution of the WMSC problem in Equation (3.4) is _c_ 4 _∨_ _c_ 5 _∨_ _c_ 7. It is a valid
cover of all configuration indices: _J_ 4 _∪_ _J_ 5 _∪_ _J_ 7 = _{_ 1 _,_ 2 _,_ 3 _,_ 4 _}_, and the corresponding
branching complexity is the root of the following equation:


(3.6) _γ_ _[−]_ [5] + _γ_ _[−]_ [5] + _γ_ _[−]_ [4] = 1 _,_

|672.|Col2|Col3|Col4|
|---|---|---|---|
|_i_|_Ji_|_ci_|∆_ρ_(_ci_)|
|1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14|_{_1_}_<br>_{_1_}_<br>_{_2_}_<br>_{_3_}_<br>_{_4_}_<br>_{_1_,_ 2_}_<br>_{_1_,_ 2_}_<br>_{_1_,_ 3_}_<br>_{_1_,_ 3_}_<br>_{_2_,_ 4_}_<br>_{_3_,_ 4_}_<br>_{_1_,_ 2_,_ 3_}_<br>_{_1_,_ 2_,_ 4_}_<br>_{_1_,_ 3_,_ 4_}_|_¬a ∧¬b ∧¬c ∧¬d ∧e_<br>_¬a ∧¬b ∧¬c ∧d ∧¬e_<br>_¬a ∧b ∧¬c ∧d ∧¬e_<br>_¬a ∧¬b ∧c ∧¬d ∧e_<br>_a ∧b ∧c ∧¬d ∧¬e_<br>_¬a ∧¬c_<br>_¬a ∧¬c ∧d ∧¬e_<br>_¬a ∧¬b ∧¬d ∧e_<br>_¬a ∧¬b_<br>_b ∧¬e_<br>_c ∧¬d_<br>_¬a_<br>_¬e_<br>_¬d_|5<br>5<br>5<br>5<br>5<br>2<br>4<br>4<br>2<br>2<br>2<br>1<br>1<br>1|



Table 2: The candidate clauses for the boundary-grouped MISs in Table 1. The
first column is the index of the candidate clause, the second column is the set of
configuration indices (see the last column of Table 1) covered by the clause, the
third column is the boolean expression of the clause, and the fourth column is the
reduction of measure ∆ _ρ_ ( _ci_ ) by the corresponding clause.


**3.3. Solving WMSC Problem via Integer Programming.** In this section,
we will show how to solve the WMSC problem in Definition 3.6. Let us consider the
specific WMSC problem defined in Equation (3.4), we can convert it to an integer
programming problem:



_|C|_

- _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] _xi,_


_i_ =1


_|C|_

 - _xi ≥_ 1 _, ∀j_ = 1 _,_ 2 _, . . ., |SR|,_

_i_ =1 _,j∈Ji_



(3.7)



min


s.t.



_xi ∈{_ 0 _,_ 1 _}, ∀i_ = 1 _,_ 2 _, . . ., |C|._


The boolean variables _xi_ indicate whether the set _Ji_ is chosen or not in the WMSC
problem. The objective function is the sum of the weights of the selected sets, and the
linear constraints ensure that each element in _SR_ is covered by at least one selected set.
Although the integer programming problem is NP-hard, it can be effectively addressed
in practice using the Julia package `JuMP.jl` [14, 36], which utilizes `SCIP` [3, 2] as its
backend. This combination is recognized as one of the fastest non-commercial solvers


11


for mixed integer programming (MIP). Typically, it enables us to solve a WMSC
problem exactly with about 10 [3] sets in less than 10 _[−]_ [2] seconds. However, it is mainly
based on the branch-and-bound algorithm, so that is exponential in time in the worst
case. In cases involving larger-scale problems, the integer programming formulation
can be relaxed to a linear programming problem by substituting the binary variables
_xi_ with continuous variables constrained to the range 0 _≤_ _xi ≤_ 1:



_|C|_

- _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] _xi,_


_i_ =1


_|C|_

 - _xi ≥_ 1 _, ∀j_ = 1 _,_ 2 _, . . ., |SR|,_

_i_ =1 _,j∈Ji_



(3.8)



min


s.t.



0 _≤_ _xi ≤_ 1 _, ∀i_ = 1 _,_ 2 _, . . ., |C|._


The solution _**x**_ of the linear programming problem can be interpreted as probability,
and we randomly pick the clauses in _C_ that satisfy all constraints. It turns out to
be a good approximation to the integer programming problem as we will show in
the Section 5. Unlike integer programming, a linear programming problem can be
solved in time polynomial to the problem size [12]. In our implementation, we use
the simplex algorithm [40] to solve the linear programming problem provided by the
`HiGHS` [25] solver.


**4. Branching Rule Discovery.** In this section, we will show how our method
can be applied to automatic rule discovery with a few examples, including recovering
the established rules and discovering new rules. We show how the optimal branching
rule discovery can help theorem proving by improving the branching rules for some
bottleneck cases.


**4.1. Rediscovery of established rules.** Existing branching algorithms are
constructed based on a variety of manually derived heuristic rules. As one of them,
the domination rule is an important rule for solving the MIS problem, which is also
part of the `mis2` algorithm in Ref. [21].


Lemma 4.1 (The Domination rule). _Let G_ = ( _V, E_ ) _be a graph, v and w be adja-_
_cent vertices of G such that N_ [ _v_ ] _⊆_ _N_ [ _w_ ] _. Then_


(4.1) _α_ ( _G_ ) = _α_ ( _G \ w_ ) _._


We will show how the optimal branching can automatically capture this rule by
considering the subgraph shown in Figure 2. Observing that _N_ [ _v_ ] _⊆_ _N_ [ _w_ ], according
to the domination rule, the vertex _w_ can be discarded. In our method, we first generate
the reduced _α_ -tensor and the boundary-grouped candidate local MISs, which is given
in Table 3. These configurations render a WMSC problem, and by solving it, we
obtain the optimal DNF _¬w_ since _Ssjkl ⊢¬w_ for all effective _sjkl_, which is consistent
with the domination rule.


**4.2. Discovery of optimal rules.** In this subsection, we will show how our
method can automatically discover the optimal branching rule for a given subgraph,
resulting in lower branching complexity compared to the state-of-the-art branching
algorithm in Ref. [27]. We will use the example of PH2 (comprising a **p** entagon and a
**h** exagon sharing **2** edges) in Ref. [27] to demonstrate that our method achieves a better _γ_ than their heuristic rules. As illustrated in Fig. 3, PH2 is a subgraph comprising


12







Fig. 2: An example subgraph, where the _j_, _k_, _l_ are the boundary vertices. It satisfies
the condition of domination rule, where _N_ [ _v_ ] _⊆_ _N_ [ _w_ ].

|s<br>jkl|α˜(R)<br>s∂R|s<br>wvjkl|
|---|---|---|
|000<br>010<br>101<br>111|1<br>2<br>2<br>3|01000, 10000<br>01010<br>00101<br>00111|



Table 3: The finite-valued elements of reduced _α_ -tensor ˜ _**α**_ ( _R_ ) for _R_ in Figure 2.


8 vertices _a_ - _h_, where the vertices _a_, _c_, _d_, _f_, _g_ and _h_ serve as _∂R_ . For such 3-regular
graphs, we applied a commonly used measure given by _ρ_ ( _G_ ) = [�] _v∈V_ [max] _[{]_ [0] _[, d]_ [(] _[v]_ [)] _[−]_ [2] _[}]_ [,]

since the vertices with _d_ ( _v_ ) = 1 _,_ 2 can be directly removed via graph rewriting [47].
Here, we emphasize that the problem size reduction ∆ _ρ_ ( _ci_ ) should also take into
account the vertices in _N_ 2[ _R_ ], since the possible removal for vertices in _N_ 1[ _R_ ] may
decrease the degrees for vertices in _N_ 2( _R_ ). As an example, we talk about a neighborhood where no well-established rules exist, assume that the vertices within _N_ 1( _R_ ) are
neither connected to each other nor share common neighbors, and that each vertex in
_N_ 2[ _R_ ] has a degree of 3. Without losing generality, we use the tree-like environment
_N_ 3[ _R_ ] shown in Fig. 3. It has been shown that for this subgraph, the heuristic rule [27]
obtained manually can reach a branching complexity of 1 _._ 0718, with a branching vector of _{_ 10 _,_ 10 _}_ .

|s<br>acdfgh|α˜(R)<br>s∂R|s<br>abcdefgh|Configuration index|
|---|---|---|---|
|010100<br>000010<br>001001<br>110101<br>101101|3<br>3<br>3<br>4<br>4|00101100<br>01001010<br>01010001<br>10100101<br>10010101|1<br>2<br>3<br>4<br>5|



Table 4: The finite-valued elements of reduced _α_ -tensor ˜ _**α**_ ( _R_ ) for _R_ = PH2 in Fig. 3.


It turns out to be not optimal. To show this, we start with the reduced _α_ -tensor
and the boundary-grouped MISs for the PH2 subgraph as illustrated in Table 4.


13















Fig. 3: The example of PH2 (composed of a **p** entagon and a **h** exagon sharing **2** edges)
with a tree-like neighborhood. The vertices connected by dashed lines indicate their
connections to vertices in the further environment.

|i|J<br>i|c<br>i|∆ρ(c )<br>i|
|---|---|---|---|
|1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17|_{_1_}_<br>_{_2_}_<br>_{_3_}_<br>_{_4_}_<br>_{_5_}_<br>_{_1_,_ 2_}_<br>_{_1_,_ 3_}_<br>_{_1_,_ 4_}_<br>_{_2_,_ 3_}_<br>_{_3_,_ 5_}_<br>_{_4_,_ 5_}_<br>_{_1_,_ 2_,_ 3_}_<br>_{_1_,_ 2_,_ 4_}_<br>_{_1_,_ 4_,_ 5_}_<br>_{_2_,_ 3_,_ 5_}_<br>_{_3_,_ 4_,_ 5_}_<br>_{_1_,_ 3_,_ 4_,_ 5_}_|_¬a ∧¬b ∧c ∧¬d ∧e ∧f ∧¬g ∧¬h_<br>_¬a ∧b ∧¬c ∧¬d ∧e ∧¬f ∧g ∧¬h_<br>_¬a ∧b ∧¬c ∧d ∧¬e ∧¬f ∧¬g ∧h_<br>_a ∧¬b ∧c ∧¬d ∧¬e ∧f ∧¬g ∧h_<br>_a ∧¬b ∧¬c ∧d ∧¬e ∧f ∧¬g ∧h_<br>_¬a ∧¬d ∧e ∧¬h_<br>_¬a ∧¬g_<br>_¬b ∧c ∧¬d ∧f ∧¬g_<br>_¬a ∧b ∧¬c ∧¬f_<br>_¬c ∧d ∧¬e ∧¬g ∧h_<br>_a ∧¬b ∧¬e ∧f ∧¬g ∧h_<br>_¬a_<br>_¬d_<br>_¬b ∧f ∧¬g_<br>_¬c_<br>_¬e ∧¬g ∧h_<br>_¬g_|18<br>16<br>18<br>22<br>22<br>10<br>8<br>16<br>10<br>16<br>18<br>4<br>4<br>10<br>4<br>10<br>4|



Table 5: The candidate clauses for the boundary-grouped MISs in Table 4.


Then we generate all candidate clauses _C_ = _{c_ 1 _, c_ 2 _, . . ., c_ 17 _}_ as shown in Table 5. The
_Ji_ column indicates the configuration indices covered by _ci_ and the ∆ _ρ_ ( _ci_ ) column
indicates the reduction in the graph measure in the branch induced by _ci_ . Finally, by
solving the WMSC problem, we obtain the optimal branching rule _D_ = _c_ 2 _∨_ _c_ 8 _∨_ _c_ 10
with branching vector = _{_ 16 _,_ 16 _,_ 16 _}_ . The corresponding _γ_ = 1 _._ 0711, which is smaller


14


than 1 _._ 0718 of the heuristic rule as shown in Table 6.

|Col1|D|branching vector|γ|
|---|---|---|---|
|Manual rule in Ref. [27]|_c_9_ ∨c_14|_{_10_,_ 10_}_|1.0718|
|Optimal rule|_c_2_ ∨c_8_ ∨c_10|_{_16_,_ 16_,_ 16_}_|1.0711|



Table 6: Branching rules obtained by different methods.


**4.3. Broadening the finite rule set.** Another example is from Ref. [47], which
gives the lowest complexity of _O_ (1 _._ 0836 _[n]_ ) for 3-regular graphs. The rule with the
highest complexity, or the _bottleneck case_ of the algorithm is illustrated in Figure 4. In
the original paper, it is a multistep rule. In the first step, one takes _D_ = ( _a_ ) _∨_ ( _¬a_ ). Its
corresponding branching vector is _{_ 4 _,_ 10 _}_, and the branching complexity is of 1 _._ 1120.
Then in the next step, a _fine structure_ will appear, and the branching rule with lower
complexity can be applied. Such multistep branching gives an overall _γ_ = 1 _._ 0836.





























Fig. 4: The example of the bottleneck case in Ref. [47]. The neighborhood of _R_ is
chosen to be tree-like.


Here, we also consider a special case where _N_ 3[ _R_ ] is tree-like. When applying
our method, this structure generates 71 entries in the reduced- _α_ -tensor and 15782
candidate clauses. This seemingly large integer programming problem can be solved


15


in a few seconds due to the easy problem structure. The resulting optimal branching
rule on _R_ yields the branching vector _{_ 10 _,_ 16 _,_ 26 _,_ 26 _}_ with a complexity of _γ_ = 1 _._ 0817,
which is lower than that of the multistep branching. Although this tree-like environment is considered a hard instance for multistep branching, we admit that the optimal
branching does not consider all possible choices of the environment. A rigorous proof
of having a lower complexity is left as a future work.


**5. On-the-fly branch-and-reduce.** This section presents a numeric method
that utilizes the optimal branching algorithm for solving the MIS problem. Its performance is benchmarked against existing methods across various graphs, including
3-regular graphs, Erdos-Renyi graphs and geometric graphs. Additionally, the performance of its LP relaxation is also examined. Our methods are implemented based
on the Julia Programming Language [8] and are open-sourced on GitHub [23]. A
comprehensive technical guide is available in Appendix D.


**5.1. The algorithm.** We improve the branch-and-reduce algorithm by including our optimal branching algorithm to generate the branching rules on-the-fly. A
branch-and-reduce algorithm contains two building blocks: reduction and branching.
Reduction is a graph rewriting process that replaces specific sub-graphs with smaller
ones. The simplest reduction is the d1/d2 reduction that only handles degree 1 and 2
vertices. Although some reduction rules such as the d1 reduction and the dominance
rule that only involve vertex removal can be automatically discovered by our optimal
branching algorithm, reduction rules that requires more sophisticated rewriting fail to
fit into the branching framework. Therefore, we still need to borrow the existing reduction rules from the previous methods. The reduction rules and branching algorithms
used in this study are listed in Table 7. Two different sets of additional reduction
rules are used. They are the Xiao’s rules that are used in Ref. [47] and the packing
rule from Ref. [5]. Since reduction does not increase the number of branches, it is a
free-to-use resource. Branching is performed exclusively when no further reduction
is feasible. The choice of vertex set for branching (the function `select_subgraph` )
is more flexible than the previous methods. A heuristic vertex selection strategy is
used, where we check each vertex _v_ and its neighborhood _N_ 2[ _v_ ], and branch over the
region with the fewest boundary vertices.


**5.2. Comparison with the existing methods.** As shown in Table 7, two
state-of-the-art methods are compared with our method. The `xiao2013` [47] is tailored
for 3-regular graphs, which possesses the lowest theoretical computational complexity
of _O_ (1 _._ 0836 _[n]_ ). As we will show later, its practical performance is much better than
the theoretical complexity. The `akiba2015` and `akiba2015+xiao&packing` [5] are
from the winning solver of the minimum vertex cover (the same as MIS) problem in
the exact track at the PACE 2019 challenge [24]. We use the total number of branches
as our metric, which reflects how much the branching algorithm can prune the search
space. The performance is tested over 4 types of graphs: 3-regular graphs, ErdosRenyi graphs, King’s subgraphs [15], and grid graphs. For the Erdos-Renyi graphs,
we set the average degree to _d_ = 3, while for the King’s sub-graphs and grid graphs,
we select a filling rate of _f_ = 0 _._ 8. The results of this comparison are presented in
Figure 5, where each data point represents the geometric average of results from 1,000
runs conducted on randomly generated graphs.
We fitted the average branching factor _γ_ with the above data and present the results in Table 8. For 3-regular graphs, we find the algorithms `ob` and `ob+xiao` reduce
the average complexity to _O_ (1 _._ 0457 _[n]_ ) and _O_ (1 _._ 0441 _[n]_ ), respectively, outperforming the


16














|Branching<br>Algorithms<br>Reduction<br>Rules|Optimal<br>Branching<br>(this work)|Xiao 2013 [47]|Akiba 2015 [5]|
|---|---|---|---|
|d1/d2 reduction|`ob`||`akiba2015`|
|d1/d2 reduction<br>Xiao’s rules [47]|`ob+xiao`|`xiao2013`||
|d1/d2 reduction<br>Xiao’s rules<br>packing rule [5]|||`akiba2015+`<br>`xiao&packing`|



Table 7: The various branch-and-reduce algorithms used in this study. Different rows
correspond to different reduction rules and different columns correspond to different
branching algorithms. `ob+xiao` excludes the packing rule since it can be automatically
discovered by our optimal branching algorithm.


`xiao2013` ’s _O_ (1 _._ 0487 _[n]_ ). Furthermore, `ob+xiao` consistently produces fewer branches
than `xiao2013` across all tested problem sizes. In other graphs, `ob` demonstrates
superior performance compared to `akiba` when using only d1/d2 reduction in both
cases. Additionally, despite using fewer reduction rules, `ob+xiao` achieves a performance comparable to that of `akiba2015+xiao&packing` . These results affirm the
effectiveness and generality of the optimal branching rule generation algorithm across
a variety of graphs, regardless of whether they are bounded or unbounded, geometric
or non-geometric. While the above study is based on the average case, the worst-case
performances are presented in Appendix C, revealing conclusions that align closely
with those observed in the average case.

```
               ob+ akiba2015+
           ob xiao2013 akiba2015
               xiao xiao&packing
```

3-regular graphs 1.0457 1.0441 1.0487   -   Erdos-Renyi graphs 1.0011 1.0002  - 1.0044 1.0001
King’s sub-graphs 1.0116 1.0022  - 1.0313 1.0019
Grid graphs 1.0012 1.0009   - 1.0294 1.0007


Table 8: The average branching factor _γ_ for the branch-and-reduce algorithms in
Table 7 on different graphs. These results are obtained by fitting the data Figure 5.


The high performance of on-the-fly branching also comes from the flexible vertex
selection strategy. Our selection strategy simply selects the second order neighborhood
with the fewest boundary vertices, which is a larger region with a small boundary. This
implies more internal constraints, making it more likely to yield effective branching
rules. Moreover, there is a room to further improve the vertex selection strategy, e.g.
we can select a long chain as the branching region instead of limiting to the second
order neighborhood. In the past, we do not have this freedom since we need to detect
the mirrors [21], satellites [30], and other structures that only live in the second order
neighborhood.


17



10 [4]


10 [3]


10 [2]


10 [1]


10 [6]


10 [4]


10 [2]


10 [0]



3-regular graphs


50 100 150 200


Number of vertices


King’s subgraphs


200 400 600


Number of vertices



10 [2]


10 [1]


10 [0]


10 [4]


10 [3]


10 [2]


10 [1]


10 [0]



Erdos-Renyi graphs


500 1 _,_ 000


Number of vertices


Grid graphs


0 1 _,_ 000 2 _,_ 000


Number of vertices


```
      xiao2013 ob ob+xiao akiba2015 akiba2015+xiao&packing

```

Fig. 5: The average number of branches produced by various algorithms on different
graphs as functions of the graph size.


**5.3. LP relaxation.** While the integer programming solver is already efficient
enough for us to generate the rules on-the-fly, by relaxing the integer programming to
linear programming, we can further speed up the generation of the branching rules.
While linear programming is convex and can be solved in polynomial time, it does
not guarantee the optimal solution for the WMSC problem, potentially resulting in a
higher branching factor. The relaxation of `ob` and `ob+xiao` are denoted as `ob_relax`
and `ob_relax+xiao`, respectively, and the results are presented in Figure 6. It is
confirmed that the linear programming relaxation results in an increased number of
branches, however, the difference is small across all tested problems.


**6. Conclusion.** In this paper, we present a framework to automatically generate
provably optimal branching rules for constraint satisfaction problems, and implement
it to solve the maximum independent set problems better. We also show that this
framework can generate better branching rules than the existing ones, which could
be used to improve the complexity bound of existing branch-and-bound algorithms.


18



10 [4]


10 [3]


10 [2]


10 [1]


10 [2]


10 [1]


10 [0]



3-regular graphs


50 100 150 200


Number of vertices


King’s subgraphs


200 400 600


Number of vertices



10 [1]


10 [0]


10 [1]


10 [0]



Erdos-Renyi graphs


500 1 _,_ 000


Number of vertices


Grid graphs


0 1 _,_ 000 2 _,_ 000


Number of vertices


```
            ob ob+xiao ob_relax ob_relax+xiao

```

Fig. 6: The average number of branches produced by `ob`, `ob_relax`, `ob+xiao`, and
`ob_relax+xiao` on different graphs as functions of the graph size.


We also implement the on-the-fly optimal branching algorithm. Numerical results on
3-regular graphs show an advantage compared with state-of-the-art algorithms, even
though no predefined branching rule is used.
Although the proposed algorithm can generate the optimal branching rule on
sub-graphs with tens of nodes, it is not the end of improving the branch-and-bound
algorithm. The vertex selection strategy, the measure function, the way to truncated
candidate clauses, and pre-processing with graph rewriting are all potential research
directions to further improve the performance of the branch-and-bound algorithm.
The source code under the MIT license is available at the GitHub repository [23], and
a technical guide about how to use the code is available at Appendix D.
In the future, we expect this framework can be extended to a variety of combinatorial optimization challenges, including the Vertex Cover problem [46], the Max-SAT
problem [11], and the Traveling Salesman Problem [16]. More importantly, it may
also be used in propositional proof and resolution [44, 6] to improve the performance
of logic reasoning.


19


**Acknowledgments.** The authors thank Huanhai Zhou, Kaiwen Jin, and Zisong
Shen for helpful discussions. We acknowledge the use of AI tools like Grammarly and
ChatGPT for sentence rephrasing and grammar checks.


REFERENCES


[1] A. Abrame and D. Habet, _Ahmaxsat: Description and evaluation of a branch and bound_
_Max-SAT solver_ [, J. Satisf. Boolean Model. Comput., 9 (2015), pp. 89–128, https://doi.](https://doi.org/10.3233/SAT190104)
[org/10.3233/SAT190104.](https://doi.org/10.3233/SAT190104)

[2] T. Achterberg, _SCIP: Solving constraint integer programs_, Math. Program. Comput., 1
[(2009), pp. 1–41, https://doi.org/10.1007/s12532-008-0001-1.](https://doi.org/10.1007/s12532-008-0001-1)

[3] T. Achterberg, T. Berthold, T. Koch, and K. Wolter, _Constraint integer program-_
_ming: A new approach to integrate CP and MIP_, in Integration of AI and OR Techniques
in Constraint Programming for Combinatorial Optimization Problems, Springer Berlin
[Heidelberg, 2008, pp. 6–20, https://doi.org/10.1007/978-3-540-68155-7_4.](https://doi.org/10.1007/978-3-540-68155-7_4)

[4] T. Achterberg, T. Koch, and A. Martin, _Branching rules revisited_, Oper. Res. Lett., 33
[(2005), pp. 42–54, https://doi.org/10.1016/j.orl.2004.04.002.](https://doi.org/10.1016/j.orl.2004.04.002)

[5] T. Akiba and Y. Iwata, _Branch-and-reduce exponential/FPT algorithms in practice: A case_
_study of vertex cover_ [, Theoretical Computer Science, 609 (2016), pp. 211–225, https://doi.](https://doi.org/10.1016/j.tcs.2015.09.023)
[org/10.1016/j.tcs.2015.09.023.](https://doi.org/10.1016/j.tcs.2015.09.023)

[6] M. Alekhnovich, _Lower bounds for k-DNF resolution on random 3-CNFs_, in Proceedings
of the Thirty-Seventh Annual ACM Symposium on Theory of Computing, Association for
[Computing Machinery, 2005, p. 251–256, https://doi.org/10.1145/1060590.1060628.](https://doi.org/10.1145/1060590.1060628)

[7] J. Argelich, C. M. Li, F. Manyà, and J. R. Soler, _Clause branching in MaxSAT and_
_MinSAT_, in Artificial Intelligence Research and Development, IOS Press, 2018, pp. 17–26,
[https://doi.org/10.3233/978-1-61499-918-8-17.](https://doi.org/10.3233/978-1-61499-918-8-17)

[8] J. Bezanson, A. Edelman, S. Karpinski, and V. B. Shah, _Julia: A fresh approach to_
_numerical computing_, SIAM Rev., 59 (2017), pp. 65–98.

[9] N. Bourgeois, B. Escoffier, V. T. Paschos, and J. M. van Rooij, _Fast algorithms_
_for max independent set_ [, Algorithmica, 62 (2012), pp. 382–415, https://doi.org/10.1007/](https://doi.org/10.1007/s00453-010-9460-7)
[s00453-010-9460-7.](https://doi.org/10.1007/s00453-010-9460-7)

[10] G. Carpaneto and P. Toth, _Some new branching and bounding criteria for the asymmetric_
_travelling salesman problem_ [, Manage. Sci., 26 (1980), pp. 736–743, https://doi.org/10.](https://doi.org/10.1287/mnsc.26.7.736)
[1287/mnsc.26.7.736.](https://doi.org/10.1287/mnsc.26.7.736)

[11] J. Chen and I. A. Kanj, _Improved exact algorithms for Max-SAT_, Discrete Appl. Math., 142
[(2004), pp. 17–27, https://doi.org/10.1016/j.dam.2003.03.002.](https://doi.org/10.1016/j.dam.2003.03.002)

[12] M. B. Cohen, Y. T. Lee, and Z. Song, _Solving linear programs in the current matrix_
_multiplication time_ [, J. ACM, 68 (2021), pp. 1–39, https://doi.org/10.1145/3424305.](https://doi.org/10.1145/3424305)

[13] M. Cygan, F. V. Fomin, Ł. Kowalik, D. Lokshtanov, D. Marx, M. Pilipczuk,
M. Pilipczuk, and S. Saurabh, _Lower bounds based on the exponential-time hy-_
_pothesis_ [, Springer International Publishing, 2015, pp. 467–521, https://doi.org/10.1007/](https://doi.org/10.1007/978-3-319-21275-3_14)
[978-3-319-21275-3_14.](https://doi.org/10.1007/978-3-319-21275-3_14)

[14] I. Dunning, J. Huchette, and M. Lubin, _JuMP: A modeling language for mathematical_
_optimization_ [, SIAM Rev., 59 (2017), pp. 295–320, https://doi.org/10.1137/15M1020575.](https://doi.org/10.1137/15M1020575)

[15] S. Ebadi, A. Keesling, M. Cain, T. T. Wang, H. Levine, D. Bluvstein, G. Semeghini, A. Omran, J.-G. Liu, R. Samajdar, et al., _Quantum optimization of maximum_
_independent set using rydberg atom arrays_, Science, 376 (2022), pp. 1209–1215.

[16] D. Eppstein, _The traveling salesman problem for cubic graphs_, J. Graph Algorithms Appl.,
[11 (2003), pp. 307–318, https://doi.org/10.1007/978-3-540-45078-8_27.](https://doi.org/10.1007/978-3-540-45078-8_27)

[17] J. Fairbanks, M. Besançon, S. Simon, J. Hoffiman, N. Eubank, and S. Karpinski,
_Juliagraphs/graphs.jl: an optimized graphs package for the julia programming language_,
[2021, https://github.com/JuliaGraphs/Graphs.jl/.](https://github.com/JuliaGraphs/Graphs.jl/)

[18] M. Fischetti and M. Monaci, _Backdoor_ _branching_, in Integer Programming and
Combinatoral Optimization, Springer, 2011, pp. 183–191, [https://doi.org/10.1007/](https://doi.org/10.1007/978-3-642-20807-2_15)
[978-3-642-20807-2_15.](https://doi.org/10.1007/978-3-642-20807-2_15)

[19] F. V. Fomin, F. Grandoni, and D. Kratsch, _Measure and conquer: A simple O_ (2 [0] _[.]_ [288] _[n]_ )
_independent set algorithm_, in Proceedings of the Seventeenth Annual ACM-SIAM Symposium on Discrete Algorithm, Society for Industrial and Applied Mathematics, 2006,
[p. 18–25, https://doi.org/10.1145/1109557.1109560.](https://doi.org/10.1145/1109557.1109560)

[20] F. V. Fomin and K. Høie, _Pathwidth of cubic graphs and exact algorithms_, Inf. Process.
[Lett., 97 (2006), pp. 191–196, https://doi.org/10.1016/j.ipl.2005.10.012.](https://doi.org/10.1016/j.ipl.2005.10.012)


20


[21] F. V. Fomin and P. Kaski, _Exact exponential algorithms_, Commun. ACM, 56 (2013), pp. 80–
[88, https://doi.org/10.1145/2428556.2428575.](https://doi.org/10.1145/2428556.2428575)

[22] G. Gamrath and C. Schubert, _Measuring the impact of branching rules for mixed-integer_
_programming_, in Operations Research Proceedings 2017, Springer International Publishing,
[2018, pp. 165–170, https://doi.org/10.1007/978-3-319-89920-6_23.](https://doi.org/10.1007/978-3-319-89920-6_23)

[23] X. Gao, Y. Wang, and J.-G. Liu, _OptimalBranching.jl: An implementation of the opti-_
_mal branching algorithm in Julia_ [. https://github.com/ArrogantGao/OptimalBranching.jl,](https://github.com/ArrogantGao/OptimalBranching.jl)
2024.

[24] D. Hespe, S. Lamm, C. Schulz, and D. Strash, _Wegotyoucovered: The winning solver from_
_the pace 2019 challenge, vertex cover track_, in 2020 proceedings of the SIAM workshop
[on combinatorial scientific computing, SIAM, 2020, pp. 1–11, https://epubs.siam.org/doi/](https://epubs.siam.org/doi/abs/10.1137/1.9781611976229.1)
[abs/10.1137/1.9781611976229.1.](https://epubs.siam.org/doi/abs/10.1137/1.9781611976229.1)

[25] Q. Huangfu and J. J. Hall, _Parallelizing the dual revised simplex method_, Math. Program.
[Comput., 10 (2018), pp. 119–142, https://doi.org/10.1007/s12532-017-0130-5.](https://doi.org/10.1007/s12532-017-0130-5)

[26] R. Impagliazzo and R. Paturi, _On the complexity of k-SAT_, J. Comput. Syst. Sci., 62 (2001),
[pp. 367–375, https://doi.org/10.1006/jcss.2000.1727.](https://doi.org/10.1006/jcss.2000.1727)

[27] D. Issac and R. Jaiswal, _An O_ _[∗]_ (1 _._ 0821 _[n]_ ) _-time algorithm for computing maximum indepen-_
_dent set in graphs with bounded degree 3_ [, 2022, https://doi.org/10.48550/arXiv.1308.1351.](https://doi.org/10.48550/arXiv.1308.1351)

[28] T. Jian, _An O_ (2 [0] _[.]_ [304] _[n]_ ) _algorithm for solving maximum independent set problem_, IEEE Trans.
[Comput., 35 (1986), p. 847–851, https://doi.org/10.1109/TC.1986.1676847.](https://doi.org/10.1109/TC.1986.1676847)

[29] E. Khalil, P. Le Bodic, L. Song, G. Nemhauser, and B. Dilkina, _Learning to branch in_
_mixed integer programming_ [, AAAI Conf. Artif. Intell., 30 (2016), https://doi.org/10.1609/](https://doi.org/10.1609/aaai.v30i1.10080)
[aaai.v30i1.10080.](https://doi.org/10.1609/aaai.v30i1.10080)

[30] J. Kneis, A. Langer, and P. Rossmanith, _A fine-grained analysis of a simple independent_
_set algorithm_, in IARCS Annual Conference on Foundations of Software Technology and
Theoretical Computer Science, vol. 4, Schloss Dagstuhl – Leibniz-Zentrum für Informatik,
[2009, pp. 287–298, https://doi.org/10.4230/LIPIcs.FSTTCS.2009.2326.](https://doi.org/10.4230/LIPIcs.FSTTCS.2009.2326)

[31] A. H. Land and A. G. Doig, _An automatic method of solving discrete programming problems_,
[Econometrica, 28 (1960), pp. 497–520, https://doi.org/10.2307/1910129.](https://doi.org/10.2307/1910129)

[32] P. Le Bodic and G. Nemhauser, _An abstract model for branching and its application to_
_mixed integer programming_ [, Math. Program., 166 (2017), pp. 369–405, https://doi.org/10.](https://doi.org/10.1007/s10107-016-1101-8)
[1007/s10107-016-1101-8.](https://doi.org/10.1007/s10107-016-1101-8)

[33] C. M. Li, F. Manyà, and J. Planes, _Exploiting unit propagation to compute lower bounds_
_in branch and bound Max-SAT solvers_, in Principles and Practice of Constraint Program[ming - CP 2005, Springer Berlin Heidelberg, 2005, pp. 403–414, https://doi.org/10.1007/](https://doi.org/10.1007/11564751_31)
[11564751_31.](https://doi.org/10.1007/11564751_31)

[34] J.-G. Liu, X. Gao, M. Cain, M. D. Lukin, and S.-T. Wang, _Computing solution space_
_properties of combinatorial optimization problems via generic tensor networks_, SIAM J.
[Sci. Comput., 45 (2023), pp. A1239–A1270, https://doi.org/10.1137/22M1501787.](https://doi.org/10.1137/22M1501787)

[35] J.-G. Liu, J. Wurtz, M.-T. Nguyen, M. D. Lukin, H. Pichler, and S.-T. Wang,
_Computer-assisted gadget design and problem reduction of unweighted maximum indepen-_
_dent set_, unpublished, (2024).

[36] M. Lubin, O. Dowson, J. Dias Garcia, J. Huchette, B. Legat, and J. P.
Vielma, _JuMP 1.0: Recent improvements to a modeling language for mathematical op-_
_timization_ [, Math. Program. Comput., 15 (2023), p. 581–589, https://doi.org/10.1007/](https://doi.org/10.1007/s12532-023-00239-3)
[s12532-023-00239-3.](https://doi.org/10.1007/s12532-023-00239-3)

[37] I. L. Markov and Y. Shi, _Simulating quantum computation by contracting tensor networks_,
[SIAM J. Comput., 38 (2008), pp. 963–981, https://doi.org/10.1137/050644756.](https://doi.org/10.1137/050644756)

[38] C. Moore and S. Mertens, _The nature of computation_, Oxford University Press, 2011,

[https://doi.org/10.1093/acprof:oso/9780199233212.001.0001.](https://doi.org/10.1093/acprof:oso/9780199233212.001.0001)

[39] D. R. Morrison, S. H. Jacobson, J. J. Sauppe, and E. C. Sewell, _Branch-and-bound_
_algorithms: A survey of recent advances in searching, branching, and pruning_, Discrete
[Optim., 19 (2016), pp. 79–102, https://doi.org/10.1016/j.disopt.2016.01.005.](https://doi.org/10.1016/j.disopt.2016.01.005)

[40] H. Nabli, _An overview on the simplex algorithm_, Appl. Math. Comput., 210 (2009), pp. 479–
[489, https://doi.org/10.1016/j.amc.2009.01.013.](https://doi.org/10.1016/j.amc.2009.01.013)

[41] F. Peres and M. Castelli, _Combinatorial optimization problems and metaheuristics: Re-_
_view, challenges, design, and development_ [, Appl. Sci., 11 (2021), p. 6449, https://doi.org/](https://doi.org/10.3390/app11146449)
[10.3390/app11146449.](https://doi.org/10.3390/app11146449)

[42] J. Robson, _Algorithms for maximum independent sets_, J. Algorithms, 7 (1986), pp. 425–440,

[https://doi.org/10.1016/0196-6774(86)90032-5.](https://doi.org/10.1016/0196-6774(86)90032-5)

[43] R. E. Tarjan and A. E. Trojanowski, _Finding a maximum independent set_, SIAM J.
[Comput., 6 (1977), pp. 537–546, https://doi.org/10.1137/0206038.](https://doi.org/10.1137/0206038)


21


[44] A. Urquhart, _The complexity of propositional proofs_, Bull. Symb. Log., 1 (1995), pp. 425–467,

[https://doi.org/10.2307/421131.](https://doi.org/10.2307/421131)

[45] M. Xiao, _New branching rules: Improvements on independent set and vertex cover in sparse_
_graphs_ [, arXiv:0904.2712, (2009), https://doi.org/10.48550/arXiv.0904.2712.](https://doi.org/10.48550/arXiv.0904.2712)

[46] M. Xiao, _A note on vertex cover in graphs with maximum degree 3_, in Computing and Com[binatorics, Springer, 2010, pp. 150–159, https://doi.org/10.1007/978-3-642-14031-0_18.](https://doi.org/10.1007/978-3-642-14031-0_18)

[47] M. Xiao and H. Nagamochi, _Confining sets and avoiding bottleneck cases: A simple max-_
_imum independent set algorithm in degree-3 graphs_, Theor. Comput. Sci., 469 (2013),
[pp. 92–104, https://doi.org/10.1016/j.tcs.2012.09.022.](https://doi.org/10.1016/j.tcs.2012.09.022)

[48] M. Xiao and H. Nagamochi, _Exact algorithms for maximum independent set_, Inf. Comput.,
[255 (2017), pp. 126–146, https://doi.org/10.1016/j.ic.2017.06.001.](https://doi.org/10.1016/j.ic.2017.06.001)


**Appendix A.** _α_ **-tensor and reduced** _α_ **-tensor.**
The finite-valued entries of _α_ -tensor correspond to permissible configurations and
they all have the potential to constitute a segment of an MIS configuration. However,
since our objective is to determine the MIS size rather than enumerating all MIS
configurations, the entries of the _α_ -tensor can be further reduced. This pruning
is under the basic criterion that if all outcomes under one branch can find better
counterparts under another branch, then this branch can be safely discarded during
the search process. In the context of the MIS size problem, when branching on the
subgraph _R_ of a given graph _G_, consider two configurations _s_ 1 and _s_ 2 on _R_ and let
the set _S_ consist of all MIS configurations on _G_ . If for any element _s_ in _S_ satisfying
that its segment restricted to _R_ is equal to _s_ 1, the element obtained by replacing
the segment of _s_ 1 in _s_ with _s_ 2 still belongs to _S_, then it implies that the MIS size
outcomes under the branch corresponding to _s_ 1 are a subset of those under branch _s_ 2.
Consequently, the _α_ -tensor entry corresponding to _s_ 1 can be safely reduced without
affecting the outcome.


**A.1. Pruning irrelevant entries.** To implement this pruning principle, we
first utilize only the permissible configurations and the corresponding current MIS
size on _R_ to find such _s_ 1- _s_ 2 pairs. However, with only local information available, we
cannot make assumptions about the entire graph _G_ during branching. Consequently,
the pruning condition is leveraged such that _s_ 1 and _s_ 2 must ensure the containment
relationship of branch outcomes for all graphs _G_ that include a subgraph isomorphic
to _R_ . This defines a partial order on the configuration space on _R_, which is formalized
with the following two definitions.


Definition A.1 (less restrictive relation). _Consider two bitstrings of equal length_
_n,_ _**s**_ _∈{_ 0 _,_ 1 _}_ _[n]_ _and_ _**t**_ _∈{_ 0 _,_ 1 _}_ _[n]_ _. We say that_ _**s**_ _is less restrictive than_ _**t**_ _if si ≤_ _ti for_
_all i ∈{_ 1 _, . . ., n}. We denote this by_ _**s**_ _≺_ _**t**_ _._


Clearly, the least restrictive boundary configuration is the one containing all zeros.
For any other boundary configuration, one can always find less restrictive ones by
flipping some number of ones to zeros.


Definition A.2 (irrelevant boundary configuration). _Let R be a subgraph of a_
_graph, ∂R its boundary, and_ _**α**_ ( _R_ ) _its α-tensor. A boundary configuration_ _**t**_ _is irrel-_
_evant if there exists another boundary configuration_ _**s**_ _such that_ _**s**_ _≺_ _**t**_ _and_ _**α**_ ( _R_ ) _**s**_ _≥_
_**α**_ ( _R_ ) _**t**_ _, or if_ _**α**_ ( _R_ ) _**t**_ = _−∞. A boundary configuration is called relevant if it is not_
_irrelevant._


Under these definitions, since all independent sets emerging from the _t_ branch can
find counterparts in the _s_ branch that maintain the configurations in _G\R_ but larger
in size, the _t_ branch can be safely discarded in the presence of the _s_ branch. We call
that the boundary configuration _t_ can be reduced by _s_, which defines a partial order
on the effective boundary configurations, and we only need to continue searching in


22


the branches corresponding to the maximal elements of this partially ordered set.
Therefore, we can define the reduced _α_ -tensor by setting all entries in the _α_ -tensor
that correspond to irrelevant boundary vertex configurations to _−∞_ .


**Example: Reduced irrelevant entries to obtain reduced** _α_ **-tensor**

|s<br>∂R|α(R)<br>s∂R|α˜(R)<br>s∂R|reduced by|
|---|---|---|---|
|000<br>001<br>010<br>011<br>100<br>101<br>110<br>111|1<br>2<br>2<br>2<br>1<br>2<br>2<br>3|1<br>2<br>2<br>_−∞_<br>_−∞_<br>_−∞_<br>_−∞_<br>3|-<br>-<br>-<br>010<br>000<br>001<br>010<br>-|



Table 9: The finite-valued entries in _α_ -tensor and the corresponding reduced _α_  tensor entries for the sub-graph _R_ in Figure 1. Each row corresponds to a local
MIS size associated with the boundary-vertex configuration _**s**_ _abc_ . Since no other
configurations can reduce configurations 000, 001, 010, and 111, they are maximal
elements in the partial order set, i.e., they are the relevant configurations, whose
values on ˜ _**α**_ ( _R_ ) are equal to those on _**α**_ ( _R_ ). At the same time, since configurations
011, 100, 101, and 110 can be reduced by the relevant configurations, their corresponding entries in ˜ _**α**_ ( _R_ ) _**s**_ _∂R_ are set to _−∞_ .


**A.2. Enhanced pruning via incorporating nearest neighbor informa-**
**tion.** It has been demonstrated that the entries in a reduced _α_ -tensor can not be
further reduced if no environmental information is provided, i.e. the further removal
of any finite-valued elements in the reduced _α_ -tensors may reduce the MIS size of the
host graph. However, with a pruning scheme that utilizes environmental information
from _R_, we can further reduce the number of entries in the reduced _α_ -tensor.
As the amount and precision of environmental information increase, so does the
computational cost at each branching step. To address this, we have chosen a strategy
that minimizes costs while still considering the environment, concentrating exclusively
on the nearest neighbors of boundary vertices and disregarding the connectivity structure among these neighbors. Let _α_ ( _G_ ) denotes the MIS size on graph _G_ and _α_ _**s**_ _V_ = _**x**_ ( _G_ )
denotes the MIS size when vertices _V ⊆_ _V_ ( _G_ ) are fixed with configuration _**s**_ _V_ = _**x**_ .
Thus, our criterion for pruning can be traced back to the inequality:


(A.1) _α_ ( _G_ 1 _∪_ _G_ 2) _≤_ _α_ ( _G_ 1) + _α_ ( _G_ 2) _,_


where _G_ 1 _∪_ _G_ 2 denotes the induced subgraph of _G_ from _V_ ( _G_ 1) _∪_ _V_ ( _G_ 2). Given
a boundary configuration _**s**_ on subgraph _R_, we denote _G \_ ( _N_ ( _T_ ( _**s**_ )) _∪_ _V_ ( _R_ )) as
_G_ left( _**s**_ ), where _T_ ( _**s**_ ) is the set of boundary vertices with true assignment in _**s**_ . Then
the independent set consistent with _**s**_ has a size that is upper bounded by the one
consistent with another boundary configuration _**t**_ :


_α_ _**s**_ _∂R_ = _**s**_ ( _G_ ) = _α_ _**s**_ _∂R_ = _**s**_ ( _R_ ) + _α_ _**s**_ _∂R_ = _**s**_ ( _G\R_ )



(A.2)



= _**α**_ ( _R_ ) _**s**_ + _α_ ( _G_ left( _**s**_ ))

_≤_ _**α**_ ( _R_ ) _**s**_ + _α_ ( _G_ left( _**s**_ ) _\G_ left( _**t**_ )) + _α_ ( _G_ left( _**s**_ ) _∩_ _G_ left( _**t**_ ))

_≤_ _**α**_ ( _R_ ) _**s**_ + _α_ ( _G_ left( _**s**_ ) _\G_ left( _**t**_ )) + _α_ ( _G_ left( _**t**_ ))


23


If the MIS size within _R_ and the nearest-neighbor graph structure upon which
_G_ left( _**s**_ ) _\G_ left( _**t**_ ) depends satisfy that


(A.3) _**α**_ ( _R_ ) _s_ + _α_ ( _G_ left( _s_ ) _\G_ left( _t_ )) _≤_ _**α**_ ( _R_ ) _t,_


then we have:


_α_ _**s**_ _∂R_ = _**s**_ ( _G_ ) _≤_ _**α**_ ( _R_ ) _**t**_ + _α_ ( _G_ left( _**t**_ ))

(A.4) = _α_ _**s**_ _∂R_ = _**t**_ ( _R_ ) + _α_ _**s**_ _∂R_ = _**t**_ ( _G\R_ )
= _α_ _**s**_ _∂R_ = _**t**_ ( _G_ )


which means that the maximum MIS size under the _**s**_ branch is bounded by the _**t**_
branch, thus the _**s**_ branch can be safely discarded during the search process. Thus,
Equation (A.3) defines a partial order on the boundary configurations. By setting
entries corresponding to elements outside the maximal elements of this partial order
set to _−∞_, we can further simplify the reduced _α_ -tensor.
As _G_ left( _**s**_ ) _\G_ left( _**t**_ ) only involves the union and difference between the nearest
neighbors of boundary vertices, solving for its MIS size is a local and manageable
task, which is a minor component compared to the dominant computational cost
of the whole algorithm. Consequently, without altering the order of computational
complexity, we enhance the pruning strategy by considering information from the
neighboring environment.


**Example: Fine-grained pruning via environment**

|s<br>∂R|α˜(R)<br>s∂R|α˜env(R)<br>s∂R|reduced by|
|---|---|---|---|
|000<br>001<br>010<br>111|1<br>2<br>2<br>3|_−∞_<br>2<br>2<br>3|001<br>-<br>-<br>-|



Table 10: The finite-valued entries in the reduced _α_ -tensor ˜ _**α**_ ( _R_ ) _**s**_ _∂R_ after reducing irrelevant entries and the corresponding entries of the futher-reduced _α_  tensor ˜ _**α**_ [env] ( _R_ ) _**s**_ _∂R_ for the sub-graph _R_ in Figure 1, with an extra assumption that
_|N_ ( _c_ ) _\V_ ( _R_ ) _|_ = 1. Each row corresponds to a local MIS size associated with the
boundary-vertex configuration _**s**_ _abc_ . Since _**α**_ ( _R_ )000 + _α_ ( _G_ left(000) _\G_ left(001)) =
1 + _|N_ ( _c_ ) _\V_ ( _R_ ) _|_ = 2 = _**α**_ ( _R_ )001, 000 can be reduced by 001 and consequently,
_**α**_ ˜ [env] ( _R_ )000 is set to _−∞_ .


**Appendix B. Fixed Point Iteration.**
In this section, we provide more details about the fixed point iteration used in Algorithm 3.2. Let _f_ be the function representing the process described in the while
loop of Algorithm 3.2, which takes a _γold_ as input to generate a new _γnew_ . Then the
following theorems hold.


Theorem B.1. _The function f has only one fixed point γ_ 0 _, i.e., f_ ( _γ_ 0) = _γ_ 0 _,_
_where γ_ 0 _is the solution of the WMSC problem defined in Equation_ (3.2) _._


_Proof._ First we define the following function:



(B.1) _g_ ( _γ,_ _**x**_ ) =



_|C|_

- _γ_ _[−]_ [∆] _[ρ]_ [(] _[c][i]_ [)] _xi,_


_i_ =1


24





1.10


1.05


1.00


|Col1|Col2|Col3|Col4|Col5|Col6|f(𝛾)<br>y = x|Col8|
|---|---|---|---|---|---|---|---|
|||||||||
|||||||||
|||||||||
|||||||||
|||||||||
|||||||||



1.2 1.5 1.8
𝛾 _old_



Fig. 7: An example of the fixed point iteration of _γ_ in Algorithm 3.2, the inset subplot
shows the iteration near the fixed point. The blue line represents the value of _f_ ( _γ_ ),
the black line represents _y_ = _x_, and the red dashed lines and points represent the
iteration steps.


which is is monotonically decreasing to _γ_ with _**x**_ fixed, since ∆ _ρ_ are non-negative.
Recall WMSC problem defined in Eq. (3.2), let its solution be ( _γ_ wmsc _,_ _**x**_ wmsc), so that
_∀_ _**x**_ _[′]_ = _**x**_ wmsc satisfies the constraints in Eq. (3.7), _g_ ( _γ_ wmsc _,_ _**x**_ _[′]_ ) _≥_ 1 (if not, a smaller _γ_
can be found). Thus, in the iteration process taking _γold_ = _γ_ wmsc as input, the output
is given by _γnew_ = _γ_ wmsc, i.e., _γ_ wmsc is the fixed point of the iteration function _f_ .
Let _γ_ 1 _> γ_ 0, then in the integer programming progress, the function _g_ is minimized
over _**x**_ so that resulting in _g_ ( _γ_ 1 _,_ _**x**_ _[′]_ ) _< g_ ( _f_ ( _γ_ 1) _,_ _**x**_ _[′]_ ) = 1, which implies _f_ ( _γ_ 1) _< γ_ 1.
Thus, _∀γ > γ_ 0 can not be a fixed point of _f_, i.e., _γ_ 0 is the unique fixed point of _f_ .


Theorem B.2. _For any γ > γ_ 0 _, the fixed point iteration in Algorithm_ 3.2 _con-_
_verges to γ_ 0 _._


_Proof._ As been proved in the previous theorem, the function _f_ has only one
fixed point _γ_ 0, and for any _γ > γ_ 0, the sequence _γ, f_ ( _γ_ ) _, f_ ( _f_ ( _γ_ )) _, . . ._ is monotonically
decreasing and bounded below by _γ_ 0. Hence, the sequence converges to _γ_ 0.
What’s more, since for any _t ≥_ 1, _f_ _[t]_ ( _γ_ ) _∈_ Γ = _{_ 1 _< γ ≤_ 2 _| ∃_ _**x**_ 0 satisfying the
constraints in Equation (3.7), s.t. _g_ ( _γ,_ _**x**_ 0) = 1 _}_ which is a set of finite size, there
are at most _|_ Γ _|_ possible _f_ _[t]_ ( _γ_ ) during the iteration process. Therefore, _γ_ 0 can be
precisely reached and the number of iteration steps needed is bounded by the number
of solutions to the corresponding set covering the problem.


An example is shown in Figure 7, which describes the iteration of _γ_ during solving
the MIS of a randomly generated 3-regular graph. It is shown that the iteration
converges to the fixed point _γ_ 0 rapidly in a few steps as expected.


**Appendix C. Worst case of the branching algorithm on random graphs.**


The maximum number of branches generated by the branching algorithm applied
to the random graphs depicted in Figure 5 is illustrated in Figure 8. The results
for three-regular graphs closely resemble those of the average case, indicating that
the branching complexity is not significantly affected by the graph structure in this


25


scenario. For unbounded-degree graphs, similar observations can be made as shown
in Figure 5. Notably, `ob` continues to outperform `akiba2015` while employing the
same reduction rules, and `ob+xiao` demonstrates performance comparable to that of
`akiba2015+xiao&packing` .



Erdos-Renyi graphs


10 [6]


10 [4]


10 [2]


10 [0]
500 1 _,_ 000


Number of vertices


Grid graphs


10 [6]


10 [4]


10 [2]


10 [0]
0 1 _,_ 000 2 _,_ 000


Number of vertices



10 [4]


10 [3]


10 [2]


10 [1]


10 [9]


10 [6]


10 [3]


10 [0]



3-regular graphs


50 100 150 200


Number of vertices


King’s subgraphs


200 400 600


Number of vertices


```
      xiao2013 ob ob+xiao akiba2015 akiba2015+xiao&packing

```

Fig. 8: The largest number of branches produced by various algorithms on different
graphs as functions of the graph size.


**Appendix D. Technical guides.**
This appendix covers some technical guides for efficiency, which is mainly about
[the open-source package OptimalBranching [23] implementing the algorithms in this](https://github.com/ArrogantGao/OptimalBranching.jl)
paper. It is built on top of multiple open source packages in the Julia ecosystem:
[a) GenericTensorNetworks [34] is a package for solving the solution space properties](https://github.com/QuEraComputing/GenericTensorNetworks.jl)
(including the sizes, the counting, the enumeration and the sampling of solutions) of
[a constraint satisfaction problem; b) JuMP [36] is one of the most high-performance](https://github.com/jump-dev/JuMP.jl)
open-source packages for mathematical optimization. It interfaces multiple backends,
[the HiGHS [25] backend is used in this work for solving the linear programming (LP)](https://github.com/jump-dev/HiGHS.jl)
[and SCIP [2] is used for solving the mixed-integer programming (MIP) problems; c)](https://github.com/scipopt/SCIP.jl)


26


[Graphs [17] is a foundational package for graph manipulation in the Julia community.](https://github.com/JuliaGraphs/Graphs.jl)
The `OptimalBranching` is a meta package that consists of two component packages: `OptimalBranchingCore` and `OptimalBranchingMIS` . The `OptimalBranchingCore`
contains the core functionalities of the optimal branching algorithm and is designed
for the sake of modularity and extensibility. The `OptimalBranchingMIS` is a specific
application of the optimal branching algorithm, which is used to solve the maximum
independent set problem. The `OptimalBranching` package can be used directly in a
Julia REPL as follows:


1 `julia> using OptimalBranching, Graphs`
2
3 `julia> graph = smallgraph(:tutte)`
4 `{46, 69} undirected simple Int64 graph`
5
6 `julia> mis_branch_count(graph)`
7 `(19, 2)`


Here the main function `mis_branch_count` takes a graph as the input and returns
a tuple of the maximum independent set size and the number of branches generated
by the optimal branching strategy. In this example, the maximum independent set
size of the Tutte graph is 19, and the optimal branching strategy only generates 2
branches in the branching tree. The first execution of this function will be a bit slow
due to Julia’s just-in-time compilation. After that, the subsequent runs will be faster.
The algorithm in default is corresponding to the `ob_mis2` in the main text.
The component package `OptimalBranchingCore` contains the core functionalities
of the optimal branching algorithm and is designed for the sake of modularity and
extensibility. The following code snippet shows an example of how to use this module
to generate the optimal branching rule.


1 `julia> using OptimalBranchingCore, OptimalBranchingCore.BitBasis`
2
3 `julia> tbl = BranchingTable(5, [`
4 `[[0, 0, 0, 0, 1], [0, 0, 0, 1, 0]],`
5 `[[0, 0, 1, 0, 1]],`
6 `[[0, 1, 0, 1, 0]],`
7 `[[1, 1, 1, 0, 0]]])`
8 `BranchingTable{LongLongUInt{1}}`
9 `10000, 01000`
10 `10100`
11 `01010`
12 `00111`
13
14 `julia> candidates = collect(OptimalBranchingCore.candidate_clauses(tbl))`
15 `14-element Vector{Clause{LongLongUInt{1}}}:`
16 `Clause{LongLongUInt{1}}:` _¬_ `#5`
17 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧¬_ `#2` _∧_ `#3` _∧¬_ `#4` _∧_ `#5`
18 `Clause{LongLongUInt{1}}: #3` _∧¬_ `#4`
19 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧¬_ `#3` _∧_ `#4` _∧¬_ `#5`
20 `Clause{LongLongUInt{1}}:` _¬_ `#1`
21 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧_ `#2` _∧¬_ `#3` _∧_ `#4` _∧¬_ `#5`


27


22 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧¬_ `#2` _∧¬_ `#3` _∧¬_ `#4` _∧_ `#5`
23 `Clause{LongLongUInt{1}}:` _¬_ `#4`
24 `Clause{LongLongUInt{1}}: #1` _∧_ `#2` _∧_ `#3` _∧¬_ `#4` _∧¬_ `#5`
25 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧¬_ `#2` _∧¬_ `#4` _∧_ `#5`
26 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧¬_ `#3`
27 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧¬_ `#2`
28 `Clause{LongLongUInt{1}}: #2` _∧¬_ `#5`
29 `Clause{LongLongUInt{1}}:` _¬_ `#1` _∧¬_ `#2` _∧¬_ `#3` _∧_ `#4` _∧¬_ `#5`
30
31 `julia>` ∆ _ρ_ `= [length(literals(sc)) for sc in candidates]; println(` ∆ _ρ_ `)`
32 `[1, 5, 2, 4, 1, 5, 5, 1, 5, 4, 2, 2, 2, 5]`
33
34 `julia> res_ip = OptimalBranchingCore.minimize_` _γ_ `(tbl, candidates,` ∆ _ρ_ `,`
```
    IPSolver())
```

35 `OptimalBranchingResult{LongLongUInt{1}, Int64}:`
36 `selected_ids: [4, 2, 9]`
37 `optimal_rule: DNF{LongLongUInt{1}}: (` _¬_ `#1` _∧¬_ `#3` _∧_ `#4` _∧¬_ `#5)` _∨_ `(` _¬_ `#1` _∧¬_ `#`

`2` _∧_ `#3` _∧¬_ `#4` _∧_ `#5)` _∨_ `(#1` _∧_ `#2` _∧_ `#3` _∧¬_ `#4` _∧¬_ `#5)`
38 `branching_vector: [4, 5, 5]`
39 _γ_ `: 1.2671683045421243`


_•_ **Line 3:** We first setup the problem by constructing a branching table `tbl`,
which is a table of the boundary-grouped configurations from the example in
Figure 1. To goal is to design a boolean expression in the DNF form, which
is satisfied by at least one element from each row in this table. Meanwhile,
we require that the branching complexity _γ_ is minimized.

_•_ **Line 14:** We generate all possible clauses `candidates` from the branching
table using the Algorithm 3.1. Here, the total number of candidate clauses
is 14, which is much smaller than 3 [5] = 243. The discarded clauses are those
that can not form optimal branching rules. They do not use the maximum
number of literals to cover the same set of rows in `tbl` .

_•_ **Line 31:** The associated problem size reduction values ∆ _ρ_ of the clauses are
computed. Here, we assume that the size reduction value is only related to
the number of literals in the clause for simplicity. In practice, it is also related
to the measure _ρ_, and the environment of the chosen sub-graph.

_•_ **Line 34:** With the branching table `tbl`, the candidate clauses `candidates`,
and the associated problem size reduction values ∆ _ρ_, we minimize the _γ_ value
(Equation (3.2)) by iteratively solving the WMSC problem (Algorithm 3.2)
with the integer programming backend `IPSolver` . The resulting _γ_ value is
_∼_ 1 _._ 2672, the associated branching rule (the 2-nd, 4-th, and 9-th clauses in
`candidates` ) is


_D_ = ( `#1` _∧_ `#2` _∧_ `#3` _∧¬_ `#4` _∧¬_ `#5` ) _∨_


(D.1) ( _¬_ `#1` _∧¬_ `#3` _∧_ `#4` _∧¬_ `#5` ) _∨_

( _¬_ `#1` _∧¬_ `#2` _∧_ `#3` _∧¬_ `#4` _∧_ `#5` ) _,_


and the associated branching vector is (4 _,_ 5 _,_ 5).


