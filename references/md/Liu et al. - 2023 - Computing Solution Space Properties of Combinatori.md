\mathrm{S}\mathrm{I}\mathrm{A}\mathrm{M} \mathrm{J}. \mathrm{S}\mathrm{C}\mathrm{I}. \mathrm{C}\mathrm{O}\mathrm{M}\mathrm{P}\mathrm{U}\mathrm{T}. © 2023 \mathrm{S}\mathrm{o}\mathrm{c}\mathrm{i}\mathrm{e}\mathrm{t}\mathrm{y} \mathrm{f}\mathrm{o}\mathrm{r} \mathrm{I}\mathrm{n}\mathrm{d}\mathrm{u}\mathrm{s}\mathrm{t}\mathrm{r}\mathrm{i}\mathrm{a}\mathrm{l} \mathrm{a}\mathrm{n}\mathrm{d} \mathrm{A}\mathrm{p}\mathrm{p}\mathrm{l}\mathrm{i}\mathrm{e}\mathrm{d} \mathrm{M}\mathrm{a}\mathrm{t}\mathrm{h}\mathrm{e}\mathrm{m}\mathrm{a}\mathrm{t}\mathrm{i}\mathrm{c}\mathrm{s}
\mathrm{V}\mathrm{o}\mathrm{l}. 45, \mathrm{N}\mathrm{o}. 3, \mathrm{p}\mathrm{p}. \mathrm{A}1239--\mathrm{A}1270


**COMPUTING SOLUTION SPACE PROPERTIES OF**
**COMBINATORIAL OPTIMIZATION PROBLEMS VIA GENERIC**
**TENSOR NETWORKS** **[*]**


JIN-GUO LIU _[\dagger ]_, XUN GAO _[\ddagger ]_, MADELYN CAIN _[\dagger ]_, MIKHAIL D. LUKIN _[\dagger ]_, AND
SHENG-TAO WANG _[\S ]_


**Abstract.** We introduce a unified framework to compute the solution space properties of a broad
class of combinatorial optimization problems. These properties include finding one of the optimum
solutions, counting the number of solutions of a given size, and enumeration and sampling of solutions
of a given size. Using the independent set problem as an example, we show how all these solution
space properties can be computed in the unified approach of generic tensor networks. We demonstrate
the versatility of this computational tool by applying it to several examples, including computing
the entropy constant for hardcore lattice gases, studying the overlap gap properties, and analyzing
the performance of quantum and classical algorithms for finding maximum independent sets.


**Key words.** generic tensor network, solution space property, independent set, combinatorial
optimization


**MSC codes.** 15A69, 05C31, 14N10


**DOI.** 10.1137/22M1501787


**1. Introduction.** An important class of problems in graph theory and combinatorial optimization can be formulated as satisfiability problems involving constraints
specified over a vertex and its neighborhood. These problems include, for example,
the independent set problem, the cutting problem, the dominating set, set packing,
set covering, vertex coloring, K-SAT, the clique problem, and the vertex cover problem [45]. These problems have a wide range of applications in scheduling, logistics,
wireless networks and telecommunication, and computer vision, among others [13,
55]. Finding an optimum solution for these problems is typically NP-hard in the
worst case [34].
In this article, we introduce a unified framework to compute a broad class of properties associated with the solutions of these problems, beyond just finding an optimum solution. We call them _solution space properties_ . In practice, these can be much
harder to compute (corresponding, e.g., to a \#P-complete class [45]). However, these
properties can be crucial for understanding detailed properties of hard combinatorial
optimization problems. For example, for the independent set problem, these _solution_
_space properties_ can include not only the maximum or minimum independent set size


  - Submitted to the journal's Methods and Algorithms for Scientific Computing section June 8,
2022; accepted for publication (in revised form) December 22, 2022; published electronically June
13, 2023.
[https://doi.org/10.1137/22M1501787](https://doi.org/10.1137/22M1501787)
**Funding:** The authors received financial support from the DARPA ONISQ program (grant
W911NF2010021), the Center for Ultracold Atoms, the National Science Foundation, the Vannevar
Bush Faculty Fellowship, the U.S. Department of Energy (DE-SC0021013) and DOE Quantum Systems Accelerator Center (contract 7568717), and the Army Research Office MURI. The authors
received computation credits from Amazon Web Services for running the benchmarks and case studies. The first author received funding support from QuEra Computing through a sponsored research
program.
_\dagger_ Department of Physics, Harvard University, Cambridge, MA 02138 USA, and QuEra Computing,
[Boston, MA 02135 USA (cacate0129@gmail.com).](mailto:cacate0129@gmail.com)
_\ddagger_ [Department of Physics, Harvard University, Cambridge, MA 02138 USA (xungao@g.harvard.](mailto:xungao@g.harvard.edu)
[edu, mcain@g.harvard.edu, lukin@physics.harvard.edu).](mailto:xungao@g.harvard.edu)
_\S_ [QuEra Computing, Boston, MA 02135 USA (swang@quera.com).](mailto:swang@quera.com)

A1239


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1240 LIU, GAO, CAIN, LUKIN, AND WANG


but also the number of sets at a given size, enumeration of all sets at a given size,
and direct sampling of such sets when they are too large to be fit into memory. They
can be used to understand the hardness of finding an optimum solution for a given
problem instance and the performance of a specific solver. For example, the number of
configurations at different sizes can inform how likely a simulated annealing algorithm
will be trapped in local minima at certain sizes [56]. The pairwise Hamming distance
distribution of configurations at a given size can indicate the presence or absence of
the overlap gap property [26, 25], which can be used to bound the performance of local
optimization algorithms. In a recent experiment based on a Rydberg atom array quantum computer, the counting and the configuration space connectivity information were
used to find maximum independent set (MIS) problem instances that are hard for simulated annealing and to evaluate the corresponding quantum algorithm performance

[19]. The need to understand these important aspects of combinatorial optimization
motivates us to find methodologies to compute these solution space properties.
To this end, we show how to obtain all of these seemingly unrelated properties in
a unified approach using _generic tensor networks_ . Tensor networks are a computational model widely used in condensed matter physics [46], quantum computing [44],
big data [15], mathematics [47], and combinatorial optimization [9, 8, 38]. They are
also known as the sum-product networks in probabilistic modeling [10] or `einsum` in
linear algebra libraries such as NumPy [32]. Recent progress in simulating quantum
circuits with tensor networks [31, 48, 36] makes it possible to contract a randomly
structured sparse tensor network with up to thousands of tensors in a reasonable time.
In previous studies, the data types of the tensor elements typically were restricted to
standard number types such as real numbers and complex numbers. Here, we extend
to _generic tensor networks_ by generalizing the tensor element data types to any type
that has the algebraic structure of a commutative semiring. In what follows, for clarity of presentation, we focus on the independent set problem in the main text and
show how to compute the solution space properties for other combinatorial optimization problems in Appendix B. The latter includes cutting, matching, vertex coloring,
satisfiability, dominating set, set packing, set covering, and the clique problem.
The paper is organized as follows. We first introduce the basic concepts of tensor
networks and generic programming in sections 2 and 3. Then we show how to reduce the independent set problem to a tensor network contraction problem in section
4. Subsequently, we explain how to engineer the element types to compute various
solution space properties in sections 6, 7, and 8. Last, we provide three example
applications in section 9 to demonstrate the versatility of our tool. A benchmark to
demonstrate the performance of our algorithms can be found in both section SM1 and
the code repository [1].


**2. Tensor networks.** A tensor network is a multilinear map from a collection
of labeled tensors _\scrT_ to an output tensor. It is formally defined as follows.

Definition 2.1 (tensor network [16, 46]). _A tensor network is a multilinear_
_map specified by a triple of_ = (\Lambda _,_ _,_ _**\bfitsigma**_ _o_ ) _, where_ \Lambda _is a set of symbols_ ( _or labels_ ) _,_
_\scrN_ _\scrT_
_\scrT symbols labeling the output tensor. Each_ = _\{ T_ _**\bfitsigma**_ [(1)] 1 _[,T]_ [ (2)] _**\bfitsigma**_ 2 _[,...,T]_ _**\bfitsigma**_ [ (] _[M]_ _M_ [)] _[\} ]_ _[is a set of tensors as the inputs, and]_ _T_ _**\bfitsigma**_ [(] _[k]_ _**\bfitk**_ [)] _[\in \scrT ]_ _[is labeled by a string]_ _**[ \bfitsigma ]**_ _o_ _**[ \bfitsigma ]**_ _[is a string of]_ _k_
_where r_ ( _T_ [(] _[k]_ [)] ) _is the rank of T_ [(] _[k]_ [)] _. The multilinear map or the contraction on this_ _[\in ]_ [\Lambda ] _[r]_ [(] _[T]_ [ (] _[k]_ [)][)] _[,]_
_triple is_



(2.1) _O_ _**\bfitsigma**_ _o_ = \sum

\Lambda _\setminus \sigma o_



_M_
\prod _T_ _**\bfitsigma**_ [(] _[k]_ _**\bfitk**_ [)] _[,]_

_k_ =1



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1241


_where the summation runs over all possible configurations over the set of symbols_
_absent in the output tensor._


For example, the matrix multiplication can be specified as a tensor network


(2.2) _\scrN_ matmul = ( _\{ i,j,k\},_ _\{ Aij,Bjk\},ik_ ) _,_

where _Aij_ and _Bjk_ are input matrices (two-dimensional tensors), and ( _i,k_ ) are labels
associated to the output. The contraction is defined as _Oik_ = [\sum ] _j_ _[A][ij][B][jk]_ [, where the]

subscripts are for tensor indexing, and the tensor dimensions with the same label
must have the same size. The graphical representation of a tensor network is an open
hypergraph having open hyperedges, where an input tensor is mapped to a vertex and
a label is mapped to a hyperedge that can connect an arbitrary number of vertices,
while the labels appearing in the output tensor are mapped to open hyperedges. Our
notation is a minor generalization of the standard tensor network notation used in
physics as we do not restrict the number of times a label can appear in the tensors
to two. While this generalized form is equivalent in representation power, it can have
smaller contraction complexity, as will be illustrated in section SM2.


_Example_ 1.



\Lambda = _\{ i,j,k,l,m\},_



= _Ajkm,Bmil,Vjm_ _,_
_\scrT_ _\{_ _\}_



(2.3) _\scrT_ = _\{ A_
_**\bfitsigma**_ _o_ = _ijk,_



is a tensor network that can be evaluated as _Oijk_ = [\sum ] _ml_ _[A][jkm][B][mil][V][jm]_ [.] Its hy
pergraph representation is shown below, where we use different colors to represent
different hyperedges.















**3. Generic programming tensor contractions.** In previous works relating
tensor networks and combinatorial optimization problems [38, 8], the element types
in the tensor networks are limited to standard number types such as floating-point
numbers and integers. We propose to use more general element types with a certain algebraic property. With different data types, we can solve different problems
within the same unified framework. This idea of using the same program for different
purposes is also called generic programming in computer science.


Definition 3.1 (generic programming [54]). _Generic programming is an ap-_
_proach to programming that focuses on designing algorithms and data structures so_
_that they work in the most general setting without loss of efficiency._


This definition of generic programming covers two major aspects: ``work in the
most general setting"" and ``without loss of efficiency."" By the most general setting,
we mean that a single program should work correctly for the most general input data
types. For example, suppose we want to write a function that raises an element to
a power, _f_ ( _x,n_ ) := _x_ _[n]_ . One can easily write a function for standard number types
that computes the power of _x_ in _O_ (log( _n_ )) steps using the multiply and square trick.


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1242 LIU, GAO, CAIN, LUKIN, AND WANG


Generic programming does not require _x_ to be a standard number type; instead, it
treats _x_ as an element with an associative multiplication operation _\odot_ and a multiplicative identity 1. Then, when the program takes a matrix as an input instead of
a standard number type, it computes the matrix power correctly without rewriting
the program. The second aspect is about efficiency. For dynamically typed languages
such as Python, the type information is not available for type-specific optimizations
at the compilation stage. Therefore, one can easily write code that works for general
input types, but the efficiency is not guaranteed; for example, the speed of computing
the matrix multiplication between two NumPy arrays with Python objects as elements is much slower than statically typed (i.e., the type information can be accessed
at the compilation stage) languages such as C++ and Julia [7]. C++ uses templates
for generic programming, while Julia takes advantage of just-in-time compilation and
multiple dispatches. When these languages ``see"" a new input type, the compiler recompiles the generic program for the new type to generate an efficient binary. Myriad
optimizations can be done during the compilation. For example, the compiler can
optimize the memory layout of immutable elements with fixed sizes in an array to
speed up array indexing. In Julia, if a type is immutable and contains no references
to other values, an array of that type can even be compiled to graphics processing
units (GPU) for faster computation [6].
This motivates us to identify the most general tensor element type allowed in
a tensor network contraction program. We find that as long as the tensor elements
are members of a commutative semiring, the tensor network contraction will be well
defined and the result will be independent of the contraction order. In contrast
with a field, a commutative semiring does not need not to have an additive inverse
and a multiplicative inverse. Giving up these nice properties of fields has significant
implications for tensor computation: tensor network compression algorithms might
not be applicable because matrix factorization is NP-hard for commutative semirings

[53] and matrix multiplication faster than _O_ ( _n_ [3] ) does not exist for an algebra without
an additive inverse [37]. Here, we only use the commutative properties of an algebra
for optimizing the tensor network contraction order. To define a commutative semiring
with the addition operation _\oplus_ [1] and the multiplication operation _\odot_ on a set _S_, the
following relations must hold for any arbitrary three elements _a,b,c \in_ _S_ :



( _a \oplus_ _b_ ) _\oplus_ _c_ = _a \oplus_ ( _b \oplus_ _c_ ) _\triangleleft_ commutative monoid _\oplus_ with identity 0



_a \oplus_ 0 = 0 _\oplus_ _a_ = _a_



_a \oplus_ _b_ = _b \oplus_ _a_



( _a \odot_ _b_ ) _\odot_ _c_ = _a \odot_ ( _b \odot_ _c_ ) _\triangleleft_ commutative monoid _\odot_ with identity 1



_a \odot_ 1 = 1 _\odot_ _a_ = _a_



_a \odot_ _b_ = _b \odot_ _a_



_a \odot_ ( _b \oplus_ _c_ ) = _a \odot_ _b \oplus_ _a \odot_ _c_ _\triangleleft_ left and right distributive

( _a \oplus_ _b_ ) _\odot_ _c_ = _a \odot_ _c \oplus_ _b \odot_ _c_



_a \odot_ 0 = 0 _\odot_ _a_ = 0

1We use the _\oplus_ operator throughout this paper to denote the generic addition, which is not the
logical `XOR` operation, in which the symbol typically represents in computer science.


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1243


R

Tropical









Extended Tropical


Fig. 1. _The tensor network element types used in this work and their relations. The overlap_
_between two ellipses indicates that a new algebra can be created by combining those two types of_
_algebra. ``Largest order"" and ``Largest_ 2 _orders"" mean truncating the polynomial by only keeping its_
_largest or largest two orders. The purpose of these element types can be found in Table_ 1 _._


Table 1

_Tensor element types and the independent set properties that can be computed using them._


**Element type** **Solution space property**
\BbbR Counting of all independent sets
Polynomial (equation (5.2: PN)) Independence polynomial
Tropical (equation (6.4: T)) MIS size
Extended tropical of order _k_ (equation (8.1: Tk)) Largest _k_ independent set sizes
Polynomial truncated to _k_ th order (equations (6.3: _k_ largest independent sizes and their
P1) and (6.6: P2)) degeneracy
Set (equation (7.1: SN)) Enumeration of independent sets
Sum-product expression tree (equation (7.7: EXPR)) Sampling of independent sets
Polynomial truncated to largest order combined with MIS size and one of such
bit string (equation (7.5: S1)) configurations
Polynomial truncated to _k_ th order combined with set _k_ largest independent set sizes and
(equation (7.3: P1+SN)) their enumeration


In the following sections, we will show how to compute solution space properties of
independent sets using the same tensor network contraction algorithm by engineering
tensor element algebra. The Venn diagram in Figure 1 shows the different types of
algebra we will introduce in the main text and their relation, and Table 1 summarizes
which solution space properties can be computed by which tensor element types.


**4. Tensor network representation of independent sets.** This section describes the reduction of the independent set problem to a tensor network contraction
problem. An alternative interpretation, perhaps more accessible to physicists, can
be found in Appendix A, where we introduce the reduction from the energy model
of hardcore lattice gases [18, 21]. Let _G_ = ( _V,E_ ) be an undirected graph with each
vertex _v_ _V_ being associated with a integer weight _wv_ . An independent set _I_ _V_ is
_\in_ _\subseteq_
a set of vertices that for any vertex pair _u,v \in_ _I_, we have ( _u,v_ ) _E_ ; we refer to this
constraint as the independence constraint. The independent set problem on _G_ can be
encoded as a tensor network IS( _G_ ) _,_
_\scrN_



(4.1)



\Lambda = _sv_ _v_ _V_ _,_
_\{_ _|_ _\in_ _\}_



= _Ws_ [(] _v_ _[v]_ [)] _susv_
_\scrT_ _\{_ _[| ]_ _[v][ \in ]_ _[V][ \} \cup \{ ][B]_ [(] _[u,v]_ [)] _[| ]_ [(] _[u,v]_ [)] _[ \in ]_ _[E][\} ][,]_



_**\bfitsigma**_ _o_ = _\varepsilon,_



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1244 LIU, GAO, CAIN, LUKIN, AND WANG


where for each vertex _v_, we define a parameterized rank-one tensor associated with it
as



\biggl( 1
(4.2) _W_ [(] _[v]_ [)] =
_x_ _[w]_ _v_ _[v]_



\biggr)
_,_



and for each edge ( _u,v_ ) _\in_ _E_, we define a matrix _B_ as

\biggl( 1 1\biggr)
(4.3) _B_ [(] _[u,v]_ [)] = _._
1 0


We map each vertex _v_ _V_ to a label _sv_ 0 _,_ 1, where we use 0 or 1 to denote a
_\in_ _\in \{_ _\}_
vertex is absent or present in _I_, respectively. These labels can be used as subscripts
of tensors to index tensor elements, e.g., _W_ 0 [(] _[v]_ [)] = 1 is the first element associated with
_sv_ = 0 and _W_ 1 [(] _[v]_ [)] = _x_ _[w]_ _v_ _[v]_ is the second element associated with _sv_ = 1, where _xv_ is
an element of some commutative semiring (e.g., listed in Table 1) associated with
vertex _v_ and its power with an integer is defined by repeated multiplication. The
label associated to the output tensor is an empty string _\varepsilon_, meaning this tensor has
rank 0, i.e., the output is a scalar. The independence constraint is encoded in the
edge tensors, where we use _B_ 11 [(] _[u,v]_ [)] = 0 to denote that two vertices connected by an
edge ( _u,v_ ) cannot both be in the independent set. The contraction of this tensor
network is



\prod _Bs_ [(] _[u,v]_ _usv_ [)] _[,]_

( _u,v_ ) _\in E_



(4.4) _P_ ( _G_ ) =



1
\sum


_s_ 1 _,s_ 2 _,...,s| V |_ =0



\prod _Ws_ [(] _v_ _[v]_ [)] \prod

_v\in V_ ( _u,v_ )



\prod



where the summation runs over all 2 _[| ][V][ | ]_ vertex configurations _s_ 1 _,s_ 2 _,...,s| V |_ and
_\{_ _\}_
accumulates the product of tensor elements to the output _P_ . A vertex tensor element
_Ws_ [(] _v_ _[v]_ [)] contributes a multiplicative factor _x_ _[w]_ _v_ _[v]_ whenever _v_ is in the set.


_Example_ 2. Here, we show a minimum example of mapping the independent problem
of a 2-vertex complete graph K2 (left) to a tensor network (right).


In the graphical representation of the tensor network on the right panel, we use
a circle to represent a tensor, a cyan hyperedge to represent the degree of freedom
_sa_, and a hyperedge in red to represent the degree of freedom _sb_ . Tensors sharing
the same degree of freedom are connected by the same hyperedge. The contraction
of this tensor network has the following form:



\bigl( \bigr) [\biggl( ] 1 1
_P_ (K2) = 1 _x_ _[w]_ _a_ _[a]_ 1 0



\biggr)



(4.5) 1
= 1 + _x_ _[w]_ _a_ _[a]_ + _x_ _[w]_ _b_ _[b]_ _[.]_



\biggr) \biggl( 1
_x_ _[w]_ _b_ _[b]_



The resulting polynomial represents three different independent sets _\{ \}_, _\{ a\}_, and _\{ b\}_
with weights 0, _wa_, and _wb_, respectively.
For a general graph, it is computationally inefficient to evaluate (4.4) by directly
summing up the 2 _[| ][V][ | ]_ products. A better approach to evaluate a tensor network is to
find a good pairwise tensor contraction order as a binary tree and then contract two
tensors at a time by this order.


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1245


Theorem 4.1. _The tensor network in_ (4.1) _for the independent set problem on_
_graph G_ = ( _V,E_ ) _can be contracted in cc_ ( IS( _G_ )) = _O_ ( _E_ )2 _[O]_ [(tw(] _[G]_ [))] _number of addi-_
_\scrN_ _|_ _|_
_tions and multiplications._


_Proof._ Let us denote the line graph---a graph obtained by mapping an edge in the
original graph to a vertex and connecting two vertices if and only if their associated
edges in the original graph share a common vertex---of the hypergraph representation
of a tensor network _\scrN_ as _L_ ( _\scrN_ ). A contraction order of _\scrN_ corresponds to a tree decomposition of _L_ ( _\scrN_ ) and the largest intermediate tensor has a rank equal to the width
of its tree decomposition [44]. Therefore, an optimal (in terms of space complexity)
contraction order corresponds to the tree decomposition of _L_ ( _\scrN_ ) with the smallest
width (or the treewidth tw( _L_ ( _\scrN_ )). The contraction complexity is _O_ ( _| \scrN |_ )2 _[O]_ [(tw(] _[L]_ [(] _[\scrN ]_ [)))],
where _| \scrN |_ is the number of tensors in _\scrN_ [44]. For the independent set problem on
graph _G_ = ( _V,E_ ), the line graph of the hypergraph representation of the tensor network in (4.1) is isomorphic to the graph _G_ up to some isolated vertices, hence the
contraction complexity of this tensor network with an optimal contraction order is
_O_ ( _| E|_ )2 _[O]_ [(tw(] _[G]_ [))] .

In practice, it is difficult to find an optimal contraction order for large tensor
networks because finding the treewidth is a well-known NP-hard problem. However,
it is easy to find a close-to-optimal contraction order within typically a few minutes
using a heuristic algorithm [38, 36]. For large-scale applications, it is also possible to
slice over certain degrees of freedom to reduce the space complexity, i.e., loop over
possible combinations of certain degrees of freedom so that one can have a smaller
tensor network inside the loop since these degrees of freedom are fixed.


_Example_ 3. In this example, we map a 5-vertex graph (left) to a tensor network
(right) and show how optimizing the contraction order reduces the time and space
complexities.







_W_ [(] _[e]_ [)]











_se_







_W_ [(] _[d]_ [)]


_W_ [(] _[c]_ [)]















One can represent a possible pairwise contraction of tensors as a binary tree
structure:

_R_ [ _n_ [2] ]


_Sbc_ [ _n_ [3] ]


_Bde_ _We_ _Wd_ _Bbd_ _Wb_ _Bcd_ _Wc_ _Bbc_ _Bab_ _Bac_ _Wa_


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1246 LIU, GAO, CAIN, LUKIN, AND WANG


The contraction process goes from bottom to top, where the root node stores
the contraction result, the leaves are input tensors, and the rest of the nodes are all
intermediate contraction results. Tensor subscripts are indices so that the number
of subscripts indicates the space complexity to store this tensor. The contraction
complexity to generate a tensor is annotated in the square brackets, where _n_ is the
dimension of the degree of freedoms, which is 2 in a tensor network mapped from an
independent set problem. One can easily check the largest tensor in contraction has a
space complexity _O_ ( _n_ [2] ) and this is the smallest among all possible contraction trees,
i.e., the treewidth of the original 5-vertex graph is 2. The time complexity is _O_ ( _n_ [3] ),
which is much smaller than that of direct evaluation _O_ ( _n_ [5] ).


**5. Independence polynomial.** Letting _xi_ = _x_ and _wi_ = 1, (4.4) corresponds
to the independence polynomial,



(5.1) _I_ ( _G,x_ ) =



_\alpha_ ( _G_ )
\sum _akx_ _[k]_ _,_


_k_ =0



where _ak_ is the number of independent sets of size _k_ and _\alpha_ ( _G_ ) _\equiv_ max _I_ \sum _v\in I_ _[w][v]_ [ is the]

size of an MIS, and it is also called the independence number. An independence polynomial is a useful graph characteristic related to, for example, the partition functions

[39, 57] and Euler characteristics of the independence complex [11, 40]. By assigning
a real number to _x_, one can evaluate this independence polynomial for this specific
value directly using tensor network contraction. For example, the total number of
independent sets can be evaluated as _I_ ( _G,_ 1). However, instead of evaluating this
polynomial for a certain value, we are more interested in knowing the coefficients of
this polynomial, because this quantity tells us the counting of independent sets at different sizes. To this end, let us create a polynomial number data type by representing
a polynomial _a_ 0 + _a_ 1 _x_ + _\cdot \cdot \cdot_ + _akx_ _[k]_ as a coefficient vector _a_ = ( _a_ 0 _,a_ 1 _,...,ak_ ) _\in_ \BbbR _[k]_,
e.g., _x_ is represented as (0 _,_ 1). Then we can define an algebra among coefficient vectors, including a redefinition of additive identity and multiplicative identity. To avoid
potential confusion, let us denote the additive identity as 0, and the multiplicative
identity is 1. The algebra between the polynomials number _a_ of order _ka_ and _b_ of
order _kb_ is specified as



_a \oplus_ _b_ = ( _a_ 0 + _b_ 0 _,a_ 1 + _b_ 1 _,...,a_ max( _ka,kb_ ) + _b_ max( _ka,kb_ )) _,_



(5.2: PN)



_a \odot_ _b_ = ( _a_ 0 + _b_ 0 _,a_ 1 _b_ 0 + _a_ 0 _b_ 1 _,a_ 2 _b_ 0 + _a_ 1 _b_ 1 + _a_ 0 _b_ 2 _,...,aka_ _bkb_ ) _,_



0 = () _,_



1 = (1) _,_


where _\oplus_ and _\odot_ are the standard polynomial addition and multiplication operations.

Theorem 5.1. _The independence polynomial_ [33 _,_ 22] _of a graph G_ = ( _V,E_ ) _can_
_be computed in time O_ ( _V_ log( _V_ )) _cc_ ( IS( _G_ )) _._
_|_ _|_ _|_ _|_ _\scrN_

_Proof._ By doing the following replacement of tensor elements from the standard
number type to the polynomial number type,



(5.3)



\left\{ 1 _\rightarrow_ 1 _,_

0 _\rightarrow_ 0 _,_
_x_ _[w]_ _v_ _[v]_ (0 _,_ 1) _,_
_\rightarrow_



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1247


the tensors _W_ and _B_, which were introduced in section 4, can thus be written as



\biggl( 1 \biggr) \biggl( 1 1
(5.4) \bigl( _W_ [PN][\bigr) ][(] _[v]_ [)] = _,_ \bigl( _B_ [PN][\bigr) ][(] _[u,v]_ [)] =
(0 _,_ 1) 1 0



\biggr)
_._



By contracting the tensor network with this polynomial type, we have the exact representation of the independence polynomial. In (5.2: PN), the addition can be computed
in time _O_ ( _k_ ), where _k_ = max( _ka,kb_ ), and the multiplication can be evaluated in time
_O_ ( _k_ log( _k_ )) using the convolution theorem [52]. Since _k_ is upper bounded by the MIS
size _\alpha_ ( _G_ ) _\leq | V |_, the time complexity of elementwise addition and multiplication operation is upper bounded by _| V |_ log( _| V |_ ). Combining with Theorem 4.1, the overall
time complexity is _O_ ( _V_ log( _V_ )) _cc_ ( IS( _G_ )).
_|_ _|_ _|_ _|_ _\scrN_

In practice, using the polynomial type suffers a space overhead proportional to
_\alpha_ ( _G_ ) because each polynomial requires a vector of such size to store the coefficients.
One may argue that one can first evaluate this polynomial at different _x_ being a real
number, and then apply the Gaussian elimination procedure to fit the coefficients of
this polynomial. However, in practice this seemingly more time- and space-efficient
approach suffers from precision issues. The data ranges of standard integer types are
too small to cover many practical use cases, while the floating-point numbers may
have round-off errors that are much larger than the value itself. These are because
the number of independent sets at different sizes may vary by tens or even hundreds
of orders of magnitude. For practical methods to evaluate these coefficients, we refer
readers to Appendix D, where we provide an accurate and memory-efficient method
to find the polynomial by contracting and fitting on finite-field algebra. For simplicity,
we use this less efficient polynomial algebra for the discussion in the main text.


**6. Maximum independent sets and its counting.**


**6.1. The number of independent sets.**
Theorem 6.1. _Let G_ = ( _V,E_ ) _be a graph. The total number of independent sets_
_of G can be computed in time cc_ ( IS( _G_ )) _._
_\scrN_

_Proof._ Let _x_ = 1 be a real constant number; the independence polynomial in the
previous section becomes



(6.1) _I_ ( _G,_ 1) =



_\alpha_ ( _G_ )
\sum _ak,_


_k_ =0



which corresponds to the total number of independent sets. The addition and multiplication of real number can be computed in _O_ (1) time, thus proving the theorem by
Theorem 4.1.


**6.2. Tropical algebra for finding the MIS size and counting MISs.** Letting _x_ = _\infty_, the independence polynomial in the previous section becomes



(6.2) _I_ ( _G,_ ) = lim
_\infty_ _x\rightarrow \infty_



_\alpha_ ( _G_ )
\sum _akx_ _[k]_ = _a\alpha_ ( _G_ ) _,_

_\infty_ _[\alpha ]_ [(] _[G]_ [)]
_k_ =0



where all terms except the one with the largest order vanish. We can thus replace the
polynomial type _a_ = ( _a_ 0 _,a_ 1 _,...,ak_ ) with a new type that has two fields: the largest
exponent _k_ and its coefficient _ak_ . From this, we can define a new algebra as


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1248 LIU, GAO, CAIN, LUKIN, AND WANG



\left\{



_ax_ _ay_ =
_\infty_ _[x]_ _\oplus_ _\infty_ _[y]_



( _ax_ + _ay_ ) _\infty_ [max(] _[x,y]_ [)] _,_ _x_ = _y,_
_ay_ _,_ _x < y,_
_\infty_ [max(] _[x,y]_ [)]
_ax_ _,_ _x > y,_
_\infty_ [max(] _[x,y]_ [)]



(6.3: P1)



_ax_ _ay_ = _axay_ _,_
_\infty_ _[x]_ _\odot_ _\infty_ _[y]_ _\infty_ _[x]_ [+] _[y]_



0 = 0 _\infty_ _[ - \infty ]_ _,_



1 = 1 _\infty_ [0] _._



Here, we have generalized the previous polynomial to the Laurent polynomial to define
the zero-element properly. To implement this algebra programmatically, we create a
data type with two fields ( _x,ax_ ) to store the MIS size and its counting, and define the
above operations and constants correspondingly. If one is only interested in finding
the MIS size, one can drop the counting field. The algebra of the exponents becomes
the max-plus tropical algebra [42, 45]:



_x \oplus_ _y_ = max( _x,y_ ) _,_



(6.4: T)



_x \odot_ _y_ = _x_ + _y,_



0 = _- \infty,_



1 = 0 _._



Algebra equations (6.4: T) and (6.3: P1) are the same as those used in Liu, Wang,
and Zhang [41] to compute the spin glass ground state energy and its degeneracy.


Theorem 6.2. _Let G_ = ( _V,E_ ) _be a graph. Its MIS size \alpha_ ( _G_ ) _can be computed in_
_time cc_ ( IS( _G_ )) _._
_\scrN_

_Proof._ By replacing the tensor elements from the standard number type to the
tropical numbers in (6.4: T), the vertex and edge tensors transform to



\biggl( 1
(6.5) \bigl( _W_ [T][\bigr) ][(] _[v]_ [)] =
_\infty_ _[w][v]_



\biggr) \biggl( 1 1\biggr)
_,_ \bigl( _B_ [T][\bigr) ][(] _[u,v]_ [)] = _._
1 0



The MIS can be obtained by contracting a tensor network with the above vertex tensors and edge tensors. Since the elementwise addition and multiplication can be computed in _O_ (1) time, the complexity of contracting this tensor network is _cc_ ( IS( _G_ ))
_\scrN_
by Theorem 4.1.


**6.3. Truncated polynomial algebra for counting independent sets of**
**large size.** Instead of counting just the MISs, one may also be interested in counting
the independent sets with the largest several sizes. For example, if one is interested
in counting only _a\alpha_ ( _G_ ) and _a\alpha_ ( _G_ ) _-_ 1, we can define a truncated polynomial algebra by
keeping only the largest two coefficients in the polynomial in (5.2: PN) as



_a \oplus_ _b_ = ( _a_ max( _ka,kb_ ) _-_ 1 + _b_ max( _ka,kb_ ) _-_ 1 _,a_ max( _ka,kb_ ) + _b_ max( _ka,kb_ )) _,_



(6.6: P2)



_a \odot_ _b_ = ( _aka -_ 1 _bkb_ + _aka_ _bkb -_ 1 _,aka_ _bkb_ ) _,_



0 = () _,_



1 = (1) _._


In the program, we thus need a data structure that contains three fields: the largest
order _k_, and the coefficients for the two largest orders _ak_ and _ak -_ 1. This approach
can clearly be extended to calculate more independence polynomial coefficients and is
more efficient than calculating the entire independence polynomial. Similarly, one can


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1249


also truncate the polynomial and keep only its smallest several orders. It can be used,
for example, to count the maximal independent sets with the smallest cardinality,
where a maximal independent set is an independent set that cannot be made larger
by adding a new vertex into it without violating the independence constraint. As
will be shown below, this algebra can also be extended to enumerate those large-size
independent sets.


Theorem 6.3. _The number of the largest K independent sets of a graph G_ =
( _V,E_ ) _can be computed in time O_ ( _K_ log _K_ ) _cc_ ( IS( _G_ )) _._
_\scrN_

The proof is similar to the proof of Theorem 5.1, except only _K_ largest coefficients
are involved in the addition and multiplication.


**7. Enumerating and sampling independent sets.**


**7.1. Set algebra for configuration enumeration.** The configuration enumeration of independent sets include, for example, the enumeration of all independent
sets, the enumeration of all MISs, and the enumeration of independent sets with the
largest several sizes. Recall that in the definition of a vertex tensor in (4.2), variables
carry labels, so that one can read out all independent sets directly from the output
polynomials. The multiplication between labeled variables is commutative while the
summation of labeled variables forms a set. Intuitively, one can use a bit string as
the representation of a labeled variable and use the bitwise or _\vee_ _[\circ ]_ as the multiplication operation. For example, in a 5-vertex graph, _x_ 2 and _x_ 5 can be represented as
01000 and 00001, respectively, and their multiplication _x_ 2 _x_ 5 can be represented as
01000 _\vee_ _[\circ ]_ 00001 = 01001. To enumerate all independent sets, we designed an algebra
on sets of bit strings:



_s \oplus_ _t_ = _s \cup_ _t,_



(7.1: SN)



_s \odot_ _t_ = _\{ \sigma_ _\vee_ _[\circ ]_ _\tau_ _|_ _\sigma_ _\in_ _s,\tau_ _\in_ _t\},_



0 = _\{ \},_



1 = _\{_ 0 _[\otimes | ][V][ | ]_ _\},_



where _s_ and _t_ are each a set of _| V |_ -bit strings.



_Example_ 4. For elements that are bit strings of length 5, we have the following set
algebra:



_\{_ 00001 _\} \oplus \{_ 01110 _,_ 01000 _\}_ = _\{_ 01110 _,_ 01000 _\} \oplus \{_ 00001 _\}_ = _\{_ 00001 _,_ 01110 _,_ 01000 _\}_

_\{_ 00001 _\} \oplus \{ \}_ = _\{_ 00001 _\},_



_\{_ 00001 _\} \odot \{_ 01110 _,_ 01000 _\}_ = _\{_ 01110 _,_ 01000 _\} \odot \{_ 00001 _\}_ = _\{_ 01111 _,_ 01001 _\}_



_\{_ 00001 _\} \odot \{ \}_ = _\{ \}_



_\{_ 00001 _\} \odot \{_ 00000 _\}_ = _\{_ 00001 _\} ._



Lemma 7.1. _The independent sets of a graph G_ = ( _V,E_ ) _can be enumerated in_
_time O_ ( _I_ _V_ ) _cc_ ( IS( _G_ )) _, where_ _I_ _is the number of independent sets._
_|_ _| \ast |_ _|_ _\scrN_ _|_ _|_

_Proof._ To enumerate over _I_, we initialize the variable _xi_ in the vertex tensor to
_xi_ = _\{_ _**\bfite**_ _i\}_, where _**\bfite**_ _i_ is a basis bit string of size _| V |_ that has only one nonzero value at
location _i_ . The vertex and edge tensors are thus



\biggl( 1
(7.2) \bigl( _W_ [SN][\bigr) ][(] _[v]_ [)] =
_**\bfite**_ _i_
_\{_ _\}_



\biggr) \biggl( 1 1
_,_ \bigl( _B_ [SN][\bigr) ][(] _[u,v]_ [)] =
1 0



\biggr)
_._



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1250 LIU, GAO, CAIN, LUKIN, AND WANG


The contraction of this tensor network is a set with its elements being all independent
set configurations. The time complexity of elementwise addition and multiplication
is upper bounded by _| I| \ast | V |_, where _| V |_ comes from the linear cost of representing a
_| V |_ -vertex configuration. Combining with Theorem 4.1, the overall time complexity
is _O_ ( _I_ _V_ ) _cc_ ( IS( _G_ )). In practice, the huge multiplicative factor _I_ only appears
_|_ _| \ast |_ _|_ _\scrN_ _|_ _|_
in the last step of tensor contraction. This complexity only serves as an upper bound
for the actual performance of the algorithm.


This set algebra can serve as the coefficients in (5.2: PN) to enumerate independent sets of all different sizes, (6.3: P1) to enumerate all MISs, or (6.6: P2) to
enumerate all independent sets of sizes _\alpha_ ( _G_ ) and _\alpha_ ( _G_ ) _-_ 1. As long as the coefficients
in a truncated polynomial are members of a commutative semiring, the polynomial
itself is a commutative semiring.
For example, to enumerate only the MISs, we can define a combined element type
_sk_, where the coefficients follow the algebra in (7.1: SN) and the exponents follow
_\infty_ _[k]_
the max-plus tropical algebra. The combined operations become



\left\{



_sx_ _sy_ =
_\infty_ _[x]_ _\oplus_ _\infty_ _[y]_



( _sx_ _sy_ ) _,_ _x_ = _y,_
_\cup_ _\infty_ [max(] _[x,y]_ [)]
_sy_ _,_ _x < y,_
_\infty_ [max(] _[x,y]_ [)]
_sx_ _,_ _x > y,_
_\infty_ [max(] _[x,y]_ [)]



(7.3: P1+SN)



_sx_ _sy_ = _\sigma_ _\tau_ _\sigma_ _sx,\tau_ _sy_ _,_
_\infty_ _[x]_ _\odot_ _\infty_ _[y]_ _\{_ _\vee_ _[\circ ]_ _|_ _\in_ _\in_ _\} \infty_ _[x]_ [+] _[y]_



0 = _\{ \} \infty_ _[ - \infty ]_ _,_



1 = _\{_ 0 _[\otimes | ][V][ | ]_ _\} \infty_ [0] _._



Lemma 7.2. _Let G_ = ( _V,E_ ) _be a graph and_ _\alpha_ _be the set of all MISs of G._ _\alpha_
_\scrI_ _\scrI_
_can be computed in time O_ ( _\alpha_ _V_ ) _cc_ ( IS( _G_ )) _._
_| \scrI_ _| \ast |_ _|_ _\scrN_

_Proof._ By replacing the tensor elements in section 4 with the number type defined
in (7.3: P1+SN) and with variable _x_ _[w]_ _v_ _[v]_ = _**\bfite**_ _v_, the vertex tensor and edge tensor
_\{_ _\} \infty_ _[w][v]_
become



\biggr)
_._



\biggl( 1
(7.4) \bigl( _W_ [P1+SN][\bigr) ][(] _[v]_ [)] =
_**\bfite**_ _v_
_\{_ _\} \infty_ _[w][v]_



\biggr) \biggl( 1 1
_,_ \bigl( _B_ [P1+SN][\bigr) ][(] _[u,v]_ [)] =
1 0



The enumeration of all MIS configurations corresponds to the contraction of this
tensor network. The time complexity of elementwise addition and multiplication is
upper bounded by the number of MISs _\alpha_ . Combining with Theorem 4.1, the overall
_| \scrI_ _|_
time complexity is _O_ ( _\alpha_ _V_ ) _cc_ ( IS( _G_ )).
_| \scrI_ _| \ast |_ _|_ _\scrN_

However, direct contraction might have significant space overheads for keeping
too many intermediate states irrelevant to the final MISs. We introduce the bounding
technique in Appendix C to avoid this issue. One may also be interested in the
more studied maximal independent sets [12, 20, 35] enumeration. We discuss this in
subsection B.1 since it requires using a different tensor network structure.



Lemma 7.3. _Let G_ = ( _V,E_ ) _be a graph and \scrI k be the set of independent sets with_
_size k. The independent sets with size k > \alpha_ ( _G_ ) _-_ _K of G can be computed in time_
_O_ ( _V_ _k_ = _\alpha_ ( _G_ ) _- K_ +1
_|_ _| \ast_ [\sum ] _[\alpha ]_ [(] _[G]_ [)] _[| \scrI ][k][| ]_ [)] _[cc]_ [(] _[\scrN ]_ [IS][(] _[G]_ [))] _[.]_

_Proof._ This can be proved by combining the set algebra equation (7.1: SN) with
the polynomial number truncated to largest _K_ orders (equation (6.6: P2)). The
number of bitstring operations in the addition and multiplication of the joint algebra
is upper bounded by the elements in the sets [\sum ] _k_ _[\alpha ]_ = [(] _[G]_ _\alpha_ [)] ( _G_ ) _- K_ +1 _[| \scrI ][k][| ]_ [. Combining with]


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1251


Theorem 4.1, the overall time complexity of contracting this tensor network is _O_ ( _V_
\sum _\alpha_ ( _G_ ) _|_ _| \_
_k_ = _\alpha_ ( _G_ ) _- K_ +1

_[| \scrI ][k][| ]_ [)] _[cc]_ [(] _[\scrN ]_ [IS][(] _[G]_ [)).]

If one is interested in obtaining only one MIS configuration, they can just keep one
configuration in each tensor element to save the computational effort. By replacing
the sets of bit strings in (7.1: SN) with a single bit string, we have the following
algebra:



_\sigma_ _\oplus_ _\tau_ = `select` ( _\sigma,\tau_ ) _,_



(7.5: S1)



_\sigma_ _\odot_ _\tau_ = ( _\sigma_ _\vee_ _[\circ ]_ _\tau_ ) _,_



0 = 1 _[\otimes | ][V][ | ]_ _,_



1 = 0 _[\otimes | ][V][ | ]_ _._


The `select` function picks one of _\sigma_ and _\tau_ by some criteria. It can be picking the one
smaller in the lexicographical order such that the addition operation is commutative
and associative. In most cases, it is completely fine for the `select` function to pick a
random one (not commutative and associative anymore) to generate a random MIS.


Proposition 7.4. _Let G_ = ( _V,E_ ) _be a graph. One of its MIS can be computed_
_in time O_ ( _V_ ) _cc_ ( IS( _G_ )) _._
_|_ _|_ _\scrN_

The proof is similar to Lemma 7.2, except the set algebra is replace by the one
in (7.5: S1), and the time complexity of elementwise addition and multiplication no
longer depends on _\alpha_ . The linear dependency of _V_ in the time complexity can be
_| \scrI_ _|_ _|_ _|_
remove using the back propagation technique, at the cost of additional space.


Theorem 7.5. _Let G_ = ( _V,E_ ) _be a graph. One of its MIS can be computed in_
_time cc_ ( IS( _G_ )) _._
_\scrN_

_Proof._ Let _\alpha_ ( _G_ ) = max _s\in I_ \sum _v_ _[s][v]_ [ be the MIS size. The optimal configuration can]

be obtained by differentiating over vertex tensors as



(7.6)



\Biggl\{ 1 _,_ _\\_ ( _G_ )



1 _,_ _\partial sv_ = 1 _,_

0 _,_ _\\_ ( _G_ ) = 0 _._



_\partial sv_ = 0 _._



It can be numerically computed by differentiating over the process of the tropical
tensor network contraction, where the backward rules can be found in Appendix C.
The time overhead of computing a single optimal solution is constant compared to
only computing the contraction. Thus, the computing time complexity should be the
same as in Theorem 6.2.


**7.2. Sampling from the extremely large configuration space.** When the
problem size becomes larger, a set of all bitstrings might be impossible to fit into
any type of storage. To get something meaningful out of the configuration space,
we use a binary sum-product expression tree as a compact representation of a set
of configurations, i.e., instead of directly computing a set using the algebra in (7.1:
SN), we store the process of computing it. Each node in this tree is a quadruple
( _type,data,left,right_ ), where _type_ is one of `LEAF`, `ZERO`, `SUM`, and `PROD`, _data_ is a bit
string as the content in a `LEAF` node, and _left_ and _right_ are left and right operands
of a `SUM` or `PROD` node.



_s \oplus_ _t_ = ( `SUM` _,/,s,t_ ) _,_



(7.7: EXPR)



_s \odot_ _t_ = ( `PROD` _,/,s,t_ ) _,_



0 = ( `ZERO` _,/,/,/_ ) _,_



1 = ( `LEAF` _,_ 0 _[\otimes | ][V][ | ]_ _,/,/_ ) _._


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1252 LIU, GAO, CAIN, LUKIN, AND WANG


This algebra is a commutative semiring because we define the equivalence of
two sum-product expression trees by comparing their expanded (using (7.1: SN))
forms rather than their storage. In addition to using the sum-product expression tree
directly as tensor elements, one can also let it be the coefficients of a (truncated)
polynomial to compute such trees for independent sets with the largest several sizes.


Theorem 7.6. _The independent sets I of a graph G_ = ( _V,E_ ) _can be enumerated_
_in time cc_ ( IS( _G_ )) + _O_ ( _V_ _I_ ) _._
_\scrN_ _|_ _| \ast |_ _|_

_Proof._ By replacing the tensor elements with the number type in (7.7: EXPR)
with _x_ _[w]_ _v_ _[v]_ mapped to ( `LEAF` _,_ _**\bfite**_ _i,/,/_ ), the vertex tensor and edge tensor become



\biggl( 1 \biggr) \biggl( 1 1
(7.8) \bigl( _W_ [EXPR][\bigr) ][(] _[v]_ [)] = _,_ \bigl( _B_ [EXPR][\bigr) ][(] _[u,v]_ [)] =
( `LEAF` _,_ _**\bfite**_ _i,/,/_ ) 1 0



\biggr)
_._



The contraction result of this tensor network corresponds to a sum-product expression
tree for the set of independent sets. Unlike in Lemma 7.1, the contraction complexity
is independent of the set size, i.e., the time complexity is _cc_ ( IS( _G_ )) by Theorem 4.1.
_\scrN_
The time complexity to evaluating this expression tree is _O_ ( _| V | \ast | I|_ ), where _| V |_ comes
from the number of bits to represent a configuration. Proving the theorem by adding
two computing times.


Similarly, we have the following corollary by combining the sum-product expression tree algebra with the truncated polynomial.

Corollary 7.7. _Let G_ = ( _V,E_ ) _be a graph and \scrI k be the number of independent_
_sets with size k. The independent sets with size k > \alpha_ ( _G_ ) _-_ _K can be computed in_
_time O_ ( _K_ log _K_ ) _cc_ ( IS( _G_ )) + _O_ ( _V_ _k_ = _\alpha_ ( _G_ ) _- K_ +1
_\scrN_ _|_ _| \ast_ [\sum ] _[\alpha ]_ [(] _[G]_ [)] _[| \scrI ][k][| ]_ [)] _[.]_

Again, the theorem can be proven by relating it with its set algebra version in
Lemma 7.3. Because it is unlikely that one can collect all configurations represented
by a sum-product expression tree into a set due to its space complexity, one can also
use this construction to produce unbiased samples of the sum-product tree.


Theorem 7.8. _Let G_ = ( _V,E_ ) _be a graph. Its independent sets with size k >_
_\alpha_ ( _G_ ) _K can be unbiasedly sampled in time cc_ ( IS( _G_ )) + _O_ ( _V_ _E_ _M_ ) _, where M_
_-_ _\scrN_ _|_ _| \ast |_ _| \ast_
_is the number of samples._


_Proof._ Similar to the proof of Theorem 7.6, we first obtain a sum-product tree
representation of the configurations in time _cc_ ( IS( _G_ )). Then we generate a sample
_\scrN_
using the following procedure with cost _O_ ( _| V | \ast | E|_ ). The sampling program starts
from the root node and descends this tree recursively to the left and right siblings. If
a node has type `SUM`, the program draws samples from the left and right siblings with
a probability decided by the size of each subtree and returns the union of samples.
Otherwise, if a node has type `PROD`, the program draws two sets of samples of equal
sizes from its left and right siblings and returns the elementwise multiplication ( _\vee_ _[\circ ]_ )
of them. The recursion stops at a `LEAF` node having size 1 or a `ZERO` node having size
0. In a sum-product expression tree, the number of configurations of subtrees can be
determined easily, as we will show in the following example.


_Example_ 5. Let us consider the sum-product expression tree


( `SUM` _,/,_ ( `PROD` _,/,A,B_ ) _,_ ( `SUM` _,/,C,D_ )) _,_


where subtrees _A,B,C_, and _D_ can be any of the four types of nodes. This sumproduct expression tree can be represented diagrammatically as the following:


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1253


_\oplus_


_\odot_ _\oplus_


_A_ _B_ _D_ _C_

The left and right siblings of the root node have sizes _| A| \ast | B|_ and _| C|_ + _| D|_,
respectively, while the root node size can be computed as _| A| \ast | B|_ + _| C|_ + _| D|_ . The
sizes of _A,B,C_, and _D_ can be computed recursively until the program meets either a
`LEAF` node or a `ZERO` node, which has a known size of 1 or 0.
Since the depth of the expression tree is _O_ ( _| E|_ ) and the cost of each arithmetic
operation is _O_ ( _| V |_ ), the overall time complexity to generate a sample is _O_ ( _| V | \ast | E|_ ),
hence proving the theorem.


Similarly, if one is only interested in obtaining independent sets with largest _K_
sizes, we have the following corollary.


Corollary 7.9. _Let G_ = ( _V,E_ ) _be a graph. Its independent sets with size k >_
_\alpha_ ( _G_ ) _K can be unbiasedly sampled in time O_ ( _K_ log _K_ ) _cc_ ( IS( _G_ ))+ _O_ ( _V_ _E_ _M_ ) _,_
_-_ _\scrN_ _|_ _| \ast |_ _| \ast_
_where M is the number of samples._


**8. Weighted graphs.** All the solution space properties and the corresponding
algebra on unweighted graphs still hold for integer-weighted graphs, while for general weighted graphs, the independence polynomial is not well defined anymore. For
general weighted graphs, it is more useful to know the _k_ maximum weighted sets
and their sizes. They can be computed by the extended tropical algebra, which is a
natural generalization of the max-plus tropical algebra:



_s \oplus_ _t_ = `largest` ( _s \cup_ _t,k_ ) _,_



(8.1: Tk)



_s \odot_ _t_ = `largest` ( _\{ a_ + _b |_ _a \in_ _s,b \in_ _t\},k_ ) _,_



0 = _- \infty_ _[\otimes ][k]_ _,_



1 = _- \infty_ _[\otimes ][k][ - ]_ [1] _\otimes_ 0 _,_



where `largest` ( _s,k_ ) means truncating the set _s_ by only keeping its _k_ largest values.



Theorem 8.1. _Let G_ = ( _V,E_ ) _be a weighted graph. Its K largest independent set_
_sizes can be computed in time O_ ( _K_ log _K_ ) _cc_ ( IS( _G_ )) _._
_\scrN_

_Proof._ The _K_ largest independent sets can be computed by contracting a tensor
network with extended tropical numbers. The vertex tensor and edge tensor are



\biggl( 1
(8.2) \bigl( _W_ [T] _[k]_ [\bigr) ][(] _[v]_ [)] =
_wv_
_- \infty_ _[\otimes ][k][ - ]_ [1] _\otimes_



\biggr) \biggl( 1 1
_,_ \bigl( _B_ [T] _[k]_ [\bigr) ][(] _[u,v]_ [)] =
1 0



\biggr)
_,_



where we have used _x_ _[w]_ _v_ _[v]_ = ( 1) _[w][v]_ = _wv_ .
_- \infty_ _[\otimes ][k][ - ]_ [1] _\otimes_ _- \infty_ _[\otimes ][k][ - ]_ [1] _\otimes_
The computation of _s \odot_ _t_ is a maximum sum combination problem that can be
done in time _O_ ( _k_ log( _k_ )) using the algorithm in section SM4. Hence, the overall time
complexity of contracting the tensor network is _O_ ( _K_ log _K_ ) _cc_ ( IS( _G_ )).
_\scrN_

Corollary 8.2. _Let G_ = ( _V,E_ ) _be a weighted graph. Its K largest independent_
_sets can be computed in time O_ ( _V_ _K_ log _K_ ) _cc_ ( IS( _G_ )) _._
_|_ _| \ast_ _\scrN_

To find solutions corresponding to the largest _K_ sizes, one can combine the extended tropical algebra with the bit-string algebra (equation (7.5: S1)). Since the
_\oplus_ operation of the configuration sampler is not used in the combined algebra, the
resulting configurations are deterministic and complete.



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1254 LIU, GAO, CAIN, LUKIN, AND WANG











Fig. 2. _The types of graphs used in the case study in subsection_ 9.1 _. The lattice dimensions are_
_L \times_ _L._ (a) _Square lattice graphs._ (b) _Square lattice graphs with a filling factor p_ = 0 _._ 8 _._ (c) _King's_
_graphs._ (d) _King's graphs with a filling factor p_ = 0 _._ 8 _._


**9. Example applications.**


**9.1. Number of independent sets and entropy constant for hardcore**
**lattice gases.** We compute the counting of all independent sets for graphs shown
in Figure 2, where vertices are all placed on square lattices of dimensions _L \times_ _L_ .
The types of graphs include the square lattice graphs (Figure 2(a)), the square lattice
graphs with a filling factor _p_ = 0 _._ 8, which means _\lfloor pL_ [2] _\rceil_ sites are occupied with vertices
(Figure 2(b)), the King's graphs (Figure 2(c)), and the King's graphs with a filling
factor _p_ = 0 _._ 8 (Figure 2(d)), which is the ensemble of graphs used in [19] to benchmark
quantum algorithms on a Rydberg atom array quantum computer.
The number of independent sets for square lattice graphs of size _L\times L_ form a wellknown integer sequence (OEIS A006506), which is thought of as a two-dimensional
generalization of the Fibonacci numbers. We computed the integer sequence for _L_ = 38
and _L_ = 39, which, to the best of our knowledge, was not known before. In the
computation, we used finite-field algebra for contracting integer tensor networks with
arbitrarily high precision.
A theoretically interesting number that can be computed using the number of
independent sets is the entropy constant, which can describe the thermodynamic
properties of hard-core lattice gases at the high-temperature limit. For the square
lattice graphs, this number is called the _hard square entropy constant_ (OEIS A085850),
which is defined as lim _L\rightarrow \infty_ _F_ ( _L,L_ ) [1] _[/L]_ [2], where _F_ ( _L,L_ ) is the number of independent
sets of a given lattice dimensions _L \times_ _L_ . This quantity arises in statistical mechanics
of hard-square lattice gases [5, 49] and is used to understand phase transitions for
these systems. This entropy constant is not known to have an exact representation,
but it is accurately known in many digits. Similarly, we can define entropy constants
for other lattice gases. In Figure 3, we look at how _F_ ( _L,L_ ) [1] _[/][\lfloor ][pL]_ [2] _[\rceil ]_ scales as a function
of the grid size _L_ for all types of graphs shown in Figure 2. Our results match the
known results for the nondisordered square lattice and King's graphs. For disordered
square lattice and King's graphs with a filling factor _p_ = 0 _._ 8, we randomly sample
1000 graph instances. To our knowledge, the entropy constants for these disordered
graphs have not been studied before. They may be used to study phase transitions
for disordered lattices, which are typically much harder to understand. Interestingly,
the variations due to different random instances are negligible for this quantity.


**9.2. The overlap gap property.** With this tool to enumerate or sample configurations, one can understand the structure of the independent set configuration
space, such as the optimization landscape for finding the MISs. One of the known


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1255











Fig. 3. _Mean entropy for lattice gases on graphs defined in Figure_ 2 _. We sampled_ 1000 _in-_
_stances for p_ = 0 _._ 8 _lattices and the error bar is too small to be visible. The horizontal black dashed_
_lines are for_ lim _L\rightarrow \infty_ _F_ ( _L,L_ ) [1] _[/L]_ [2] _for the corresponding non-disordered square lattice and King's_
_graphs._


barriers to finding the MIS is the so-called overlap gap property [26, 25]. If the overlap
gap property is present, it means every two large independent sets have either a significant intersection or a very small intersection; it implies that large independent sets
are clustered together. This clustering property has been used to rigorously prove upper bounds on the performance of local search algorithms [26, 25]. To investigate the
overlap gap property, we compute pairwise Hamming distance distributions of large
independent sets as they are good indicators of the presence or absence of overlap
gap properties. We inspect two types of graphs that are particularly interesting, the
King's graphs with defects and 3-regular graphs. It is known that the MIS problem on
a general graph can be mapped to the King's graph with defects [27, 19]. However, it
is not clear whether the MIS problem defined on a randomly generated King's graph
with defects can have the overlap gap property. It is known that finding MISs of
_d_ -regular graphs has the overlap gap property [51, 24] when both _d_ and the graph
sizes are large, but it is not known whether, for small _d_, e.g., for 3-regular graphs,
this statement remains true. We randomly generated 9 instances for each category
of King's graph at 0 _._ 8 filling with dimensions 20 _\times_ 20 (320 vertices) and 3-regular
graphs with 110 vertices. At this problem size, there are too many independent sets
to fit into any storage, hence we combine the truncated polynomial and sum-product
expression tree to directly sample from the target configuration space. For each instance _G_, we sample 10 [4] pairs of configurations from the independent sets of sizes _\geq_
_\lceil \gamma_ _\times_ _\alpha_ ( _G_ ) _\rceil_ and show the pairwise Hamming distance distribution in Figure 4. We
observe a clear single peak structure at a fixed distance normalized by the MIS size
for the King's graphs, indicating the absence of the overlap gap property in a random
King's graph at 0 _._ 8 filling. Since the MIS problem on an arbitrary graph can be
mapped to a King's graph at a certain filling, this result is highly nontrivial. It likely
implies that the King's graphs with defects mapped from hard MIS instances have a
very small measure in the total defected King's graph space. In contrast, very different pairwise Hamming distributions are obtained in Figure 4(b), where we observed
the multiple peak structure when the control parameter _\gamma_ is big enough. It indicates
the existence of disconnected clusters in the configuration space of the MIS problem
on 3-regular graphs. We expect this numerical tool can be used to understand this
phenomenon better and to further investigate the graph properties and the geometry
of the configuration spaces for a variety of graph instances.


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1256 LIU, GAO, CAIN, LUKIN, AND WANG


Fig. 4. _Pairwise Hamming distances distribution for configurations sampled from independent_
_sets with sizes \geq \lceil \gamma_ _\times_ _\alpha_ ( _G_ ) _\rceil . In each plot, the x-axis is the Hamming distance normalized by the_
_total number of vertices and the y-axis is the probability._


**9.3. Analyzing quantum and classical algorithms for maximum inde-**
**pendent set.** In a recent work, the ability to enumerate configurations and compute
independence polynomials was critical in understanding the performance of quantum
optimization algorithms for the MIS problem on a Rydberg atom quantum computer

[19]. This work focused on exploring King's graphs with 0 _._ 8 filling. The hardest
instances for classical simulated annealing could be accurately predicted from the independence polynomial, which gave information about the density of local minima at
different independent set sizes. On the hardest graph instances for simulated annealing
studied in the experiment, a high density of local minima were found at independent
set sizes of _\alpha_ ( _G_ ) _-_ 1 _,_ which the algorithm became trapped in instead of finding the
optimal solution of size _\alpha_ ( _G_ ). By enumerating the configurations using techniques
described in the present work, we found that simulated annealing randomly explores
the independent sets of size _\alpha_ ( _G_ ) _-_ 1 until an optimum solution is found. Therefore,
the large ratio of local to global minima prevents simulated annealing from efficiently
finding an MIS.
Although the performance of the quantum algorithm is more challenging to understand due to the inherent difficulty in studying quantum systems, the present
methods allow one to gain significant insights by visualizing the experimental outputs
of a quantum algorithm over the solution space, as shown in Figure 5 for instances
with 39 nodes [19]. Here, the structure of the solution space is shown on a graph
where each vertex represents a large independent set. Each edge represents a pair
of independent sets that differ by a swap operation or a vertex addition to the set,
which are the operations naturally present in the effective dynamics at the end of the
quantum algorithm. The solution space graph is well-connected by local changes to
the spin configurations, it has a small diameter, and the degree of each node appears
to concentrate. This visualization makes it clear that the quantum algorithm does
not appear to return solely local minima with a large Hamming distance from the
MISs as suggested for adiabatic algorithms, e.g., by [4], which would appear as a
long path on the solution space graph from the sampled local minima to the MIS.


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1257


Count

158





1
0



Fig. 5. _Visualization of experimental outputs of a quantum algorithm for solving the MIS prob-_
_lem_ [19] _. Each vertex represents an independent set, and each edge represents a pair of independent_
_sets that differ by a swap operation or a vertex addition/removal._


Instead, the quantum algorithm samples from local minima across the solution space
graph with a wide range of Hamming distances from the MISs. In the case where
a large superposition state of local minima is created during the coherent evolution,
the quantum algorithm achieves a quadratic speedup over simulated annealing [19].
Looking forward, we expect these tools can be applied to understanding the performance of quantum and classical algorithms on a wide class of NP-hard combinatorial
optimization problems.


**10. Discussion and conclusion.** In this work, we introduced a framework that
uses generic tensor networks to compute different solution space properties of a certain
class of NP-hard combinatorial optimization problems. Each solution space property
is computed using the same tensor network with different tensor element algebra.
The different data types introduced in the main text to compute these properties are
summarized in the diagram in Figure 1. The class of problems solvable by a tensor
network includes but is not limited to MISs and a variety of other combinatorial
problems such as the matching problem, the _k_ -coloring problem, the max-cut problem,
the set packing problem, and the set covering problem, as detailed in Appendix B.
Looking ahead, it could be possible to generalize the idea of generic programming
to other algorithms that have certain algebraic structures such as those using the
inclusion-exclusion principle or subset convolution [23] and explore what new properties can be computed. To this end, dynamic programming [17, 23] approaches could
be considered. Dynamic programming is closely related to a tropical tensor network

[41]; for example, the Viterbi algorithm for finding the most probable configuration
in a hidden Markov model can be interpreted as a matrix product state featured
with tropical algebra, and the tropical tensor network in the main text is potentially
equivalent to dynamic programming in finding an optimum solution. Since dynamic
programming has much broader applications, it would be interesting to extend the
ideas from this paper to provide an algebraic interpretation for dynamic programming so that it can be used to compute other solution space properties beyond just
finding an optimum solution. It is also possible to extend this idea to other algebras.
For example, generic semiring algebra has been used in computational linguistics to
compute interesting quantities of a given grammar and string [30].
The source code in the Julia language for this paper can be found in the GitHub
repository [1]. There is a short introduction to this repository as well a gist to show


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1258 LIU, GAO, CAIN, LUKIN, AND WANG


how it works in section SM5. We expect our tool can be used to understand and
study many interesting applications of independent sets and beyond. We also hope
the toolkit we built, including tensor network contraction order optimization and
efficient tropical matrix multiplication, can be helpful to the development of other
scientific software.


**Appendix A. An alternative way to construct the tensor network.** Let
us characterize the independent set problem on graph _G_ = ( _V,E_ ) as an energy model
with two parts,



\sum _wisi_ + _\infty_ \sum

_i\in V_ ( _i,j_ ) _\in_



(A.1) _\scrE_ ( _G,s_ ) = _-_ \sum



_sisj,_

( _i,j_ ) _\in E_



where _si_ is a spin on vertex _i \in_ _V_ and _wi_ is an onsite energy term associated with it.
The first part corresponds to the negative independent set size and the second part
describes the independence constraint, which corresponds to the Rydberg blockade

[50, 19] in cold atom arrays or the repulsive force in hardcore lattice models [18, 21].
The partition function is defined as



_e_ _[ - ][\beta ][\scrE ]_ [(] _[G,s]_ [)] = \sum
_s_ _s\in \scrI_ (



_Z_ ( _G,\beta_ ) = \sum



\sum _e_ _[\beta ]_ [\sum ] _[w][i][s][i]_


_s\in \scrI_ ( _G_ )



(A.2)



=



_\alpha_ ( _G_ )
\sum _a_ ( _k_ ) _e_ _[\beta k]_ ( _k_ = \sum _wisi_ ) _,_


_k_ =0



where _\scrI_ ( _G_ ) is the set of independent sets of graph _G_, _\alpha_ ( _G_ ) is the absolute value of
the minimum energy (MIS size), and _a_ ( _k_ ) is the number of spin configurations with
energy _- k_ (independent sets of size _k_ ). The partition function can be expressed as a
tensor network by placing a vertex tensor on each spin _i \in_ _V,_



\biggl( 1
(A.3) _W_ [(] _[i]_ [)] =
_e_ _[\beta w][i]_



\biggr)
_,_



and an edge tensor on each bond ( _u,v_ ) _\in_ _E,_



\biggr)
_,_



\biggl( 1 1
(A.4) _B_ [(] _[u,v]_ [)] =
1 0



where the 0 in the edge tensor comes from _e_ _[ - ][\beta ][\infty ]_ in the second term of (A.1), which
is the independence constraint. By letting _x_ = _e_ _[\beta ]_, we get the tensor network for
computing the independence polynomial as described by (4.2) and (4.3). If we further
let _wi_ = 1, the second line of (A.2) is equivalent to the independence polynomial.


**Appendix B. Hard problems and tensor networks.**


**B.1. Maximal independent sets and maximal cliques.** In this section, we
focus the discussion on the maximal independent sets problem since finding maximal cliques of a graph is equivalent to finding the maximal independent sets of its
complement. Let _G_ = ( _V,E_ ) be a graph; we denote the neighborhood of a vertex
_v \in_ _V_ as _N_ ( _v_ ). A maximal independent set _Im_ is an independent set such that no
_v_ _V_ satisfies _Im_ ( _v_ _cupN_ [ _v_ ]) =, i.e., an independent set that cannot become a
_\in_ _\cap_ _\{_ _\}_ _\emptyset_
larger one by adding a new vertex. The corresponding tensor network mIS( _G_ ) can
_\scrN_
be specified as



(B.1)



\Lambda = _sv_ _v_ _V_ _,_
_\{_ _|_ _\in_ _\}_



= _Ts_ [(] _N_ _[v]_ [)] ( _v,_ 1) _sN_ ( _v,_ 2) _...sN_ ( _v,d_ ( _v_ )) _sv_
_\scrT_ _\{_ _[| ]_ _[v][ \in ]_ _[V][ \} ][,]_



_**\bfitsigma**_ _o_ = _\varepsilon,_



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1259



where we defined a tensor for each _v \in_ _V_ and its neighborhood _N_ ( _v_ ) as



(B.2) _Ts_ [(] _N_ _[v]_ [)] ( _v,_ 1) _sN_ ( _v,_ 2) _...sN_ ( _v,d_ ( _v_ )) _sv_ [=]



\Biggl\{
_svx_ _[w]_ _v_ _[v]_ _[,]_ _sN_ ( _v,_ 1) = _sN_ ( _v,_ 2) = _\cdot \cdot \cdot_ = _sN_ ( _v,d_ ( _v_ )) = 0 _,_
1 _sv_ otherwise _._
_-_



Here, _N_ ( _v,k_ ) is the _k_ th vertex in _N_ ( _v_ ) and _d_ ( _v_ ) = _| N_ ( _v_ ) _|_ is the degree of vertex _v_ .
If _sv_ = 1, then none of its neighbors can be a member of _Im_ by the independence
constraint, contributing a factor _x_ _[w]_ _v_ _[v]_ [. If] _[ s][v]_ [= 0, then at least one of its neighbors]
must be in _Im_ by the maximal constraint, contributing a unit factor. For a degree 2
vertex _v_, the tensor has the following form:



\left(



\biggr)



\right)


_[.]_



(B.3) _T_ [(] _[v]_ [)] =



\biggl( 0 1
1 1



\biggl( _x_ _[w]_ _v_ _[v]_ 0\biggr)
0 0



Theorem B.1. _The tensor network representation of a maximal independent set_
_problem on a graph G_ = ( _V,E_ ) ( _equation_ (B.1)) _can be contracted in cc_ ( _mIS_ ( _G_ )) =
_\scrN_
_O_ ( _| V |_ )2 _[O]_ [(tw(] _[G]_ [)\Delta )] _number of additions and multiplications, where_ \Delta _is the maximum_
_degree of vertices in G._

_Proof._ The prefactor _| V |_ comes from the number of tensors, while the contraction
complexity of pairwise tensor contraction is closely related to the treewidth of the
line graph of its hypergraph representation tw( _L_ ( _mIS_ ( _G_ ))). In the following, we
_\scrN_
will show this quantity is upper bounded by (\Delta + 1) times the treewidth of _G_ . In the
line graph _L_ ( _mIS_ ( _G_ )), a tensor _T_ [(] _[v]_ [)] corresponds to a clique over _N_ ( _v_ ) _v_ . In the
_\scrN_ _\cup \{_ _\}_
following, we will show that given an optimal tree decomposition of _G_, it is always
possible to include all cliques into the bags by increasing the bag size by a factor
(\Delta + 1). Let _v \in_ _V_ be a vertex and _N_ ( _v_ ) be its neighborhood; we first arbitrarily
pick an edge _u \in_ _N_ ( _v_ ); then by the definition of tree decomposition, we can find a
bag containing this edge, and last we include all _N_ ( _v_ ) _\cup \{ v\}_ into this bag. Hence the
maximum tensor rank during contraction is upper bounded by tw( _G_ )\Delta, proving the
theorem.


Let us consider the graph in Example 1. The corresponding tensor network structure for computing the maximal independent polynomial has the following hypergraph
representation:


_sa_ _sb_ _sc_ _sd_ _se_


By contracting this tensor network with generic element types, we can compute
the maximal independent set properties such as the maximal independence polynomial and the enumeration of maximal independent sets. The maximal independence
polynomial is defined as



(B.4) _Dm_ ( _G,x_ ) =



_\alpha_ ( _G_ )
\sum _bkx_ _[k]_ _,_


_k_ =0



where _bk_ is the number of maximal independent sets of size _k_ . Comparing with the
independence polynomial in (5.1), we have _bk \leq_ _ak_ and _b\alpha_ ( _G_ ) = _a\alpha_ ( _G_ ). _Dm_ ( _G,_ 1)


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1260 LIU, GAO, CAIN, LUKIN, AND WANG


counts the total number of maximal independent sets [28, 43]; to our knowledge, the
best algorithm has a time complexity _O_ (1 _._ 3642 _[| ][V][ | ]_ ) [28].
The benchmark of computing the maximal independent set properties on 3-regular
graphs is shown in section SM1.


**B.2. Matching problem.** A _k_ -matching in a graph _G_ = ( _V,E_ ) is a set of _k_
edges no two of which have a vertex in common. We map an edge ( _u,v_ ) _\in_ _E_ to a
degree of freedom _\langle u,v\rangle \in \{_ 0 _,_ 1 _\}_ in a tensor network, where 1 means an edge is in
the set and 0 otherwise. The tensor network representation for the matching problem
_\scrN_ match can be specified as



(B.5)



\Lambda = _\{ \langle u,v\rangle |_ ( _u,v_ ) _\in_ _E\},_



= _W\langle_ [(] _v,N_ _[v]_ [)] ( _v,_ 1) _\rangle \langle v,N_ ( _v,_ 2) _\rangle ...\langle v,N_ ( _v,d_ ( _v_ )) _\rangle_ _[| ]_ _[v][ \in ]_ _[V][ \} \cup \{ ][B]_ _\langle_ [(] _u,v_ _[u,v]_ _\rangle_ [)] _[| ]_ [(] _[u,v]_ [)] _[ \in ]_ _[E][\} ][,]_
_\scrT_ _\{_



_**\bfitsigma**_ _o_ = _\varepsilon,_



where for each _v \in_ _V_, we define a vertex tensor over its neighborhood _N_ ( _v_ ) as



(B.6) _W\langle_ [(] _v,N_ _[v]_ [)] ( _v,_ 1) _\rangle \langle v,N_ ( _v,_ 2) _\rangle ...\langle v,N_ ( _v,d_ ( _v_ )) _\rangle_ [=]



\Biggl\{ 1 _,_ \sum _di_ =1( _v_ )

_[\langle ][v,N]_ [(] _[v,i]_ [)] _[\rangle \leq ]_ [1] _[,]_
0 otherwise _,_



and for each bond ( _u,v_ ) _\in_ _E_, we define a rank one tensor as



(B.7) _B\langle_ [(] _u,v_ _[u,v]_ _\rangle_ [)] [=]



\Biggl\{ _x_ 1 _,w\langle u,v\langle u,v\rangle_ _\rangle_ _[,]_ _\langle u,vu,v\rangle_ = 0= 1 _,._
_\langle_ _\rangle_



Here, _N_ ( _v,k_ ) is the _k_ th vertex in _N_ ( _v_ ) and _d_ ( _v_ ) = _| N_ ( _v_ ) _|_ is the degree of vertex _v_ ;
a label _\langle v,u\rangle_ is equivalent to _\langle u,v\rangle_ . _W_ tensor specifies the constraint that a vertex
cannot be shared by two edges in the edge set, and an edge tensor carries the weights.


Theorem B.2. _The tensor network representation of a matching problem_
_on graph G_ = ( _V,E_ ) ( _equation_ (B.5)) _can be contracted in cc_ ( match( _G_ )) =
_\scrN_
_O_ ( _| V |_ )2 _[O]_ [(tw(] _[L]_ [(] _[G]_ [))] _number of additions and multiplications, where L_ ( _G_ ) _is the line_
_graph of G._


_Proof._ To contract the tensor network, we first absorb edge tensors into the
vertex tensors, which does not increase computational complexity. After this, the
resulting tensor network is isomorphic to _G_ . Hence the contraction complexity is
_O_ ( _| V |_ )2 _[O]_ [(tw(] _[L]_ [(] _[G]_ [))] .

Let _x\langle wu,v\langle u,v\rangle_ _\rangle_ = _x_ ; the tensor network contraction corresponds to the matching
polynomial



(B.8) _M_ ( _G,x_ ) =



_| V | /_ 2
\sum _ckx_ _[k]_ _,_


_k_ =1



where _k_ is the size of an edge set, and a coefficient _ck_ is the number of _k_ -matchings.


**B.3. Vertex coloring.** Let _G_ = ( _V,E_ ) be a graph. A vertex coloring is an
assignment of colors to each vertex _v \in_ _V_ such that no edge connects two identically
colored vertices. In a _k_ -coloring problem, the number of colors is limited to less than
or equal to _k_ . Let us use the 3-coloring problem as an example to show how to
reduce it to tensor contractions. We first map a vertex _v \in_ _V_ to a degree of freedom


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1261


_cv_ 0 _,_ 1 _,_ 2 . The tensor network for the vertex coloring problem 3-color( _G_ ) can be
_\in \{_ _\}_ _\scrN_
specified as



(B.9)



\Lambda = _cv_ _v_ _V_ _,_
_\{_ _|_ _\in_ _\}_



= _Wc_ [(] _v_ _[v]_ [)] _cucv_
_\scrT_ _\{_ _[| ]_ _[v][ \in ]_ _[V][ \} \cup \{ ][B]_ [(] _[u,v]_ [)] _[| ]_ [(] _[u,v]_ [)] _[ \in ]_ _[E][\} ][,]_



_**\bfitsigma**_ _o_ = _\varepsilon,_



where for each vertex _v_ _V_, we define a tensor labeled by _cv,_
_\in_



\right)


_,_



(B.10) _W_ [(] _[v]_ [)] =



\left( 1 _cv_ = _r_

1 _cv_ = _g_
1 _cv_ = _b_



and for each edge ( _u,v_ ) _E_, we define a tensor labeled by ( _cu,cv_ ) as
_\in_



(B.11) _B_ [(] _[u,v]_ [)] =



\left( 0 _x_ _[w][uv]_ _x_ _[w][uv]_

_x_ _[w][uv]_ 0 _x_ _[w][uv]_
_x_ _[w][uv]_ _x_ _[w][uv]_ 0



\right)


_,_



where subscripts _cv_ = _r_, _cv_ = _g_, and _cv_ = _b_ are for labeling the color configurations.
_B_ tensors are for specifying the coloring constraints and _W_ tensors are for labeling
the solutions.


Theorem B.3. _The tensor network representation of a K-coloring problem_
_on a graph G_ = ( _V,E_ ) ( _equation_ (B.9)) _can be contracted in cc_ ( K-color( _G_ )) =
_\scrN_
_O_ ( _| E|_ ) _K_ _[O]_ [(tw(] _[G]_ [))] _number of additions and multiplications._

The proof is similar to that for Theorem 4.1 except the dimension of each degree
of freedom is _K_ . Let _x_ _[w][uv]_ = _x_ and _rv_ = _gv_ = _bv_ = 1; we then have a graph polynomial,
in which the _k_ th coefficient is the number of coloring that _k_ bonds satisfy constraints.
If a graph is colorable, the maximum order of this polynomial should be equal to the
number of edges in this graph. Similarly, one can define an edge coloring problem by
defining the tensor network on the line graph of _G_ .


**B.4. Cutting problem.** In graph theory, a cut is a partition of the vertices of
a graph into two disjoint subsets, which is also known as the spin glass problem in
statistical physics. Let _G_ = ( _V,E_ ) be a graph. We associate a weight _wv_ to each
_v \in_ _V_ . To reduce the cutting problem on _G_ to the contraction of a tensor network,
we first define a Boolean degree of freedom _sv_ 0 _,_ 1 for each vertex _v_ _V_ . The
_\in \{_ _\}_ _\in_
tensor network representation for the cutting problem _\scrN_ cut can be specified as



(B.12)



= _Bs_ [(] _[u,v]_ _usv_ [)]
_\scrT_ _\{_ _[| ]_ [(] _[u,v]_ [)] _[ \in ]_ _[E][\} ][,]_



\Lambda = _sv_ _v_ _V_ _,_
_\{_ _|_ _\in_ _\}_



_**\bfitsigma**_ _o_ = _\varepsilon,_



where for each edge ( _u,v_ ) _E_, we define an edge matrix labeled by ( _su,sv_ ) as
_\in_



(B.13) _B_ [(] _[u,v]_ [)] = \biggl( 1 _x_ _[w]_ _v_ _[uv]_
_xu_ _[w][uv]_ 1



\biggr)
_._



Here, variables _xu_ _[w][uv]_ and _xv_ _[w][uv]_ are for a cut on this edge or a domain wall in a spin
glass problem.


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1262 LIU, GAO, CAIN, LUKIN, AND WANG



Theorem B.4. _The tensor network representation of a cutting problem on a_
_graph G_ = ( _V,E_ ) ( _equation_ (B.12)) _can be contracted in cc_ ( cut( _G_ )) = _O_ ( _E_ )2 _[O]_ [(tw(] _[G]_ [))]
_\scrN_ _|_ _|_

_number of additions and multiplications._

The proof is similar to that for Theorem 4.1. Let _x_ _[w]_ _u_ _[uv]_ = _x_ _[w]_ _v_ _[uv]_ = _x_ ; we have
a graph polynomial similar to the previous ones, in which the _k_ th coefficient is two
times the number of cut configurations that have size _k_ (i.e., cutting _k_ edges).


**B.5. Dominating set.** In graph theory, a dominating set for a graph _G_ = ( _V,E_ )
is a subset _D \subseteq_ _V_ such that every vertex not in _D_ is adjacent to at least one member
of _D_ . To reduce this problem to the contraction of a tensor network, we first map a
vertex _v_ _V_ to a Boolean degree of freedom _sv_ 0 _,_ 1 . The tensor network for the
_\in_ _\in \{_ _\}_
dominating set problem _\scrN_ dom can be specified as



(B.14)



\Lambda = _sv_ _v_ _V_ _,_
_\{_ _|_ _\in_ _\}_



= _Ts_ [(] _N_ _[v]_ [)] ( _v,_ 1) _sN_ ( _v,_ 2) _...sN_ ( _v,d_ ( _v_ )) _sv_
_\scrT_ _\{_ _[| ]_ _[v][ \in ]_ _[V][ \} ][,]_



_**\bfitsigma**_ _o_ = _\varepsilon,_



where for each vertex _v_, we define a tensor on its closed neighborhood _\{ v\} \cup_ _N_ ( _v_ ) as
(B.15)



_Ts_ [(] _N_ _[v]_ [)] ( _v,_ 1) _sN_ ( _v,_ 2) _...sN_ ( _v,d_ ( _v_ )) _sv_ [=]



\left\{ 0 _,_ _sN_ ( _v,_ 1) = _sN_ ( _v,_ 2) = _\cdot \cdot \cdot_ = _sN_ ( _v,d_ ( _v_ )) = _sv_ = 0 _,_

1 _,_ _sv_ = 0 _,_
_xv_ _[w][v]_ otherwise _._



Here, _wv_ is the weight associated with the vertex _v_, _N_ ( _v,k_ ) is the _k_ th vertex in
_N_ ( _v_ ), and _d_ ( _v_ ) = _| N_ ( _v_ ) _|_ is the degree of vertex _v_ . This tensor implies a configuration
having a closed neighborhood of _v_ not in _D_ ( _sN_ ( _v,_ 1) = _sN_ ( _v,_ 2) = _\cdot \cdot \cdot_ = _sN_ ( _v,d_ ( _v_ )) =
_sv_ = 0) cannot be a dominating set. Otherwise, if _v_ is in _D_, this tensor contributes a
multiplicative factor _x_ _[w]_ _v_ _[v]_ to the output.


Theorem B.5. _The tensor network representation of a dominating set prob-_
_lem on a graph G_ = ( _V,E_ ) ( _equation_ (B.14)) _can be contracted in cc_ ( dom( _G_ )) =
_\scrN_
_O_ ( _| V |_ )2 _[O]_ [(tw(] _[G]_ [)\Delta )] _number of additions and multiplications._

The proof is similar to that for Theorem B.1. The graph polynomial for the
dominating set problem is known as the domination polynomial [3]



(B.16) _D_ ( _G,x_ ) =



_\gamma_ ( _G_ )
\sum _dkx_ _[k]_ _,_


_k_ =0



where _dk_ is the number of dominating sets of size _k_ .


**B.6. Boolean satisfiability problem.** The Boolean satisfiability problem is the
problem of determining if there exists an assignment that satisfies a given Boolean
formula. One can specify a satisfiable problem in the conjunctive normal form (CNF),
i.e., a conjunction of clauses (or disjunctions of Boolean literals). Given the alphabet
of Boolean variables _V_ and its negation _\neg V_ = _\{ \neg v |_ _v \in_ _V \}_, a CNF can be formally
defined as



_| C_ [(] _[k]_ [)] _|_
\bigvee _Ci_ [(] _[k]_ [)] _,_

_i_ =1



(B.17) CNF =



_M_
\bigwedge


_k_ =1



where _M_ is the number of clauses, _C_ [(] _[k]_ [)] is the _k_ th clause, and _Ci_ [(] _[k]_ [)] _V_ _V_ is the _i_ th
_\in_ _\cup \neg_
literal in it. The standard tensor network can be used to study the counting version of


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1263


the satisfiability problem [9], while in the following, we will show a generic reduction
from the problem of solving a CNF to a tensor network contraction for solving more
solution space properties. We first map each Boolean literal _v \in_ _V_ to a Boolean degree
of freedom _sv \in \{_ 0 _,_ 1 _\}_ . _sv_ = 0 stands for variable _v_ having value `false` while _sa_ = 1
stands for having value `true` . The tensor network _\scrN_ CNF can be specified as



(B.18)



\Lambda = _sv_ _v_ _V_ _,_
_\{_ _|_ _\in_ _\}_



= _Wv_ [(] _[v]_ [)] _v_ _V_ _Ts_ [(] _N_ _[k]_ [)] ( _k,_ 1) _sN_ ( _k,_ 2) _...sN_ ( _k,d_ ( _k_ )))
_\scrT_ _\{_ _|_ _\in_ _\} \cup \{_ _[| ]_ _[k]_ [ = 1] _[,...,M]_ _[\} ][,]_



_**\bfitsigma**_ _o_ = _\varepsilon,_



where a tensor defined on literal _v \in_ _V_ is

\biggl( 1
(B.19) _W_ [(] _[v]_ [)] =
1 _v_



\biggr)



and a tensor defined on the clause _C_ [(] _[k]_ [)] is
(B.20)



_Ts_ [(] _N_ _[k]_ [)] ( _k,_ 1) _sN_ ( _k,_ 2) _...sN_ ( _k,d_ ( _k_ )) [=]



\Biggl\{
_x_ _[w][k]_ _,_ _C_ [(] _[k]_ [)] is satisfied by ( _sN_ ( _k,_ 1) _,sN_ ( _k,_ 2) _,...,sN_ ( _k,d_ ( _k_ ))) _,_
1 otherwise _,_



where _N_ ( _k,i_ ) =



\Biggl\{
_\neg Ci_ [(] _[k]_ [)] _,_ _Ci_ [(] _[k]_ [)] _\in \neg V,_ is the _i_ th literal in _C_ [(] _[k]_ [)] with its negation sign
_Ci_ [(] _[k]_ [)] _,_ _Ci_ [(] _[k]_ [)] _V,_
_\in_



removed and _d_ ( _k_ ) is the number of boolean variables in it; _wk_ is the weight associated
with clause _C_ [(] _[k]_ [)] .


Theorem B.6. _The tensor network representation of a CNF_ ( _equation_ (B.18))
_can be contracted in cc_ ( CNF) = _O_ ( _M_ )2 _[O]_ [(tw(] _[H]_ [))] _number of additions and multipli-_
_\scrN_
_cations, where M is the number of clauses, and H is a hypergraph constructed by_
_mapping a variable v \in_ _V to a vertex and the kth clause C_ [(] _[k]_ [)] _to a hyperedge connect-_
_ing \{ N_ ( _k,i_ ) _|_ _i_ = 1 _,...,d_ ( _k_ ) _\} ._

This can be proved by showing the hypergraph _H_ is the line graph of CNF. Let
_\scrN_
_x_ _[w][k]_ = _x_ and 1 _v_ = 1; one can get a polynomial, in which the _k_ th coefficient gives the
number of assignments that _k_ clauses are satisfied.



Theorem B.6. _The tensor network representation of a CNF_ ( _equation_ (B.18))
_can be contracted in cc_ ( CNF) = _O_ ( _M_ )2 _[O]_ [(tw(] _[H]_ [))] _number of additions and multipli-_
_\scrN_
_cations, where M is the number of clauses, and H is a hypergraph constructed by_
_mapping a variable v \in_ _V to a vertex and the kth clause C_ [(] _[k]_ [)] _to a hyperedge connect-_
_ing \{ N_ ( _k,i_ ) _|_ _i_ = 1 _,...,d_ ( _k_ ) _\} ._



**B.7. Set packing.** Suppose one has a finite set _V_ and a list of subsets of _V_,
denoted as _S_ . Then, the set packing problem asks if some _k_ subsets in _S_ are pairwise
disjoint. It is the hypergraph generalization of the independent set problem, where a
set corresponds to a vertex and an element corresponds to a hyperedge. The generic
tensor network for the set packing problem _\scrN_ pack also has a similar form as that for
the independent set problem



(B.21)



\Lambda = _s\sigma_ _\sigma_ _S_ _,_
_\{_ _|_ _\in_ _\}_



= _Bs_ [(] _[v]_ _N_ [)] ( _v,_ 1) _...sN_ ( _v,d_ ( _v_ )) _s\sigma_ _[| ]_ _[\sigma ]_ _[\in ]_ _[S][\} ][,]_
_\scrT_ _\{_ _[| ]_ _[v][ \in ]_ _[V][ \} \cup \{ ][W]_ [ (] _[\sigma ]_ [)]



_**\bfitsigma**_ _o_ = _\varepsilon,_



where for each _v \in_ _V_, we have the constraints over sets, _N_ ( _v_ ) = _\{ \sigma_ _|_ _\sigma_ _\in_ _S \wedge_ _v \in_ _\sigma \}_,
that contain it as



(B.22) _BN_ [(] _[v]_ ( [)] _v,_ 1) _N_ ( _v,_ 2) _...N_ ( _v,d_ ( _v_ )) [=]



\Biggl\{
1 _,_ _sN_ ( _v,_ 1) + _sN_ ( _v,_ 2) + _\cdot \cdot \cdot_ + _sN_ ( _v,d_ ( _v_ )) _\leq_ 1 _,_
0 otherwise _._



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1264 LIU, GAO, CAIN, LUKIN, AND WANG


and the vertex tensor for each _\sigma_ _\in_ _S,_



\biggl( 1
(B.23) _W_ [(] _[\sigma ]_ [)] =
_x_ _[w]_ _\sigma_ _[\sigma ]_



\biggr)
_,_



where _N_ ( _v,k_ ) is the _k_ th element in _N_ ( _v_ ) and _d_ ( _v_ ) = _| N_ ( _v_ ) _|_ is the number of elements
in _N_ ( _v_ ).


Theorem B.7. _The tensor network representation of a set packing problem_
( _equation_ (B.21)) _can be contracted in cc_ ( pack) = _O_ ( _S_ )2 _[O]_ [(tw(] _[H]_ [))] _number of ad-_
_\scrN_ _|_ _|_
_ditions and multiplications, where | S|_ _is the number of sets, and H is a hypergraph_
_constructed by mapping a set \sigma_ _\in_ _S to a vertex and element v \in_ _V to a hyperedge_
_connecting sets, N_ ( _v_ ) _, that contain it._


This can be proved by showing the hypergraph _H_ is the line graph of pack.
_\scrN_

**B.8. Set covering.** Suppose one has a finite set _V_ and a list of subsets of _V_,
denoted as _S_ . The set covering problem aims to find the minimum number of sets
in _S_ that incorporate (cover) all elements in _V_ . To get the generic tensor network
representation, we first map a set _\sigma_ _S_ to a Boolean degree of freedom _s\sigma_ 0 _,_ 1 .
_\in_ _\in \{_ _\}_
Then the tensor network representation for the set covering problem _\scrN_ cover can be
specified as



(B.24)



\Lambda = _s\sigma_ _\sigma_ _,_
_\{_ _|_ _\in \scrS \}_



= _Ws_ [(] _\sigma_ _[\sigma ]_ [)] _[| ]_ _[\sigma ]_ _[\in ]_ _[S][\} \cup \{ ][B]_ _s_ [(] _[v]_ _N_ [)] ( _v,_ 1) _sN_ ( _v,_ 2) _...sN_ ( _\sigma,d_ ( _v_ ))
_\scrT_ _\{_ _[| ]_ _[v][ \in ]_ _[V][ \} ][,]_



_**\bfitsigma**_ _o_ = _\varepsilon,_



where for each _s\sigma_, we define a parameterized rank-one tensor indexed by it as



\biggl( 1
(B.25) _W_ [(] _[\sigma ]_ [)] =
_x_ _[w]_ _\sigma_ _[\sigma ]_



\biggr)
_,_



where _x\sigma_ is a generic typed variable associated with _\sigma_ and _w\sigma_ is a positive integer
as the weight. For each element _v \in_ _V_, we can define a constraint over all _s \in_ _S_
containing this element, i.e., _N_ ( _v_ ) = _\{ s |_ _s \in_ _S \wedge_ _v \in_ _s\}_, as



(B.26) _Bs_ [(] _[v]_ _N_ [)] ( _v,_ 1) _sN_ ( _v,_ 2) _...sN_ ( _v,d_ ( _v_ )) [=]



\Biggl\{
0 _,_ _sN_ ( _v,_ 1) = _sN_ ( _v,_ 2) = _\cdot \cdot \cdot_ = _sN_ ( _v,d_ ( _v_ )) = 0 _,_
1 otherwise _,_



where _N_ ( _v,k_ ) is the _k_ th element in _N_ ( _v_ ) and _d_ ( _v_ ) = _| N_ ( _v_ ) _|_ is the number of elements
in _N_ ( _v_ ). If a subset of _S_ does not include any sets containing element _v_, then the
corresponding entry is zero.


Theorem B.8. _The tensor network representation of a set covering problem_
( _equation_ (B.24)) _can be contracted in cc_ ( cover) = _O_ ( _S_ )2 _[O]_ [(tw(] _[H]_ [))] _number of ad-_
_\scrN_ _|_ _|_
_ditions and multiplications, where | S|_ _is the number of sets, and H is a hypergraph_
_constructed by mapping a set \sigma_ _\in_ _S to a vertex and element v \in_ _V to a hyperedge_
_connecting sets N_ ( _v_ ) _, that contain it._


This can be proved by showing the hypergraph _H_ is the line graph of cover.
_\scrN_

**Appendix C. Bounding the MIS enumeration space.** When using the
algebra in (7.3: P1+SN) to enumerate all MISs, the program often stores significantly
more intermediate configurations than necessary. To reduce the space overhead, we
will show how to bound the searching space using the MIS size _\alpha_ ( _G_ ). The bounded


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1265



_α_ ( _G_ )


(a)







_α_ ( _G_ )


(b)





_sα_ ( _G_ )


(c)







Fig. 6. _Bounded enumeration of MISs. Here, a circle is a tensor, an arrow specifies the exe-_
_cution direction of a function, A is the Boolean mask for A, and \circ_ _is the Hadamard_ ( _elementwise_ )
_multiplication._ (a) _is the forward pass with tropical algebra_ ( _equation_ (6.4: T)) _for computing \alpha_ ( _G_ ) _._
(b) _is the backward pass for computing Boolean gradient masks._ (c) _is the masked tensor network_
_contraction with tropical algebra combined with sets_ ( _equation_ (7.3: P1+SN)) _for enumerating con-_
_figurations._


contraction consists of three stages as shown in Figure 6. (a) We first compute the
value of _\alpha_ ( _G_ ) with tropical algebra and cache all intermediate tensors. (b) Then,
we compute a Boolean mask for each cached tensor, where we use a Boolean `true`
to represent a tensor element having a contribution to the MIS and Boolean `false`
otherwise. (c) Finally, we perform masked tensor network contraction (i.e., discarding
elements masked `false` ) using the element type with the algebra in (7.3: P1+SN) to
obtain all MIS configurations. The crucial part is computing the masks in step (b).
Note that these masks correspond to tensor elements with nonzero gradients to the
MIS size; we can compute these masks by back-propagating the gradients. To derive
the back-propagation rule for tropical tensor contraction, we first reduce the problem
to finding the back-propagation rule of a tropical matrix multiplication _C_ = _AB_ . Since
_Oik_ = [\bigoplus ] _j_ _[A][ij][ \odot ]_ _[B][jk]_ [ = max] _[j][ A][ij][ \odot ]_ _[B][jk]_ [ with tropical algebra, we have the following]

inequality:


(C.1) _Aij_ _Bjk_ _Cik._
_\odot_ _\leq_

Here _\leq_ on tropical numbers are the same as the real-number algebra. The equality
holds for some _j_ _[\prime ]_, which means _Aij\prime_ and _Bj\prime k_ have contributions to _Cik_ . Intuitively,
one can use this relation to identify elements with nonzero gradients in _A_ and _B_,
but if doing this directly, one loses the advantage of using BLAS libraries [2] for high
performance. Since _Aij \odot_ _Bjk_ = _Aij_ + _Bjk_, one can move _Bjk_ to the right-hand side
of the inequality:

(C.2) _Aij \leq_ _Cik \odot_ _Bjk_ _[\circ - ]_ [1] _[,]_

where _[\circ - ]_ [1] is the elementwise multiplicative inverse on tropical algebra (which is the
additive inverse on real numbers). The inequality still holds if we take the minimum
over _k_ :



\biggl(
\bigl( \bigr) [\biggr) ] _[\circ - ]_ [1]
_Aij \leq_ min _k_ [(] _[C][ik][ \odot ]_ _[B]_ _jk_ _[\circ - ]_ [1][) =] max _k_ _Cik_ _[\circ - ]_ [1] _\odot_ _Bjk_ =



\Biggl( \bigoplus \bigl( _Cik_ _[\circ - ]_ [1] _Bjk_ \bigr) \Biggr) _\circ -_ 1

_\odot_

_k_



(C.3) = \bigl( _C_ _[\circ - ]_ [1] _B_ [\sansT ][\bigr) ] _[\circ - ]_ [1] _._
_ij_


On the right-hand side, we transform the operation into a tropical matrix multiplication so that we can utilize the fast tropical BLAS routines [2]. Again, the equality


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1266 LIU, GAO, CAIN, LUKIN, AND WANG


holds if and only if the element _Aij_ has a contribution to _C_ (i.e., having a nonzero
gradient). Let the gradient mask for _C_ be _C_ ; the back-propagation rule for gradient
masks reads



(C.4) _Aij_ = _\delta_ \Bigl( _Aij,_ \bigl( \bigl( _C_ _[\circ - ]_ [1] _C_ ~~\~~ _B_ [\sansT ][\bigr) ] _[\circ - ]_ _ij_ [1]
_\circ_



\Bigr)
_,_



where _\delta_ is the Dirac delta function that returns one if two arguments have the same
value and zero otherwise,tropical number 0, and Boolean true is treated as the tropical number _\circ_ is the elementwise product, Boolean false is treated as the 1. This rule
defined on matrix multiplication can be easily generalized to tensor contraction by
replacing the matrix multiplication between _C_ _[\circ - ]_ [1] _\circ C_ and _B_ [\sansT ] by a tensor contraction.
With the above method, one can significantly reduce the space needed to store the
intermediate configurations by setting the tensor elements masked false to zero during
contraction.


**Appendix D. The fitting approach to computing the independence**
**polynomial.** In this section, we propose to find the independence polynomial by
fitting _\alpha_ ( _G_ ) + 1 random pairs of _xi_ and _yi_ = _I_ ( _G,xi_ ). One can then compute the
independence polynomial coefficients _ai_ by solving the linear equation:



\left( _a_ 0

_a_ 1
_..._
_a\alpha_ ( _G_ )



\left(



1 _x_ 0 _x_ [2] 0 _..._ _x_ _[\alpha ]_ 0 [(] _[G]_ [)]
1 _x_ 1 _x_ [2] 1 _..._ _x_ _[\alpha ]_ 1 [(] _[G]_ [)]
_..._ _..._ _..._ _..._ _..._
1 _x\alpha_ ( _G_ ) _x_ [2] _\alpha_ ( _G_ ) _..._ _x_ _[\alpha ]_ _\alpha_ [(] ( _[G]_ _G_ [)] )



\right)



\left( _y_ 0

_y_ 1
_..._
_y\alpha_ ( _G_ )



\right)


_[.]_



\right)


[=]



(D.1)



Unlike using the polynomial numbers in (5.2: PN), the fitting approach does not have
the linear overhead in space. However, since the independence polynomial coefficients
can have a huge order-of-magnitude range, the round-off errors can be larger than
the value itself when using floating-point numbers in computation. To avoid using
the arbitrary precision number that can be very slow and is incompatible with GPU
devices, we introduce the following finite-field algebra GF( _p_ ) approach:



_x \oplus_ _y_ = _x_ + _y_ (mod _p_ ) _,_



_D._ 2 : _GF_ ( _p_ )



_x \odot_ _y_ = _xy_ (mod _p_ ) _,_



0 = 0 _,_



1 = 1 _._


Regarding the finite-field algebra, we have the following observations:

1. One can use Gaussian elimination [29] to solve the linear equation (D.1)
since it is a generic algorithm that works for any elements with field algebra.
The multiplicative inverse of a finite-field algebra can be computed with the
extended Euclidean algorithm.
2. Given the remainders of a larger unknown integer _x_ over a set of co-prime
integers _p_ 1 _,p_ 2 _,...,pn_, _x_ (mod _p_ 1 _p_ 2 _pn_ ) can be computed using
_\{_ _\}_ _\times_ _\times \cdot \cdot \cdot \times_
the Chinese remainder theorem. With this, one can infer big integers from
small integers.
With these observations, we develop Algorithm D.1 to compute the independence
polynomial exactly without introducing space overheads. The algorithm iterates over
a sequence of large prime numbers until convergence. In each iteration, we choose


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1267


**Algorithm D.1** Computing the independence polynomial exactly without integer
overfow.


Let _P_ = 1, _W_ be the integer width, vector _\chi_ = (0 _,_ 1 _,_ 2 _, . . ., \alpha_ ( _G_ )), matrix _Xij_ = ( _\chi i_ ) _[j]_, where
_i, j_ = 0 _,_ 1 _, . . ., \alpha_ ( _G_ )
**while** _true_ **do**
compute the largest prime _p_ that \mathrm{g}\mathrm{c}\mathrm{d}( _p, P_ ) = 1 and _p <_ 2 _[W]_

**for** _i_ = 0 _. . . \alpha_ ( _G_ ) **do**
_yi_ (\mathrm{m}\mathrm{o}\mathrm{d} _p_ ) = \mathrm{c}\mathrm{o}\mathrm{n}\mathrm{t}\mathrm{r}\mathrm{a}\mathrm{c}\mathrm{t}\]\mathrm{t}\mathrm{e}\mathrm{n}\mathrm{s}\mathrm{o}\mathrm{r}\]\mathrm{n}\mathrm{e}\mathrm{t}\mathrm{w}\mathrm{o}\mathrm{r}\mathrm{k}( _\chi i_ (\mathrm{m}\mathrm{o}\mathrm{d} _p_ )) ; `// on GF` ( _p_ )
**end**
_Ap_ = ( _a_ 0 _, a_ 1 _, . . ., a\alpha_ ( _G_ )) (\mathrm{m}\mathrm{o}\mathrm{d} _p_ ) = \mathrm{g}\mathrm{a}\mathrm{u}\mathrm{s}\mathrm{s}\mathrm{i}\mathrm{a}\mathrm{n}\]\mathrm{e}\mathrm{l}\mathrm{i}\mathrm{m}\mathrm{i}\mathrm{n}\mathrm{a}\mathrm{t}\mathrm{i}\mathrm{o}\mathrm{n}( _X,_ ( _y_ 0 _, y_ 1 _, . . ., y\alpha_ ( _G_ ))
(\mathrm{m}\mathrm{o}\mathrm{d} _p_ ))
_AP_ _p_ = \mathrm{c}\mathrm{h}\mathrm{i}\mathrm{n}\mathrm{e}\mathrm{s}\mathrm{e}\]\mathrm{r}\mathrm{e}\mathrm{m}\mathrm{a}\mathrm{i}\mathrm{n}\mathrm{d}\mathrm{e}\mathrm{r}( _AP, Ap_ )
_\times_
**if** _AP_ = _AP \times p_ **then**
**return** _AP_ ; `// converged`
**end**
_P_ = _P \_ _p_
**end**


a large prime number _p_, and contract the tensor networks to evaluate the polynomial for each variable _\chi_ = ( _x_ 0 _,x_ 1 _,...,x\alpha_ ( _G_ )) on GF( _p_ ) and denote the outputs as
( _y_ 0 _,y_ 1 _,...,y\alpha_ ( _G_ )) (mod _p_ ). Then we solve (D.1) using Gaussian elimination on GF( _p_ )
to find the coefficient modulo _p_, _Ap_ ( _a_ 0 _,a_ 1 _,...,a\alpha_ ( _G_ )) (mod _p_ ). As the last step of
_\equiv_
each iteration, we apply the Chinese remainder theorem to update _A_ (mod _P_ ) to _A_
(mod _P \times_ _p_ ), where _P_ is a product of all prime numbers chosen in previous iterations.
If this number does not change compared with the previous iteration, it indicates the
convergence of the result and the program terminates. All computations are done
with integers of fixed width _W_ except the last step of applying the Chinese remainder
theorem, where we use arbitrary precision integers to represent the counting.
Alternatively, one can use a faster but less accurate Fourier transformation based
method to fit this polynomial, which is detailed and benchmarked in section SM1.

|u<br>o|Col2|Col3|Col4|Col5|
|---|---|---|---|---|
|_u_<br>_o_|_The_<br>_ence_<br>|_The_<br>_ence_<br>|Table 2<br>_ number of independent sets for square lattice graphs of size L \L. This forms the inte_<br>_ OEIS A_006506_. Here we only include two updated entries for L_ = 38_,_39_, which, to o_<br>|Table 2<br>_ number of independent sets for square lattice graphs of size L \L. This forms the inte_<br>_ OEIS A_006506_. Here we only include two updated entries for L_ = 38_,_39_, which, to o_<br>|
|_u_<br>_o_|~~_wledg_~~|~~_wledg_~~|~~_e, has not been computed before_ [14]~~~~_._~~|~~_e, has not been computed before_ [14]~~~~_._~~|
||||||
||||||
||||||
||||||



Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1268 LIU, GAO, CAIN, LUKIN, AND WANG


**Appendix E. Integer sequence formed by the number of independent**
**sets.** We computed the number of independent sets on square lattices and King's
graphs with our generic tensor network contraction algorithm on GPUs. The tensor
element type is the finite-field algebra so that we can reach an arbitrary precision.
We also computed the independence polynomial for these lattices up to size 30 _\times_ 30
in our GitHub repository.


**Acknowledgments.** We would like to thank Pan Zhang for sharing his Python
code for optimizing contraction orders of a tensor network. We acknowledge Sepehr
Ebadi and Leo Zhou for coming up with many interesting questions about independent
sets, and their questions strongly motivated the development of this project. We thank
Benjamin Schiffer for providing helpful feedback on the writing of this manuscript.
We thank Chris Elord for helping us write the fastest matrix multiplication library for
tropical numbers, TropicalGEMM.jl. We thank Jacob Miller for helpful discussions.
We would also like to thank a number of open-source software developers, including
Roger Luo, Time Besard, Edward Scheinerman, and Katharine Hyatt, for actively
maintaining their packages and resolving related issues voluntarily.


REFERENCES


[1] _Generic Tensor Networks_ [, https://github.com/QuEraComputing/GenericTensorNetworks.jl.](https://github.com/QuEraComputing/GenericTensorNetworks.jl)

[2] _Tropical GEMM_ [, https://github.com/TensorBFS/TropicalGEMM.jl.](https://github.com/TensorBFS/TropicalGEMM.jl)

[3] S. Alikhani and Y.-H. Peng, _Introduction to Domination Polynomial of a Graph_,
[https://arxiv.org/abs/0905.2251, 2009.](https://arxiv.org/abs/0905.2251)

[4] B. Altshuler, H. Krovi, and J. Roland, _Anderson localization makes adiabatic quantum_
_optimization fail_ [, Proc. Natl. Acad. Sci. USA, 107 (2010), pp. 12446--12450, https://doi.](https://doi.org/10.1073/pnas.1002116107)
[org/10.1073/pnas.1002116107.](https://doi.org/10.1073/pnas.1002116107)

[5] R. J. Baxter, I. G. Enting, and S. K. Tsang, _Hard-square lattice gas_, J. Stat. Phys., 22
[(1980), pp. 465--489, https://doi.org/10.1007/BF01012867.](https://doi.org/10.1007/BF01012867)

[6] T. Besard, C. Foket, and B. De Sutter, _Effective extensible programming:_ _Unleash-_
_ing Julia on GPUs_ [, IEEE Trans. Parallel Distr. Syst., 30 (2018), pp. 827--841, https://](https://doi.org/10.1109/TPDS.2018.2872064)
[doi.org/10.1109/TPDS.2018.2872064.](https://doi.org/10.1109/TPDS.2018.2872064)

[7] J. Bezanson, S. Karpinski, V. B. Shah, and A. Edelman, _Julia: A Fast Dynamic Language_
_for Technical Computing_ [, https://arxiv.org/abs/1209.5145, 2012.](https://arxiv.org/abs/1209.5145)

[8] J. Biamonte and V. Bergholm, _Tensor Networks in a Nutshell_, [https://arxiv.org/](https://arxiv.org/abs/1708.00006)
[abs/1708.00006, 2017.](https://arxiv.org/abs/1708.00006)

[9] J. D. Biamonte, J. Morton, and J. Turner, _Tensor network contractions for \#SAT_, J.
[Stat. Phys., 160 (2015), pp. 1389--1404, https://doi.org/10.1007/s10955-015-1276-z.](https://doi.org/10.1007/s10955-015-1276-z)

[10] C. M. Bishop, _Pattern Recognition and Machine Learning_, Springer, New York, 2006,
[https://link.springer.com/gp/book/9780387310732.](https://link.springer.com/gp/book/9780387310732)

[11] M. Bousquet-M\'elou, S. Linusson, and E. Nevo, _On the independence complex of square_
_grids_ [, J. Algebraic Combin., 27 (2008), pp. 423--450, https://doi.org/10.1007/s10801-007-](https://doi.org/10.1007/s10801-007-0096-x)
[0096-x.](https://doi.org/10.1007/s10801-007-0096-x)

[12] C. Bron and J. Kerbosch, _Algorithm_ 457 _: Finding all cliques of an undirected graph_, Com[mun. ACM, 16 (1973), pp. 575--577, https://doi.org/10.1145/362342.362367.](https://doi.org/10.1145/362342.362367)

[13] S. Butenko and P. M. Pardalos, _Maximum Independent Set and Related Problems,_
_with Applications_, Ph.D. thesis, University of Florida, 2003, [https://ufdc.ufl.edu/](https://ufdc.ufl.edu/UFE0001011/00001)
[UFE0001011/00001.](https://ufdc.ufl.edu/UFE0001011/00001)

[14] P. Butera and M. Pernici, _Sums of Permanental Minors Using Grassmann Algebra_,
[https://arxiv.org/abs/1406.5337, 2014.](https://arxiv.org/abs/1406.5337)

[15] A. Cichocki, _Era of Big Data Processing: A New Approach via Tensor Networks and Tensor_
_Decompositions_ [, https://arxiv.org/abs/1403.2048, 2014.](https://arxiv.org/abs/1403.2048)

[16] J. I. Cirac, D. P\'erez-Garc\'{\i}a, N. Schuch, and F. Verstraete, _Matrix product states and_
_projected entangled pair states: Concepts, symmetries, theorems_, Rev. Modern Phys., 93
[(2021), https://doi.org/10.1103/revmodphys.93.045003.](https://doi.org/10.1103/revmodphys.93.045003)

[17] B. Courcelle, _The monadic second-order logic of graphs._ I. _Recognizable sets of finite graphs_,
[Inform. Comput., 85 (1990), pp. 12--75, https://doi.org/10.1016/0890-5401(90)90043-H.](https://doi.org/10.1016/0890-5401(90)90043-H)


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


GENERIC TENSOR NETWORKS A1269


[18] J. C. Dyre, _Simple liquids' quasiuniversality and the hard-sphere paradigm_, J. Phys. Condensed
[Matter, 28 (2016), 323001, https://doi.org/10.1088/0953-8984/28/32/323001.](https://doi.org/10.1088/0953-8984/28/32/323001)

[19] S. Ebadi, A. Keesling, M. Cain, T. T. Wang, H. Levine, D. Bluvstein, G. Semegh
ini, A. Omran, J.-G. Liu, R. Samajdar, X.-Z. Luo, B. Nash, X. Gao, B. Barak,

E. Farhi, S. Sachdev, N. Gemelke, L. Zhou, S. Choi, H. Pichler, S.-T. Wang, M.
Greiner, V. Vuleti\'c, and M. D. Lukin, _Quantum optimization of maximum independent_
_set using Rydberg atom arrays_ [, Science, 376 (2022), pp. 1209--1215, https://www.science.](https://www.science.org/doi/abs/10.1126/science.abo6587)
[org/doi/abs/10.1126/science.abo6587.](https://www.science.org/doi/abs/10.1126/science.abo6587)

[20] D. Eppstein, M. L\"offler, and D. Strash, _Listing all maximal cliques in sparse graphs in_
_near-optimal time_, in Algorithms and Computation, O. Cheong, K.-Y. Chwa, and K. Park,
[eds., Springer, Berlin, 2010, pp. 403--414, https://doi.org/10.1007/978-3-642-17517-6](https://doi.org/10.1007/978-3-642-17517-6_36) ~~3~~ 6.

[21] H. C. M. Fernandes, J. J. Arenzon, and Y. Levin, _Monte_ _Carlo_ _simulations_
_of two-dimensional hard core lattice gases_, J. Chem. Phys., 126 (2007), 114508,
[https://doi.org/10.1063/1.2539141.](https://doi.org/10.1063/1.2539141)

[22] G. M. Ferrin, _Independence Polynomials_ [, https://scholarcommons.sc.edu/etd/2609/, 2014](https://scholarcommons.sc.edu/etd/2609/)

[23] F. V. Fomin and P. Kaski, _Exact exponential algorithms_, Commun. ACM, 56 (2013),
[pp. 80--88, https://doi.org/10.1145/2428556.2428575.](https://doi.org/10.1145/2428556.2428575)

[24] D. Gamarnik, _The overlap gap property:_ _A topological barrier to optimizing over ran-_
_dom structures_ [, Proc. Natl. Acad. Sci. USA, 118 (2021), https://doi.org/10.1073/pnas.](https://doi.org/10.1073/pnas.2108492118)
[2108492118.](https://doi.org/10.1073/pnas.2108492118)

[25] D. Gamarnik and A. Jagannath, _The Overlap Gap Property and Approximate Message Pass-_
_ing Algorithms for p-Spin Models_ [, https://arxiv.org/abs/1911.06943, 2019.](https://arxiv.org/abs/1911.06943)

[26] D. Gamarnik and M. Sudan, _Limits of Local Algorithms over Sparse Random Graphs_,
[https://arxiv.org/abs/1304.1831, 2013.](https://arxiv.org/abs/1304.1831)

[27] M. R. Garey and D. S. Johnson, _The rectilinear steiner tree problem is NP_ _-complete_, SIAM
[J. Appl. Math., 32 (1977), pp. 826--834, https://doi.org/10.1137/0132071.](https://doi.org/10.1137/0132071)

[28] S. Gaspers, D. Kratsch, and M. Liedloff, _On independent sets and bicliques in graphs_,
[Algorithmica, 62 (2012), pp. 637--658, https://doi.org/10.1007/s00453-010-9474-1.](https://doi.org/10.1007/s00453-010-9474-1)

[29] G. H. Golub and C. F. Van Loan, _Matrix Computations_, Vol. 3, Johns Hopkins University
[Press, Baltimore, 2013, https://doi.org/10.2307/3621013.](https://doi.org/10.2307/3621013)

[30] J. Goodman, _Semiring parsing_, Comput. Linguist., 25 (1999), pp. 573--606, [https://](https://aclanthology.org/J99-4004.pdf)
[aclanthology.org/J99-4004.pdf.](https://aclanthology.org/J99-4004.pdf)

[31] J. Gray and S. Kourtis, _Hyper-optimized tensor network contraction_, Quantum, 5 (2021),
[410, https://doi.org/10.22331/q-2021-03-15-410.](https://doi.org/10.22331/q-2021-03-15-410)

[32] C. R. Harris, K. J. Millman, S. J. van der Walt, R. Gommers, P. Virtanen, D. Cour
napeau, E. Wieser, J. Taylor, S. Berg, N. J. Smith, R. Kern, M. Picus, S. Hoyer,

M. H. van Kerkwijk, M. Brett, A. Haldane, J. Fern\'andez del R\'{\i}o, M. Wiebe, P.

Peterson, P. G\'erard-Marchant, K. Sheppard, T. Reddy, W. Weckesser, H. Abbasi,
C. Gohlke, and T. E. Oliphant, _Array programming with NumPy_, Nature, 585 (2020),
[pp. 357--362, https://doi.org/10.1038/s41586-020-2649-2.](https://doi.org/10.1038/s41586-020-2649-2)

[33] N. J. Harvey, P. Srivastava, and J. Vondr\'ak, _Computing the independence polynomial:_
_From the tree threshold down to the roots_, in Proceedings of the 29th Annual ACMSIAM Symposium on Discrete Algorithms, SIAM, Philadelphia, 2018, pp. 1557--1576,
[https://doi.org/10.1137/1.9781611975031.102.](https://doi.org/10.1137/1.9781611975031.102)

[34] J. Hastad, _Clique is hard to approximate within n_ [1] _[ - ][\epsilon ]_, in Proceedings of the 37th Confer[ence on Foundations of Computer Science, IEEE, 1996, pp. 627--636, https://doi.org/](https://doi.org/10.1007/BF02392825)
[10.1007/BF02392825.](https://doi.org/10.1007/BF02392825)

[35] D. S. Johnson, M. Yannakakis, and C. H. Papadimitriou, _On generating all maximal inde-_
_pendent sets_ [, Inform. Process. Lett., 27 (1988), pp. 119--123, https://doi.org/10.1016/0020-](https://doi.org/10.1016/0020-0190(88)90065-8)
[0190(88)90065-8.](https://doi.org/10.1016/0020-0190(88)90065-8)

[36] G. Kalachev, P. Panteleev, and M.-H. Yung, _Multi-Tensor Contraction for XEB Verifica-_
_tion of Quantum Circuits_ [, https://arxiv.org/abs/2108.05665, 2021.](https://arxiv.org/abs/2108.05665)

[37] L. R. Kerr, _The Effect of Algebraic Structure on the Computational Complexity of_
_Matrix_ _Multiplication_, Tech. report, Cornell University, 1970, [https://ecommons.](https://ecommons.cornell.edu/handle/1813/5934)
[cornell.edu/handle/1813/5934.](https://ecommons.cornell.edu/handle/1813/5934)

[38] S. Kourtis, C. Chamon, E. Mucciolo, and A. Ruckenstein, _Fast counting with tensor_
_networks_ [, SciPost Phys., 7 (2019), https://doi.org/10.21468/scipostphys.7.5.060.](https://doi.org/10.21468/scipostphys.7.5.060)

[39] T.-D. Lee and C.-N. Yang, _Statistical theory of equations of state and phase transi-_
_tions._ II. _Lattice gas and ising model_ [, Phys. Rev., 87 (1952), 410, https://doi.org/](https://doi.org/10.1103/PhysRev.87.410)
[10.1103/PhysRev.87.410.](https://doi.org/10.1103/PhysRev.87.410)

[40] V. E. Levit and E. Mandrescu, _The Independence Polynomial of a Graph at -_ 1,
[https://arxiv.org/abs/0904.4819, 2009.](https://arxiv.org/abs/0904.4819)


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


A1270 LIU, GAO, CAIN, LUKIN, AND WANG


[41] J.-G. Liu, L. Wang, and P. Zhang, _Tropical tensor network for ground states of spin glasses_,
[Phys. Rev. Lett., 126 (2021), https://doi.org/10.1103/physrevlett.126.090506.](https://doi.org/10.1103/physrevlett.126.090506)

[42] D. Maclagan and B. Sturmfels, _Introduction to Tropical Geometry_, Grad. Stud. Math.
[161, AMS, Providence, RI, 2015, http://www.cs.technion.ac.il/](http://www.cs.technion.ac.il/~janos/COURSES/238900-13/Tropical/MaclaganSturmfels.pdf) _\sim_ janos/COURSES/238900[13/Tropical/MaclaganSturmfels.pdf.](http://www.cs.technion.ac.il/~janos/COURSES/238900-13/Tropical/MaclaganSturmfels.pdf)

[43] F. Manne and S. Sharmin, _Efficient counting of maximal independent sets in sparse graphs_,
in International Symposium on Experimental Algorithms, Springer, New York, 2013, pp.
[103--114, https://doi.org/10.1007/978-3-642-38527-8](https://doi.org/10.1007/978-3-642-38527-8_11) ~~1~~ 1.

[44] I. L. Markov and Y. Shi, _Simulating quantum computation by contracting tensor networks_,
[SIAM J. Comput., 38 (2008), pp. 963--981, https://doi.org/10.1137/050644756.](https://doi.org/10.1137/050644756)

[45] C. Moore and S. Mertens, _The nature of computation_, Oxford University Press, Oxford,
[UK, 2011, https://doi.org/10.1093/acprof:oso/9780199233212.001.0001.](https://doi.org/10.1093/acprof:oso/9780199233212.001.0001)

[46] R. Or\'us, _A_ _practical_ _introduction_ _to_ _tensor_ _networks:_ _Matrix_ _product_ _states_
_and_ _projected_ _entangled_ _pair_ _states_, Ann. Phys., 349 (2014), pp. 117--158,
[https://doi.org/10.1016/j.aop.2014.06.013.](https://doi.org/10.1016/j.aop.2014.06.013)

[47] I. V. Oseledets, _Tensor-train decomposition_, SIAM J. Sci. Comput., 33 (2011), pp. 2295--2317,
[https://doi.org/10.1137/090752286.](https://doi.org/10.1137/090752286)

[48] F. Pan and P. Zhang, _Simulating_ _the_ _Sycamore_ _Quantum_ _Supremacy_ _Circuits_,
[https://arxiv.org/abs/2103.03074, 2021.](https://arxiv.org/abs/2103.03074)

[49] P. A. Pearce and K. A. Seaton, _A classical theory of hard squares_, J. Stat. Phys., 53 (1988),
[pp. 1061--1072, https://doi.org/10.1007/BF01023857.](https://doi.org/10.1007/BF01023857)

[50] H. Pichler, S.-T. Wang, L. Zhou, S. Choi, and M. D. Lukin, _Quantum Opti-_
_mization for Maximum Independent Set Using Rydberg Atom Arrays_ [, https://arxiv.](https://arxiv.org/abs/1808.10816)
[org/abs/1808.10816, 2018.](https://arxiv.org/abs/1808.10816)

[51] M. Rahman and B. Vir\'ag, _Local algorithms for independent sets are half-optimal_, Ann.
[Probab., 45 (2017), https://doi.org/10.1214/16-aop1094.](https://doi.org/10.1214/16-aop1094)

[52] A. Sch\"onhage and V. Strassen, _Schnelle multiplikation grosser zahlen_, Computing, 7 (1971),
[pp. 281--292, https://doi.org/10.1007/BF02242355.](https://doi.org/10.1007/BF02242355)

[53] Y. Shitov, _The complexity of tropical matrix factorization_, Adv. Math., 254 (2014), pp. 138-[156, https://doi.org/10.1016/j.aim.2013.12.013.](https://doi.org/10.1016/j.aim.2013.12.013)

[54] A. A. Stepanov and D. E. Rose, _From Mathematics to Generic Programming_, Pearson Ed[ucation, 2014, https://www.fm2gp.com/.](https://www.fm2gp.com/)

[55] Q. Wu and J.-K. Hao, _A review on algorithms for maximum clique problems_, European J.
[Oper. Res., 242 (2015), pp. 693--709, https://doi.org/10.1016/j.ejor.2014.09.064.](https://doi.org/10.1016/j.ejor.2014.09.064)

[56] Y.-Z. Xu, C. H. Yeung, H.-J. Zhou, and D. Saad, _Entropy inflection and invis-_
_ible low-energy states:_ _Defensive alliance example_, Phys. Rev. Lett., 121 (2018),
[https://doi.org/10.1103/physrevlett.121.210602.](https://doi.org/10.1103/physrevlett.121.210602)

[57] C.-N. Yang and T.-D. Lee, _Statistical theory of equations of state and phase transi-_
_tions._ I. _Theory of condensation_ [, Phys. Rev., 87 (1952), pp. 404--409, https://doi.](https://doi.org/10.1103/PhysRev.87.404)
[org/10.1103/PhysRev.87.404.](https://doi.org/10.1103/PhysRev.87.404)


Copyright © by SIAM. Unauthorized reproduction of this article is prohibited.


