**Encoding computationally hard problems in triangular Rydberg atom arrays**


Xi-Wei Pan, [1] Huan-Hai Zhou, [1] Yi-Ming Lu, [2] and Jin-Guo Liu [1,] _[ ∗]_

1 _Thrust of Advanced Materials, The Hong Kong University of Science and Technology (Guangzhou), Guangdong, China_
2 _Zhili College, Tsinghua University, Beijing, China_
(Dated: October 30, 2025)


Rydberg atom arrays are a promising platform for quantum optimization, encoding computationally hard problems by reducing them to independent set problems with unit-disk graph topology. In

[[Nguyen et al., PRX Quantum 4, 010316 (2023)], a systematic and efficient strategy was introduced](https://doi.org/10.1103/PRXQuantum.4.010316)
to encode multiple problems into a special unit-disk graph: the King’s subgraph. However, King’s
subgraphs are not the optimal choice in two dimensions. Due to the power-law decay of Rydberg
interaction strengths, the approximation to unit-disk graphs in real devices is poor, necessitating
post-processing that lacks physical interpretability. In this work, we develop an encoding scheme that
can universally encode computationally hard problems on triangular lattices, based on our innovative
automated gadget search strategy. Numerical simulations demonstrate that quantum optimization
on triangular lattices reduces independence-constraint violations by approximately two orders of
magnitude compared to King’s subgraphs, substantially alleviating the need for post-processing in
experiments.



_Introduction._  - Classical algorithms for NP-hard
optimization problems scale exponentially [1–3], motivating the search for quantum approaches with potential
advantages [4–10]. Rydberg atom arrays are a promising
platform for quantum optimization, as blockade interactions directly enforce independence constraints [11–
15]. This naturally maps to the maximum independent set (MIS) problem on unit-disk graphs—graphs
where vertices are connected if separated by less than
a fixed distance—an NP-hard problem [16–18]. With
tunable local detunings, this mapping extends to the
maximum weighted independent set (MWIS), also NPhard [18, 19]. Recent experiments have even reported
signatures of superlinear quantum speedup for MIS on
King’s subgraphs (KSGs)—a restricted subclass of unitdisk graphs—with up to 289 qubits [20], highlighting the
central role of KSG embeddings in current Rydbergatom implementations.

To make Rydberg atoms useful for practical optimization problems, Nguyen et al. [21] introduced the use of
KSGs to encode independent set problems with arbitrary connectivity. The key idea is to use _gadgets_, small
atomic arrangements that locally enforce constraints
while respecting unit-disk connectivity. This approach
has a provably optimal vertex overhead of _O_ ( _n_ [2] ), where
_n_ is the number of vertices in the original graph.

The main critique of KSG-based quantum optimization [20, 22–24] is that the approximation to unit-disk
graphs is poor, leading to the need for post-processing
that lacks explainability. In Ref. [20], a significant portion of independence constraints were observed to be
violated, with many output configurations having cardinalities exceeding that of the maximum independent set.
Extensive post-processing, including removing vertices
that violate the independence constraint and adding
new vertices greedily, is necessary. Partly due to this,
the observed superlinear speedup is not completely convincing.



A convincing demonstration of quantum speedup
should rest on a robust encoding scheme that avoids
post-processing, which could be achieved by changing
the lattice type, e.g., to a triangular lattice. In this
letter, we introduce a key insight: the _quality factor_
_Q_ = _R_ min _/r_ max quantifies encoding robustness, where
_R_ min is the minimum distance between non-adjacent
atoms and _r_ max is the maximum distance between adjacent atoms. Since Rydberg interactions between atoms
separated by distance _r_ scale as _V_ ( _r_ ) _∝_ 1 _/r_ [6], the energetic separation between connected and non-connected
_√_
pairs scales as _Q_ [6] . KSGs yield only _Q_ = 2, corre
sponding to an energetic separation of _Q_ [6] = 8, whereas
_√_
triangular lattices naturally provide _Q_ = 3, giving

_Q_ [6] = 27—more than three times larger (see Supplemental Material for details). This enhanced penalty
substantially suppresses constraint violations and mitigates unwanted long-tail effects [23]. The higher quality
factor is also widely believed to be beneficial for quantum simulation of exotic phases [25–27].

Yet, a general encoding scheme for triangular-lattice
subgraphs (TLSGs) is lacking. Here TLSGs refer to
unit-disk graphs constrained to the triangular lattice.
It is even unknown whether MWIS on TLSGs is NPhard [3], casting doubt on universal encodability. A key
obstacle is the absence of a systematic gadget-search
framework. In particular, gadgets such as the crossing
gadget serve as fundamental building blocks in encoding
constructions. Ref. [21] identified an optimal 8-vertex
crossing gadget for KSGs, but the brute-force search employed there quickly becomes infeasible for larger gadgets. For TLSGs, no valid crossing gadget had been
reported until now.

In this letter, we develop an innovative automated
gadget-search strategy, discover a 12-vertex crossing
gadget for TLSGs, construct a universal encoding for
NP-hard problems using this gadget, and numerically
show that independence-constraint violations are re

duced by nearly two orders of magnitude compared
with KSG encodings. These results suggest that postprocessing may be unnecessary for TLSG encodings.
_Encoding scheme._  - The MIS or MWIS problem on
unit-disk graphs can be cast as a ground-state search for
an effective Hamiltonian implemented by Rydberg atom
arrays [19, 21]. The blockade interaction enforces the independence constraint by forbidding simultaneous excitations of nearby atoms, while detunings encode vertex
weights. Let ∆ _v_ denote the detuning of atom _v_ and _Rb_
the blockade radius. The effective classical Hamiltonian
is



_H_ = _−_ 


∆ _vnv_ + _v_ _|_ **r** _−_ **r** _|_



_∞_ _nunv,_ (1)

_|_ **r** _u−_ **r** _v|<Rb_



2


tices (see Supplemental Material for details), somewhat higher than the _O_ (4 _n_ [2] ) reported for KSG encodings [21, 29], but still quadratic. Potential optimizations, such as vertex reordering [21] and further simplifications, can reduce the required number of atoms.
_Gadget finding._  - This section introduces the gadget search methodology, applicable to graphs both with
and without geometric constraints, including, but not
limited to, TLSGs.
A gadget is a small positive-weighted graph whose
MWIS ground states realize a prescribed logical relation among a selected subset of vertices. Such relation
can be expressed as a _k_ -variable logical constraint with
satisfying set _L ⊆{_ 0 _,_ 1 _}_ _[k]_ . For example, a 2-to-1 AND
gadget encodes the constraint _L_ = _{_ 000 _,_ 010 _,_ 100 _,_ 111 _}_ .
Gadgets are basic building blocks in our encoding
scheme due to their _composability_ [21]: MWIS ground
states of multiple gadgets can be combined to realize conjunctions of multiple logical constraints (see
Fig. 2(d)).


**Definition** **1** (Logical equivalence) **.** _Let_ _GL_ =
( _V, E,_ ∆) _be a weighted graph with positive vertex_
_weights_ ∆= _{_ ∆ _v}v∈V, and let P_ = _{p_ 1 _, p_ 2 _, . . ., pk} ⊆_ _V_
_be an ordered set of_ pin vertices _._
_For each MWIS M ⊆_ _V, define the pin-projection_



where _nv_ is the number operator of atom _v_, and **r** _u_ and
**r** _v_ are the atomic positions. The infinite interaction
crudely approximates the fast-decaying van der Waals
potential _∼_ 1 _/r_ [6] and enforces the hard constraint.
Since many computational problems can be reduced
to MIS or MWIS on graphs [28], a central challenge
is encoding graphs with arbitrary connectivity into
hardware-native unit-disk geometries. In this letter, we
focus on the TLSG and propose an efficient encoding
framework.
Consider a general graph _G_ = ( _V, E_ ) with vertex set
_V_ and edge set _E_ .


**Theorem 1.** _The problem of finding a maximum in-_
_dependent set on a general graph G_ = ( _V, E_ ) _can be_
_encoded into that on a TLSG with O_ ( _|V |_ [2] ) _vertices._


_Proof._ We prove this theorem by constructing a twostep mapping scheme, illustrated in Fig. 1. In Step 1,
each logical vertex of the source graph _G_ = ( _V, E_ ) is
replaced by a vertex wire consisting of _O_ ( _|V |_ ) vertices,
corresponding to the copy gadget in Ref. [21]. The collection of these vertex wires forms a two-dimensional
_crossing lattice_, where crossings occur at specific sites
for any ( _u, v_ ) _∈_ _E_ . Vertices with odd indices along
the same wire represent equivalent copies of the same
source vertex, allowing an edge in the source graph to
be redistributed to any pair of equivalent vertices. The
redistributed edges, shown as red lines in Fig.1(b), are
placed at the crossings of the lattice.
In Step 2, we use specialized gadgets with constant size to replace crossings in the crossing lattice
(Fig. 1(c)), ensuring that all vertices respect the unitdisk constraint, while preserving the solution equivalence. Details on how to design such gadgets are discussed in the following section. The generated graph
can be further simplified, e.g., by trimming the dangling legs. The resulting TLSG encoding is shown in
Fig. 1(d), with further details provided in the Supplemental Material.


For a graph with _n_ vertices, our TLSG encoding
scheme introduces an overhead of at most _O_ (8 _n_ [2] ) ver


_The set of projected MWIS configurations is_


_M_ _[P]_ MWIS [(] _[G][L]_ [) :=] _[ {][π][P]_ [(] _[M]_ [)] _[ |][ M][ ∈M]_ [MWIS][(] _[G][L]_ [)] _[} ⊆{]_ [0] _[,]_ [ 1] _[}][k][.]_


_We say the MWIS solutions of GL are_ logically equivalent on _P to a k-variable logical constraint L ⊆{_ 0 _,_ 1 _}_ _[k]_

_if_


_M_ _[P]_ MWIS [(] _[G][L]_ [) =] _[ L][.]_


**Definition 2** (Gadget) **.** _A_ gadget _for a logical con-_
_straint L is a positive-weighted graph GL_ = ( _V, E,_ ∆)
_with designated pins P ⊆_ _V such that its MWIS solu-_
_tions are logically equivalent to L on P_ _. In particular,_
_the gadget must be_ non-degenerate _, meaning that each_
_assignment in L corresponds to exactly one MWIS so-_
_lution._


**Proposition 1** (MWIS is maximal) **.** _For any positive-_
_weighted graph G_ = ( _V, E,_ ∆) _, a MWIS is always_ maximal _; that is, no additional vertex can be added without_
_violating independence._


_Proof._ If a MWIS _M_ were not maximal, there would
exist a vertex _u ∈_ _V \_ _M_ with no neighbors in _M_ . Then
_M ∪{u}_ is independent and has strictly larger weight
than _M_, contradicting maximality. Hence, every MWIS
is maximal.



_πP_ ( _M_ ) _i_ =




1 _,_ _pi ∈_ _M,_
_i_ = 1 _, . . ., k._
0 _,_ _pi /∈_ _M,_


3



(a) Computational problem



Maximum Independent
Set of 𝐾2,3









(c) Apply gadget replacement and simplification


(d) Implementation on triangular lattice














|2|3|3|
|---|---|---|
||||


|Col1|1<br>3|1|Col4|
|---|---|---|---|
|||||
||3<br>3<br>2|2||
||3|||


|Col1|1|5|
|---|---|---|
||||
||||
||||



FIG. 1. Procedure for encoding a MWIS/MIS problem on an arbitrary graph into MWIS on a TLSG, enabling optimization
using programmable Rydberg atom arrays. (a) Example problem: finding MIS of _K_ 2 _,_ 3 graph. (b) Extend each vertex to a
copy gadget and form a crossing lattice; numbers label equivalent copies of the same source vertex, and red edges indicate
the original-graph connections. (c) Replace the substructures that violate the unit-disk constraint by logically equivalent
gadgets. The gadgets and their composition rule are detailed in Fig. 2. (d) Final encoding of _K_ 2 _,_ 3; the solution to the
original problem is inferred from the ground state configuration of the numbered nodes.



Given a target logical constraint _L ⊆{_ 0 _,_ 1 _}_ _[k]_ and a
candidate graph space _G_ (e.g., unit-disk graphs on a triangular lattice), we assign a designated set of vertices
_P_ = _{p_ 1 _, . . ., pk} ⊆_ _V_ in each candidate graph _G ∈G_ .
For each candidate graph, we enumerate its _maximal_
independent sets _M_ (see Proposition 1) and extract the
subset _M_ min _⊆M_ that is sufficient to realize the logically equivalent condition, i.e., the pin-projected MWIS
configurations match the target constraint. Weights
∆ _∈_ Z _[|]_ _≥_ _[V]_ 0 _[ |]_ [are then assigned to vertices by solving the]
following integer linear program:



min
∆ _∈_ Z _[|]_ _≥_ _[V]_ 0 _[ |]_




- ∆ _i_


_i_







_n_ _[′]_ _i_ [∆] _[i]_ _[<]_  
_i_ _i_

_ni_ ∆ _i_ =  
_i_ _i_



_ni_ ∆ _i,_ _∀_ **n** _∈M_ min _,_ **n** _[′]_ _∈M \ M_ min

_i_







_n_ _[′]_ _i_ [∆] _[i][,]_ _∀_ **n** _,_ **n** _[′]_ _∈M_ min _._

_i_



(2)


These two constraints ensure that all configurations in
_M_ min acquire identical energies, while every non-target
configuration in _M \ M_ min is lifted above the groundstate energy. Optionally, one can minimize [�] _v_ [∆] _[v]_

to keep the vertex weights small. Solving this integer program using a standard solver (e.g., Gurobi [30])
yields feasible weight assignments, and iterating over the



graph space _G_ enables systematic discovery of gadgets
that encode the target logical constraints.
For gadgets on unit-disk graphs such as TLSGs, the
candidate graph space _G_ is generated by applying a
Boolean mask to the triangular lattice. The _pin ver-_
_tices_ representing logical variables are constrained to lie
on the boundary, ensuring that ancilla vertices do not
form unwanted connections when gadgets are composed.
The gadgets used in Theorem 1 obtained through this
search framework are shown in Fig. 2(a-c). In particular, the crossing gadget on the triangular lattice requires 12 vertices with weights in the range 1 to 4. A
brute-force construction as in Ref. [21] would necessitate enumerating at least 4 [12] _≈_ 1 _._ 6 _×_ 10 [7] weight allocations, making the gadget-design computationally infeasible. By contrast, our integer-programming approach
finds valid solutions within only a few seconds.
_Numerical simulation results_  - To benchmark the
TLSG encoding, we simulate the quantum optimization
process for the encoded _K_ 2 _,_ 3 instance shown in Fig. 1(d),
comparing it against the KSG encoding obtained via
_UnitDiskMapping.jl_ [31] shown in Fig. 3(a). We quantify encoding performance using the _violation rate_ —the
per-bond probability that independence constraints are
violated in the final measurement outcomes (details in
Supplemental Material).
In quantum annealing, the system evolves adiabatically under time-varying Rabi frequency Ω( _t_ ) and de

4



(a) Crossing gadget

(𝑛1 = 𝑛4) ∧(𝑛2 = 𝑛3)









(a)





(b) Crossing-with-edge gadget

(𝑛1 = 𝑛4) ∧(𝑛2 = 𝑛3) ∧(𝑛1𝑛2 = 0)










|Col1|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|
|---|---|---|---|---|---|---|---|---|---|
|1||||||||||
|||||||||||
|||||||||||
|||||||||||
|2<br>|||||4|||||



(c) T-connection gadgets



(𝑛1 = 𝑛3) ∧(𝑛1 ~~𝑛~~ 2 = 0)













(d) Gadget composition


+


Copy gadget T-connection gadget Weights added up





FIG. 2. (a-c) Three essential gadgets for TLSG encoding. In
each subfigure, the left column is the source graph, and the
right column is the mapped graph on a triangular lattice.
The red-framed vertices on the boundary are pin vertices,
and only pin vertices can connect to external vertices. The
full list of gadgets is provided in the Supplemental Material.
(d) The composition of a copy gadget and a T-connection
gadget. This requires summing the weights of the connected
pin vertices at the junction.



tuning ∆( _t_ ). Following the experimental protocol of
Ref. [20], we employ unoptimized piecewise-linear ramps
for both parameters. To ensure fair comparison, we
adopt identical parameter strategies for TLSG and KSG
instances: given preset maximum values Ωmax and
∆max, the lattice unit _a_ is chosen such that Ωmax equals
the geometric mean of interaction strengths at distances
_R_ min and _r_ max, i.e., Ωmax = - _RC_ min [6] 6 _[·]_ _rC_ max [6] 6 [=] ~~_√_~~ _R_ min [3] _C_ 6 _[r]_ max [3] [.]

We perform tensor network simulations across various
annealing times (from 0 _._ 4 _µ_ s to 4 _._ 0 _µ_ s) to analyze violation rate scaling. For detailed parameter setup and
simulation methods, see Supplemental Material.
The key advantage of TLSG encoding lies in its enlarged operational energy window. As illustrated in
Fig. 3(b), the annealing pulses must operate within constraints imposed by strong interactions at _r_ max (maintaining blockade) and weak interactions at _R_ min (avoiding spurious blockade of disconnected atoms). The superior quality factor of TLSG encodings translates directly to enhanced performance. Figure 3(c) demonstrates that TLSG encoding reduces violation rates
by nearly two orders of magnitude compared to KSG
encoding. Furthermore, the violation rate exhibits
steeper exponential decay with increasing annealing
time, demonstrating more effective constraint enforcement by the TLSG encoding. For annealing times exceeding 3 _µ_ s, the TLSG violation rate drops below 10 _[−]_ [4],
eliminating post-processing even for state-of-the-art arrays with 6100 atoms [32], as (1 _−_ 10 _[−]_ [4] ) [6100] _∼_ 0 _._ 543,



FIG. 3. Quantum annealing simulations comparing TLSG
and KSG encodings for the _K_ 2 _,_ 3 problem. (a) The KSG
encoding of _K_ 2 _,_ 3 for comparison. The TLSG encoding is
shown in Fig. 1(d). (b) Piecewise-linear annealing pulses
for Rabi frequency Ω( _t_ ) and detuning ∆( _t_ ). The shaded
regions indicate the operational range _RC_ min [6] 6 _[<]_ [ Ω] _[<]_ _r_ max _C_ [6] 6
with _C_ 6 = 2 _π ×_ 862690 MHz _µ_ m [6] . The lattice unit is chosen
so that Ωmax equals the geometric mean of the interaction
bounds. (c) Violation rate of independence constraints versus total annealing time for both encodings. Dashed lines
show exponential fits, and shaded regions denote 95% confidence intervals. The TLSG encoding reduces the violation
rate by nearly two orders of magnitude compared to the KSG
encoding across most annealing regimes.



_C_ 6 _C_ 6 ~~_√_~~ _C_ 6
_R_ min [6] _[·]_ _r_ max [6] [=] _R_ min [3]



6

_R_ min [3] _[r]_ max [3] [.]



allowing us to simply discard the illegal configurations
without post-processing.

_Conclusions and outlook_  - Our work establishes
triangular-lattice subgraphs (TLSGs) as superior to
King’s subgraphs for Rydberg quantum optimization.
_√_ _√_
The enhanced quality factor ( _Q_ = 3 vs 2) reduces

constraint violations by nearly two orders of magnitude,
potentially eliminating the need for post-processing. We
contribute two key innovations: (i) the first systematic
MWIS encoding scheme for TLSGs with _O_ ( _n_ [2] ) overhead
using crossing-lattice constructions and specialized gadgets, and (ii) an automated integer-programming framework for discovering valid gadgets—previously computationally infeasible. Both are implemented in opensource Julia packages available online [31, 33].

This framework has the potential to be applied to
other NP-hard problems (graph coloring, dominating
sets, etc.) and alternative platforms (trapped ions [34],
superconducting qubits [35]), broadening quantum optimization beyond Rydberg systems.

_Acknowledgment_  - This work was partially supported by the National Key R&D Program of China



_√_
3 vs


(Grant No. 2024YFB4504004), the National Natural
Science Foundation of China under grant nos. 12404568,
and the Guangzhou Municipal Science and Technology
Project (No. 2024A03J0607).


_∗_ [jinguoliu@hkust-gz.edu.cn](mailto:jinguoliu@hkust-gz.edu.cn)

[1] A. Schrijver _et al._, _[Combinatorial optimization: polyhe-](https://link.springer.com/book/9783540443896)_
_[dra and efficiency](https://link.springer.com/book/9783540443896)_, Vol. 24 (2003).

[2] K. Bernhard and J. Vygen, Combinatorial optimization:
[Theory and algorithms, Springer, Third Edition, 2005.](https://doi.org/10.1007/978-3-662-56039-6)
[(2008).](https://doi.org/10.1007/978-3-662-56039-6)

[3] C. Moore and S. Mertens, _[The nature of computation](https://nature-of-computation.org/)_
(OUP Oxford, 2011).

[4] E. Farhi, J. Goldstone, S. Gutmann, _et al._ [, Quan-](https://arxiv.org/abs/quant-ph/0001106)
tum computation by adiabatic evolution (2000),
[arXiv:quant-ph/0001106 [quant-ph].](https://arxiv.org/abs/quant-ph/0001106)

[5] E. Farhi, J. Goldstone, S. Gutmann, _et al._, A quantum adiabatic evolution algorithm applied to random
instances of an NP-complete problem, Science **[292](https://doi.org/10.1126/science.1057726)**, 472
[(2001).](https://doi.org/10.1126/science.1057726)

[6] T. Kadowaki and H. Nishimori, Quantum annealing in
[the transverse ising model, Physical Review E](https://doi.org/10.1103/physreve.58.5355) **58**, 5355
[(1998).](https://doi.org/10.1103/physreve.58.5355)

[7] A. Das and B. K. Chakrabarti, Colloquium: Quantum
[annealing and analog quantum computation, Rev. Mod.](https://doi.org/10.1103/RevModPhys.80.1061)
Phys. **[80](https://doi.org/10.1103/RevModPhys.80.1061)**, 1061 (2008).

[8] T. Albash and D. A. Lidar, Adiabatic quantum computation, Rev. Mod. Phys. **[90](https://doi.org/10.1103/RevModPhys.90.015002)**, 015002 (2018).

[[9] E. Farhi, J. Goldstone, and S. Gutmann, A quan-](https://arxiv.org/abs/1411.4028)
tum approximate optimization algorithm (2014),
[arXiv:1411.4028 [quant-ph].](https://arxiv.org/abs/1411.4028)

[10] A. Lucas, Ising formulations of many np problems,
[Front. in Phys.](https://doi.org/10.3389/fphy.2014.00005) **2**, 5 (2014).

[11] M. Saffman, T. G. Walker, and K. Mølmer, Quantum
[information with rydberg atoms, Reviews of modern](https://doi.org/10.1103/RevModPhys.82.2313)
physics **[82](https://doi.org/10.1103/RevModPhys.82.2313)**, 2313 (2010).

[12] H. Pichler, S.-T. Wang, L. Zhou, _et al._ [, Quantum op-](https://arxiv.org/abs/1808.10816)
[timization for maximum independent set using rydberg](https://arxiv.org/abs/1808.10816)
[atom arrays (2018), arXiv:1808.10816 [quant-ph].](https://arxiv.org/abs/1808.10816)

[13] S. K. Barik, A. Thakur, Y. Jindal, _et al._, Quantum tech[nologies with rydberg atoms, Frontiers in Quantum Sci-](https://doi.org/10.3389/frqst.2024.1426216)
[ence and Technology](https://doi.org/10.3389/frqst.2024.1426216) **3**, 1426216 (2024).

[14] J. Wurtz, A. Bylinskii, B. Braverman, _et al._ [, Aquila:](https://arxiv.org/abs/2306.11727)
[Quera’s 256-qubit neutral-atom quantum computer](https://arxiv.org/abs/2306.11727)
[(2023), arXiv:2306.11727 [quant-ph].](https://arxiv.org/abs/2306.11727)

[15] A. Browaeys and T. Lahaye, Many-body physics with
[individually controlled rydberg atoms, Nature Physics](https://doi.org/10.1038/s41567-019-0733-z)
**16** [, 132 (2020).](https://doi.org/10.1038/s41567-019-0733-z)

[16] H. Pichler, S.-T. Wang, L. Zhou, _et al._ [, Computational](https://arxiv.org/abs/1809.04954)
[complexity of the rydberg blockade in two dimensions](https://arxiv.org/abs/1809.04954)
[(2018), arXiv:1809.04954 [quant-ph].](https://arxiv.org/abs/1809.04954)

[17] K. Kim, M. Kim, J. Park, _et al._, Quantum computing
dataset of maximum independent set problem on king
[lattice of over hundred rydberg atoms, Scientific Data](https://doi.org/10.1038/s41597-024-02926-9)
**11** [, 111 (2024).](https://doi.org/10.1038/s41597-024-02926-9)

[18] M. J. A. Schuetz, R. Yalovetzky, R. S. Andrist, _et al._,
qredumis: [A quantum-informed reduction algorithm](https://arxiv.org/abs/2503.12551)
[for the maximum independent set problem (2025),](https://arxiv.org/abs/2503.12551)
[arXiv:2503.12551 [quant-ph].](https://arxiv.org/abs/2503.12551)

[19] A. de Oliveira, E. Diamond-Hitchcock, D. Walker, _et al._,
Demonstration of weighted-graph optimization on a



5


[rydberg-atom array using local light shifts, PRX Quan-](https://doi.org/10.1103/PRXQuantum.6.010301)
tum **6** [, 010301 (2025).](https://doi.org/10.1103/PRXQuantum.6.010301)

[20] S. Ebadi, A. Keesling, M. Cain, _et al._, Quantum optimization of maximum independent set using rydberg
atom arrays, Science **376** [, 1209 (2022).](https://doi.org/10.1126/science.abo6587)

[21] M.-T. Nguyen, J.-G. Liu, J. Wurtz, _et al._, Quantum
optimization with arbitrary connectivity using rydberg
atom arrays, PRX Quantum **[4](https://doi.org/10.1103/PRXQuantum.4.010316)**, 010316 (2023).

[22] L. Bombieri, Z. Zeng, R. Tricarico, _et al._, Quantum adiabatic optimization with rydberg arrays: localization
[phenomena and encoding strategies, PRX Quantum](https://doi.org/10.1103/PRXQuantum.6.020306) **6**,
[020306 (2025).](https://doi.org/10.1103/PRXQuantum.6.020306)

[23] P. Cazals, A. Fran¸cois, L. Henriet, _et al._ [, Identifying](https://arxiv.org/abs/2502.04291)
[hard native instances for the maximum independent set](https://arxiv.org/abs/2502.04291)
[problem on neutral atoms quantum processors (2025),](https://arxiv.org/abs/2502.04291)
[arXiv:2502.04291 [quant-ph].](https://arxiv.org/abs/2502.04291)

[24] P. Cazals, A. Sorondo, V. Onofre, _et al._ [, Quantum op-](https://arxiv.org/abs/2508.06130)
[timization on rydberg atom arrays with arbitrary con-](https://arxiv.org/abs/2508.06130)
[nectivity: Gadgets limitations and a heuristic approach](https://arxiv.org/abs/2508.06130)
[(2025), arXiv:2508.06130.](https://arxiv.org/abs/arXiv:2508.06130)

[25] Z. Zeng, G. Giudici, and H. Pichler, Quantum dimer
[models with rydberg gadgets, Physical Review Research](https://doi.org/10.1103/PhysRevResearch.7.L012006)
**7** [, L012006 (2025).](https://doi.org/10.1103/PhysRevResearch.7.L012006)

[[26] P. Patil and O. Benton, Tunable topological protection](https://arxiv.org/abs/2503.12949)
[in rydberg lattices via a novel quantum monte carlo](https://arxiv.org/abs/2503.12949)
[approach (2025), arXiv:2503.12949 [cond-mat.str-el].](https://arxiv.org/abs/2503.12949)

[27] C.-X. Li, S. Yang, and J.-B. Xu, Quantum phases of
rydberg atoms on a frustrated triangular-lattice array,
Optics Letters **[47](https://doi.org/10.1364/OL.450855)**, 1093 (2022).

[28] X. Gao, X. Li, and J. Liu, Programming guide for solving constraint satisfaction problems with tensor networks, Chinese Physics B **[34](https://doi.org/10.1088/1674-1056/adbee2)**, 050201 (2025).

[29] M. J. Schuetz, R. S. Andrist, G. Salton, _et al._, Quantum
compilation toolkit for rydberg atom arrays with implications for problem hardness and quantum speedups,
[Physical Review Research](https://doi.org/10.1103/7dkh-crjj) **7**, 033107 (2025).

[[30] Gurobi Optimization, LLC, Gurobi Optimizer Refer-](https://www.gurobi.com)
[ence Manual (2025).](https://www.gurobi.com)

[31] UnitDiskMapping.jl, `[https://github.com/](https://github.com/QuEraComputing/UnitDiskMapping.jl)`
`[QuEraComputing/UnitDiskMapping.jl](https://github.com/QuEraComputing/UnitDiskMapping.jl)` (2025).

[32] H. J. Manetsch, G. Nomura, E. Bataille, _et al._, A
tweezer array with 6100 highly coherent atomic qubits,
[arXiv:2403.12021 (2024).](https://arxiv.org/abs/2403.12021)

[33] GadgetSearch.jl, `[https://github.com/isPANN/](https://github.com/isPANN/GadgetSearch.jl)`
`[GadgetSearch.jl](https://github.com/isPANN/GadgetSearch.jl)` (2025).

[34] G. Pagano, A. Bapat, P. Becker, _et al._, Quantum approximate optimization of the long-range ising model
[with a trapped-ion quantum simulator, Proceedings of](https://doi.org/10.1073/pnas.2006373117)
[the National Academy of Sciences](https://doi.org/10.1073/pnas.2006373117) **117**, 25396 (2020).

[35] M. P. Harrigan, K. J. Sung, M. Neeley, _et al._, Quantum
approximate optimization of non-planar graph problems
[on a planar superconducting processor, Nature Physics](https://doi.org/10.1038/s41567-020-01105-y)
**17** [, 332 (2021).](https://doi.org/10.1038/s41567-020-01105-y)

[36] All the gadgets are named according to their function, even though their specific implementations may
differ. For example, in Ref. [21], the crossing gadget
enforces ( _n_ 1 = ~~_n_~~ 4 ~~)~~ _∧_ ( _n_ 2 = ~~_n_~~ 3 ~~)~~, and the copy gadget contains an even number of vertices. In the present
work, these gadgets may be implemented slightly differently—typically differing by a single NOT gadget
per logical variable—but they perform analogous roles
within the crossing lattice.

[37] H. Bernien, S. Schwartz, A. Keesling, _et al._, Probing
many-body dynamics on a 51-atom quantum simulator,


6



Nature **551** [, 579 (2017).](https://doi.org/10.1038/nature24622)

[38] C. Bron and J. Kerbosch, Algorithm 457: finding all
[cliques of an undirected graph, Communications of the](https://doi.org/10.1145/362342.362367)
ACM **[16](https://doi.org/10.1145/362342.362367)**, 575 (1973).

[39] J. Haegeman, J. I. Cirac, T. J. Osborne, _et al._, TimeDependent Variational Principle for Quantum Lattices,
[Physical Review Letters](https://doi.org/10.1103/PhysRevLett.107.070601) **107**, 070601 (2011).

[[40] Bloqade.jl: Package for the quantum computation and](https://github.com/QuEraComputing/Bloqade.jl/)
[quantum simulation based on the neutral-atom archi-](https://github.com/QuEraComputing/Bloqade.jl/)
[tecture. (2023).](https://github.com/QuEraComputing/Bloqade.jl/)

[41] M. Yang and S. R. White, Time Dependent Variational
[Principle with Ancillary Krylov Subspace, Physical Re-](https://doi.org/10.1103/PhysRevB.102.094315)
view B **[102](https://doi.org/10.1103/PhysRevB.102.094315)** [, 094315 (2020), arXiv:2005.06104 [cond-](https://arxiv.org/abs/2005.06104)
[mat].](https://arxiv.org/abs/2005.06104)


7


**SUPPLEMENTARY MATERIAL: ENCODING COMPUTATIONALLY HARD PROBLEMS IN**
**TRIANGULAR RYDBERG ATOM ARRAYS**


In this supplemental material, we provide detailed technical information and extended discussions that support
the main results presented in the paper.
Section I introduces the triangular lattice geometry and explains the coordinate transformation convention used
to map between the square-grid representation and the physical triangular lattice. Section II presents the gadget
composition principle, which forms the theoretical foundation for combining individual logical constraints into
complex systems through vertex merging operations. Section III describes our systematic methodology for encoding
arbitrary graphs onto triangular-lattice subgraphs (TLSGs)—unit-disk graphs laid out on a triangular lattice.
Section IV details the algorithmic framework for searching and constructing gadgets that encode specific logical
constraints. Finally, Section V describes the numerical simulation setup used to benchmark the performance of our
TLSG encoding against the established King’s subgraph (KSG) approach through quantum annealing simulations.


**I.** **TRIANGULAR LATTICE GEOMETRY AND LAYOUT CONVENTION**


In a TLSG with spacing _a_ (Fig. S1(b)), each vertex has six nearest neighbors at distance _a_, and the shortest
_√_
non-adjacent distance is 3 _a_, hence



_Q_ TLSG = _[R]_ [min] =

_r_ max



_√_

3 _a_ _√_
= 3 _._
_a_



In a King’s graph (KSG) each vertex has eight neighbors (four axial at distance _a_ and four diagonal at distance
_√_ _√_

2 _a_ ; Fig. S1(a)). Here the largest edge length is _r_ max = 2 _a_, while the shortest non-edge distance is _R_ min = 2 _a_,

giving



_Q_ KSG = _[R]_ [min]



2 _a_

_[R]_ [min] = ~~_√_~~

_r_ max 2



_a_ _√_

2 _a_ [=]



2 _._



Since Rydberg interactions scale as _V_ ( _r_ ) _∝_ 1 _/r_ [6], the relevant interaction-scale separation is


_V_ ( _r_ max)
_V_ ( _R_ min) [=] _[ Q]_ [6] _[,]_


so _Q_ [6] TLSG [= 27 versus] _[ Q]_ KSG [6] [= 8. In other words, the triangular lattice provides a substantially larger energetic]
gap between connected and non-connected atoms, enhancing the robustness of maximum weighted independent set
(MWIS) encodings against spurious long-tail interactions.
In our code implementation, the triangular lattice is represented on a square grid to simplify coordinate assignment. However, this representation distorts the original geometry and requires coordinate transformation.
To recover the physical triangular lattice from the square-grid representation, we perform a coordinate transformation that accounts for both spacing anisotropy and parity-dependent offsets. In this convention, vertices in
odd-numbered columns are shifted vertically by half a lattice spacing (0 _._ 5 _a_ ), while the horizontal spacing between
_√_
columns is scaled by a factor of 3 _/_ 2. Formally, for an internal coordinate ( _x, y_ ), the physical coordinates ( _X, Y_ )

are




- _√_




     - [�]

[1]

2 [(] _[x]_ [ mod 2)]



( _X, Y_ ) =



3 _a_ _y_ + [1]
2 _[a x,]_ 2



_._ (S1)



As a consequence of this layout transformation, horizontal wires (aligned along rows) become zigzag-shaped in
the true triangular lattice, while vertical wires (aligned along columns) remain straight. This distinction affects
gadget design since the geometry and connectivity patterns differ between orientations.


**II.** **GADGET COMPOSITION PRINCIPLE**


This section reviews and summarizes the gadget composition principle introduced by Nguyen et al. [21]. In the
context of the MWIS problem, a NOT gadget can be represented by a simple graph consisting of just two vertices


8







𝑎



𝑎


|√ 2𝑎|Col2|Col3|
|---|---|---|
||||
||||
||||
||||


|𝑎|Col2|Col3|
|---|---|---|
||||
||||
||||
||||



FIG. S1. (a) King’s subgraph (KSG) on a square lattice. (b) Triangular lattice subgraph (TLSG) and the transformation
process between the original triangular lattice and its reshaped square-grid representation used in the code implementation.


with identical weights and a single edge connecting them (Fig. S2(a)). This construction ensures that only one of
the two vertices can be included in any MWIS, effectively encoding the logical negation: if one vertex (representing
a Boolean variable) is selected, the other (representing its negation) must be excluded, and vice versa.


(a) NOT gadget composition



𝑏= ~~𝑐~~


+


𝑎= 𝑏


(b) Copy gadget







1 2 3 4 2𝑛2𝑛+ 1

𝑛1 = ~~𝑛~~ 2 = 𝑛3 = ~~𝑛~~ 4 = … = ~~𝑛~~ 2𝑛 = 𝑛2𝑛+1


FIG. S2. Illustration of how logical conjunction translates to gadget composition in the MWIS framework. (a) Two NOT
gadgets encode the constraints _a_ = [¯] _b_ and _b_ = ¯ _c_, and are combined by merging the vertices representing the shared variable
_b_, ensuring both constraints are enforced simultaneously. (b) shows an extended version where an odd-length vertex wire
is constructed from a sequence of NOT gadgets. Red-framed vertices are equivalent in the MWIS sense, allowing local
information to propagate over long distances.


To illustrate how logical conjunction corresponds to graph composition in the MWIS framework, consider encoding
the two constraints: _a_ = [¯] _b_ and _b_ = ¯ _c_, see Figure S2(a). Each of these constraints can be represented by a simple NOT
gadget. To enforce both constraints simultaneously, the two gadgets must be composed. Since both constraints
involve the same logical variable _b_, we must identify the two vertices representing _b_, i.e., merge _vb_ and _vb_ _[′]_ [into a]
single vertex. This merged vertex now participates in both constraints.
From the energy perspective, each gadget originally assigned a weight _δ_ to its vertex _vb_ (and likewise to _va_ and
_vc_ ). After merging, the shared vertex _vb_ contributes to two energy terms—one from each NOT constraint. Since
the MWIS energy function is additive over vertex weights, the new weight of _vb_ must be updated to 2 _δ_, reflecting
the combined energetic influence of both constraints on that variable.
In summary, merging two gadgets on a shared logical variable enforces the conjunction of their respective constraints. The overlapping vertex inherits the sum of the weights from all participating gadgets, so that the total
MWIS Hamiltonian remains a linear sum of individual gadget energies. Merging vertices does not affect the independence constraints, provided that no new edges are introduced, ensuring that each logical constraint contributes
correctly to the total energy. As a result, the ground state of the composite system simultaneously satisfies all
encoded constraints. We summarize the above procedure in the following according to Ref. [21].


**Proposition 2** (Gadget composition principle) **.** _Let G_ 1 = ( _V_ 1 _, E_ 1 _,_ ∆1) _and G_ 2 = ( _V_ 2 _, E_ 2 _,_ ∆2) _be gadgets that are_
_logically equivalent on their pin sets P ⊆_ _V_ 1 _and Q ⊆_ _V_ 2 _to logical constraints L_ 1 _and L_ 2 _, respectively. Let p ∈_ _P_
_and q ∈_ _Q represent the same logical variable. Form the composite graph G by identifying p and q into a single_
_vertex v and inheriting edges from E_ 1 _∪_ _E_ 2 _(updated to reflect the merge). Assume the MWIS objective is additive_
_in vertex weights and that the merge introduces no edges beyond E_ 1 _∪_ _E_ 2 _. Define_


∆( _v_ ) = ∆1( _p_ ) + ∆2( _q_ ) _,_


_and keep all other vertex weights unchanged. Let the composite pin set be_ ( _P \ {p}_ ) _∪_ ( _Q \ {q}_ ) _∪{v}. Then the_
_MWIS solutions of G are logically equivalent on the composite pin set to the conjunction L_ 1 _∧L_ 2 _._


9


The _copy gadget_, considered in this work, is constructed from an even number of NOT gadgets according to
Proposition 2, which naturally results in an odd-length vertex wire of 2 _n_ + 1 atoms with boundary atoms assigned
weight _δ_ and interior atoms weight 2 _δ_ (see Figure S2(b)) [36]. Under the strong Rydberg blockade, ideally no
two adjacent atoms are simultaneously excited. In the Ω _/_ ∆ _→_ 0 limit, the lowest-energy configurations of the
odd-length wire form a two-fold degenerate Z2-ordered pair: _|_ 0 _⟩ℓ_ = _|_ 0101 _. . ._ 010 _⟩,_ _|_ 1 _⟩ℓ_ = _|_ 1010 _. . ._ 101 _⟩_ [37]. These
two logical states encode a binary variable indicating whether the corresponding graph vertex is excluded (0) or
included (1) in the MWIS.


**Proposition 3.** _All odd-indexed vertices in a copy gadget are logically equivalent to the corresponding vertex in the_
_original graph._


**III.** **GRAPH ENCODING METHODOLOGY:**
**FROM ARBITRARY GRAPHS TO UDGS ON TRIANGULAR-LATTICE SUBGRAPHS (TLSGS)**


Given an arbitrary simple graph _G_ = ( _V, E_ ) with vertex set _V_ and edge set _E_, our objective is to construct an
encoding into a weighted unit-disk graph on a TLSG (see Fig. S1) such that the maximum (weighted) independent
set problem on the original graph can be reduced to the MWIS problem on the encoded graph.
To address this challenge, we introduce the _crossing lattice_ framework as in the KSG encoding [21]. In this
approach, each logical vertex is represented as a vertex wire (copy gadget), arranged so that every pair of logical
vertices intersects at exactly one crossing. This design propagates local adjacency relations along dedicated paths,
ensuring that only pairwise interactions need to be physically realized at each intersection. Each edge in the
original graph is represented by a crossing-with-edge gadget at intersections, while non-adjacent vertex pairs are
either handled by crossing gadgets or remain unconnected.
We then present a systematic approach for encoding arbitrary graphs into TLSGs through the construction of
crossing lattices. As described in Section I, indices are assigned on a square-grid representation for convenience,
whereas the physical coordinates and distances are consistently interpreted on the triangular lattice via the mapping
convention.


**III.A.** **Step 1: Construct Crossing Lattice**


To construct the crossing lattice, we use L-shaped _copy lines_ as the geometric scaffold. Each copy line specifies
the horizontal and vertical spans of an L-shaped wire assigned to a logical vertex. Arranged so that any two vertices
intersect at most once, these wires faithfully reproduce the adjacency of the original graph. Finally, each copy line
is populated with an odd-length copy gadget, turning the abstract scaffold into a physical vertex wire.
The complete graph _K_ 4 provides a concrete illustration of this procedure. As shown in Fig. S3(a) and the table
below, different colored copy lines determine the placement of vertex wires and their intersections, and physical
sites are then populated along each line. These slots partition the grid into cells, with size _s_ = 6 for the TLSG and
_s_ = 4 for the KSG. After vertices are placed at the subdivided grid points, each copy line forms an odd-length copy
gadget.
At each crossing between the copy gadgets of vertices _u_ and _v_, we introduce an edge if ( _u, v_ ) _∈_ _E_ . In the
Hamiltonian, such an edge corresponds to a hard constraint term _∞_ _nunv_ .


**III.B.** **Step 2: Gadget replacement**


_Identify and replace invalid substructures._ The dashed boxes in Fig. S3(a) highlight local substructures of the
crossing lattice that violate UDG constraints in the TLSG after Step 1. These regions are extracted and replaced
with logically equivalent gadgets, determined by the logical rules of the boundary pin vertices. When performing


|Vertex|Vertical slot|Vertical range|Horizontal slot|Horizontal range|
|---|---|---|---|---|
|1|/|/|1|[1, 4]|
|2|2|[1, 2]|2|[2, 4]|
|3|3|[1, 3]|3|[3, 4]|
|4|4|[1, 4]|/|/|


10

|Col1|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|Col11|Col12|Col13|Col14|Col15|Col16|Col17|Col18|Col19|Col20|Col21|Col22|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||
|||||||||||||||||||||||



FIG. S3. (a) Construction of the crossing lattice from copy lines for the complete graph _K_ 4 (before gadget replacement).
Dark gray lines denote copy line slots, each colored wire represents a vertex of the original graph, red-framed sites mark the
vertices logically equivalent to the originals, and red edges encode the original graph’s connectivity. Dashed boxes highlight
some regions violating TLSG constraints. (b) The crossing lattice shown in physical coordinates after gadget replacement
and fine-tuning. The number of auxiliary atoms can be further optimized, for example by manually removing dangling legs.


replacement, the weights of pin vertices connected to external structures must be updated according to Proposition 2.
Details of the replacement are shown in Fig. S4.
_Apply geometric fine-tuning._ Replacement gadgets often differ in size and pin placement from the originals, so
additional adjustments are required (see Fig. S4). Fine-tuning consists of bending, extending, or shortening copy
gadgets to maintain connectivity and ensure consistent pin-vertex alignment. Wires may need to detour sideways
to preserve the parity of each wire. The resulting layout after replacement and fine-tuning is shown in Fig. S3(b).
_Adjust vertex weights with detuning shifts._ If an original vertex _vi_ carries a weight _wi_, this can be renormalized
and transferred to the encoding by adding a small detuning shift _εi_ at the corresponding logically equivalent vertex,
with _εi ∝_ _wi_, subject to the requirement that it is large enough to lift unwanted degeneracies but small enough
not to disturb the _δ_ -scale constraints. Even for unweighted MIS instances, a small nonzero _ε_ is added to break
unwanted degeneracies. For a single copy gadget, such a detuning acts as a symmetry-breaking perturbation: it
lifts the degeneracy between the two MWIS states without affecting the Z2 ordering of the wire.
_Optimize for compactness._ Although the encoding is complete after gadget replacement and fine-tuning, further
optimization can reduce resource overhead. Dangling vertex wires may be removed, and copy gadgets shortened,
provided that parity constraints are respected. At present, such optimization needs to be performed manually.
_Finalize by reshaping to the triangular lattice._ The last step maps the square-grid representation onto the
physical triangular lattice using the procedure in Section I. This reshaping preserves all unit-disk edges and requires
no further adjustments. For readout, the measurement outcome may be taken from any logically equivalent vertex
along a vertex wire.


**III.C.** **Overhead Analysis**


For a graph with _n_ vertices and _m_ edges, the TLSG encoding scheme produces an encoding containing _N_ TLSG
vertices, given approximately by




                 - _n_ ( _n −_ 1)
_N_ TLSG ≲ 6 _n_ ( _n −_ 1) + 4 _m_ right + 1 ( _m −_ _m_ top _−_ _m_ right) + 4



_−_ 1) 
_−_ _m_
2



2 (S2)

_∼_ 8 _n_ [2] _−_ 6 _n −_ 3 _m,_


11



(a) Crossing gadget (b) Crossing-with-edge gadget


(c) T-connection gadgets


(d) Other substructures to be fine-tuned







FIG. S4. Illustration of the gadget replacement and fine-tuning procedure. The dashed boxes indicate regions where gadgets
are directly replaced. Fine-tuning is applied after replacement to ensure proper integration with the existing structure,
subject to two constraints: (1) the parity of the number of atoms on each vertex-wire is preserved, and (2) no additional
connections are introduced beyond those that already exist. Red-framed vertices indicate the logical counterparts on the
corresponding vertex wires, and white-framed vertices inside each gadget have no logical role and function solely as ancillas.


where 6 is the size of the cross-lattice cell _s_ (see Figure S3(a)), 4 the ancilla vertex count of the rightmost Tconnection gadget, 1 that of the crossing-with-edge gadget, 4 that of the crossing gadget, _m_ right _, m_ top _≤_ _n −_ 1
denote the numbers of edges intersecting the rightmost and topmost copy lines, respectively.
This analysis indicates that our method requires at most _O_ (8 _n_ [2] ) atoms, whereas the encoding overhead on the
KSG is at most _O_ (4 _n_ [2] ) [21, 29]. This estimate is rather coarse, as it does not account for potential optimizations
such as vertex reordering [21] after encoding.


**III.D.** **Code Availability and Usage**


We build upon the existing Julia package _UnitDiskMapping.jl_ [31], which reduces generic maximum (weighted)
independent set, QUBO, or integer factorization problems to KSG formulations. In this work, we extend the
package by introducing a new module that encodes generic MIS/MWIS instances directly onto TLSGs, enabling
natural implementation on neutral-atom quantum computers. The updated codebase, along with usage examples
and documentation, is openly available at [31].
Here, we take the complete graph _K_ 4 as an example to demonstrate how to use the code. The entire encoding
workflow, though conceptually involving many steps, has been fully encapsulated, so that a single function call
suffices to perform the whole process.


12











|1|0<br>9|Col3|8|Col5|Col6|Col7|Col8|Col9|Col10|7|Col12|Col13|Col14|Col15|Col16|6|Col18|Col19|Col20|Col21|Col22|5|Col24|Col25|Col26|Col27|Col28|Col29|4|Col31|Col32|Col33|Col34|3|Col36|Col37|Col38|Col39|Col40|Col41|2|Col43|Col44|Col45|1|Col47|Col48|Col49|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|1<br>|0<br>||8||||||||||||||||||||||||||||||||||||||||||||||


Weights: 𝛿 2𝛿 3𝛿 4𝛿 1 Pin vertex


FIG. S5. Encoding of the Petersen graph onto a TLSG. Vertex color indicates weight. Vertices in the original graph correspond
to the red-framed vertices. Membership in the original graph’s independent set is inferred by projective measurement of the
corresponding red-framed vertex in the lattice.









The result can then be visualized, producing plots such as those shown in Fig. S3(b). A larger example using the
Petersen graph is shown in Fig. S5.









The code also provides APIs to verify the correctness of the encoding results; for detailed usage, please refer to
the documentation.


13


**Algorithm 1:** Graph Traversal and Logic Constraint Matching Search Process

**Input** **:** Graph set to search _G_ ; logic rules _L_ (e.g., truth table of a Boolean function)
**Output:** Set _S_ of graphs and corresponding weight configurations that satisfy _L_
_S ←_ ∅ ; `// Initialize the solution set as empty`
**foreach** _G ∈G_ **do**

_M ←_ `MaximalIndependentSets` ( _G_ ) ; `// Compute maximal independent sets`
_O ←_ `GetOpenNodes` ( _G_ ) ; `// Get candidate nodes that can serve as pins`
**foreach** _pins ∈_ _`GeneratePinConfigs`_ ( _O, M, L_ ) **do**

_M_ min _←_ `GetProperMIS` ( _M,_ pins _, L_ ) ; `// Select MISs that satisfy the logic rule`
**if** _Mmin is empty_ **then**

continue
IP _←_ `FormulateIP` ( _M, M_ min _,_ pins _, L_ ) ; `// Formulate a mixed-integer program`
**if** _`Solve`_ (IP) _is feasible_ **then**

∆ _←_ `ExtractWeights` (IP _._ solution) ; `// Extract vertex weights`
_S ←S ∪{_ ( _G,_ pins _,_ ∆) _}_ ; `// Record the current solution`


**return** _S_


**IV.** **DETAILS OF THE SEARCH ALGORITHM**


In this section, we describe how, given a logical rule _L_, one can construct or search for a graph _G_ = ( _V, E_ ) along
with positive vertex weights _{_ ∆ _v | v ∈_ _V }_ such that the solution to the MWIS problem on this graph corresponds
to the given logical rule. Such a graph is what we previously referred to as a gadget which maps a discrete set of
states to the energy-minimizing solution of a combinatorial optimization problem.


**IV.A.** **Preliminaries**


**Definition 3** (Maximal Independent Set) **.** _A maximal independent set is an independent set that is not a proper_
_subset of any other independent set._


In other words, a maximal independent set _S_ satisfies the following condition: adding any vertex not in _S_ would
violate its independence, i.e.,


_∀v ∈_ _V \ S, ∃u ∈_ _S_ such that ( _u, v_ ) _∈_ _E._ (S3)


**Proposition 4** (MWIS is maximal) **.** _For any positive-weighted graph G_ = ( _V, E,_ ∆) _, a maximum weighted inde-_
_pendent set is always a maximal independent set._


_Proof._ Suppose there exists a maximum weighted independent set _S_ that is not maximal. Then there exists a
vertex _u ∈_ _V \ S_ that is not adjacent to any vertex in _S_ . In this case, _S ∪{u}_ forms a larger independent set with
total weight ∆( _S_ ) + ∆( _u_ ) _>_ ∆( _S_ ), which contradicts the assumption that _S_ is maximum weighted. Therefore, a
maximum weighted independent set must be maximal.


As we will see in the following sections, the concepts of maximal and MWIS form the foundation for constructing
gadgets: by carefully selecting maximal independent sets and assigning vertex weights, we can encode logical rules
into the MWIS problem on unit-disk graphs.


**IV.B.** **Search algorithm**


To find gadgets that satisfy the desired properties within a constrained graph dataset _G_ (e.g., TLSGs), we design
a systematic search procedure, as outlined in Algorithm 1.
_Step 1: Solving maximal independent sets M_ For each candidate graph _G_ = ( _V, E_ ) _∈G_, all maximal _cliques_ in
the complement graph _G_ can be found using the Bron-Kerbosch algorithm [38], which corresponds to all maximal
independent sets _M_ on _G_ . The set of maximal independent sets _M_ can be represented as a _|M| × |V |_ binary
matrix, where each row corresponds to a maximal independent set **n** _∈{_ 0 _,_ 1 _}_ _[|][V][ |]_ and each column corresponds to a
vertex _vi_ in the graph.


14


_Step 2: Selecting target maximal independent sets Mmin ⊆M based on L_ In our encoding scheme, pin vertices—representing logical variables at gadget boundaries—are chosen from the open boundary vertices. We first
identify the candidate set of pin vertices _O_ . Given the logical rule _L_ and the set of maximal independent sets _M_,
the algorithm then enumerates all possible ordered pin configurations within _O_, which determine how logical bits
are mapped onto gadget vertices.
Let the target configuration set for _L_ = _{_ **s** 1 _,_ **s** 2 _, . . .,_ **s** _N_ _}_, where each **s** _i ∈{_ 0 _,_ 1 _}_ _[k]_, _k ≤|V |_ . For a fixed pin
configuration, a maximal independent set is said to satisfy **s** _i_ if its configuration values on the pin vertices exactly
match **s** _i_ .
Accordingly, for each target configuration **s** _i_, one can define the candidate set of maximal independent sets
_M_ **s** _i ⊆M_ . If _M_ **s** 1 _, . . ., M_ **s** _N_ are all non-empty, then _M_ min is non-empty, indicating that the vertex configuration
_possibly_ encodes the logical rule _L_ . As the number of ancilla vertices increases, the number of maximal independent
sets also grows, so the selection of _M_ min satisfying _L_ is generally not unique.
_Step 3: Formulating the integer programming problem_ For any vertex configuration with a non-empty _M_ min, the
algorithm formulates the integer programming problem IP defined in main text:



min
**∆** _∈_ Z _[|]_ _≥_ _[V]_ 0 _[ |]_




- ∆ _i_


_i_







_n_ _[′]_ _i_ [∆] _[i]_ _[<]_  
_i_ _i_

_ni_ ∆ _i_ =  
_i_ _i_



_ni_ ∆ _i,_ _∀_ **n** _∈M_ min _,_ **n** _[′]_ _∈M \ M_ min

_i_



(S4)







_n_ _[′]_ _i_ [∆] _[i][,]_ _∀_ **n** _,_ **n** _[′]_ _∈M_ min _._

_i_



As stated in the main text, vertex weights should be non-negative. In particular, if an optimal solution assigns a
weight of zero to a vertex, it implies that the corresponding vertex in the resulting gadget can be removed.
In conclusion, the constraints in the IP are determined by the graph topology, the pin choice, and the logical
rule. If the IP has a feasible solution—i.e., there exists a set of vertex weights ∆such that the graph under this
configuration correctly encodes _L_ —then the graph, pin choice, and vertex weights are considered a valid solution
and stored in the final solution set.


TABLE S1. Examples of gadgets on the triangular lattice


Logic Pin MWIS Logic Pin MWIS
Gadget Gadget
gate configuration energy gate configuration energy



AND


NAND


OR



`000`, `010`, `100`, `111` 3 XOR







`000`, `011`, `101`, `110` 4


`001`, `010`, `100`, `110` 3





`000`, `011`, `101`, `111` 4









1 Pin vertex Weights: 𝛿 2𝛿


15


**IV.C.** **Code Availability and Usage**


We developed a Julia package, _GadgetSearch.jl_ [33], for systematically searching gadgets in graph structures. The
package provides tools to find weighted graphs whose MWIS solutions encode arbitrary logical constraints. It is
suitable for TLSGs in this work.
Using this systematic search method, Table S1 shows examples of gadgets on TLSGs that implement the logical
rules of AND, NAND, OR, NOR, and XOR gates. These gadgets are not unique. The code used to generate these
gadgets is provided below; for detailed usage, please refer to the documentation.

















**V.** **NUMERICAL SIMULATION SETUP**


To quantitatively evaluate the performance of our TLSG encoding, we simulate quantum annealing dynamics
and benchmark against the established KSG encoding for the mapped _K_ 2 _,_ 3 graph. The simulations are designed
to closely replicate experimental conditions in Ref. [20] while remaining computationally tractable. We employ the
time-dependent variational principle (TDVP) [39] with a matrix product state (MPS) ansatz.
Annealing performance is quantified by the _violation rate p_ v, defined from the final measurement outcomes of
_|ψf_ _⟩_ as



1
_p_ v _≡_
_|E|_




 - _P_ ( **n** ) 

**n** _∈{_ 0 _,_ 1 _}_ _[|][V][ |]_ ( _u,v_ )








 - _nunv,_ _P_ ( **n** ) = _|⟨_ **n** _|ψf_ _⟩|_ [2] _,_ (S5)


( _u,v_ ) _∈E_



where **n** = ( _n_ 1 _, . . ., n|V |_ ) denotes a bit-string configuration with _ni ∈{_ 0 _,_ 1 _}_ indicating whether vertex _vi ∈_ _V_ is
excited. Smaller _p_ v corresponds to stronger enforcement of independence constraints.
The annealing protocol follows standard experimental practice [20], employing an unoptimized piecewise-linear
pulse (see main text Fig. 3(b)). All atoms are initialized in the ground state. The Rabi frequency Ω( _τ_ ) ramps
from 0 to Ωmax and back to 0, while the detuning ∆( _τ_ ) sweeps from _−_ ∆max to ∆max over the total annealing time
_τ ∈_ [0 _, T_ ]. Key parameters are:


  - Maximum Rabi frequency: Ωmax = 2 _π ×_ 4 MHz,


  - Maximum detuning: ∆max = 5 _×_ Ωmax.


The blockade radius _Rb_ is defined as the distance at which the van der Waals interaction equals the maximum
Rabi frequency, _C_ 6 _/Rb_ [6] [= Ω][max][ with] _[ C]_ [6][ = 2] _[π][ ×]_ [862690 MHz] _[ µ]_ [m][6][. To map the Rydberg blockade onto the unit-disk]


16


graph representation, we choose the lattice spacing _a_ (also the unit-disk radius) such that


_Rb_ = ~~�~~ _R_ min _r_ max _,_ (S6)


where _R_ min and _r_ max are the minimum distance between disconnected atoms and the maximum distance between
connected atoms in the unit-disk graph. This sets the blockade radius at the geometric mean of these bounds,
ensuring blockade for connected pairs while avoiding spurious long-range interactions [40]. For the two lattice types
considered, we have:



_√_
KSG: _R_ min = 2 _a,_ _r_ max =



2 _a_ = _⇒_ _a_ = 2 _[−]_ [3] _[/]_ [4] _Rb,_



_√_
TLSG: _R_ min =



3 _a,_ _r_ max = _a_ = _⇒_ _a_ = 3 _[−]_ [1] _[/]_ [4] _Rb._



Time evolution is simulated using the time-dependent variational principle (TDVP) [39] with a matrix product
state (MPS) ansatz, a maximum bond dimension _χ_ = 256, and a time step of 0 _._ 1 Ω _[−]_ max [1] _[≈]_ [0] _[.]_ [004] _[ µ]_ [s. To accurately]
capture non-local interactions and geometric frustration in the Rydberg Hamiltonian, we employ a two-site TDVP
scheme with third-order global subspace expansion (GSE) [41]. After the bond dimension is saturated, we switch
to one-site TDVP without GSE for computational efficiency.


