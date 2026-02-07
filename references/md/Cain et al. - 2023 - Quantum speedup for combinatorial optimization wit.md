**Quantum speedup for combinatorial optimization with flat energy landscapes**


M. Cain [1], S. Chattopadhyay [1], J.-G. Liu [1] _[,]_ [2], R. Samajdar [3] _[,]_ [4], H. Pichler [5] _[,]_ [6], M. D. Lukin [1]

1 _Department of Physics, Harvard University, Cambridge, MA 02138, USA_
2 _Advanced Materials Thrust, Hong Kong University of Science and Technology (Guangzhou), Guangdong 511453, China_
3 _Department of Physics, Princeton University, Princeton, NJ 08544, USA_
4 _Princeton Center for Theoretical Science, Princeton University, Princeton, NJ 08544, USA_
5 _Institute for Theoretical Physics, University of Innsbruck, Innsbruck A-6020, Austria_
6 _Institute for Quantum Optics and Quantum Information, Austrian Academy of Sciences, Innsbruck A-6020, Austria_
(Dated: July 10, 2023)


Designing quantum algorithms with a speedup over their classical analogs is a central challenge
in quantum information science. Motivated by recent experimental observations of a superlinear
quantum speedup in solving the Maximum Independent Set problem on certain unit-disk graph
instances [Ebadi _et al._, Science **376** [, 6598 (2022)], we develop a theoretical framework to analyze](https://www.science.org/doi/10.1126/science.abo6587)
the relative performance of the optimized quantum adiabatic algorithm and a broad class of classical
Markov chain Monte Carlo algorithms. We outline conditions for the optimized adiabatic algorithm
to achieve a quadratic speedup on hard problem instances featuring flat low-energy landscapes and
provide example instances with either a quantum speedup or slowdown. We then introduce an
additional local Hamiltonian with no sign problem to the optimized adiabatic algorithm to achieve
a quadratic speedup over a wide class of classical simulated annealing, parallel tempering, and
quantum Monte Carlo algorithms in solving these hard problem instances. Finally, we use this
framework to analyze the experimental observations.



**1.** **INTRODUCTION**


Combinatorial optimization problems have wideranging applications in science and technology [1]. They
are foundational to modern computer science because
they encompass NP-hard problems which cannot be
solved efficiently by known algorithms. A central challenge in quantum information science is to understand
when quantum algorithms can outperform their classical counterparts in solving such NP-hard combinatorial
optimization problems [2, 3]. The most general classical
combinatorial optimization algorithms seek to minimize
a cost function over a set of bit strings. This includes
broad classes of Markov chain Monte Carlo algorithms
such as simulated annealing (SA) and parallel tempering [4], which simulate cooling to low-temperature states
of a classical Hamiltonian encoding the cost function.


Quantum adiabatic algorithms (QAAs) [5] can be
viewed as quantum analogs of such general-purpose classical solvers. QAA prepares low-energy states of a classical cost Hamiltonian [6] by adiabatic evolution. The relative performance of QAA and SA is not generically well
understood beyond numerical studies [7–9], and theoretical examples of quantum speedup are either restricted
to specifically constructed problem instances [10] or require unphysical Hamiltonians [11–13]. However, unlike
other quantum algorithms that are known to generically
achieve a quadratic speedup over SA [14–16], QAA can
be studied experimentally on existing quantum devices.
Although early experimental implementations of QAA
lacked the many-body coherence believed to be necessary
for quantum speedup [17–22], a recent study using a programmable Rydberg atom array [23] observed a superlinear speedup over SA in solving certain hard instances
of the NP-hard Maximum Independent Set problem on



unit-disk graphs.


Motivated by these experimental results, in this work
we develop a theoretical framework to analyze the relative performance of optimized QAA and several classical Markov chain Monte Carlo algorithms. Specifically,
we focus on problem instances with flat energy landscapes comprised of many suboptimal configurations of
the same cost, over which algorithms must search to find
the optimal solution. We show that the QAA’s performance is determined by (de)localization of the low-energy
eigenstates of the adiabatic Hamiltonian in configuration
space: when the low-energy eigenstates are delocalized,
and the quantum evolution is optimized to maintain adiabaticity, QAA achieves a quadratic speedup over a wide
class of SA and parallel tempering algorithms. To illustrate these concepts, we provide examples of problem instances that feature either a quantum speedup or
slowdown depending on the localization of the low-energy
eigenstates.


Having developed this framework, we then use it to introduce a modification of QAA that achieves a quadratic
speedup over SA and parallel tempering on certain hard
Maximum Independent Set problem instances. Importantly, our algorithm only uses local Hamiltonians with
no sign problem, meaning that all the off-diagonal matrix elements are non-positive. While QAA Hamiltonians
without a sign problem are typically amenable to simulation with quantum Monte Carlo (QMC) – and many
prior speedups over SA in this setting have indeed been
recovered by QMC [13, 24] – we nevertheless show that
our algorithm maintains a quadratic speedup over a wide
class of path-integral QMC algorithms. Finally, we apply
these techniques to interpret the experimental observations reported in Ref. [23]. We identify instances with
better-than-classical performance due to either delocal

2


The largest independent set for a graph _G_ = ( _V, E_ ) with
_n_ vertices is a configuration _|z⟩∈{|_ 0 _⟩_ _, |_ 1 _⟩}_ _[n]_ minimizing
_H_ cost( _z_ ) = _⟨z| H_ cost _|z⟩_ for _δ >_ 0, where



_nunv_ (1)
( _u,v_ ) _∈E_



FIG. 1. Flat energy landscapes in combinatorial optimization. The goal of the Maximum Independent Set problem is
to find the largest independent sets of a graph (e.g., the dark
blue vertices, bottom right) among many suboptimal independent sets (top left). The dynamics of SA on this problem
can be visualized by a configuration graph (center), where
vertices represent individual independent sets and edges link
sets connected by an SA update. SA algorithms randomly
walk (black lines) between suboptimal independent sets of
the same size (light green vertices) until finding an optimal
independent set (dark green vertices). We study QAA’s performance on unit-disk graphs (bottom left), where vertices are
connected within a unit radius (yellow circle). Each vertex is
associated with a qubit with a time-dependent drive Ω( _t_ ) and
detuning _δ_ ( _t_ ).


ization or favorable localization of the low-energy eigenstates. Instances with worse-than-classical performance
can be explained by unfavorable localization of the eigenstates, as introduced by Ref. [25].
Before proceeding, we note that state-of-the-art classical heuristic algorithms specialized to the Maximum
Independent Set problem can outperform SA (e.g., [26]).
These algorithms accelerate the computation by exploiting the problem-specific graph structure. In contrast,
SA is a general-purpose solver that only uses the energy
of a configuration in decision-making to prepare the
Gibbs distribution of the cost Hamiltonian. Similarly,
QAA only takes in the cost Hamiltonian as an input,
and prepares its ground state by adiabatic evolution.
We will restrict our analysis to the case where the
QAA evolution is slow enough to maintain adiabaticity,
and the SA evolution is long enough to equilibrate to
the Gibbs distribution. Running these algorithms at
short, _diabatic_ timescales and exploring shortcuts to
adiabaticity is of independent interest [27–30].


**A.** **Maximum Independent Set**


Throughout this work, we focus on the Maximum Independent Set problem, a paradigmatic NP-hard optimization problem that involves finding the largest independent set of a graph. An independent set is a subset of
vertices where no two vertices are connected by an edge.



_H_ cost = _−δ_ 



- _nu_ + _U_ 
_u∈V_ ( _u,v_ )



is the classical cost Hamiltonian. Here, _nu ≡|_ 1 _u⟩⟨_ 1 _u|_,
and _|_ 1 _u⟩_ ( _|_ 0 _u⟩_ ) denotes that vertex _u_ is present (absent)
in the independent set. _U ≫|δ|_ penalizes edges that violate the independent set constraint. We focus primarily
on unit-disk graphs, where edges connect vertices within
a unit radius on a two-dimensional plane. These graphs
naturally model problems with geometrically local connectivity, such as wireless communication networks [31].
The Maximum Independent Set problem on unit-disk
graphs can be naturally encoded in Rydberg atom arrays
as follows [32]. Every vertex is associated with an atomic
qubit placed on a square grid at position _ru_ (Fig. 1). The
full system is described by the many-body Hamiltonian
_H_ = _H_ Ryd _−_ _Hq_, where



_Hq_ = Ω 


_|_ 1 _u⟩⟨_ 0 _u|_ + h _._ c _.,_ (2)
_u∈V_



_H_ Ryd = _−δ_ 



- _nu_ + 
_u∈V_ _u,v_



_Vuvnunv,_ (3)
_u,v_



and Ω( _t_ ) _>_ 0 and _δ_ ( _t_ ) are time-dependent energies controlled by a coherent laser drive. The distance-dependent
Rydberg blockade interaction energy _Vuv ∼_ 1 _/|ru −_ _rv|_ [6]

makes simultaneous excitation of two atoms in the Rydberg state _|_ 1 _u_ 1 _v⟩_ within a certain radius energetically
unfavorable, mimicking _U_ in Eq. (1). In practice, the
blockade radius is chosen to encompass nearest and
next-nearest neighbors on the grid.


**2.** **SIMULATED ANNEALING RUNTIME ON**
**HARD INSTANCES**


We first characterize fundamentally hard graph instances for SA to find the largest independent set. SA
stochastically samples spin configurations from the thermal Gibbs distribution _π_ of _H_ cost at a low temperature 1 _/β_ . We consider any Metropolis-Hastings SA algorithm [33, 34] in which the probability _Pz,z′_ to update
_|z⟩_ to _|z_ _[′]_ _⟩_ satisfies the detailed balance condition,


_Pz,z′πz_ = _Pz′,zπz′_ _πz_ = _e_ _[−][βH]_ [cost][(] _[z]_ [)] _/Zβ,_ (4)


where _πz_ is the Gibbs population of _|z⟩_ and _Zβ_ is the
partition function. We allow the update rule to be arbitrarily non-local.
Within this general setting, we find that flat energy
landscapes, defined as many suboptimal independent sets
of the same size with few larger independent sets, form a
fundamental obstacle for SA to find the solution [23, 35].
Figure 1 visualizes the flat energy landscape of an example unit-disk graph as a _configuration graph_, where vertices represent independent sets and edges represent SA


3



updates (here, spin-exchange and spin-flip operations).
This instance has many suboptimal independent sets of
size _α−_ 1 and few optimal largest independent sets of size
_α_ . The SA dynamics, governed by Eq. (4), are dominated
by a random walk among the suboptimal, equal-energy
configurations, reminiscent of unstructured search for the
optimal solutions. Therefore, we expect the SA runtime
to go like the inverse rate _≃_ _Dα−_ 1 _/Dα_ of randomly choosing an optimal independent set, where _Db_ is the number
of independent sets of size _b_ .
We now formalize this intuition and describe a lower
bound on the SA runtime _τ_ SA( _ε_ ). _τ_ SA( _ε_ ) is a proxy for
the time needed for SA to find an optimal solution. In
particular, it given by the SA _mixing time_ : the number
of proposed updates, normalized by _n_, needed to prepare the Gibbs distribution with total variation distance
_ε <_ 1 _/_ 2 starting from any initial configuration [36]. As
the temperature 1 _/β →_ 0, the Gibbs distribution approaches the uniform mixture of optimal configurations.
Thus, if the time for SA to equilibrate amongst the optimal configurations is small compared to the time to find
an optimal configuration, we expect _τ_ SA( _ε_ ) to represent
the time to find a solution. We confirm that this is the
case in Appendix E 2, because the optimal configurations
are well-connected under spin-exchange updates.
We prove the lower bound on _τ_ SA( _ε_ ) in Appendix A 1
by relating _τ_ SA( _ε_ ) to the inverse spectral gap ∆ _[−]_ SA [1] [of]
the SA Markov chain transition matrix _P_ = ( _Pz,z′_ ) [37].
We then use the Cheeger inequality [38] to relate ∆SA
to the flow of population in the Gibbs distribution from
independent sets of size _≤_ _b−_ 1 to size _≥_ _b_ during a single
SA update. This flow is proportional to _Db/Db−_ 1, which
gives us



10 [6]


10 [4]


10 [2]


10 [0]



|4<br>3<br>2<br>1<br>y = x<br>√<br>y = x<br>0|Col2|Col3|Col4|Col5|
|---|---|---|---|---|
|_y_ =_ x_<br>_y_ = _√_~~_x_~~<br>0<br>1<br>2<br>3<br>4|_y_ =_ x_<br>_y_ = _√_~~_x_~~|_y_ =_ x_<br>_y_ = _√_~~_x_~~|_y_ =_ x_<br>_y_ = _√_~~_x_~~|_y_ =_ x_<br>_y_ = _√_~~_x_~~|
||||||
||||||
||||||
||||||


10 [0] 10 [2] 10 [4] 10 [6]

SA runtime lower bound






      - 1
_τ_ SA( _ε_ ) _≥_ [ln] 2



1 
2 _ε_



_,_ (5)
_Db_



2 _ε_ max _[D][b][−]_ [1]

2 _nk_ _Db_



FIG. 2. Flat energy landscapes determine SA runtime. The
actual SA runtime to find an optimal solution with probability 3 _/_ 4 is linearly related to the analytic SA runtime lower
bound in Eq. (5), confirming that SA runtime is dominated
by overcoming flat energy landscapes.


**3.** **INSTANCE-BY-INSTANCE PERFORMANCE**
**OF QAA**


We now establish conditions for which QAA outperforms SA on such hard instances. QAA prepares the
ground state of _H_ cost by adiabatic evolution under


_H_ QAA = _H_ cost _−_ _Hq,_ (6)


where the energies Ω( _t_ ) _, δ_ ( _t_ ) [Eqs. (1) and (2)] vary in
time as shown in Fig. 3(a). In particular, we assume that
Ω( _t_ ) _, δ_ ( _t_ ) are optimized to minimize the evolution time
while maintaining adiabaticity near the minimum energy
gap ∆QAA between the ground and first-excited states of
the dominant avoided level crossing, so the runtime of
QAA goes as ∆ _[−]_ QAA [1] [(specifically,] _[ |][dH/dt][| ∝]_ [∆] QAA [2] [at the]
avoided crossing location (Ω _/δ_ ) _⋆_, see Refs. [11, 41] and
Sec. 6 for further discussion). We will show that ∆QAA
is controlled by the properties of two states, _|G⟩_ and _|E⟩_,
which approximate the ground and first-excited states at
this avoided crossing, as shown in Fig. 3(b). We analyze
three qualitatively distinct behaviors for _|G⟩_ _, |E⟩_, which
we term _delocalized, favorably localized_, and _unfavorably_
_localized_ . The former two result in a speedup over SA,
while the latter causes a slowdown.


As argued in Appendix C 3, generically, the avoided
level crossing occurs near the end of the ramp, at
(Ω _/δ_ ) _⋆_ _≪_ 1. We will show later that _|G⟩_ and _|E⟩_ can
be computed at leading order in Ω _/δ_ as non-negative superpositions of optimal and suboptimal independent sets,



where _k_ is the maximum number of spins altered during a proposed update [39]. We numerically find in Appendix B that max _b_ ( _Db−_ 1 _/Db_ ), and therefore the SA runtime, grows exponentially in _[√]_ ~~_n_~~ ~~.~~ Moreover, we demonstrate that a similar bound holds for a wide class of parallel tempering algorithms in Appendix A 2. As our proofs
are framed in terms of a generic discrete cost function,
they also apply to combinatorial optimization problems
beyond Maximum Independent Set.
Figure 2 shows the time for an optimized SA algorithm [23] to find an optimal solution with probability
3 _/_ 4 against Eq. (5), which we compute via a tensornetwork algorithm [40]. We plot the data for the top 5%
hardest unit-disk graphs maximizing Eq. (5) within each
system size ( _n_ = 39 – 460, see Appendix B), omitting
a small fraction (0 _._ 9%) of instances for which the SA
runtime is too long to collect sufficient statistics. The
strong linear relationship in Fig. 2 confirms that the SA
runtime is dominated by unstructured search over flat
energy landscapes. Furthermore, it indicates that _τ_ SA( _ε_ )
is representative of the time to find an optimal solution.


4



|Col1|Col2|
|---|---|
|||
|||


(b) Energy





(e)









FIG. 3. Eigenstate localization determines QAA runtime. (a) The optimized QAA runtime is proportional to ∆ _[−]_ QAA [1] [when]
the system Hamiltonian changes slowly at ( _δ/_ Ω) _⋆_, the location of the avoided level crossing. (b) ∆QAA can be computed
perturbatively when (Ω _/δ_ ) _⋆_ _≪_ 1 from Eq. (8), which describes the coupling under the Hamiltonian between the estimated
eigenstates _|G⟩_ _, |E⟩_ involved in the avoided level crossing. (c) The star graph with _nb_ branches of even length _ℓ_ has a unique
optimal independent set of size _α_ with the central vertex in the independent set (top left). It has approximately ( _ℓ/_ 2 + 1) _[n][b]_
suboptimal independent sets of size _α −_ 1 with the central vertex absent (top right), corresponding to all possible locations of
a domain wall on each branch. When _ℓ_ = 2, the two possible domain wall locations on each branch are equally energetically
favored, causing _|E⟩_ to delocalize over all domain wall locations. (d) When _ℓ>_ 2, _|E⟩_ localizes around configurations with the
domain walls near the center of each branch. (e) QAA has a quadratic speedup in runtime over SA as a function of _nb_ for the
delocalized case of _ℓ_ = 2. As _ℓ_ increases, _|E⟩_ localizes away from _|G⟩_, causing SA to outperform QAA when _ℓ_ _≫_ 1.



respectively:


_|G⟩_ =       
_z_ : _H_ cost( _z_ )= _−δα_

_|E⟩_ =       



- _Gz |z⟩_ _,_


~~�~~ _Ez |z⟩_ _._ (7)



_z_ : _H_ cost( _z_ )= _−δ_ ( _α−_ 1)


In the examples we consider, _|E⟩_ is a superposition of independent sets of size _α −_ 1, though our arguments can
be generalized when _|E⟩_ is a superposition of smaller independent sets (see Appendix C 3). We can estimate
∆QAA in powers of (Ω _/δ_ ) _⋆_ as the coupling between _|G⟩_
and _|E⟩_ [25, 42–45],



are localized on comparatively few sets, and those where
they are distributed more evenly among all sets. We
refer to instances where _|G⟩_ and _|E⟩_ localize on sets sufficiently far apart in Hamming distance such that QAA
suffers a slowdown relative to SA ( ∆ [˜] QAA _≪_ _Dα/Dα_ 1)

_−_
as _unfavorably localized_ [25]. By contrast, on _favor-_
_ably localized_ instances, _|G⟩_ and _|E⟩_ localize at small
Hamming distances, such that QAA has speedup over
SA ( ∆ [˜] QAA _≫_ _Dα/Dα_ 1). Several previous notable in
_−_
stances where QAA has an exponential speedup [10] or
slowdown [30] fall into these two categories.
QAA also outperforms SA on _delocalized_ instances,
where the amplitudes _[√]_ _Gz_ and _[√]_ _Ez_ are close to uniform.
Suppose that _|G⟩_ = _|Sα⟩_ and _|E⟩_ = _|Sα−_ 1 _⟩_, where



1
_|Sb⟩_ = ~~_√_~~
_Db_




- _∞_ _⟨E|_ - _Hq_ _Q_

_E⋆_ _−_ _H_ cost
_l_ =0




- _l_
_Hq |G⟩_ _,_ (8)

�����



_,_ (8)
�����



˜∆QAA = 2



�����




 - _|z⟩_ _._ (9)

_z_ : _H_ cost( _z_ )= _−δb_



where _Q_ = 1 _−|E⟩⟨E| −|G⟩⟨G|_ . In Appendix C 1, we derive a bounded proportionality factor relating ∆QAA and
˜∆QAA. We note that these results provide a perturbative approach to _exactly_ compute ∆QAA and are thus of
broader utility and interest beyond the specifics of the
problem considered here.
Per Eq. (8), ∆ [˜] QAA is determined by the distribution of
wavefunction amplitudes in _|G⟩_ and _|E⟩_ . At each order _l_
in (Ω _/δ_ ) _⋆_, factors of _Hq_ generate _l_ +1 spin flips to connect
pairs of configurations in _|G⟩_ and _|E⟩_ . The leading-order
coupling between two configurations _|z⟩_ and _|z_ _[′]_ _⟩_ within
Hamming distance _l_ + 1 goes like _[√]_ _GzEz′_ (Ω _/δ_ ) _[l]_ _⋆_ [. This]
coupling is enhanced for sets with larger amplitude but
is suppressed exponentially in _l_ . This intuition leads us to
distinguish between problem instances where _Gz_ and _Ez_



The lowest-order ( _l_ = 0) contribution to Eq. (8) is then



2
˜∆QAA = 2 _| ⟨Sα−_ 1 _| Hq |Sα⟩|_ = ~~�~~ _Dα−_ 1 _Dα_




 - Ω _α_

_z_ : _H_ cost( _z_ )= _−δα_




  

= 2Ω _α_



_Dα_
_._ (10)
_Dα−_ 1



Due to coherent enhancement in the coupling, here, the
QAA runtime ∆ [˜] _[−]_ QAA [1] [is quadratically smaller than the]
SA runtime [Eq. (5)] up to polynomial factors in _n_ .
This is reminiscent of the adiabatic version of Grover’s
search [11], which has a similar quadratic speedup over
randomly guessing in _{|_ 0 _⟩_ _, |_ 1 _⟩}_ _[n]_ for optimal solutions.


However, we emphasize that the runtimes of QAA and
SA in Eqs. (10) and (5), respectively, are asymptotically
faster than Grover’s search, because they search only
among near-optimal configurations for the largest independent set.


**A.** **Determining eigenstate localization**


Given a problem instance, we can determine _|G⟩_ and
_|E⟩_ by performing second-order perturbation theory in
the degenerate manifolds of _H_ cost. For simplicity, we take
the energy penalty on independent set violations _U →∞_,
so that each degenerate manifold contains independent
sets of the same size. The perturbed eigenstates (energy
shifts) are the eigenvectors (eigenvalues) of the matrix



5


_nb_ branches of even length _ℓ_ connected by a central vertex. We will compare the QAA and SA runtimes at fixed
_ℓ_ as _nb_ grows. The unique largest independent set includes the central vertex plus alternating vertices on each
branch (Fig. 3(c), top left). All but a vanishing fraction
of the suboptimal independent sets of size _α_ _−_ 1 have the
central vertex absent and alternating antiferromagnetic
order on the branches, each of which has a single domain
wall located in one of _ℓ/_ 2+1 possible positions (Fig. 3(c),
top right). The SA runtime is thus exponential in _nb_,




      - 1
_τ_ SA( _ε_ ) _≥_ [ln] 2



1 
2 _ε_




     - 1

_α−_ 1 _≥_ [ln] 2

_Dα_ 2 _nk_



2 _ε_ _Dα−_ 1

2 _nk_ _Dα_



2 _ε_ (13)

2 _nk_ [(] _[ℓ/]_ [2 + 1)] _[n][b]_ _[.]_



1 
2 _ε_



_H_ [(2)] = _−_ [Ω][2]

_δ_




_Hse_ + 
_u∈V_



) - (1 _−_ _nv_ )� [�] _,_

( _u,v_ ) _∈E_



(11)




- _nu −_ (1 _−_ _nu_ ) 


To compute the QAA runtime from Eq. (8), we first
calculate _|G⟩_ and _|E⟩_ . _|G⟩_ is the unique largest independent set, and _|E⟩_ is the ground state of _H_ [(2)] in the
_H_ cost = _−δ_ ( _α −_ 1) manifold. By the reasoning above, on
each branch, _|E⟩_ is well-approximated by the ground state
of _−_ (Ω [2] _/δ_ ) _Hse_, which acts as a one-dimensional hopping
Hamiltonian, with open boundary conditions, for each
domain wall. Therefore, _|E⟩_ is given by



where _Hse_ is the spin-exchange Hamiltonian,


_Hse_ =      - _σu_ [+] _[σ]_ _v_ _[−]_ [+] _[ σ]_ _u_ _[−][σ]_ _v_ [+] _[,]_ (12)

( _u,v_ ) _∈E_

_σu_ [+] [=] _[ |]_ [1] _[u][⟩⟨]_ [0] _[u][|][,]_ [ and] _[ σ]_ _u_ _[−]_ [=] _[ |]_ [0] _[u][⟩⟨]_ [1] _[u][|]_ [.] _[ |G⟩]_ [is the ground]
state of _H_ [(2)] in the _H_ cost = _−δα_ manifold, and _|E⟩_ is
the ground state of the excited manifold whose energy
first intersects _|G⟩_ at a finite (Ω _/δ_ ) _⋆_ . As _H_ [(2)] has no sign
problem, _|G⟩_ and _|E⟩_ have non-negative amplitudes.
We find that first term in Eq. (11), _−_ (Ω [2] _/δ_ ) _Hse_,
primarily determines the (de)localization of _|G⟩_ and
_|E⟩_ . This is because the second term is uniform within
a manifold, and the third term (which counts the
number of vertices that can be added to the independent
set) is small for near-optimal independent sets. In
particular, the expectation value of the third term is
at most _−_ (Ω [2] _/δ_ )( _α −_ _b_ ) for an independent set of size
_b_, and is zero when no vertices can be added to a set
without removing existing vertices. In order to minimize

_−_ (Ω [2] _/δ_ ) _Hse_, _|G⟩_ and _|E⟩_ will thus have larger overlap
with independent sets that have more neighboring
independent sets connected by spin exchanges in the
configuration graph. In contrast, if all configurations in
the _H_ cost = _−δb_ manifold have the same degree (number
of neighbors), the ground state in that manifold is the
delocalized superposition _|Sb⟩_ . This follows from viewing
_Hse_ as the adjacency matrix of the configuration graph
within that manifold, and noting that the principal
eigenvector of the adjacency matrix of a graph with
regular degree is uniform [46].


**B.** **Delocalization–localization crossover for a**
**family of star graphs**


To concretely illustrate these concepts, we explore a
family of star graphs, where _|E⟩_ can be tuned from delocalized to unfavorably localized. A star graph contains



**4.** **QUANTUM SPEEDUP FROM**
**DELOCALIZATION**


**A.** **Quantum speedup over simulated annealing**


So far, our results show that the optimized QAA



_⟨x_ 1 _x_ 2 _. . . xnb_ _|E⟩≃_



_nb_



_i_ =1



1   - _πxi_

sin

~~�~~ _ℓ/_ 4 + 1 _ℓ/_ 2 + 2




_,_ (14)



where _|xi⟩_ _, xi ∈{_ 1 _,_ 2 _, . . ., ℓ/_ 2 + 1 _}_ is the state with
the domain wall on the _i_ th branch located between
sites 2 _xi −_ 2 and 2 _xi −_ 1 (see Fig. 3(d), top and Appendix D 1). ∆ [˜] QAA can be computed to leading order in
Ω _/δ_ from Eq. (8) by connecting _|G⟩_ to the set in _|E⟩_ with
all domain walls adjacent to the central vertex ( _xi_ = 1)
by flipping the central vertex,


˜∆QAA _≃_ 2Ω _| ⟨G| Hq |E⟩|_




  - 1  - _π_
_≃_ 2Ω sin

~~�~~ _ℓ/_ 4 + 1 _ℓ/_ 2 + 2




- [�] _[n]_ _b_
_._ (15)



Terms that are higher-order in Ω _/δ_ do not affect the scaling of ∆ [˜] QAA with _nb_, as shown in Appendix D 2.
Figure 3(e) plots the numerically computed QAA
runtime ∆ _[−]_ QAA [1] [versus the SA runtime lower bound]
for _τ_ SA(1 _/_ 4) for branch lengths _ℓ_ = 2 _,_ 4 _,_ 6 _,_ and 8.
When _ℓ_ = 2, _|E⟩_ delocalizes evenly among all domain
wall configurations (Eq. (14) and Fig. 3(c), bottom), yielding a quadratic quantum speedup because
∆ _[−]_ QAA [1] [= 2Ω] _√_ 2 ~~_n_~~ _b_ ≲ - _τ_ SA( _ε_ ). As _ℓ_ increases, according



2 ~~_n_~~ _b_ ≲ 


∆QAA [= 2Ω] 2 _τ_ SA( _ε_ ). As _ℓ_ increases, according

to Eq. (14), _|E⟩_ unfavorably localizes away from _|G⟩_, on
sets with the domain wall located near the center of
each branch (Fig. 3(d), bottom). Expanding Eq. (14)
for small angles, we find that this results in a _slowdown_
for QAA when _ℓ_ _≫_ 1, as ∆ _[−]_ QAA [1] _[≃]_ _[τ]_ SA [(] _[ε]_ [)][3] _[/]_ [2][.]


6



(a) (c)

ground subspace


(b)



(d)



FIG. 4. Quantum speedup over simulated annealing. (a) When _λ →∞_, the dynamics of the modified QAA [Eq. (16)]
are restricted to the degenerate ground states of _Hℓ_, which are the uniform superpositions _|Sb⟩_ of each independent set size
_b_ [Eq. (9)]. The matrix elements of _Hq_ (gold) between _|Sb⟩_ and _|Sb−_ 1 _⟩_ are coherently enhanced over the analogous rate at
which SA transitions from independent sets of size _b −_ 1 to _b_ . (b) The energy spectrum minus the ground state energy _E_ 0 of
an example 720-vertex instance, restricted to the ground subspace of _Hℓ_ . The minimum gap ∆QAA of the modified QAA is
set by the smallest coupling (gold). (c) The modified QAA runtime ∆ _[−]_ QAA [1] [scales as the square root of the SA runtime for the]
same instances as in Fig. 2 when dynamics are restricted to the ground subspace of _Hℓ_ (circles). The speedup is also obtained
for finite _λ_ = 5 (triangles). (d) The modified QAA obtains a quadratic speedup over SA for the star graphs with branch length
_ℓ_ = 4 _,_ 6 _,_ 8 when _λ_ = 2 _._ 2 _,_ 4 _._ 1 _,_ 6 _._ 5, respectively.



achieves a quadratic speedup over SA when its lowenergy eigenstates are delocalized, due to the coherent
enhancement of the couplings _⟨Sb_ 1 _| Hq |Sb⟩_ in Eq. (10).

_−_
It is thus natural to ask whether instances with unfavorable localization can be remedied by modifying QAA to
force the eigenstates to delocalize. We achieve this result
by designing a Hamiltonian _Hℓ_ whose degenerate ground
subspace is spanned by the uniform superpositions _{|Sb⟩}_
( _b_ = 0 _,_ 1 _, . . ., α_ ), and adding it to the QAA Hamiltonian
with a time-independent energy scale _λ_,


_H_ = _H_ QAA + _λHℓ._ (16)


In contrast to prior approximate approaches to favoring
delocalization [47, 48], this approach provably enforces
delocalization under certain conditions on the flat energy
landscape, which we will state.
To design _Hℓ_, we draw inspiration from the singleparticle quantum kinetic energy operator, the ground
state of which is maximally delocalized. Since the singleparticle kinetic energy is the negative of the continuum
Laplacian _−∇_ [2], we let _Hℓ_ be the discrete Laplacian of
the configuration graph in Fig. 1, restricted to each degenerate manifold of _H_ cost, where vertices represent independent sets and edges represent spin exchanges. The
discrete Laplacian is the negative of the adjacency matrix ( _Hse_ ), plus a diagonal term that counts the degree
for that configuration, i.e., the number of possible spin
exchanges,



where _G_ = ( _V, E_ ) is the original problem graph. Crucially, the diagonal term prevents the ground states of
_Hℓ_ from localizing on independent sets with larger degrees on the configuration graph. This differs from the
perturbative spin-exchange term in the unmodified QAA
Hamiltonian _H_ [(2)] [Eq. (11)], which energetically favors
configurations with more possible spin exchanges. We
emphasize that _Hℓ_ can be efficiently constructed using
only local information about the problem graph. For
unit-disk graphs embedded on a square grid, the terms
in _Hℓ_ only involve a constant number of spins, which
allows for its implementation in near-term experiments.
To develop some intuition, let us first analyze the modified QAA when the energy scale of _Hℓ_, _λ_, is large. If there
exists a path between any two configurations in a degenerate manifold under spin exchanges, then each block _Hb_
of _Hℓ_ = _H_ 0 _⊕_ _H_ 1 _⊕_ _. . . ⊕_ _Hα_ has a unique ground state
equal to _|Sb⟩_ with eigenvalue zero [46]. Since the QAA
dynamics are restricted to this ground subspace when
_λ, U →∞_, the modified QAA Hamiltonian in Eq. (16)
reduces to a one-dimensional tight-binding Hamiltonian,



_Db_
_Db−_ 1 ( _|Sb⟩⟨Sb−_ 1 _|_ + h _._ c _._ ) _,_

(18)




~~�~~



_Htb_ = _−_



_α_

- _δb |Sb⟩⟨Sb|_ + Ω _b_


_b_ =1



_Hℓ_ = _−Hse_ + 
_u∈V_




 - _nu_ (1 _−_ _nv_ ) 
( _u,v_ ) _∈E_ ( _y,v_ )







( _y,vy_ =) _∈uE_



which has an electric field gradient of strength _δ_ and
site-dependent couplings Ω _b_ ~~�~~ _Db/Db−_ 1 [see Fig. 4(a)].

If the minimum energy gap ∆QAA of _Htb_ is set by the
smallest coupling, as shown in Fig. 4(b) for an example
720-vertex unit-disk graph, then ∆ _[−]_ QAA [1] [is quadratically]
smaller than the SA runtime lower bound. We confirm
the trend ∆QAA _≃_ min _b_ (Ω _b_ - _Db/Db_ 1) numerically for

_−_



(1 _−_ _ny_ ) _,_


(17)


hundreds of hard instances of the Maximum Independent
Set problem on unit-disk graphs in Fig. 4(c). To explain these observations, we show in Appendix E 1 that
∆QAA _≃_ Ω _α_ ~~�~~ _Dα/Dα_ 1 on the vast majority of studied



∆QAA _≃_ Ω _α_ _Dα/Dα−_ 1 on the vast majority of studied

instances, for which the smallest coupling is between independent sets of size _α −_ 1 and _α_ and the remaining
couplings are a smooth function of _b_ . We additionally
argue in Appendix E 2 that the same result holds when a
small number of configurations within a degenerate manifold are disconnected under spin exchanges, which occurs
for a small fraction of instances.
To achieve the quantum speedup in practice, however,
∆QAA _[−]_ [1] [must scale more favorably than the SA runtime]
when the energy scales of the modified QAA Hamiltonian
are measured in units of _λ_, when _λ_ is the largest energy
scale of _H_ . To investigate the scale of _λ/_ Ωrequired to
obtain the quadratic enhancement of ∆QAA, in Fig 4(c)
we plot ∆ _[−]_ QAA [1] [for the top 1% hardest instances with up]
to _n_ = 80 vertices, computed using the density matrix
renormalization group method (DMRG) [49, 50]. With
the modest overhead of _λ/_ Ω= 5, we observe a clear
quadratic scaling advantage over the SA runtime lower
bound in Eq. (5). Furthermore, the modified QAA with
_λ/_ Ω= 1 substantially outperforms the unmodified QAA
on the same instances (see Fig. 13(a) of Appendix E 2).
We complement our numerical observations with
sufficient, though not necessary, conditions on the
_λ_ which yield a quadratic quantum speedup. In
Appendix E 2, we show analytically that a sufficient
condition for achieving the quadratic enhancement of
∆QAA is _λ/_ Ω _, λ/δ_ ≳ ∆ _[−]_ _ℓ,b_ [1] _[,]_ [ ∆] _ℓ,b_ _[−]_ [1] 1 [, where ∆] _[ℓ,b][,]_ [ ∆] _[ℓ,b][−]_ [1][ are]

_−_
the spectral gaps of the delocalizing Hamiltonian _Hℓ_
restricted to the manifolds _b_ and _b −_ 1 that share the
smallest tight-binding coupling min _b_ (Ω _b_ - _Db/Db_ 1).



smallest tight-binding coupling min _b_ (Ω _b_ _Db/Db−_ 1).

In Fig. 4(d), we confirm that the modified QAA with
_λ_ = ∆ _[−]_ _ℓ,α_ [1] 1 [=] _[ O]_ [(1) has a quadratic speedup for the fam-]

_−_
ily of star graphs. We show in Fig. 13(b) of Appendix E 2
that typically ∆we study; accordingly, _ℓ,b,_ ∆ _ℓ,b λ−_ ∆1 _>_ _[−]_ QAA [1] 1 _/n_ _[∼]_ for the unit-disk graphs _[n]_ [ min] _[b]_ [(Ω] _[b]_ ~~�~~ _Db_ 1 _/Db_ ).



7


sampling from the QMC path integral at low temperatures as the Hamiltonian is varied adiabatically in real
time [13, 51]. It is thus natural to ask whether this procedure, also called _simulated quantum annealing_, can match
the modified QAA runtime.
In Appendix A 3, we derive a lower bound for the QMC
runtime _τ_ QMC( _ε_ ) of both the modified and unmodified
QAA. Analogous to the SA runtime _τ_ SA( _ε_ ), _τ_ QMC( _ε_ ) is
the number of QMC updates, normalized by _n/M_, where
_M_ is the number of imaginary time slices, needed to sample from _π_ with total variation distance _ε <_ 1 _/_ 2 [52]. We
consider any QMC algorithm which alters up to _k_ spins
in each imaginary time slice per update, where _k_ is restricted to be constant in _n_ .
Crucial to our argument is the fact that before QMC
encounters an independent set _|z⟩_ with _H_ cost( _z_ ) _≤−δb_,
it effectively samples from a restricted Hilbert space of
only independent sets with _H_ cost( _z_ ) _≥−δ_ ( _b −_ 1). At any
point during the adiabatic ramp, we let _H_ [(] _[r,b]_ [)] denote
the Hamiltonian in this restricted Hilbert space, with
corresponding Gibbs populations _πz_ [(] _[r,b]_ [)] . We let _|z_ max _⟩_
denote the configuration in this restricted Hilbert space
within _k_ spin flips of an independent set of size _b_ with
the maximum Gibbs population _πz_ [(] _[r,b]_ max [)] [. Further, we let]
_e_ [(] max _[r,b]_ [)] [=] _[ π]_ _z_ [(] _[r,b]_ max [)] _[D]_ _b−_ 1 [describe relative enhancement or sup-]
pression of its population compared to the uniform superposition state _|Sb−_ 1 _⟩_ .
Analogous to SA, we then apply the Cheeger inequality to derive an upper bound on the QMC Markov
chain spectral gap ∆QMC, which gives a lower bound on
_τ_ QMC( _ε_ ) _._ This allows us to relate ∆QMC to the flow from

populations in the Gibbs distribution of _πz_ [(] _[r,b]_ [)] to independent sets of size _≥_ _b._ This flow is proportional to
_e_ [(] max _[r,b]_ [)] _[D]_ _b_ _[/D]_ _b−_ 1 [, which gives us]




       - 1
_τ_ QMC( _ε_ ) _≥_ [ln] 2



1 
2 _ε_




[ln] 2 _nkn_ 2 _ε_ _[k]_ [max] _e_ [(] max _D_ _[r,b]_ _b−_ [)] _[D]_ 1 _b_ _._ (19)



we study; accordingly, _λ_ ∆QAA _[∼]_ _[n]_ [ min] _[b]_ [(Ω] _[b]_ _Db−_ 1 _/Db_ ).

Therefore, when ∆ _[−]_ _ℓ,b_ [1] _[,]_ [ ∆] _ℓ,b_ _[−]_ [1] 1 [grow at most polynomially]

_−_
in _n_, the modified QAA’s runtime is (sub)exponentially
_√_ _n_
faster than the runtime of Grover’s search ( 2 ) for



_n_

faster than the runtime of Grover’s search ( 2 ) for

the hard unit-disk graphs we study: numerically, the
SA runtime goes like _c_ ~~_√n_~~ for some _c ∈_ (1 _,_ 2), whereas

~~_√n_~~

the modified QAA runtime is _[√]_ ~~_c_~~ up to polynomial



~~_√n_~~

the modified QAA runtime is _[√]_ ~~_c_~~ up to polynomial

factors in _n_ (see Appendix B).



Eq. (19) shows that when the Gibbs distribution of the
restricted Hilbert space is delocalized, i.e., when the _Hℓ_
energy scale _λ_ is sufficiently large, the modified QAA has
a quadratic speedup over QMC. In this case, _e_ [(] max _[r,b]_ [)] _[≤]_ [1,]
the modified QAA runtime goes like maxso the QMC runtime goes like max _b_ ( _Db−_ 1 _/Db_ ~~�~~ _b_ ), whereas _Db_ 1 _/Db_ .



**B.** **Quantum speedup over Quantum Monte Carlo**


As the modified QAA does not suffer from a sign
problem, path-integral QMC can be used to sample
independent sets from its thermal Gibbs distribution
_πz_ = _⟨z| e_ _[−][βH]_ _|z⟩_ _/Zβ_ . In general, path-integral QMC
works by stochastically sampling trajectories from a
discretized imaginary-time path integral of the partition function _Zβ_ = Tr( _e_ _[−][βH]_ ). Several prior exponential speedups for QAA over SA have been recovered by



the modified QAA runtime goes like max _b_ _Db−_ 1 _/Db_ .

To match the modified QAA runtime, the restricted
Gibbs distribution must be _exponentially_ favorably localized, so that _e_ [(] max _[r,b]_ [)] [=] - _Db_ 1 _/Db_ . In this case, however,



ized, so that _e_ max [=] _Db−_ 1 _/Db_ . In this case, however,

we expect the QAA runtime to be similarly enhanced
under Eq. (8) due to favorable localization. Thus,
QMC does not recover the quadratic speedup due to
delocalization, which crucially stems from the quantum
coherent enhancement of the coupling _⟨Sb_ 1 _| Hq |Sb⟩_ .

_−_



**5.** **UNDERSTANDING THE EXPERIMENTAL**
**OBSERVATIONS**


We now apply our framework to interpret recent exper

(c)







FIG. 5. Analysis of the experimental performance. (a) The
experimental optimized time to solution correlates with the
theoretical QAA runtime ∆ _[−]_ QAA [1] [on instances where the max-]
imum experimental evolution time _T_ max can resolve the minimum gap ( _T_ max _≤_ ∆ _[−]_ QAA [1] [, teal-filled points). Instances for]
which the evolution time is too short to maintain adiabaticity
deviate from the trend ( _T_ max _≥_ ∆ _[−]_ QAA [1] [, white points). (b) The]
experimental time to solution correlates less strongly with the
SA runtime lower bound on instances where _|E⟩_ is localized
(light green points). On the most delocalized instances (dark
green points), the QAA runtime is similar to the square root
of the SA runtime. (c) We plot the distribution of Hamming
distances between _|G⟩_ and _|E⟩_ for three localized graphs. The
pairwise Hamming distances are larger for the instance where
QAA performs poorly relative to SA (bottom), and smaller
for the instances where QAA outperforms SA (top, middle).


iments on Rydberg atom arrays [23] using the aforementioned hardware-efficient encoding of the Maximum Independent Set problem on unit-disk graphs. Ebadi _et al._

[23] observed that the experimental optimized QAA outperformed SA on certain hard unit-disk graph instances
with a large ratio of _Dα−_ 1 _/Dα_ ( _n_ = 39 – 80). We compute the experimental optimized time to solution as [3]


_T_
TTSopt = min (20)
_T_ ln[1 _−_ _p_ ( _T_ )] _[,]_


where _p_ ( _T_ ) is the probability of QAA finding the optimal solution at evolution time _T_ . In Fig. 5(a), we confirm
that TTSopt goes like the theoretical runtime ∆ _[−]_ QAA [1] [com-]
puted numerically for the Rydberg Hamiltonian [Eqs. (2)
and (3)].
However, in Fig. 5(b), we find that TTSopt correlates
less strongly with the SA runtime lower bound. To understand ∆QAA, and therefore the experimental time to solution, we obtain perturbative estimates for the eigenstates



8


at the avoided level crossing, _|G⟩_ and _|E⟩_, in the manifold of independent sets of size _α_ and _α −_ 1, respectively.
On the more delocalized instances, ∆ _[−]_ QAA [1] [is similar to]
the square root of the SA runtime (Fig 5(b), dark green
points), as expected from perturbation theory [Eq. (10)].
In contrast, for more localized instances (light green
points), we find that TTSopt is less correlated with the
SA runtime. By Eq. (8), we expect ∆QAA to be small
when the Hamming distance between _|G⟩_ and _|E⟩_ is
large and (Ω _/δ_ ) _⋆_ is small, which we verify numerically in
Appendix C 4. For illustration, in Fig. 5(c) we examine
three localized instances with vastly different SA and
QAA runtimes. We plot the distribution of the product
of populations _GzEz′_ of spin configurations _|z⟩_ _, |z_ _[′]_ _⟩_ in
_|G⟩_ _, |E⟩_ over their Hamming distances. The instance
where SA outperforms QAA is highly localized (bottom,
_n_ = 80), with large Hamming distances compared to
the two other instances where QAA outperforms SA
(top and middle, _n_ = 65). Due to favorable localization,
these instances obtain a significant speedup over SA.
Thus, the instance-dependent characteristics of _|G⟩_ and
_|E⟩_ can be used to predict the experimental performance.


**6.** **OUTLOOK**


In this work, we have shown that the optimized QAA
has a quadratic speedup over a wide class of classical
Markov chain algorithms when the low-energy eigenstates are delocalized across a flat energy landscape. To
promote delocalization on generic problem instances [25],
we modified QAA by adding a local Hamiltonian _Hℓ_ with
no sign problem, with a time-independent energy scale _λ_ .
To observe the corresponding quadratic speedup on nearterm devices, the algorithm must be efficiently encoded in
hardware [53]. The modified QAA is amenable to direct
experimental implementation via hybrid digital-analog
Trotterized evolution [54], by generating spin-exchange
interactions with excitation into _S_ and _P_ Rydberg states
or microwave driving [55, 56], and decomposing the diagonal component of _Hℓ_ into multiqubit controlled phase
gates. Local detunings can generate the diagonal component of _Hℓ_ on certain instances with structured configuration graphs, such as when the suboptimal configurations
correspond to the motion of a domain wall [57].
Similar to other problems involving Grover-type
quadratic speedups [11, 58], our approach requires optimizing the QAA evolution to maintain adiabaticity.
Optimizing QAA evolution in general is an open problem; however, recent work has shown that it is possible to optimize a wide class of QAA algorithms which
use the reflection about the uniform superposition state,
1 _−_ 21 _[n]_ - _z,z_ _[′][ |][z][⟩⟨][z][′][|]_ [, to drive the evolution instead of]

_Hq_ [41]. In Appendix E 1 b, we describe approaches to
optimizing the modified QAA when _λ →∞_, which retain a quadratic speedup. Future work could attempt to
generalize these results to finite _λ_ . At the same time, one
could circumvent the need for optimization by identifying instances with an exponential, rather than quadratic,


speedup over SA. One approach could be to characterize instances where the low-energy eigenstates are favorably localized at small Hamming distance [10]. However,
QAA may not generically provide a speedup over QMC
on these instances [10, 13, 51]. It remains an open question whether instances exist with an exponential speedup
over both SA and QMC, despite optimistic results in the
black-box setting [59, 60].
It would also be interesting to extend our results
beyond flat energy landscapes to problems with the
Overlap Gap Property, whose optimal solutions are
provably hard to approximate for large classes of both
quantum and classical algorithms [61, 62]. In these
instances, independent sets of the same size form
“clusters” separated by large Hamming distances. As
the clusters are disconnected under spin-exchange
operations, they independently delocalize, such that the
effective Hamiltonian is a tree-like version of the onedimensional tight-binding Hamiltonian _Htb_ when _λ →∞_

[Eq. (18)]. Future work could investigate the modified
QAA on instances with the Overlap Gap Property using
this framework. Particularly interesting is the prospect
of studying QAA performance in the _diabatic_ regime,
which can outperform both SA and QMC in finding
approximate solutions on certain problem instances [29].
Utilizing non-adiabatic phenomena via quantum quench
algorithms may provide an alternative mechanism for
quantum speedup [28, 30, 63, 64].


**7.** **ACKNOWLEDGEMENTS**


We would like to thank Tameem Albash, Lisa
Bombieri, Dolev Bluvstein, Sepehr Ebadi, Nicholas
Ezzell, Aram Harrow, Marcin Kalinowski, Andrew King,
Daniel Lidar, Subir Sachdev, Benjamin Schiffer, Juspreet
Singh Sandhu, Lei Wang, and Zhongda Zeng for helpful
discussions. This work was supported by the US Department of Energy [DE-SC0021013 and DOE Quantum
Systems Accelerator Center (contract no. 7568717)], the
Defense Advanced Research Projects Agency (grant no.
W911NF2010021), the Army Research Office (grant No.
W911NF-21-1-0367), the National Science Foundation,
the Harvard-MIT Center for Ultracold Atoms, and the
European Research Council (grant No. 101041435).
M.C. acknowledges support from Department of Energy
Computational Science Graduate Fellowship under
Award Number (DESC0020347). S.C. is grateful for
support from the NSF under Grant No. DGE-1845298.
R.S. is supported by the Princeton Quantum Initiative
Fellowship.


**Appendix A: Runtime lower bounds for classical**
**Markov chain algorithms**


**1.** **Simulated annealing**


In this section, we establish a runtime lower bound
on all simulated annealing (SA) algorithms using the



9


Metropolis-Hastings update rule. Although we focus on
the Maximum Independent Set problem in our proof, we
will show that our bound applies to generic combinatorial optimization problems. The goal of SA is to sample
from an equilibrium probability distribution _π_, which we
take to be the thermal Gibbs distribution of _H_ cost at
temperature 1 _/β_,



where _µ_ is the initial distribution, _P_ = ( _Pz,z′_ ) is the
matrix of Markov chain transition probabilities, and


_πb_ =         - _πz_ (A5)

_z_ : _H_ cost( _z_ )= _−δb_


is the Gibbs population of independent sets of size _b_ .
_τ_ SA( _ε, β_ ) represents the time to sample an optimal solution from the Gibbs distribution. The normalization
factor of 1 _/πα_ is necessary because at high temperatures,
the mixing time may be small, but the Gibbs population
of the optimal solutions is correspondingly very small.
At low temperatures, the normalization factor is unnecessary because optimal solutions have high Gibbs population. As a result, the mixing time is directly related to



_πz_ = _[e][−][βH]_ [cost][(] _[z]_ [)]



_Dbe_ _[βδb]_ _,_ (A1)

_b_



_,_ _Zβ_ =      _Zβ_



where _πz_ is the probability of spin configuration
_|z⟩∈{|_ 0 _⟩_ _, |_ 1 _⟩}_ _[n]_, _Zβ_ is the partition function, and _Db_ is
the number of independent sets of size _b_ . SA stochastically updates a spin configuration _|z⟩_ to _|z_ _[′]_ _⟩_ according
to the Markov chain transition probabilities _Pz,z′_ . We
consider _Pz,z′_ given by the Metropolis-Hastings update
rule [33, 34],


        _Pz,z′_ = _pz,z′_ min 1 _, e_ _[−][β]_ [[] _[H]_ [cost][(] _[z][′]_ [)] _[−][H]_ [cost][(] _[z]_ [)]][�] _,_ (A2)


where _pz,z′_ = _pz′,z_ is the probability of proposing to update from _|z⟩_ to _|z_ _[′]_ _⟩_, and the remaining factor is the
probability of accepting the proposed update. One can
check that for _pz,z′_ = _pz′,z_, the update rule satisfies the
detailed balance condition,


_Pz,z′πz_ = _Pz′,zπz′._ (A3)


The _mixing time_ of SA is defined as the minimum number of proposed updates per spin to prepare the Gibbs
distribution with error (measured in total variation distance, see [37]) less than or equal to _ε,_ starting from any
initial probability distribution _µ_ . The total variation distance between two distributions is equal to half the _l_ 1
norm of _π −_ _µ_ [37]. We define the SA runtime at inverse
temperature _β_, _τ_ SA( _ε, β_ ), as the mixing time normalized
by the Gibbs population of the optimal independent sets
of size _α_ . Explicitly, we let (see [37], Eqs. 4.2 and 4.30)



1       _τ_ SA( _ε, β_ ) = min _t_ : max
_nπα_ _µ_




 - _|πz −_ _P_ _[t]_ _µz| ≤_ _ε_ - _,_

_z∈{_ 0 _,_ 1 _}_ _[n]_







(A4)


the time to find an optimal solution, maximized over all
optimal solutions (i.e., the _hitting time_ ) [65]. We define
the SA runtime _τ_ SA( _ε_ ) as the minimum runtime over all
temperatures,


_τ_ SA( _ε_ ) = min (A6)
_β_ _[τ]_ [SA][(] _[ε, β]_ [)] _[.]_


Our main result, stated next, is an analytic lower bound
on _τ_ SA( _ε_ ).


**Theorem 1.** _Consider any Metropolis-Hastings SA al-_
_gorithm that prepares the Gibbs distribution of the Max-_
_imum Independent Set cost Hamiltonian H_ cost _._ _Sup-_
_pose the SA update rule alters at most k of the n total_
_spins. Define a cutoff independent set size b_ _[⋆]_ _, such that_
_the number of larger independent sets is decreasing, i.e._
_Db_ 1 _/Db ≥_ 1 _for b > b_ _[⋆]_ _. Then for any error ε <_ 1 _/_ 2 _,_

_−_
_the SA runtime τ_ SA( _ε_ ) _can be lower-bounded as_



10


very little probability flows from _S_ to _S_ _[c]_ during one update of the Markov chain. The spectral gap is then upper
bounded by this probability flow _QS,Sc_ normalized by the
total Gibbs population _πS_ in _S_ . Explicitly, the Cheeger
inequality states



∆SA _≤_ [2] _[Q][S,S][c]_



_πz,_ (A9)
_z∈S_




_[S,S][c]_ _,_ _πS_ =  
_πS_



for any _S_ with _πS <_ [1] 2 [, where]




  _QS,Sc_ = _πzPz,z′_ (A10)

_z∈S,z_ _[′]_ _∈S_ _[c]_




 = _πz′Pz′,z_

_z∈S,z_ _[′]_ _∈S_ _[c]_




      - 1
_τ_ SA( _ε_ ) _≥_ [ln] 2 _ε_



1 
2 _ε_



_._ (A7)
_Db_



2 _ε_ max _Db−_ 1

2 _nk_ _b>b_ _[⋆]_ _Db_



= _QS_ _[c]_ _,S_


is the flow from _S_ to _S_ _[c]_ . Note that _QS,Sc_ = _QSc,S_ follows
from the detailed balance condition on _P_ in Eq. (A3).
When _QS,S_ _[c]_ is small, ∆SA is correspondingly small by
Eq. (A9) and the SA runtime is large by Eq. (A8).
We will first consider the low temperature case
_πS <_ 1 _/_ 2, and obtain an upper bound on _QS,Sc_ _/πS_ . Let
_k ∈{_ 1 _,_ 2 _, . . ., n}_ denote the maximum number of spins
altered during a proposed update, and _b ∈{b_ _[⋆]_ _, b_ _[⋆]_ +
1 _, . . ., α}_ represent a particular independent set size satisfying _b > b_ _[⋆]_ . We define the set


_S_ = _{z_ : _H_ cost( _z_ ) _≥−δ_ ( _b −_ 1) _}_ (A11)


of independent sets of size _b −_ 1 or smaller. We
first replace all the probabilities _πz_ in Eq. (A10) with
_e_ _[βδ]_ [(] _[b][−]_ [1)] _/Zβ_ . This gives an upper bound on _QS,Sc_ _/πS_,
because _H_ cost = _−δ_ ( _b −_ 1) is the smallest value of _H_ cost
present in _S_ :



Before proceeding, we note that the restriction _b > b_ _[⋆]_

appearing in Theorem 1 is not necessary when the independence polynomial of the graph is _unimodal_, meaning
that _D_ 0 _≤_ _D_ 1 _≤· · · ≤_ _Db_ _[⋆]_ _≥· · · ≥_ _Dα_ 1 _≥_ _Dα_ . This

_−_
condition is met for every unit-disk graph we study in
Appendix B.


_Proof._ The SA runtime at temperature 1 _/β_ can be
lower-bounded by the inverse of the spectral gap ∆SA =
∆SA( _β_ ) between the largest and second largest eigenvalue
of the corresponding Markov chain matrix _P_ with transition probabilities _Pz,z′_ as ([37], Eq. 12.14)




       - 1
_τ_ SA( _ε, β_ ) _≥_ [ln] 2 _ε_



1 
2 _ε_




- 1 
_−_ 1 _._ (A8)
∆SA



_QS,Sc_



_S,Sc_

_≤_ _[e][βδ]_ [(] _[b][−]_ [1)]
_πS_ _πSZβ_




 

_H_ cost( _z_ ) _≥−δ_ ( _b−_ 1)
_H_ cost( _z_ _[′]_ ) _≤−δb_



_nπα_



_Pz,z_ _[′]_ _._ (A12)



Because 1
∆SA _[≫]_ [1, we will ignore the second term. This]
bound applies to any Markov chain transition matrix _P_
which satisfies detailed balance and is _lazy_, meaning that
the outwards transition probability [�] _z_ _[′]_ : _z_ _[′]_ = _z_ _[P][z,z][′][ ≤]_ [1] _[/]_ [2]

for any _|z⟩_ . Any Markov chain _P_ can be made lazy by
taking ( _P_ + 1) _/_ 2 (i.e., adding weight-1/2 self-loops to
each _|z⟩_ ). This transformation does not substantially
affect the mixing time because it reduces the outwards
transition probability by at most a factor of 2, so we will
analyze _P_ instead of ( _P_ +1) _/_ 2. Note that in Eq. (A8) we
divided the standard definition of mixing time by _n_ because we allow the SA algorithm to “parallelize” updates
over different spins.
We can therefore lower-bound _τ_ SA( _ε, β_ ) by upper
bounding ∆SA and _πα_ . To do this, we use the Cheeger
inequality [38], which can be used to establish an upper bound on ∆SA for any Markov chain satisfying detailed balance. The idea in a Cheeger bound is to bipartition the state space of the Markov chain into two
sets, _S_ and _S_ _[c]_, such that in the Gibbs distribution _π_,



where in the second line we have used that _pz,z′_ = _pz′,z_
under the detailed balance condition [Eq. (A3)]. The
inner summation over configurations _|z⟩_ at fixed _|z_ _[′]_ _⟩_ is
equal to the probability of proposing an update from _|z_ _[′]_ _⟩_
to any configuration _|z⟩_ with _H_ cost( _z_ ) _≥−δ_ ( _b −_ 1). This
probability is at most one because the total transition
probability out of _|z_ _[′]_ _⟩_ into _S_ is at most one, and is strictly



_πSZβ_



Now, plugging in the Metropolis-Hastings update rule
from Eq. (A2), we have



_S,Sc_

_≤_ _[e][βδ]_ [(] _[b][−]_ [1)]
_πS_ _πSZβ_



_QS,Sc_








   _pz,z′_ min 1 _,_ _[e][−][β]_ [[] _[H]_ [cost][(] _[z][′]_ [)]]







_πSZβ_



_z_ _[′]_ : _H_ cost( _z_ _[′]_ ) _≤−δb_
_z_ : _H_ cost( _z_ ) _≥−δ_ ( _b−_ 1)



_e_ _[−][βH]_ [cost][(] _[z]_ [)]]



= _[e][βδ]_ [(] _[b][−]_ [1)]




 

_H_ cost( _z_ _[′]_ ) _≤−δb_





  


_pz′,z_
_H_ cost( _z_ ) _≥−δ_ ( _b−_ 1)



(A13)




_._



_πSZβ_


zero if _H_ cost( _z_ _[′]_ ) _< −δ_ ( _b_ + _k−_ 1) (because we have assumed
that we update at most _k_ spins). This constraint yields



_S,Sc_

_≤_ _[e][βδ]_ [(] _[b][−]_ [1)]
_πS_ _πSZβ_




  - 1

_−δ_ min( _α,b_ + _k−_ 1) _≤H_ cost( _z_ _[′]_ ) _≤−δb_



_QS,Sc_



_πSZβ_



= _[e][βδ]_ [(] _[b][−]_ [1)]

_πSZβ_



min( _α,b_ + _k−_ 1)

 
_Db′_
_b_ _[′]_ = _b_



_≤_ _[kD][b][e][βδ]_ [(] _[b][−]_ [1)]

_πSZβ_



_≤_ _[kD][b]_ _._ (A14)

_Db−_ 1



In the third step we used the fact that _Db ≥_ _Db′_
for any _b_ _[′]_ _>_ _b_ _[⋆]_, and in the fourth step we have
used _πS_ = [�] _b_ _[b][′][−]_ =0 [1] _[D][b][′][e][βδb][′][/][Z][β][ > D][b][−]_ [1] _[e][βδ]_ [(] _[b][−]_ [1)] _[/][Z][β]_ [. From]
Eq. (A9), the SA spectral gap ∆SA is thus bounded as




_[S,S][c]_

_≤_ [2] _[kD][b]_
_πS_ _Db_ 1



∆SA _≤_ [2] _[Q][S,S][c]_



_._ (A15)
_Db−_ 1



Combining this with the lower bound on runtime
_τ_ SA( _ε, β_ ) [Eq. (A8)], and plugging in _πα ≤_ 1, we have
for any _β_ such that _πS <_ 1 _/_ 2 _,_




       - 1
_τ_ SA( _ε, β_ ) _≥_ [ln] 2



1 
2 _ε_



_._ (A16)
_Db_



2 _ε_ _Db−_ 1

2 _nk_ _Db_



11


**2.** **Parallel tempering**


We now derive a runtime lower bound for a wide class
of parallel tempering algorithms using the MetropolisHastings update rule. Because our bound uses identical
techniques to the runtime lower bound for SA, we recommend the reader read Appendix A 1 before proceeding. In
parallel tempering there are _M_ copies, or _replicas_, of the
_n_ -spin system of SA, each equilibrating to the Gibbs distribution of _H_ cost at temperatures 1 _/β_ 1 _, . . .,_ 1 _/βM_ . The
state space is the product of states over all the replicas
_{z_ 1 _. . . zM_ _}_, where _zi ∈{_ 0 _,_ 1 _}_ _[n]_ represents the spin configuration of the _i_ th replica. Similar to SA, the state of
a single replica can be updated based on proposing an
update to at most _k_ spins. However, in parallel tempering collective updates involving multiple replicas are also
possible. We will consider collective Metropolis-Hastings
update rules,


_Pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_ (A20)

         = _pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_ [min] 1 _, e_ _[−]_ [�] _i_ _[M]_ =1 _[β][i]_ [[] _[H]_ [cost][(] _[z]_ _i_ _[′]_ [)] _[−][H]_ [cost][(] _[z][i]_ [)]][�] _,_


where _pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_ [is the probability of proposing an]
update to the configuration _z_ 1 _[′]_ _[. . . z]_ _M_ _[′]_ [given that the cur-]
rent configuration is _z_ 1 _. . . zM_ . Note that this update rule
satisfies the detailed balance condition in Eq. (A3). The
equilibrium distribution is therefore the Gibbs distribution,



On the other hand, at high temperatures _πS >_ 1 _/_ 2, we
must swap _S_ with _S_ _[c]_ in the Cheeger bound [Eq. (A9)],



_α_

- _Dbe_ _[β][i][δb]_ _._


_b_ =0

(A21)




_[S][c][,S][π][α]_

= [2] _[Q][S,S][c]_ _[π][α]_
_πSc_ _πSc_



∆SA _πα ≤_ [2] _[Q][S][c][,S][π][α]_



(A17)
_πSc_



_i_ =1 _[β][i][H]_ [cost][(] _[z][i]_ [)]
_πz_ 1 _...zM_ = _[e][−]_ [�] ~~�~~ _[M]_ _M_ _,_ _Zβi,i_ =
_i_ =1 _[Z][β]_ _i_ _[,i]_



where we have used the fact that _QS,S_ _[c]_ = _QS_ _[c]_ _,S._ By
Eq. (A14) we have _QS,Sc ≤_ _kDbe_ _[βδ]_ [(] _[b][−]_ [1)] _/Zβ_, so we find



∆SA _πα ≤_ [2] _[kD][b][e][βδ]_ [(] _[b][−]_ [1)] _[π][α]_



_,_ (A18)
_Zβ_




_[e][βδ]_ [(] _[b][−]_ [1)] _[π][α]_

_≤_ [2] _[kD][b][e][βδ]_ [(] _[b][−]_ [1)]
_ZβπS_ _[c]_ _Zβ_



We define the parallel tempering runtime _τ_ PT( _ε_ ) as


_τ_ PT( _ε_ ) = min (A22)
_β_ 1 _...βM_ _[τ]_ [PT][(] _[ε, β]_ [1] _[ . . . β][M]_ [)] _[,]_


where _τ_ PT( _ε, β_ 1 _. . . βM_ ) is the runtime lower bound
for replica temperatures _β_ 1 _. . . βM_ defined similarly to
SA [Eq. (A4)]:


_τ_ PT( _ε, β_ 1 _. . . βM_ ) (A23)



using _πα ≤_ _πS_ _[c]_ (because sets of size _α_ are contained in
_S_ _[c]_ ). Now, since _Zβ > Db−_ 1 _e_ _[βδ]_ [(] _[b][−]_ [1)] _,_ we are left with

∆SA _πα ≤_ [2] _[kD][b]_ _,_ (A19)

_Db−_ 1

which gives the same bound as in the low-temperature
case via Eq. (A8). Because the same bound holds for all
temperatures and for any _b > b⋆_, we can use Eq. (A6)
to obtain a lower bound on _τ_ SA( _ε_ ), which gives us Theorem 1.
Finally, we note that Theorem 1 can be applied to general combinatorial optimization problems with discrete
cost Hamiltonian energies. Our proof does not change
if we replace the energies of _H_ cost, _{−δb}b_ =0 _,_ 1 _,...,α_, with
energies _{Eb}b_ =0 _,_ 1 _,...,α_ for any generic cost function with
_α_ + 1 discrete energy levels, and let _Db_ represent the
number of spin configurations with energy _Eb._ As a result, Theorem 1 can be applied to generic discrete cost
functions beyond Maximum Independent Set.



= _[M]_




 - _|πz −_ _P_ _[t]_ _µz| ≤_ _ε_ - _,_

_z∈{_ 0 _,_ 1 _}_ _[n]_




   min _t_ : max
_nπα_ _µ_







where _P_ is the parallel tempering Markov chain, _µ_ is the
initial probability distribution, and




 

_z_ 1 _...zM_ :
_H_ cost( _zi_ )= _−δb_



_πα_ =



_M_



_i_ =1



_πz_ 1 _...zM_ (A24)



is now the probability that the configuration of at least
one replica is an independent set of size _b_ . Note that
_τ_ PT( _ε, β_ 1 _. . . βM_ ) in Eq. (A23) has a factor of _M_ in the
numerator. This is because we allow the parallel tempering update rule to update the spin configuration on


all _M_ replicas; thus, the time complexity to perform an
update is _O_ ( _M_ ) _._ This also excludes the possibility of a
trivial “speedup” from making _M_ exponentially large, at
the expense of, e.g., _M_ = _O_ (2 _[n]_ ) space-time complexity.


_a._ _Replica exchange, arbitrary single-replica updates, and_
_constant-sized collective updates_


We first consider parallel tempering algorithms that
include the following update rules: single-replica updates
that can update an arbitrary number of spins _k_ on a
single replica, collective-replica updates that modify _k_ _[′]_

spins on each replica, where _k_ _[′]_ is restricted to be constant
in _n_, and replica exchange updates. Replica exchange
updates are defined as proposing to exchange the states _zi_
and _zj_ of two replicas _i_ and _j_ . Our runtime lower bound
is stated next in Theorem 2. We will generalize our result
to include non-local _isoenergetic cluster updates_ [66] later
in Theorem 3.


**Theorem 2.** _Consider a parallel tempering algorithm_
_with M replicas and any update rule as described above._
_Define a cutoff independent set size b_ _[⋆]_ _, such that the_
_number of larger independent sets is decreasing, i.e._
_Db_ 1 _/Db ≥_ 1 _for b > b_ _[⋆]_ _. Then for any error ε <_ 1 _/_ 2 _,_

_−_
_the parallel tempering runtime τ_ PT( _ε_ ) _is bounded as_



12


replica exchange updates do not contribute to _QS,S_ _c_ because swapping the states of two replicas in _S_ does not
transfer probability from _S_ to _S_ _[c]_ . In addition, arbitrary
updates to a single replica are subject to the same bound
as SA [Eq. (A7)]. Therefore, it only remains to bound
collective updates that update at most _k_ _[′]_ spins on each
replica, where _k_ _[′]_ is constant in _n_ . The runtime lower
bound is then given by the minimum of the runtime lower
bounds on collective updates and single-replica updates.
We will find that the runtime lower bound for collective
updates is smaller than for single-replica updates; hence,
Theorem 2 reflects the collective update bound.
As before, we will obtain an upper bound on _QS,S_ _c_ .
Notice that only transitions from configurations in _S_
within _k_ _[′]_ spin flips of some _z_ 1 _. . . zM ∈S_ _[c]_ can contribute
to _QS,S_ _c_ . We denote these configurations as _∂S_ . Configurations in _∂S_ must have least one replica _j_ within _k_ _[′]_ spin
flips of _Sj_ _[c]_ [, whereas all other replicas] _[ i]_ [ may be in any con-]
figuration in _Si_ . We let _∂Sj_ denote configurations _zj ∈_ _Sj_
within _k_ _[′]_ spin flips of _Sj_ _[c]_ [, and] _[ π][∂S]_ _j_ [=][ �] _zj_ _∈∂Sj_ _[π][z]_ _j_ [. We]

then can show



_QS,S_ _[c]_ _≤_ 


_πz_ 1 _...zM_
_z_ 1 _...zM_ _∈∂S_



_πSi_ =



_≤_



_M_




_π∂Sj_
_j_ =1



_M_




_i_ =1
_i_ = _j_


- _M_

 

_j_ =1



_M_

- _j_ =1 _π∂Sj_ _ππSSj_




      - 1
_τ_ PT( _ε_ ) _≥_ [ln] 2



1 
2 _ε_



_._ (A25)
_Db_




[ln] 2 _ε_ [max] _Db−_ 1

2 _nk_ _[′]_ _n_ _[k][′]_ _b>b⋆_ _Db_



_πS_
_πSj_



_Dbe_ _[δβ][j]_ [(] _[b][−]_ [1)]

_Zβj_ _,j_




  - _n_
_≤_ ( _k_ _[′]_ ) [2]
_k_ _[′]_


_M_
_≤_ _k_ _[′]_ _n_ _[k][′]_ 

_j_ =1



_Proof._ Define the set _S_ as the set of states with all
the replicas having independent set size less than _b_, for
_b > b⋆_,


_S_ = _{z_ 1 _. . . zM_ : _∀i ∈{_ 1 _, . . ., M_ _}, H_ cost( _zi_ ) _≥−δ_ ( _b −_ 1) _}_
= _S_ 1 _× · · · × SM_ _,_ (A26)


where _Si_ is the partition defined for a single replica as
defined in Eq. (A11). As with the SA runtime lower
bound in Appendix A 1, our goal is to bound the flow of
probability _QS,S_ _[c]_ from _S_ to _S_ _[c]_ in the Gibbs distribution,



_M_

_S,S_ _c_ _≤_ _k_ _[′]_ _n_ _[k][′]_ 
_π_
_S_ _j_ =1



_j_ =1



_Dbe_ _[δβ][j]_ [(] _[b][−]_ [1)]

_Zβj_ _,j_



_πS_ _,_ (A29)
_πSj_



where in the third line we have used the fact that
the Gibbs population of any configuration in _∂Sj_
is _≤_ _e_ _[δβ][j]_ [(] _[b][−]_ [1)] _/Zβj_ _,j_, and the fact that there are
_≤_ ( _k_ _[′]_ ) [2][�] _k_ _[n][′]_ - _Db_ such configurations. Then we may write



_QS,S_ _c_



_Dbe_ _[δβ][j]_ [(] _[b][−]_ [1)]

_Zβj_ _,jπSj_


_Db_
= _k_ _[′]_ _n_ _[k][′]_ _M_ _[D][b]_ _,_ (A30)
_Db−_ 1 _Db−_ 1




  _QS,S_ _c_ =

_zz_ 1 _[′]_ 1 _[...z]_ _...zM_ _[′]_ _M_ _[∈S]_ _∈S_ _[c]_



_πz_ 1 _...zM Pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_ _[,]_ (A27)



_M_
_≤_ _k_ _[′]_ _n_ _[k][′]_ 

_j_ =1



to obtain a Cheeger bound on the spectral gap of the
parallel tempering Markov chain ∆PT = ∆PT( _β_ 1 _. . . βM_ ),



where in the second line we have used that _πSj_ _≥_
_Db−_ 1 _e_ _[β][j]_ _[δ]_ [(] _[b][−]_ [1)] _/Zβj_ _,j_ . We can combine Eqs. (A30)
and (A9) and use the fact that _πα ≤_ 1 to get


_Db_
∆PT _≤_ 2 _k_ _[′]_ _n_ _[k][′]_ _M_ min (A31)
_b>b⋆_ _Db−_ 1


for the spectral gap of the parallel tempering Markov
chain ∆PT _._ This, combined with Eq. (A8), yields a
runtime lower bound for parallel tempering given by
Eq. (A25). We emphasize that this bound is only restrictive when max _b>b⋆_ ( _Db/Db−_ 1) is much larger than _n_ _[k][′]_ .



∆PT _≤_ [2] _[Q][S][,][S]_ _[c]_ =

_πS_



2 [�] _zz_ 1 _[′]_ 1 _[...z]_ _...zM_ _[′]_ _M_ _[∈S]_ _∈S_ _[c][ π][z]_ [1] _[...z][M][ P][z]_ [1] _[...z][M]_ _[,z]_ 1 _[′]_ _[...z]_ _M_ _[′]_

~~�~~ _M_
_i_ =1 _[π][S]_ _i_
(A28)



where _πSi_ is the Gibbs population of _Si_ on a replica
_i_, as in Eq. (A9), and _πS_ is the Gibbs population of
_S_ . Eq. (A28) gives a lower bound on the runtime via
Eq. (A8). From Eq. (A28) we can immediately see that


Because max _b>b⋆_ ( _Db/Db−_ 1) grows exponentially in _[√]_ ~~_n_~~
in the worse case for the Maximum Independent Set problem on unit-disk graphs (see Appendix B), this bound is
only useful when _k_ _[′]_ does not grow with _n_ .
The above result holds when _πS <_ 1 _/_ 2. Just as in the
case of SA, we can derive the same bound on the runtime
when _πS >_ 1 _/_ 2. Using the fact that _QS,S_ _[c]_ = _QS_ _[c]_ _,S_ [see
Eq. (A10)], we use Eq. (A29) to receive:



13


lower bounds in Theorems 1 and 3, respectively, up to
subleading polynomial factors in _n_ .



700


600


500


400


300


200


100


0



|Col1|y = x|Col3|Col4|Col5|Col6|Col7|Col8|
|---|---|---|---|---|---|---|---|
|||||||||
|||||||||
|||||||||
|||||||||
|||||||||
|||||||||


10 [0] 10 [2] 10 [4] 10 [6] 10 [8] 10 [10]



∆PT _πα ≤_ [2] _[Q][S][,][S]_ _[c]_ _[π][α]_



_≤_ 2 _Q_ _,_
_πS_ _c_ _S_ _S_ _[c]_



_Db_
_≤_ 2 _k_ _[′]_ _n_ _[k][′]_ _M_ min _._ (A32)
_b>b⋆_ _Db−_ 1



10 [10]


10 [8]


10 [6]


10 [4]


10 [2]


10 [0]



As a result, the same bound Eq. (A25) holds for the case
where _πS >_ 1 _/_ 2 _._
Finally, we note that Theorem 2 can be applied to
general combinatorial optimization problems with discrete cost Hamiltonian energies. Our proof, as in the
case of SA, does not change if we replace the energies
of _H_ cost, _{−δb}b_ =0 _,_ 1 _,...,α_, with energies _{Eb}b_ =0 _,_ 1 _,...,α_ for
any generic cost function with _α_ +1 discrete energy levels,
and let _Db_ represent the number of spin configurations
with energy _Eb._


_b._ _Isoenergetic cluster updates_


Here we obtain a runtime lower bound for all parallel tempering algorithms that use the same update rules
as in the previous Appendix A 2, in addition to _isoen-_
_ergetic cluster updates_, which are non-local updates designed specifically for optimizing two-dimensional spin
glasses [66]. Isoenergetic cluster updates collectively update a pair of replicas _i, j_ by identifying clusters of spins
(vertices) connected by edges for which _zi_ and _zj_ differ.
The update rule then proposes to exchange the configurations of spins within a randomly chosen connected
cluster between _zi_ and _zj_ . One can check that this update rule conserves the total energy of the two replicas:
_H_ cost( _zi_ ) + _H_ cost( _zj_ ) = _H_ cost( _zi_ _[′]_ [) +] _[ H]_ [cost][(] _[z]_ _j_ _[′]_ [), where] _[ z]_ _i_ _[′]_
and _zj_ _[′]_ [are the spin configurations after an isoenergetic]
cluster update. Note that isoenergetic cluster updates
are equivalent to replica exchange updates when there is
only a single connected cluster of differing spins.
The bound that we will derive in Theorem 3 is similar
to the parallel tempering runtime lower bound previously derived in Theorem 2 when min _b>b_ _[⋆]_ ( _Db/Db−_ 1)
is small compared to the other ratios _Db/Db−_ 1, i.e.
when there is a single smallest coupling that limits the
runtime. In Fig. 6 we numerically find that the scaling
of our bound, stated next in Theorem 3, is similar to
the SA runtime lower bound in Theorem 1 for the top
5% hardest instances of each system size studied in Appendix B. In particular, Fig. 6 plots max _b>b⋆_ [�] _Db/Db−_ 1 +

- _α_ �2( _b−_ 1) _−b_ 1 - _b−_ 1 _−b_ _[′]_ 2 - _−_ 1
_b_ _[′]_ 1 [=] _[b]_ _b_ _[′]_ 2 [=0] _k_ = _b_ _[′]_ 1 _[−][b]_ [+1][(] _[D][b]_ 1 _[′]_ _[D][b][′]_ 2 [)(] _[D][b][′]_ 1 _[−][k][D][b][′]_ 2 [+] _[k]_ [)]

versus the quantity max _b>b⋆_ ( _Db−_ 1 _/Db_ ). These quantities are equal to the parallel tempering and SA runtime



We define _S_ identically to Eq. (A26). As a result, the
runtime lower bound we will derive in Theorem 3 automatically applies to the same update rules from Theorem 2, and it only remains to upper bound _QS,S_ _c_ for
isoenergetic cluster updates. The total _QS,S_ _c_ will then
be bounded by the sum of the bounds on _QS,S_ _c_ derived
here for isoenergetic cluster updates and on the bound in



Simulated annealing runtime

lower bound (leading)


FIG. 6. Simulated annealing and parallel tempering
runtime lower bounds. We plot max _b>b_ _[⋆]_ [�] _Db/Db−_ 1 +

- _α_ �2( _b−_ 1) _−b_ 1 - _b−_ 1 _−b_ _[′]_ 2 - _−_ 1
_b_ _[′]_ 1 [=] _[b]_ _b_ _[′]_ 2 [=0] _k_ = _b_ _[′]_ 1 _[−][b]_ [+1][(] _[D][b]_ 1 _[′]_ _[D][b][′]_ 2 [)(] _[D][b][′]_ 1 _[−][k][D][b][′]_ 2 [+] _[k]_ [)]

versus max _b>b_ _[⋆]_ ( _Db−_ 1 _/Db_ ) for the top 5% hardest instances
of each system size studied in Appendix B. These quantities
are equal to the SA and parallel tempering runtime lower
bounds in Theorems 1 and 3, respectively, up to subleading
polynomial factors in _n_ .


**Theorem 3.** _Consider a parallel tempering algorithm_
_with M replicas using isoenergetic cluster updates as de-_
_scribed above, in combination with the updates described_
_in Theorem 2. Then for any error ε <_ 1 _/_ 2 _, the parallel_
_tempering runtime τ_ PT( _ε_ ) _is bounded as_




      - 1
_τ_ PT( _ε_ ) _≥_ [ln] 2



1 
2 _ε_



max
2 _n_ _b>b_ _[⋆]_




_k_ _[′]_ _n_ _[k][′][ D][b]_



_Db−_ 1



_k_ = _b_ _[′]_ 1 _[−][b]_ [+1]



_b_ 1 _b_ _[′]_ 2

_−_ _−_




_α_

+ 
_b_ _[′]_ 1 [=] _[b]_



2( _b−_ 1) _−b_ 1

 

_b_ _[′]_ 2 [=0]



_Db_ _[′]_ 1 _[D][b][′]_ 2  - _−_ 1 _._
_Db_ _[′]_ 1 _[−][k][D][b][′]_ 2 [+] _[k]_


(A33)



_Proof._ As before, we bound the flow of probability _QS,S_ _c_
from _S_ to _S_ _[c]_ in the Gibbs distribution,




  _QS,S_ _c_ =

_zz_ 1 _[′]_ 1 _[...z]_ _...zM_ _[′]_ _M_ _[∈S]_ _∈S_ _[c]_



_πz_ 1 _...zM Pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_ _[,]_ (A34)


Theorem 2. The inverse of this sum of bounds will yield
the bound in Theorem 3.
An isoenergetic cluster update first proposed to update
the configurations of a pair of replicas, which are chosen
according some probability distribution. Without loss of
generality, we will call these replicas 1 and 2, and denote
the probability they are proposed as _p_ 12. Once a pair of
replicas is proposed, the quantity _QS,S_ _[c]_ _/πS_ is independent of the remaining replicas. Thus, we may consider
the flow _Q_ [(12)] _S,S_ _[c]_ [ on only replicas 1 and 2. We may bound]
the flow as



14


Now summing over all replicas (not just 1 _,_ 2) that could
be proposed for replica updates and using [�] _ij_ _[p][ij][ ≤]_ [1,]

we arrive at



For reasons analogous to those given in Appendix A 1,
this is sufficient to establish the bound in Theorem 3
when _πS >_ 1 _/_ 2. When _πS <_ 1 _/_ 2, we instead revert to
Eq. (A36) and compute the bound as



_b_ 1 _b_ _[′]_ 2

_−_ _−_

 

_k_ = _b_ _[′]_ 1 _[−][b]_ [+1]



_QS,S_ _c ≤_



_α_ 2( _b−_ 1) _−b_ 1

- 

_b_ _[′]_ 1 [=] _[b]_ _b_ _[′]_ 2 [=0]



_Db_ _[′]_ 1 _[D][b][′]_ 2 _._ (A38)
_Db_ _[′]_ 1 _[−][k][D][b][′]_ 2 [+] _[k]_



_Q_ [(12)] _S,S_ _[c]_ [ =] _[ p]_ [12] 
_zz_ 1 _[′]_ 1 _[z]_ _z_ 2 _[′]_ 2 _[∈S]_ _∈S_ _[c]_


= _p_ 12   
_zz_ 1 _[′]_ 1 _[z]_ _z_ 2 _[′]_ 2 _[∈S]_ _∈S_ _[c]_

_≤_ _p_ 12   
_zz_ 1 _[′]_ 1 _[z]_ _z_ 2 _[′]_ 2 _[∈S]_ _∈S_ _[c]_



_πz_ 1 _[′]_ _[z]_ 2 _[′]_ _[P][z]_ 1 _[′]_ _[z]_ 2 _[′]_ _[,z]_ [1] _[z]_ [2]


      _πz_ 1 _[′]_ _[z]_ 2 _[′]_ _[p][z]_ 1 _[′]_ _[z]_ 2 _[′]_ _[,z]_ [1] _[z]_ [2][ min] 1 _,_ _[π][z]_ [1] _[z]_ [2]

_πz_ 1 _[′]_ _[z]_ 2 _[′]_



_×_







_Q_ [(12)] _S,S_ _[c]_ _≤_ _p_ 12 _π_ _[−]_ [1]
_π_ _S_
_S_



_b_ 1 _b_ _[′]_ 2

_−_ _−_




_α_




2( _b−_ 1) _−b_ 1

 


_b_ _[′]_ 1 [=] _[b]_



_b_ _[′]_ 2 [=0]



2

_−_ - _−_ _Db_ _[′]_ 1 _[D][b][′]_ 2 _e_ _[β]_ [1] _[δ]_ [(] _[b]_ 1 _[′]_ _[−]_ _Z_ _[k]_ 1 [)+] _Z_ _[β]_ 2 [2] _[δ]_ [(] _[b][′]_ 2 [+] _[k]_ [)]

_k_ = _b_ _[′]_ 1 _[−][b]_ [+1]



_Z_ 1 _Z_ 2



_πz_ 1 _z_ 2 _pz_ 1 _[′]_ _[z]_ 2 _[′]_ _[,z]_ [1] _[z]_ [2] _[,]_ (A35)



_b_





- _Db_ 1 _e_ _[β]_ [1] _[δb]_ [1] ) _[−]_ [1] (

_b_ 1=0



_b_ 1





- _Db_ 2 _e_ _[β]_ [2] _[δb]_ [2] ) _[−]_ [1]

_b_ 2=0



_≤_ _p_ 12(



where _Pz_ 1 _[′]_ _[z]_ 2 _[′]_ _[,z]_ [1] _[z]_ [2][ is the probability of updating to] _[ z]_ 1 _[′]_ _[z]_ 2 _[′]_
given that the current configuration of the two replicas
we have chosen to update is _z_ 1 _z_ 2 _._ Since _z_ 1 _[′]_ _[z]_ 2 _[′]_ _[∈S]_ _[c]_ [, at least]
one of _z_ 1 _[′]_ [or] _[ z]_ 2 _[′]_ [must be in] _[ S]_ 1 _[c]_ [or] _[ S]_ 2 _[c]_ [. We assume without]
loss of generality that it is _z_ 1 _[′]_ [, so that] _[ H]_ [cost][(] _[z]_ 1 _[′]_ [)] _[ ≤−][δb]_ [.]
Then, if _z_ 1 _[′]_ _[, z]_ 2 _[′]_ [can isoenergetically update to] _[ z]_ [1] _[, z]_ [2] _[∈S]_ [,]
we must have _H_ cost( _z_ 2 _[′]_ [)] _[ ≥−]_ [2] _[δ]_ [(] _[b][−]_ [1)] _[−][H]_ [cost][(] _[z]_ 1 _[′]_ [), because]
the combined energy of _z_ 1 _[′]_ _[, z]_ 2 _[′]_ [must be at least] _[ −]_ [2] _[δ]_ [(] _[b][−]_ [1).]
Furthermore, the number of spins that can be exchanged
between the two replicas is lower-bounded by the restriction that _z_ 1 _∈_ _S_ 1 and upper-bounded by the restriction
that _z_ 2 _∈_ _S_ 2. As a result, the sum can be parameterized
as



_Q_ [(12)] _S,S_ _[c]_ _≤_ _p_ 12 - _α_
_π_
_S_ _b_ _[′]_ 1 [=] _[b]_



_b_ 1 _b_ _[′]_ 2

_−_ _−_




_α_



_b_ _[′]_ 1 [=] _[b]_




 - _Db_ _[′]_ 1 _[D][b][′]_ 2 _[e][β]_ [1] _[δ]_ [(] _[b]_ 1 _[′]_ _[−][k]_ [)+] _[β]_ [2] _[δ]_ [(] _[b][′]_ 2 [+] _[k]_ [)] _._

_k_ = _b_ _[′]_ 1 _[−][b]_ [+1]



_×_



2( _b−_ 1) _−b_ 1

 

_b_ _[′]_ 2 [=0]



(A39)



At this point, we again use the fact that for every
( _b_ _[′]_ 1 _[, b][′]_ 2 _[, k]_ [) term in the numerator, the denominator con-]
tains a term _Db_ _[′]_ 1 _[−][k][e][β]_ [1] _[δ]_ [(] _[b]_ 1 _[′]_ _[−][k]_ [)] _Db′_ 2 [+] _[k][e][β]_ [2] _[δ]_ [(] _[b]_ 2 _[′]_ [+] _[k]_ [)], allowing us
to arrive at



_Db_ _[′]_ 1 _[D][b][′]_ 2 _,_
_Db_ _[′]_ 1 _[−][k][D][b][′]_ 2 [+] _[k]_


(A40)



_b_ 1 _b_ _[′]_ 2

_−_ _−_

 

_k_ = _b_ _[′]_ 1 _[−][b]_ [+1]



2( _b−_ 1) _−b_ 1

 

_b_ _[′]_ 2 [=0]



_Q_ [(12)] _S,S_ _[c][ ≤]_ _[p]_ [12] 
_zz_ 1 _[′]_ 1 _[z]_ _z_ 2 _[′]_ 2 _[∈S]_ _∈S_ _[c]_



_πz_ 1 _z_ 2 _pz_ 1 _[′]_ _[z]_ 2 _[′]_ _[,z]_ [1] _[z]_ [2] (A36)







_b_ 1 _b_ _[′]_ 2

_−_ _−_




_b_ _[′]_ 2 [=0]



_πz_ 1 _z_ 2 _pz_ 1 _[′]_ _[z]_ 2 _[′]_ _[,z]_ [1] _[z]_ [2]



_≤_ _p_ 12


_≤_ _p_ 12



_α_



_b_ _[′]_ 1 [=] _[b]_



_α_



_b_ _[′]_ 1 [=] _[b]_



2( _b−_ 1) _−b_ 1

 


_k_ = _b_ _[′]_ 1 _[−][b]_ [+1] _H_ cost( _z_ 1 _[′]_ [)=] _[−][δb][′]_ 1

_H_ cost( _z_ 2 _[′]_ [)=] _[−][δb][′]_ 2
_H_ cost( _z_ 1)= _−δ_ ( _b_ _[′]_ 1 _[−][k]_ [)]
_H_ cost( _z_ 2)= _−δ_ ( _b_ _[′]_ 2 [+] _[k]_ [)]



_._
_Zβ_ 1 _,_ 1 _Zβ_ 2 _,_ 2



2( _b−_ 1) _−b_ 1

 


_b_ 1 _b_ _[′]_ 2

_−_ _−_




_b_ _[′]_ 2 [=0]



2

_k_ = _−b_ - _[′]_ 1 _[−]_ _−_ _[b]_ [+1] _Db_ _[′]_ 1 _[D][b][′]_ 2 _e_ _[β]_ [1] _[δ]_ [(] _Z_ _[b]_ 1 _[′]_ _β_ _[−]_ 1 _[k]_ _,_ 1 [)+] _Z_ _[β]_ _β_ [2] 2 _[δ]_ _,_ [(] 2 _[b][′]_ 2 [+] _[k]_ [)]



In the third line, we used the facts that
_πz_ 1 _z_ 2 = _e_ _[β]_ [1] _[δ]_ [(] _[b]_ 1 _[′]_ _[−][k]_ [)+] _[β]_ [2] _[δ]_ [(] _[b][′]_ 2 [+] _[k]_ [)] _/_ ( _Zβ_ 1 _,_ 1 _Zβ_ 2 _,_ 2) and


_z_ 1 _z_ 2 _[p][z]_ 1 _[′]_ _[z]_ 2 _[′]_ _[,z]_ [1] _[z]_ [2] _[ ≤]_ [1, then replaced][ �] _z_ 1 _[′]_ _[z]_ 2 _[′]_ [with] _[ D][b]_ 1 _[′]_ _[D][b][′]_ 2 [.]

To remove the factors of _β_ 1 and _β_ 2, we may also use
the fact that _Zβ_ 1 _,_ 1 contains a _Db_ _[′]_ 1 _[−][k][e][β]_ [1] _[δ]_ [(] _[b]_ 1 _[′]_ _[−][k]_ [)] term and
_Zβ_ 2 _,_ 2 contains a _Db_ _[′]_ 2 [+] _[k][e][β]_ [2] _[δ]_ [(] _[b]_ 2 _[′]_ [+] _[k]_ [)] term, to obtain



_b_ 1 _b_ _[′]_ 2

_−_ _−_

 

_k_ = _b_ _[′]_ 1 _[−][b]_ [+1]



from which we can establish the bound in Theorem 3
after summing over all choices of 1 _,_ 2.


**3.** **Quantum Monte Carlo**


We now establish a runtime lower bound for a wide
class of QMC algorithms. Our bound uses identical
techniques to the analytic runtime lower bounds of SA
(Appendix A 1) and parallel tempering (Appendix A 2),
which we recommend the reader read first for context.
We consider path-integral QMC algorithms which are
designed to sample from the populations of the Gibbs
distribution of the modified QAA Hamiltonian,

_ρzz_ = _[⟨][z][|][ e][−][β]_ [(] _[H]_ [QAA][+] _[λH][ℓ]_ [)] _[ |][z][⟩]_ _, Zβ_ = Tr� _e_ _[−][β]_ [(] _[H]_ [QAA][+] _[λH][ℓ]_ [)][�] _._

_Zβ_

(A41)


We can write the partition function _Zβ_ in the _z_ -basis by
Trotterizing _H_ = _H_ QAA + _λHℓ_ and inserting copies of the



_Q_ [(12)] _S,S_ _[c][ ≤]_ _[p]_ [12]



_α_ 2( _b−_ 1) _−b_ 1

- 

_b_ _[′]_ 1 [=] _[b]_ _b_ _[′]_ 2 [=0]



_Db_ _[′]_ 1 _[D][b][′]_ 2 _._ (A37)
_Db_ _[′]_ 1 _[−][k][D][b][′]_ 2 [+] _[k]_


identity matrix. Although we do not assume a particular
form of Trotterization of _Zβ_, we may take, for example,


_Zβ_ = - _⟨z_ 1 _| e_ _[−][β]_ [(] _[H]_ [QAA][+] _[λH][ℓ]_ [)] _|z_ 1 _⟩_ (A42)

_z_ 1

_≃_  - _⟨z_ 1 _|_  - _e_ _[−][βH]_ [o.d.] _[/M]_ _e_ _[−][βH]_ [d] _[/M]_ [�] _[M]_ _|z_ 1 _⟩_

_z_ 1

=  - _⟨z_ 1 _| e_ _[−][βH]_ [o.d.] _[/M]_ _|z_ 2 _⟩⟨z_ 2 _| e_ _[−][βH]_ [d] _[/M]_ _|z_ 2 _⟩_

_z_ 1 _...zM_

_× ⟨z_ 2 _| . . . |zM_ _⟩⟨zM_ _| e_ _[−][βH]_ [o.d.] _[/M]_ _|z_ 1 _⟩⟨z_ 1 _| e_ _[−][βH]_ [d] _[/M]_ _|z_ 1 _⟩_ _,_


where _H_ o.d. contains only off-diagonal terms of _H_ in
the computational basis, and _H_ d contains only diagonal
terms in the computational basis. When the number of
Trotter steps _M_ is sufficiently large, the marginal probability of configuration _|z_ 1 _⟩_ approximates its population
in the Gibbs distribution,


_πz_ 1 =        - _πz_ 1 _...zM_ (A43)

_z_ 2 _...zM_

= _ρz_ 1 _z_ 1 as _M →∞,_


where

_πz_ 1 _...zM_ = [1] _⟨z_ 1 _| e_ _[−][βH]_ [o.d.] _[/M]_ _|z_ 2 _⟩⟨z_ 2 _| e_ _[−][βH]_ [d] _[/M]_ _|z_ 2 _⟩_

_Zβ_

_× ⟨z_ 2 _| . . . |zM_ _⟩⟨zM_ _| e_ _[−][βH]_ [o.d.] _[/M]_ _|z_ 1 _⟩⟨z_ 1 _| e_ _[−][βH]_ [d] _[/M]_ _|z_ 1 _⟩_
(A44)


under the particular Trotterization in Eq. (A42). Since
the number of Trotter steps needed to obtain a good
approximation of _Zβ_ is typically polynomial in _β_ and
the norm of _H_, we consider finite but large _U ≫|δ|, β_ .
Path-integral QMC can be used to sample configurations from the distribution _πz_ 1 _...zM_ . The MetropolisHastings update rule updates configuration _z_ 1 _. . . zM_ to
_z_ 1 _[′]_ _[. . . z]_ _M_ _[′]_ [with probability]



15


where _P_ is the QMC Markov chain, _µ_ is the initial probability distribution, and




 

_z_ 1 _...zM_ :
_H_ cost( _zi_ ) _≤−δb_



_πα_ =



_M_



_i_ =1



_πz_ 1 _...zM_ (A48)



is now the probability that the configuration of at least
one replica is an independent set of size _b_ . As with the
definition of parallel tempering runtime in Eq. (A23), we
include a factor of _M_ in the numerator of Eq. (A47). This
decision is justified because we allow the update rule to
alter all _M_ Trotter slices, which takes _O_ ( _M_ ) time complexity. It also excludes the trivial “speedup” that one
might obtain by using exponentially many time slices to
enumerate an exponential number of low-energy configurations, at the expense of exponential space complexity. The inclusion of this factor makes our runtime lower
bound, stated next in Theorem 4, independent of the parameter _M_ . We will remark in our proof of Theorem 4
that if the number of Trotter slices modified in a single
update is _m < M_, then _m_ can be substituted for _M_ in
our definition of _τ_ QMC( _ε, β_ ) in Eq. (A47).


**Theorem 4.** _Consider any path-integral QMC algorithm_
_which uses a Metropolis-Hastings update rule to modify at_
_most k spins on each of M imaginary time slices, where_
_k is a constant in n. For a given b, let H_ [(] _[r,b]_ [)] _denote the_
_modified QAA Hamiltonian H_ = _H_ QAA + _λHℓ_ _restricted_
_to the space of configurations z with H_ cost( _z_ ) _> −δb, and_
_let π_ [(] _[r,b]_ [)] _be the QMC equilibrium distribution associated_
_with H_ [(] _[r,b]_ [)] _at inverse temperature β. Let |z_ max _⟩_ _denote_
_the configuration within k spin flips of an independent set_
_|z⟩_ _with H_ cost( _z_ ) = _−δb with the maximum Gibbs popu-_
_lation πz_ [(] _[r,b]_ max [)] _[, and let][ e]_ [(] max _[r,b]_ [)] [=] _[ π]_ _z_ [(] _[r,b]_ max [)] _[D]_ _b−_ 1 _[describe relative]_
_enhancement or suppression of its population compared to_
_the uniform superposition state |Sb−_ 1 _⟩. Then the QMC_
_runtime τ_ QMC( _ε_ ) _for any error ε <_ 1 _/_ 2 _is bounded as_



_Pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_ [=] _[ p][z]_ [1] _[...z][M]_ _[,z]_ 1 _[′]_ _[...z]_ _M_ _[′]_ [min] �1 _,_ _ππzz_ 11 _[′]_ _[...z]_ _...zMM_ _[′]_




_,_


(A45)




       - 1
_τ_ QMC( _ε_ ) _≥_ [ln] 2




[ln] 2 _nkn_ 2 _ε_ _[k]_ [max] _b>b⋆_ _e_ [(] max _D_ _[r,b]_ _b−_ [)] _[D]_ 1 _b_ _._ (A49)



1 
2 _ε_



where _pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_ [is the probability of proposing an]
update to _z_ 1 _[′]_ _[. . . z]_ _M_ _[′]_ [given that the current configuration]
is _z_ 1 _. . . zM_ .
We define the QMC runtime analogously to parallel
tempering, as


_τ_ QMC( _ε_ ) = min (A46)
_β_ _[τ]_ [QMC][(] _[ε]_ [)] _[,]_


where _τ_ QMC( _ε, β_ ) is the runtime lower bound for QMC
at temperature 1 _/β_,



_τ_ QMC( _ε, β_ ) = _[M]_




 - _|πz −_ _P_ _[t]_ _µz| ≤_ _ε_ - _._

_z∈{_ 0 _,_ 1 _}_ _[n]_




   min _t_ : max
_nπα_ _µ_







(A47)



We first comment on the implications of Theorem 4
before proceeding to its proof. Denote the Gibbs distribution of _H_ [(] _[r,b]_ [)] as _ρ_ [(] _[r,b]_ [)] = _e_ _[−][βH]_ [(] _[r,b]_ [)] _/_ Tr( _e_ _[−][βH]_ [(] _[r,b]_ [)] ). For
the purpose of discussion, assume that _M_ is large enough
such that _πz_ [(] _[r,b]_ [)] is a good approximation for _ρ_ [(] _zz_ _[r,b]_ [)] _._ Now,
when _λ_ is large enough to ensure that _ρ_ [(] _[r,b]_ [)] is delocalized
in the manifold of independent sets of size _b −_ 1 _,_ we
have _e_ [(] max _[r,b]_ [)] _[≤]_ [1. Thus, Eq. (][A49][) recovers the parallel]
tempering runtime bound in Theorem 2. Additionally,
the QMC runtime is quadratically larger than the QAA
runtime. Conversely, if _ρ_ [(] _[r,b]_ [)] is favorably localized among
sets of size _≤_ _b −_ 1 within Hamming distance _k_ of sets
of size _b_, Eq. (A49) yields a weak bound. In particular,
if _e_ [(] max _[r,b]_ [)] [≳] - _Db−_ 1 _/Db_, then Theorem 4 suggests that

QMC recovers the modified QAA’s quadratic speedup.
In such a scenario, however, it is likely that QAA itself


16



also favorably localizes on configurations which are
close in Hamming distance to solutions of size _≥_ _b_ . In
such a situation, adding a large _λ_ to the QAA likely
does _not_ enhance its performance, because it already
benefits from (exponentially) favorable localization in
the absence of _λ_ . In other words, the only scenario
where QMC can recover the QAA’s quadratic speedup
is one in which the quadratic speedup is irrelevant due
to favorable localization, which can be exploited by both
QAA and QMC. We note also that there is no reason
_a priori_ to expect such favorable localization to occur
(and indeed, Fig. 13(a) of Appendix E 2 suggests that it
typically does not), although we cannot strictly exclude
it from formal arguments.


_Proof._ As before, we will use the Cheeger inequality to
prove an upper bound on the spectral gap of the QMC
Markov chain ∆QMC. This gives us a lower bound on
the QMC runtime via Eq. (A8). We will adopt identical
notation and similar techniques to the parallel tempering
proof in Appendix A 2. As in Eq. (A26), let _S_ be the set
of configurations with _H_ cost( _zi_ ) _> −δb_ for all _i_ . Let _∂Si_
represent the configurations _zi ∈_ _Si_ for which QMC can
transition into _Si_ _[c]_ [in a single update of at most] _[ k]_ [ spins.]
We will first consider the regime where _πS <_ 1 _/_ 2. We
can compute



of those _m_ replicas _i_ in _∂Si_ .
Therefore, we have



_QS,S_ _c_ _≤_ _M_

_πS_


= _M_


= _M_



_z_ 1 _...zM_ _∈S_ _[π][z]_ 1 _[...z]_ _M_



_QS,S_ _c_ _≤_ _M_

_πS_




- _z_ 1 _∂S_ 1 _πz_ 1 _...zM_
_zj_ _∈S∈j_ _,j_ =1 _._ (A51)

~~�~~

_z_ 1 _...zM_ _∈S_ _[π][z]_ 1 _[...z]_ _M_



Now notice that the summations in the numerator and
denominator of Eq. (A51) are only over configurations
in _S_ . Thus, they can be related to the Gibbs state of
_H_ QAA + _λHℓ_ in a restricted Hilbert space that includes
no configurations in _S_ _[c]_ . We will denote quantities in
this restricted Hilbert space with a superscript ( _r, b_ ), so
that _H_ [(] _[r,b]_ [)] = _H_ QAA [(] _[r,b]_ [)] [+] _[ λH]_ _ℓ_ [(] _[r,b]_ [)] . Note now that because
_H_ [(] _[r,b]_ [)] is identical to _H_ on this restricted space, the populations that one would compute with QMC in this restricted space are related to their values in the full Hilbert
space by an overall normalization factor:


_Zβ_
_πz_ [(] _[r,b]_ 1 _...z_ [)] _M_ [=] _πz_ 1 _...zM ._ (A52)
_Zβ_ [(] _[r,b]_ [)]


As a result, we may write




- _z_ 1 _∂S_ 1 _πz_ 1 _...zM_
_zj_ _∈S∈j_ _,j_ =1

~~�~~

_z_ 1 _...zM_ _∈S_ _[π][z]_ 1 _[...z]_ _M_

- _zjz∈_ 1 _S∈j∂S,j_ =11 _πz_ [(] _[r,b]_ 1 _...z_ [)] _M_

~~�~~ [(] _[r,b]_ [)]




_z_ 1 _∂S_ 1 _[π]_ _z_ [(] _[r,b]_ 1 [)]
_∈_

~~�~~ [(] _[r,b]_ [)]



_z_ 1 _S_ 1 _[π]_ _z_ [(] _[r,b]_ 1 [)]
_∈_




  _QS,S_ _c_ =

_zz_ 1 _[′]_ 1 _[...z]_ _...zM_ _[′]_ _M_ _[∈S]_ _∈S_ _[c]_



_z_ 1 _...zM_ _∈S_ _[π]_ _z_ [(] _[r,b]_ 1 _...z_ [)] _M_



_zjz∈i∈Sj∂S,j_ = _i_ _i_



_πz_ 1 _...zM Pz_ 1 _...zM_ _,z_ 1 _[′]_ _[...z]_ _M_ _[′]_


_πz_ 1 _...zM_



_≤_



_M_



_i_ =1







_≤_ _M_ - _πz_ 1 _...zM ._ (A50)

_zjz∈_ 1 _S∈j∂S,j_ =11



In the final line, we have used that there are
( _k_ ) [2][�] _[n]_ _k_ - _Db ≤_ _k_ _[′]_ _n_ _[k]_ _Db_ configurations in _∂S_ 1, and the definition _e_ [(] max _[r,b]_ [)] [=] _[ π]_ _z_ [(] _[r,b]_ max [)] _[D]_ _b−_ 1 [. From Eq. (][A53][), we can thus]
immediately obtain the bound in Eq. (A49).
The discussion so far has assumed _πS <_ 1 _/_ 2. When
_πS >_ 1 _/_ 2, we must instead compute _QS,S_ _c_ _/πS_ _c_ for the
Cheeger bound in Eq. (A9). We multiply this quantity
by _πα_ to obtain the quantity that appears in the QMC
runtime definition in Eq. (A47),




_[e]_ max [(] _[r,b]_ [)] _[D]_ _b_
_≤_ _Mkn_ _[k]_



_._ (A53)
_Db−_ 1



In the second line we used the fact that if _z_ 1 _. . . zM ∈S_
can transition into _S_ _[c]_, then _zi ∈_ _∂Si_ for at least one
replica _i_ . The third line uses the standard cyclic permutation property of QMC Gibbs populations. We note
that strictly speaking, one can choose to Trotterize the
path integral in QMC in such a way that the cyclic permutation property is modified. For instance, if instead
of the _H_ o.d. _/H_ d decomposition above, we apply _H_ cost,
_Hℓ_ and _Hq_ in separate imaginary time slices, the QMC
Gibbs weights will only be invariant under “even” cyclic
shifts _zi →_ _zi_ +2 _a_ mod _M_ for _a ∈_ Z. This does not affect
the result because in such cases, the transition between
_S_ and _S_ _[c]_ must still happen in one “block” of the cycle
(e.g. one _H_ cost _, Hℓ, Hq_ block in this example), and all the
configurations within a single such block must be within
a constant Hamming distance from each other. Finally,
we remark that if at most _m < M_ Trotter slices are
modified during a QMC update, then the factor of _M_ in
Eq. (A50) can be replaced with _m_ . This can be seen by
writing the _QS,S_ _c_ as a sum over proposed updates to _m_
replicas, then only summing over configurations with one



We now note that _Zβ_ [(] _[r,b]_ [)] _≤Zβ_, because the Gibbs weights

contained in _Zβ_ [(] _[r,b]_ [)] are a subset of the weights contained



_QS,S_ _c_ _πα_



_πz_ 1 _...zM ._ (A54)



_,S_ _c_ _α_ _≤_ _Q_ _,_ _≤_ _M_ 
_π_ _c_ _S_ _S_ _[c]_
_S_ _z_ 1



_zjz∈_ 1 _S∈j∂S,j_ =11



By the above arguments, we may then write



_Zβ_ [(] _[r,b]_ [)]
_QS,S_ _c ≤_ _M_ _Zβ_




- _πz_ [(] _[r,b]_ 1 [)] _._ (A55)

_z_ 1 _∈∂S_ 1


17


(a) (b)


FIG. 7. Classical Markov chain runtime versus system size. (a) A box-and-whiskers plot of the classical runtime lower bound
versus the system size _n_ . The box endpoints are the 25th and 75th percentiles, and the whiskers are the 0th and 95th percentiles.
(b) The runtime lower bounds at the 80th, 95th and 99th percentiles scale exponentially in ~~_[√]_~~ ~~_n_~~ ~~.~~ The 50th percentile runtime
lower bound is also consistent with exponential scaling in ~~_[√]_~~ ~~_n_~~ ~~.~~



in _Zβ_ . Note that we use the fact that the Hamiltonian
does not have a sign problem, which ensures the positivity of the Gibbs weights. Thus, we have



_,_ _πα_ _[e]_ [(] max _[r,b]_ [)] _[D]_ _b_
_S_ _[c]_ _≤_ _Mkn_ _[k]_

_πS_ _c_ _Db−_ 1



_QS,S_ _[c]_ _πα_



_,_ (A56)
_Db−_ 1



means that for the unit-disk graphs we study, in practice
it is not strictly necessary to have a cutoff independent set
size _b_ _[⋆]_ in the runtime lower bound max _b>b⋆_ ( _Db−_ 1 _/Db_ ):
any _b_ with _Db_ 1 _/Db ≥_ 1 can be used in the maximiza
_−_
tion. The vast majority (99.87%) of instances we study
have max _b_ ( _Db−_ 1 _/Db_ ) = _Dα−_ 1 _/Dα_, and the remainder
have max _b_ ( _Db−_ 1 _/Db_ ) = _Dα−_ 2 _/Dα−_ 1.
Figure 7(a) shows a box-and-whiskers plot of the full
distribution of runtime lower bounds as a function of _n_ .
The variance of runtimes spans several orders of magnitude and increases with _n_, and the largest runtime
over all the studied graphs is nearly 10 [12] . In Fig. 7(b),
_√_ we plot various percentiles of max _b>b⋆_ ( _Db−_ 1 _/Db_ ) versus
~~_n_~~ ~~.~~ We find that the runtime is exponential in _√_ ~~_n_~~ for
instances in the 80th percentile and above. The 50th
percentile runtime also appears to scale exponentially
in _[√]_ ~~_n_~~ rather than polynomially. Therefore, the classical runtime lower bounds are (sub)exponentially faster
than black-box search, which has an expected runtime of
_O_ (2 _[n]_ _/Dα_ ), which is exponential in _n_ instead of _[√]_ ~~_n_~~ ~~.~~
We can compare the scaling of the runtime lower bound
with system size to leading exact classical algorithms,
which are guaranteed to return the largest independent
set. The best exact classical algorithms for solving the
unit-disk Maximum Independent Set problem find the solution in time _O_ ( _c_ ~~_√n_~~ ), for some constant _c ∈_ (1 _,_ 2). This
scaling can be achieved using dynamic programming [68]
or tensor-network methods [40]. Numerical evidence for
the system sizes studied (see Fig. 2 in the main text)
suggests that the actual SA runtime is linearly related to
the SA runtime lower bound, suggesting that the typical
SA runtime also scales as _O_ ( _c_ ~~_√n_~~ ). If this result holds as
_n →∞_, then the scaling of both classical Markov chain
algorithms and the modified QAA are typically polynomially related to the best classical algorithms. In particular, if the SA runtime scaling is _O_ ( _c_ ~~_√n_~~ ), then the runtime

~~_√n_~~

of our modified QAA scales roughly as _O_ ( _[√]_ ~~_c_~~ ).



using the same reasoning as in Eq. (A53). As our bounds
hold at any point during the adiabatic ramp and at any
temperature 1 _/β_, we have thus shown Theorem 4.


**Appendix B: Runtime scaling with system size**


Here, we numerically study the runtime lower bounds
for the classical Markov Chain Monte Carlo algorithms
studied in Appendix A as a function of the number of
vertices _n_, and compare the bounds against leading exact
classical algorithms. The runtime lower bounds for these
algorithms are equal to the quantity max _b>b⋆_ ( _Db−_ 1 _/Db_ )
up to polynomial factors in 1 _/n_, where _Db_ is the number
of independent sets of size _b_, and _b_ _[⋆]_ is the cutoff independent set size as defined in Appendix A 1. This quantity
is large when there are many independent sets of some
size _b −_ 1 compared to independent sets of size _b._ We are
interested in determining how this quantity scales with
_n_ .
We randomly generate unit-disk graph instances with
up to 720 vertices embedded on a two-dimensional square
lattice with random 80% filling (see Fig. 1(a), main text).
We study 1000 instances at each system size and compute
max _b>b⋆_ ( _Db−_ 1 _/Db_ ) using the tensor-network algorithm
for computing solution-space properties of combinatorial
optimization problems detailed in Ref. [40]. We find that
the independence polynomial of every single instance is
_unimodal_, i.e., _D_ 0 _≤_ _D_ 1 _≤· · · ≤_ _Db⋆_ _≥· · · ≥_ _Dα_ 1 _≥_

_−_
_Dα,_ which may be of independent interest [67]. This


**Appendix C: Resolvent method for the minimum**
**gap**


**1.** **Derivation of the minimum gap formula**



Here we will derive an exact method to pertubatively
compute the minimum gap ∆QAA of _H_ QAA = _H_ cost _−_ _Hq_
when the avoided level crossing location (Ω _/δ_ ) _⋆_ _≪_ 1.
In the main text we used degenerate perturbation theory to compute, to leading order in Ω _/δ_, the orthogonal
states _|G⟩_ _, |E⟩_ which approximate the ground and first
excited eigenstates at Ω _/δ_ ≲ (Ω _/δ_ ) _⋆_ _≪_ 1 (see Eq. (11),
main text). Here we will exactly compute ∆QAA in terms
of the matrix elements of an effective Hamiltonian _H_ eff ( _z_ )
acting on the subspace spanned by _|G⟩_ _, |E⟩_, defined by
the projector _P_ = _|G⟩⟨G|_ + _|E⟩⟨E|_ . Our main results are
in Eq. (C6), which gives ∆QAA exactly in terms of the
matrix elements of _H_ eff ( _z_ ), and Eq. (C12), which simplifies the result under a motivated approximation.
_H_ eff ( _z_ ) can be derived by rewriting the eigenvalue
equation _H_ QAA _|ψ⟩_ = _z |ψ⟩_ as _H_ QAA( _P_ + _Q_ ) _|ψ⟩_ = _z |ψ⟩_,
where _Q_ = 1 _−_ _P_, then multiplying by _P_ and _Q_ to obtain
a system of equations for the eigenvector _|ψ⟩_ :

  - _QH_ QAA _Q QH_ QAA _P_ �� _Q |ψ⟩_  - = _z_  - _Q |ψ⟩_  - _._ (C1)
_PH_ QAA _Q PH_ QAA _P_ _P |ψ⟩_ _P |ψ⟩_



�� _Q |ψ⟩_
_P |ψ⟩_




- - _Q |ψ⟩_
= _z_
_P |ψ⟩_




_._ (C1)



18


interpretation: each order _l_ applies a factor of _Hq_, but is
suppressed by a factor of _O_ (Ω _/δ_ ).
Prior works have estimated ∆QAA from the offdiagonal matrix element of _H_ eff ( _E⋆_ ) evaluated at (Ω _/δ_ ) _⋆_
as [25, 44]


˜∆QAA = 2 _| ⟨G| H_ eff ( _E⋆_ ) _|E⟩|,_ (C4)

which we analyzed in the main text [see Eq. (8)]. This
equation has an intuitive interpretation under the assumption of Landau-Zener physics on _H_ eff ( _z_ ), which
we illustrate in Fig. 8(a). At Ω _/δ_ = 0, _|G⟩_ _, |E⟩_
are eigenstates of _H_ QAA with eigenenergies given by
the on-diagonal entries of _H_ eff ( _z_ ) ( _⟨G| H_ cost _|G⟩_ and
_⟨E| H_ cost _|E⟩_, respectively). At the avoided level crossing
Ω _/δ_ = (Ω _/δ_ ) _⋆_, we expect the on-diagonal eigenenergies
of _|G⟩_ _, |E⟩_ in _H_ eff ( _z_ ) to cross at a value close to _E⋆_ for
some value of _z ≃_ _E⋆_, which we denote by _z_ _[′]_ . The gap of
_H_ eff ( _z_ _[′]_ ) at (Ω _/δ_ ) _⋆_ is then given by the off-diagonal coupling 2 _| ⟨G| H_ eff ( _z_ _[′]_ ) _|E⟩| ≃_ ∆ [˜] QAA. ∆ [˜] QAA indeed captures
the correct qualitative physics, but is quantitatively inaccurate. Here we show that ∆QAA can be computed
exactly from the matrix elements of _H_ eff ( _z_ ) in Eqs. (C6)
and (C12).
˜∆QAA does not equal ∆QAA in general because of the
_z_ -dependence of _H_ eff ( _z_ ), which prevents it from being
interpreted as a true Hamiltonian. The only guaranteed
relationship between _H_ eff and the spectrum of _H_ QAA is
that each eigenvalue _z_ of _H_ QAA is also an eigenvalue of
_H_ eff ( _z_ ) [see Eq. (C2)], i.e.,


det[ _z −_ _H_ eff ( _z_ )] = 0 (C5)


whenever _z_ is an eigenvalue of _H_ QAA. ∆QAA can therefore be obtained exactly from taking the difference between the first two values of _z_ that solve Eq. (C5),
which are the two lowest energy eigenvalues at _z_ =
_E⋆, E⋆_ + ∆QAA. We show an example of numerically using this method to exactly reconstruct ∆QAA in Fig. 8(b)
for a star graph with _b_ = 40 branches of length _ℓ_ = 2.
In contrast, we find that ∆ [˜] QAA, computed numerically,
overestimates ∆QAA for the same instance by a factor
of 4 _._ 53 (Fig 8(b), inset). This discrepancy is due to the
_z_ -dependence of _H_ eff, which we show in Fig. 8(c) for the
same instance.

To account for this _z_ -dependence, we will consider _z_ in
the neighborhood of _E⋆_, and compute the leading order,
linear dependence of _H_ eff on _z_ . We adopt the following
ansatz by expanding _H_ eff ( _z_ ) around a reference point _z_ =
_z_ 0:



These equations can then be written in terms of _P |ψ⟩_ as

- _Q_ _PH_ QAA _P_ + _PH_ QAA _|ψ⟩_ = _zP |ψ⟩._
_z −_ _QH_ QAA _Q_ _[H]_ [QAA] _[P]_


~~�~~ ~~��~~ ~~�~~
_H_ eff ( _z_ )

(C2)


The left hand side of the equation defines _H_ eff ( _z_ ), the effective Hamiltonian in the subspace spanned by _|G⟩_ _, |E⟩_ .
The second term in _H_ eff ( _z_ ) can be interpreted as a perturbative addition to original Hamiltonian, _PH_ QAA _P_,
due to higher-order couplings in Ω _/δ_ that come from the
_Q_ subspace, which is energetically separated from the _P_
subspace. Expanding the denominator using the matrix
Taylor expansion ( _A_ + _B_ ) _[−]_ [1] = _A_ _[−]_ [1][ �] _[∞]_ _l_ =0 [(] _[−][BA][−]_ [1][)] _[l]_ [, we]
receive



_H_ eff ( _z_ ) = _PH_ cost _P −_




- _∞_ _P_ - _−_ _Hq_ _Q_ - _lHqP,_

_z −_ _H_ cost
_l_ =0

(C3)



where we have used _PH_ cost _Q_ = 0 because _|G⟩_ _, |E⟩_ are
eigenstates of _H_ cost. This form of _H_ eff ( _z_ ) has an intuitive



_H_ eff ( _z_ ) = - _⟨E|⟨E| H H_ effeff(( _zz_ 00)) _|G⟩ |E⟩_ ++ _m meege_ (( _zz − −_ _zz_ 00)) _⟨E| ⟨G| H H_ effeff (( _zz_ 00)) _|G⟩ |G⟩_ ++ _m mgegg_ (( _zz − −_ _zz_ 00))� _,_ (C6)



where _mge_ = _meg_ because _H_ eff is real. ∆QAA can then be obtained from solving Eq. (C5) using the ansatz for


19



(a) Eigenstates





FIG. 8. Computing the minimum gap using the resolvent formalism. (a) When the avoided level crossing location (Ω _/δ_ ) _⋆_ _≪_ 1 _,_
the avoided level crossing can be understood in terms of Landau-Zener physics between _|G⟩_ _, |E⟩_ under _H_ eff ( _z_ _[′]_ ). At Ω _/δ_ = (Ω _/δ_ ) _⋆_,
_|E⟩_ and _|G⟩_ have the same on-diagonal energy under _H_ eff ( _z_ ), and the minimum gap of _H_ eff ( _z_ _[′]_ ) is given by their off-diagonal
coupling 2 _| ⟨G| H_ eff ( _z_ _[′]_ ) _|E⟩|._ (b) ∆QAA equals the difference of the first two zeroes of det[ _z −_ _H_ eff ( _z_ )], which occur at _z_ = _E⋆_
and _E⋆_ + ∆QAA (light blue, inset). The estimated gap ∆ [˜] QAA = 2 _| ⟨G| H_ eff ( _E⋆_ ) _|E⟩|_ overestimates the minimum gap ∆QAA by
a factor of 4 _._ 53 for this instance (light green, inset). (c) When _z −_ _E⋆_ is small, matrix elements of _H_ eff (solid lines) are wellapproximated by a linear function of _z_ (dashed lines). For the star graph with _b_ = 40 _, ℓ_ = 2, the _⟨G| H_ eff ( _z_ ) _|E⟩_ matrix element
changes as a function of _z −_ _E⋆_ with a slope of _mge_ = _−_ 5 _._ 2 _×_ 10 _[−]_ [6] . The matrix elements _⟨G| H_ eff ( _z_ ) _|G⟩_ and _⟨E| H_ eff ( _z_ ) _|E⟩_
change at much higher rates of _mgg_ = _−_ 1 _._ 9 and _mee_ = _−_ 6 _._ 1, respectively.


_H_ eff in Eq. (C6), which gives




    
∆QAA =2



_⟨E| H_ eff ( _z_ 0) _|G⟩_ [2] _feefgg_ + [1] �( _fee_ + _fgg_ ) ∆ _E_ [¯] + ( _fgg −_ _fee_ ) ( _E_ [¯] _−_ _z_ 0)�2

4



�1 _/_ 2

+ _⟨E| H_ eff ( _z_ 0) _|G⟩_ _mge_ �( _fee_ + _fgg_ ) ( _E_ [¯] _−_ _z_ 0) + ( _fgg −_ _fee_ ) ∆ _E_ [¯] - + _m_ [2] _ge_ [[( ¯] _[E][ −]_ _[z]_ [0][)][2] _[ −]_ [∆¯] _[E]_ [2][]]



_/_ - _fggfee −_ _m_ [2] _ge_ - _,_


(C7)



where we have defined the mean and difference of the
on-diagonal energies,


_E_ ¯( _z_ 0) = [1]

2 [(] _[⟨E|][ H]_ [eff] [(] _[z]_ [0][)] _[ |E⟩]_ [+] _[ ⟨G|][ H]_ [eff] [(] _[z]_ [0][)] _[ |G⟩]_ [)]

∆ _E_ [¯] ( _z_ 0) = [1] (C8)

2 [(] _[⟨E|][ H]_ [eff] [(] _[z]_ [0][)] _[ |E⟩−⟨G|][ H]_ [eff] [(] _[z]_ [0][)] _[ |G⟩]_ [)] _[,]_


and let


_fee_ = 1 _−_ _mee_
_fgg_ = 1 _−_ _mgg._ (C9)


Eq. (C7) therefore gives ∆QAA in terms of the matrix
elements of _H_ eff and their first-order derivatives in _z_ .
In the absence of _z_ -dependence ( _mee_ = _mgg_ = _mge_ = 0),
one can check that this expression reduces the result one
would obtain from directly diagonalizing _H_ eff ( _z_ 0). Therefore, as expected, when _H_ eff is independent of _z_, it can
be treated as a true Hamiltonian acting on _|G⟩_ _, |E⟩_ and
diagonalized to find ∆QAA.
Although Eq. (C7) is exact, we can vastly simplify it
using intuition from Landau-Zener theory. Suppose, to



good approximation, there exists a _z_ _[′]_ such that the diagonal entries of _H_ eff ( _z_ _[′]_ ) intersect at _z_ _[′]_ for Ω _/δ_ = (Ω _/δ_ ) _⋆_ :
_⟨E| H_ eff ( _z_ _[′]_ ) _|E⟩_ = _⟨G| H_ eff ( _z_ _[′]_ ) _|G⟩_ = _z_ _[′]_ . Because _H_ eff is independent of the point of expansion _z_ 0 in the regime
where the linear approximation is valid, we may choose
_z_ 0 = _z_ _[′]_ _._ Using our assumption that the diagonal entries
of _H_ eff ( _z_ _[′]_ ) intersect at (Ω _/δ_ ) _⋆_, we then have ∆ _E_ [¯] ( _z_ 0) = 0
and _E_ [¯] ( _z_ 0) = _z_ 0 _._ Under this choice of _z_ 0, ∆QAA simplifies
to




  2
∆QAA =



_⟨E| H_ eff ( _z_ _[′]_ ) _|G⟩_ [2] _feefgg_

_._ (C10)
_fggfee −_ _m_ [2] _ge_



We may further simplify this expression using the fact
that we expect _|mge| ≪|fgg|, |fee|_ . To see this, we compute _dH_ eff _/dz_ for _z ∈_ R as



_dH_ ef

= _−_ Ω [2] _PHq_
_dz_




- _Q_ �2

_HqP_ (C11)

_z −_ _QH_ QAA _Q_




   - _Q_    - _†_    - _Q_    = _−_ Ω [2] _,_
_z −_ _QH_ QAA _Q_ _[H][q][P]_ _z −_ _QH_ QAA _Q_ _[H][q][P]_


which is similar to the second term of _H_ eff ( _z_ ) in Eq. (C2).
By expanding Eq. (C11) in powers of Ω _/δ_, as in Eq. (C3),
one can see that the on-diagonal entries can in general
be large because they connect either _|G⟩_ or _|E⟩_ to itself
via even multiples of _Hq_ . On the other hand, the offdiagonal entries should be smaller by _O_ (∆QAA) because
they connect _|G⟩_ to _|E⟩_ via odd multiples of _Hq_, similar to
the off-diagonal entries of _H_ eff ( _z_ ) _._ Therefore, we expect
that _|mge|/|fee|, |mge|/|fgg|_ = _O_ (∆QAA). We verify numerically that _|mge|_ = _O_ (∆QAA) and _fgg, fee_ = _O_ (1) in
Fig. 8(c) for an example star graph. Therefore, to good
approximation we have




[ef] [(] _[E][⋆]_ [)] _[ |G⟩|]_

= [2 ][∆][˜] [QAA]
_fggfee_ ~~�~~ _fggf_




[(] _[E][⋆]_ [)] _[ |G⟩|]_
∆QAA = [2] _[| ⟨E|]_ ~~�~~ _[ H]_ [ef]



_._ (C12)
_fggfee_



20


at worst polynomially small in _n_ . This will make the
correction factors _fee, fgg_ at most polynomially large
in _n_, and thus subleading when ∆QAA is exponentially
small in _n_ . The quantity _⟨ψ_ 0 _|G⟩⟨ψ_ 1 _|E⟩−⟨ψ_ 0 _|E⟩⟨ψ_ 1 _|G⟩_
can be interpreted as the area of the parallelogram
defined by _|G⟩_ _, |E⟩_ in the _|ψ_ 0 _⟩_ _, |ψ_ 1 _⟩_ subspace. If
we define _P_ = _|ψ_ 0 _⟩⟨ψ_ 0 _|_ + _|ψ_ 1 _⟩⟨ψ_ 1 _|_, the condition
that ( _⟨ψ_ 0 _|G⟩⟨ψ_ 1 _|E⟩−⟨ψ_ 0 _|E⟩⟨ψ_ 1 _|G⟩_ ) is large is thus
both a statement about the size of the overlaps
_⟨G| P |G⟩_ _, ⟨E| P |E⟩_ and also a statement about the linear
independence of _P |G⟩_ _, P |E⟩_ . Intuitively, _|G⟩_ _, |E⟩_ must
have good overlap with the span of _|ψ_ 0 _⟩_ and _|ψ_ 1 _⟩_, and
must furthermore capture sufficiently different directions
within this space. We expect _|G⟩_ _, |E⟩_ to satisfy this
condition when (Ω _/δ_ ) _⋆_ _≪_ 1 because _|G⟩_ approximates
_|ψ_ 0 _⟩_ and _|E⟩_ approximates _|ψ_ 1 _⟩_ in perturbation theory,
and _|G⟩_ _, |E⟩_ are orthogonal.


_Proof._ We first find the ground state energy of _QH_ QAA _Q_
by computing min _ϕ ⟨ϕ| H_ QAA _|ϕ⟩_ subject to _⟨ϕ|ϕ⟩_ = 1
and _P |ϕ⟩_ = 0. This can be formulated as the minimization of _⟨ϕ| H_ QAA _|ϕ⟩−_ _ζ_ 0 _⟨ϕ|G⟩−_ _ζ_ 1 _⟨ϕ|E⟩−_ _µ_ ( _⟨ϕ|ϕ⟩−_ 1)
where _ζ_ 0 _,_ 1 _, µ_ are Lagrange multipliers. Writing _|ϕ⟩_ in
the eigenbasis _|ψi⟩_ of _H_ QAA and setting the derivatives
with respect to _⟨ϕ|ψi⟩_ of this expression to zero yields
the condition


1

_⟨ψi|ϕ⟩_ = [1] (C14)

2 _Ei −_ _µ_ [(] _[ζ]_ [0] _[ ⟨][ψ][i][|G⟩]_ [+] _[ ζ]_ [1] _[ ⟨][ψ][i][|E⟩]_ [)] _[.]_


Plugging Eq. (C14) into the constraints
_⟨G|ϕ⟩_ = _⟨E|ϕ⟩_ = 0 yields two equations involving _ζ_ 0 _,_ 1 _, µ_,
and _⟨ψi|G⟩_ _, ⟨ψi|E⟩_ . Solving one equation for _ζ_ 0 and
substituting into the other yields, after simplification,



Note that by the form of Eq. (C11), _dH_ eff _/dz_ can be
written as _−_ Ω [2] times a positive semidefinite operator,
so all the derivatives of _H_ eff are negative. Therefore,
_fee, fgg ≥_ 1, so ∆ [˜] QAA is an overestimate of the gap,
consistent with our numerical results on the star graph
in Fig. 8(b). We verify numerically in Appendix D 1,
Fig. 10(d) that Eq. (C12) recovers the ∆QAA for the star
graph to high accuracy.


**2.** **Validity of the resolvent method**


For ∆ [˜] QAA to be a good qualitative predictor of ∆QAA
via Eq. (C12), the factors _fgg, fee_ cannot be large compared to the minimum gap as to change its leading-order
scaling behavior with _n_ . The _z_ -dependence of _H_ eff ( _z_ )
comes from the factor of ( _z −_ _QH_ QAA _Q_ ) _[−]_ [1] in Eq. (C2),
which creates a pole at every eigenvalue of _QH_ QAA _Q_ . Although this creates significant _z_ -dependence in _H_ eff ( _E⋆_ )
if _QH_ QAA _Q_ has an eigenvalue close to the ground state
energy _E⋆_ _≡_ _E_ 0, the _z_ -dependence will be modest if the
ground state energy of _QH_ QAA _Q_ is significantly larger
than _E_ 0. We expect this to occur when _Q_ is a sufficiently
good projector out of the ground and first-excited states
of _H_ QAA, and the second-excited state energy of _H_ QAA is
much larger than ∆QAA. To formalize this intuition, in
the following Theorem 5 we relate the energy difference
between _E_ 0 and the ground state energy of _QH_ QAA _Q_, denoted _δE_, to the overlap of _|G⟩_ and _|E⟩_ with the ground
and first excited eigenstates of _H_ QAA.


**Theorem 5.** _Denote the eigenstates of H_ QAA _at_ (Ω _/δ_ ) _⋆_
_as |ψ_ 0 _⟩_ _, |ψ_ 1 _⟩_ _. . ., |ψ_ 2 _[n]_ _⟩_ _with corresponding eigenvalues_
_E_ 0 _≤_ _E_ 1 _≤· · · ≤_ _E_ 2 _n, and assume that_ ∆QAA = _E_ 1 _−_
_E_ 0 _≪_ _E_ 2 _−_ _E_ 1 _._ _Denote the ground state energy_
_of QH_ QAA _Q by E_ 0 + _δE._ _Then, if | ⟨ψ_ 0 _|G⟩⟨ψ_ 1 _|E⟩−_
_⟨ψ_ 0 _|E⟩⟨ψ_ 1 _|G⟩|_ [2] _≫_ ∆QAA _, δE is bounded as_

_δE ≥_ [1]

4 [(] _[E]_ [2] _[ −]_ _[E]_ [1][)] _[| ⟨][ψ]_ [0] _[|G⟩⟨][ψ]_ [1] _[|E⟩−⟨][ψ]_ [0] _[|E⟩⟨][ψ]_ [1] _[|G⟩|]_ [2] _[.]_

(C13)


Hence, if _| ⟨ψ_ 0 _|G⟩⟨ψ_ 1 _|E⟩−⟨ψ_ 0 _|E⟩⟨ψ_ 1 _|G⟩|_ and _E_ 2 _−_ _E_ 1
are at worst polynomially small in _n_, we will have _δE_



0 = 

_i,j_


= 

_ij_



_| ⟨ψi|G⟩⟨ψj|E⟩−⟨ψi|E⟩⟨ψj|G⟩|_ [2]

( _Ei −_ _µ_ )( _Ej −_ _µ_ )


_| ⟨ψiψj|_ Φ _⟩|_ [2]

(C15)
( _Ei −_ _µ_ )( _Ej −_ _µ_ ) _[,]_



where we have defined the wavefunction _|_ Φ _⟩_ = _|G⟩⊗|E⟩−_
_|E⟩⊗|G⟩_, which exists in a doubled Hilbert space. Now
plugging Eq. (C14) into _⟨ϕ| H_ QAA _|ϕ⟩_ _/ ⟨ϕ|ϕ⟩_ and simplifying using Eq. (C15) yields the conclusion that the minimum energy of _QH_ QAA _Q_ is _µ_ . So we must use Eq. (C15),
which gives a constraint on _µ_, to constrain _δE_ = _µ −_ _E_ 0.
Before doing so we briefly note that although we must
have _µ ≥_ _E_ 0 by definition, we must exclude the possibility that _E_ 0 _≤_ _µ ≤_ _E_ 1 by contradiction: were this to
happen, we could rewrite Eq. (C15) as



_| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] 1
2

( _µ −_ _E_ 0)( _E_ 1 _−_ _µ_ ) [+ 2] _µ −_ _E_ 0



_| ⟨ψ_ 0 _ψi|_ Φ _⟩|_ [2]

_Ei −_ _µ_






_i_ =0 _,_ 1



1
= 2
_E_ 1 _−_ _µ_






_i_ =0 _,_ 1



_| ⟨ψ_ 1 _ψi|_ Φ _⟩|_ [2]



1 _i_ + 
_Ei −_ _µ_



_i,j_ =0 _,_ 1



_| ⟨ψiψj|_ Φ _⟩|_ [2]

( _Ei −_ _µ_ )( _Ej −_ _µ_ ) _[.]_


(C16)


Here all terms are positive, but the first term on the
left hand side is _O_ ( _| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] ∆ _[−]_ QAA [2] [) (because] _[ µ][ −]_
_E_ 0 _, E_ 1 _≤_ _E_ 1 _−_ _E_ 0 = ∆QAA), whereas the first term
on the right hand side is only _O_ (∆ _[−]_ QAA [1] [).] The equa


21


tion is thus impossible to satisfy under the assumption
_| ⟨ψ_ 0 _|G⟩⟨ψ_ 1 _|E⟩−⟨ψ_ 1 _|G⟩⟨ψ_ 0 _|E⟩|_ [2] _≫_ ∆QAA.
Therefore, to constrain _δE_, we can assume that _E_ 1 _≤_
_µ ≤_ _E_ 2, and use Eq. (C15) to write



_| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] + _| ⟨ψ_ 1 _ψ_ 0 _|_ Φ _⟩|_ [2] 1

_≤_
( _µ −_ _E_ 0)( _µ −_ _E_ 1) _µ −_ _E_ 0



_i_ =0 _,_ 1



_i_ =0 _,_ 1











_| ⟨ψ_ 0 _ψi|_ Φ _⟩|_ [2] + _| ⟨ψiψ_ 0 _|_ Φ _⟩|_ [2] 1

+
_Ei −_ _µ_ _µ −_ _E_ 1



_| ⟨ψ_ 1 _ψi|_ Φ _⟩|_ [2] + _| ⟨ψiψ_ 1 _|_ Φ _⟩|_ [2]

_Ei −_ _µ_



1
_≤_
( _µ −_ _E_ 0)( _E_ 2 _−_ _µ_ ) [(2] _[| ⟨][ψ]_ [0] _[|G⟩|]_ [2][ + 2] _[| ⟨][ψ]_ [0] _[|E⟩|]_ [2] _[ −| ⟨][ψ]_ [0] _[ψ]_ [1] _[|]_ [Φ] _[⟩|]_ [2] _[ −| ⟨][ψ]_ [1] _[ψ]_ [0] _[|]_ [Φ] _[⟩|]_ [2][)]



1
+ (C17)
( _µ −_ _E_ 1)( _E_ 2 _−_ _µ_ ) [(2] _[| ⟨][ψ]_ [1] _[|G⟩|]_ [2][ + 2] _[| ⟨][ψ]_ [1] _[|E⟩|]_ [2] _[ −| ⟨][ψ]_ [0] _[ψ]_ [1] _[|]_ [Φ] _[⟩|]_ [2] _[ −| ⟨][ψ]_ [1] _[ψ]_ [0] _[|]_ [Φ] _[⟩|]_ [2][)]



Between the first and second lines we used _E_ 2 _−µ ≤_ _Ei−µ_
for _i ≥_ 2, and

- [2] [2] [2] [2]



Now multiplying out all the denominators and using
_E_ 0 = _E⋆, E_ 1 = _E⋆_ + ∆QAA, we obtain




- _| ⟨ψ_ 0 _ψi|_ Φ _⟩|_ [2] = _| ⟨ψ_ 0 _|G⟩|_ [2] + _| ⟨ψ_ 0 _|E⟩|_ [2] _−| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] _._


_i_ =0 _,_ 1



(C18)



_| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] + _| ⟨ψ_ 1 _ψ_ 0 _|_ Φ _⟩|_ [2]
_µ −_ _E⋆_ _≥_ ( _E_ 2 _−_ _E⋆_ )

2 _| ⟨ψ_ 0 _|G⟩|_ [2] + 2 _| ⟨ψ_ 0 _|E⟩|_ [2] + 2 _| ⟨ψ_ 1 _|G⟩|_ [2] + 2 _| ⟨ψ_ 1 _|E⟩|_ [2] _−_ ( _| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] + _| ⟨ψ_ 1 _ψ_ 0 _|_ Φ _⟩|_ [2] )

2 _| ⟨ψ_ 0 _|G⟩|_ [2] + 2 _| ⟨ψ_ 0 _|E⟩|_ [2] _−_ ( _| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] + _| ⟨ψ_ 1 _ψ_ 0 _|_ Φ _⟩|_ [2] )
+ ∆QAA (C19)
2 _| ⟨ψ_ 0 _|G⟩|_ [2] + 2 _| ⟨ψ_ 0 _|E⟩|_ [2] + 2 _| ⟨ψ_ 1 _|G⟩|_ [2] + 2 _| ⟨ψ_ 1 _|E⟩|_ [2] _−_ ( _| ⟨ψ_ 0 _ψ_ 1 _|_ Φ _⟩|_ [2] + _| ⟨ψ_ 1 _ψ_ 0 _|_ Φ _⟩|_ [2] ) _[.]_



The final term can be dropped because it is small, by the
assumption _| ⟨ψ_ 0 _|G⟩⟨ψ_ 1 _|E⟩−⟨ψ_ 1 _|G⟩⟨ψ_ 0 _|E⟩|_ [2] _≫_ ∆QAA.
The bound in Theorem 5 then follows from maximizing
the denominator in the first term.


**3.** **Conditions for a perturbative avoided level**
**crossing**


By the arguments in Appendix C 2, the formula in
Eq. (C7) for the minimum gap of _H_ QAA = _H_ cost _−_ _Hq_
converges when the location of the avoided level crossing (Ω _/δ_ ) _⋆_ _≪_ 1. Here we establish a condition for when
this occurs, given in Eq. (C26), and motivate why we
expect this condition to hold for problem instances with
flat energy landscapes. We refer the reader to Ref. [69]
for a detailed framework to predict (Ω _/δ_ ) _⋆_ for general
combinatorial optimization problems.
Recall that the perturbed eigenstates (energy shifts)
are the eigenvectors (eigenvalues) of the perturbed
Hamiltonian



where



_Hfv_ = 



- (1 _−_ _nu_ ) 
_u∈V_ ( _u,v_ )



(1 _−_ _nv_ ) _,_ (C21)
( _u,v_ ) _∈E_



_H_ [(2)] = _−_ [Ω][2]

_δ_




_Hse_ + - _nu −_ _Hfv_

_u∈V_




_,_ (C20)



counts the number of free vertices for each independent
set _|z⟩_ (vertices which can be added to _|z⟩_ without violating the independent set constraint). _|G⟩_ is the ground
state of _H_ [(2)] in the _H_ cost = _−δα_ manifold because this is
the instantaneous ground state of the system as Ω _/δ →_ 0
(see Fig. 3(b), main text). Its perturbed energy under
_H_ [(2)] is

_⟨G| H_ cost + _H_ [(2)] _|G⟩_ = _−δα −_ [Ω][2]

_δ_ [(] _[α]_ [ +] _[ ⟨G|][ H][se][ |G⟩]_ [)] _[,]_

(C22)


where we have used that _⟨G| Hfv |G⟩_ = 0 because no vertices can be added to _|G⟩_ . The last term counts the expected number of spin exchanges possible between neighboring vertices in _|G⟩_ .
_|E⟩_ can be found by determining the _H_ cost manifold
whose ground state energy intersects _|G⟩_ first at finite
Ω _/δ_ (see Fig. 3(b) and Ref. [44] for a discussion). Suppose
_|E⟩_ is the ground state of Eq. (C20) in the _H_ cost = _−δb_


manifold, for some unknown _b_ . Then the perturbed
eigenenergy of _|E⟩_ is


_⟨E| H_ cost + _H_ [(2)] _|E⟩_

= _−δb −_ [Ω][2]

_δ_ [(] _[b]_ [ +] _[ ⟨E|][ H][se][ |E⟩−⟨E|][ H][fv][ |E⟩]_ [)] _[.]_ [ (C23)]


Note we have assumed that the ground state of each manifold of _H_ [(2)] is nondegenerate, so that _|G⟩_ and _|E⟩_ can be
uniquely identified. On instances where the degeneracy
is not broken, or the energy splitting between the ground
and first excited state of a manifold is too small to accurately identify _|G⟩_ or _|E⟩_, one can compute _|G⟩_ and _|E⟩_
by going to higher order in perturbation theory.
(Ω _/δ_ ) _⋆_ can then be estimated by computing the value
of Ω _/δ_ where Eqs. (C22) and (C23) intersect, which is







_α −_ _b_
_⟨E|Hse|E⟩−⟨G|Hse|G⟩−⟨E|Hfv|E⟩−_ _α_ + _b_
(C24)



22


crossing location as the number of branches (and therefore _n_ ) grows. The largest independent set is unique, so
_⟨G| Hse |G⟩_ = 0 _. |E⟩_ is in the _H_ cost = _−δ_ ( _α_ _−_ 1) manifold,
so the right hand side of Eq. (C26) is equal to 3. Typical independent sets in _|E⟩_ can participate in _O_ ( _n_ ) spin
exchanges. Therefore, by Eq. (C24) the avoided level
crossing location (Ω _/δ_ ) _⋆_ goes like _O_ (1 _/_ _[√]_ ~~_n_~~ _b_ ~~)~~ = _O_ (1 _/_ _[√]_ ~~_n_~~ ~~)~~
as _n →∞_ .


**4.** **Experimental Rydberg Hamiltonian resolvent**
**gaps**


Here we analyze the performance of the Rydberg atom
array experiment [23] using the resolvent gap formalism
described in Appendix C 1. Because the Rydberg Hamiltonian _H_ Ryd (Eq. (3), main text) has long-range interactions not present in the Maximum Independent Set cost
function _H_ cost, we must modify our perturbative formalism developed to predict the minimum gap ∆QAA. Here
we describe our method to perturbatively compute ∆QAA
for the Rydberg Hamiltonian. We then verify that the
resolvent gap formalism qualitatively captures the experimental performance.
In the main text, we estimated the parameters of
the avoided level crossing _|G⟩_ _, |E⟩_ _,_ (Ω _/δ_ ) _⋆,_ and _E⋆_ (see
Fig. 3(b), main text) by solving for the perturbative
Hamiltonian _H_ [(2)] approximating the system Hamiltonian _H_ QAA at small Ω _/δ_ (Eq. (11), main text). To find
_H_ [(2)] we performed second-order perturbation theory in
the degenerate manifolds of _H_ cost, each of which contained independent sets of a fixed size. These manifolds
become non-degenerate when exchanging _H_ cost for the
Rydberg Hamiltonian,



(Ω _/δ_ ) _⋆_ =



to second order in Ω _/δ_ . If (Ω _/δ_ ) _⋆_ _≪_ 1, then the numerator of Eq. (C24) must be much smaller than the
denominator:


_⟨E| Hse |E⟩−⟨G| Hse |G⟩≫_ 2( _α −_ _b_ ) + _⟨E| Hfv |E⟩_ _._
(C25)


We can use the bound _α −_ _b ≥⟨E| Hfv |E⟩_ to get the
following condition for when (Ω _/δ_ ) _⋆_ _≪_ 1:


_⟨E| Hse |E⟩−⟨G| Hse |G⟩≫_ 3( _α −_ _b_ ) _._ (C26)


Therefore, (Ω _/δ_ ) _⋆_ _≪_ 1 when _|E⟩_ has a large number
of expected possible spin exchanges compared to _|G⟩_,
and _|E⟩_ is comprised of near-optimal independent sets.
This is exactly the case on problem instances with flat
energy landscapes at near-optimal independent set size
_b ≃_ _α_ . Because there are many independent sets of size
_b_ with freedom to spin-exchange (see e.g. the configuration graph in Fig. 1, main text), we might expect
_⟨E| Hse |E⟩_ to be large. For example, if each vertex in
independent sets of size _b_ has _k_ possible spin exchanges,
then _⟨E| Hse |E⟩_ = _kb_ is extensively large with _n_ . We
similarly expect _⟨G| Hse |G⟩_ = _k_ _[′]_ _α_, if vertices in independent sets of size _α_ have _k_ _[′]_ possible spin exchanges (in
the case where there is a unique largest independent set,
_k_ _[′]_ = 0). Since there are far fewer independent sets of
size _α_, and larger independent sets may have less freedom to spin-exchange under the independent set constraint, we might expect that _k > k_ _[′]_ and therefore that
_⟨E| Hse |E⟩≫⟨G| Hse |G⟩_ for large systems. Therefore,
on problem instances with flat energy landscapes, we expect the avoided level crossing location to occur near the
end of the ramp, (Ω _/δ_ ) _⋆_ _≪_ 1.
We verify that this interpretation is correct for the family of star graphs in Appendix D. We consider the case
of fixed branch length _ℓ_, and look at the avoided level



_H_ Ryd = _−δ_ 



- _nu_ + 
_u∈V_ _u,v_



_Vuvnunv,_ (C27)
_u,v_



due to the long-range interactions _Vuv ∼_ 1 _/|ru −_ _rv|_ [6] . At
sufficiently large distances _|ru −_ _rv|_, _Vu,v_ is small and has
negligible effect. However, to safely perform perturbation
theory in (Ω _/δ_ ) _⋆_, we must carefully handle the Rydberg
interaction energy at short distances.
In the experimental implementation, the avoided level
crossing occurs at a detuning of _δ⋆_ _≃_ 7–13 MHz. The
energy scale for _Hq_ is _|_ Ω _|_ = 2 MHz (note that our definition of Ωdiffers from the standard definition of Rabi
frequency by a factor of 2). Although the resulting value
of (Ω _/δ_ ) _⋆_ _≪_ 1, the necessary condition to perform perturbation theory is that the energy difference under _H_ Ryd
between independent sets connected via _Hq_ is large compared to Ω _._ Therefore, in addition to _δ_, we must consider the interaction energy _Vuv_, which is 107 MHz for
nearest-neighbors on the square lattice and 13 _._ 6 MHz for
next-nearest neighbors (see Fig. 1, main text, and Supplementary Information of Ref. [23]). Suppose we take
an independent set and add a vertex via _Hq_, creating
an independent set violation between nearest-neighbors.


23


FIG. 9. Perturbation theory on the Rydberg Hamiltonian. (a) The true location of the avoided level crossing (Ω _/δ_ ) _⋆_ is close
to the predicted value from perturbation theory, particularly for small (Ω _/δ_ ) _⋆_ . Here we use Hamiltonian energy scales identical
to those used in the experimental implementation. (b) The true minimum gap ∆QAA can be estimated by only considering
low-order terms in the resolvent formalism.



This interaction can be treated perturbatively because
the energy difference between an independent set with
and without a single nearest-neighbor violation under
_H_ Ryd is _≥_ 94 MHz _≫|_ Ω _|_ . However, suppose we instead
add a vertex that creates a single independent set violation with a next-nearest-neighbor. The new energy
under _H_ Ryd increases by at least 13 _._ 6 MHz due to _Vuv_,
and decreases by 13 MHz due to _δ_, meaning that this
transition can be near-resonant under _Hq_ . Therefore,
we must treat single independent set violations between
next-nearest neighbors non-perturbatively. We find that
for most instances, removing a vertex from an independent set via a spin flip can be treated perturbatively, and
discuss rare exceptions later.
We will use the standard Schrieffer-Wolff transformation to compute _H_ [(2)] for the Rydberg Hamiltonian. By
the above arguments, _|_ Ω _|_ is perturbatively small compared to the energy difference between near-degenerate
manifolds of states that include:


1. Valid independent sets of the same size, and


2. Independent sets with any number of next-nearest
neighbor independent set violations (where each
vertex has at most a single next-nearest neighbor
in the Rydberg state).


Of course, these configurations are not truly degenerate under _H_ Ryd due to long range interactions, but their
splitting is comparable to _|_ Ω _|_, and typically small compared to the energy splitting between adjacent manifolds,
which is approximately 13.6 MHz (up to interactions that
are longer-range than next-nearest neighbors). Within a
near-degenerate manifold, _H_ [(2)] is given by


_H_ [(2)] = _H_ Ryd _−_ _Hq −_ [1] (C28)

2 [[] _[S, H][q]_ []] _[,]_


where the _Hq_ term implicitly acts only within a neardegenerate manifold (i.e., it only (de)excites single nextnearest-neighbor independent set violations). The third



term _−_ [1]

2 [[] _[S, H][q]_ [] describes perturbative interactions be-]
tween neighboring manifolds due to _Hq_, where _S_ satisfies


_−Hq_ + [ _S, H_ Ryd] = 0 _._ (C29)


Solving Eq. (C29) for _S_ gives


_⟨z| Hq |z_ _[′′]_ _⟩_
_⟨z| S |z_ _[′′]_ _⟩_ = _−_ (C30)
_H_ Ryd( _z_ ) _−_ _H_ Ryd( _z_ _[′′]_ ) _[.]_


Here _z_ and _z_ _[′′]_ are in adjacent manifolds connected by
_Hq_ . Therefore we see explicitly that the perturbative
condition is _H_ Ryd( _z_ ) _−_ _H_ Ryd( _z_ _[′′]_ ) _≫|_ Ω _|._
Inserting _S_ into Eq. (C29), we find that _H_ [(2)] is given
by


_Hz,z_ [(2)] _[′]_ [ =] _[ ⟨][z][|][ H]_ [Ryd] _[ |][z][′][⟩−⟨][z][|][ H][q][ |][z][′][⟩]_



for _z, z_ _[′]_ in the same near-degenerate manifold (here we
have removed couplings involving two vertex additions or
removals because they connect different manifolds, and
are therefore off-resonant). Eq. (C31) is identical to the
perturbative Hamiltonian for _H_ QAA [Eq. (11)], but with
the denominator of the second-order terms replaced with
the energy difference under _H_ Ryd instead of _H_ cost. We
note that for a small number of instances, there exists
one or more independent sets _|z⟩_ such that removing a
single vertex creates an independent set _|z_ _[′′]_ _⟩_ for which
_H_ Ryd( _z_ ) _−_ _H_ Ryd( _z_ _[′′]_ ) _≤|_ Ω _|_, because the Rydberg interaction energy from the removed vertex is comparable to
_−δ_ . We observe that this occurs only when the removed
vertex cannot spin-exchange, so only the corresponding
contribution to the second-order diagonal energy shift in
_H_ [(2)] is non-perturbative. In these rare cases we modify




- 1
_H_ Ryd( _z_ ) _−_ _H_ Ryd( _z_ _[′′]_ )



+ 
_z_ _[′′]_ : _⟨z|Hq|z_ _[′′]_ _⟩⟨z_ _[′′]_ _|Hq|z_ _[′]_ _⟩̸_ =0

1
+
_H_ Ryd( _z_ _[′]_ ) _−_ _H_ Ryd( _z_ _[′′]_ )



Ω [2]


2




_,_ (C31)


this matrix entry to be the hybridized energy of _|z⟩_ and
_|z_ _[′′]_ _⟩_ .
Given our expression for _H_ [(2)], we can now compute
the parameters involved in the avoided level crossing. For
each graph instance, we enumerate the independent sets
of size _α_ and _α_ _−_ 1 using a tensor network algorithm [40],
which is easily achieved on a laptop for the system sizes
we study ( _n_ = 39 – 80). From the independent sets we
construct _H_ [(2)] and find its lowest energy eigenstate and
eigenenergy for a given value of Ω _/δ_, which corresponds
to the leading order approximation for _|G⟩_ or _|E⟩_ under
_S_ . From this, we can predict (Ω _/δ_ ) _⋆_ by finding the value
of Ω _/δ_ where the perturbed energies of _|G⟩_ _, |E⟩_ intersect.
The energy where _|G⟩_ _, |E⟩_ intersect provides an estimate
of _E⋆_ . Figure 9(a) shows that the estimated (Ω _/δ_ ) _⋆_ from
perturbation theory agrees with the true (Ω _/δ_ ) _⋆_ computed via DMRG, particularly as (Ω _/δ_ ) _⋆_ becomes small.
Using our perturbatively estimated _|G⟩_ _, |E⟩_, and
(Ω _/δ_ ) _⋆_, we can now estimate the minimum gap ∆QAA.
Ideally we would evaluate Eq. (8) in the main text, replacing _H_ cost with _H_ Ryd, but this is intractable at the
largest system sizes we study ( _n_ = 65 _,_ 80). Inspired by
the form of Eq. (8), we instead compute ∆ [est.] QAA [, an esti-]
mate for ∆QAA given by


∆ [est.] QAA [= 2] �(Ω _/δ_ ) _[d]_ _⋆_ [(] _[z,z][′]_ [)] _⟨z |G⟩⟨z_ _[′]_ _|E⟩_ _,_ (C32)

_z,z_ _[′]_


where _d_ ( _z, z_ _[′]_ ) is the pairwise Hamming distance between
_z_ and _z_ _[′]_ . ∆ [est.] QAA [corresponds to only considering the]
lowest-order coupling between _|z⟩∈|G⟩_ and _|z_ _[′]_ _⟩∈|E⟩_
under _Hq_ in Eq. (8), which approximately occurs at order (Ω _/δ_ ) _[d]_ _⋆_ [(] _[z,z][′]_ [)] . In Fig. 9(b), we show that ∆ [est.] QAA [and]
∆QAA are similar. This verifies that even low-order estimations can qualitatively predict ∆QAA. We note that
∆ [est.] QAA [can be computed with relatively low space com-]
plexity on the order of _O_ ( _Dα_ + _Dα−_ 1), where recall _Db_
is the number of independent sets of size _b._


**Appendix D: The star graph**


Here we analyze the QAA runtime to find the largest
independent set of a family of star graphs. A star graph
has _nb_ branches of even length _ℓ_ connected by a central
vertex. We are interested in the runtime as a function of
_nb_ at fixed _ℓ_ .


**1.** **Level-crossing parameters**


We start by deriving the parameters involved in the
avoided level crossing when (Ω _/δ_ ) _⋆_ _→_ 0 _._ In this limit,
we can perturbatively predict (Ω _/δ_ ) _⋆_, the ground state
energy at the avoided crossing _E⋆_, and the states involved in the avoided crossing _|G⟩_ _, |E⟩_ . We can determine
these parameters from the eigenstates and eigenenergies



24


of the second-order perturbed Hamiltonian (Eq. (11),
main text),



Next we determine _|E⟩_ and its corresponding energy
shift by finding the ground state of _H_ [(2)] in the _H_ cost =
_−δ_ ( _α−_ 1) manifold. In this manifold there are ( _ℓ/_ 2+1) _[n][b]_
independent sets of size _α −_ 1 with the central vertex absent, and each branch in one of the _ℓ/_ 2 + 1 largest independent sets of a one-dimensional length- _ℓ_ chain with
open boundary conditions (see Fig. 10(a), top). This degeneracy corresponds to the motion of a single domain
wall (two adjacent vertices absent from the independent
set) in the antiferromagnetic ordering on each branch.
There are also a small number of independent sets of
size _α −_ 1 with the central vertex present (see Fig. 10(a),
bottom). In these sets, all but one of the branches has
perfect anti-ferromagnetic ordering ( _ℓ/_ 2 vertices in the
set per branch), and the remaining branch has _ℓ/_ 2 _−_ 1
vertices. One can count that the number of such independent sets is 3 _nb_ ( _ℓ/_ 2 _−_ 1), meaning they form a vanishingly small fraction of independent sets of size _α −_ 1
as _nb →∞._
As _nb_ grows we find that _|E⟩_ primarily has support on
the independent sets with the central vertex absent. We
first observe that the first term in _H_ [(2)], _−_ [Ω][2]

_δ_ _[H][se]_ [, deter-]
mines the ground state of _H_ [(2)] to good approximation.
To see this, first note that the second term in _H_ [(2)] acts
uniformly on all independent sets of size _α −_ 1, so it does
not affect the eigenvectors. The third term gives a small
diagonal shift onto an independent set for every vertex
that can be added to that set. This term is zero for all but
_ℓnb/_ 2+1 independent sets that connect to the largest independent set via a single spin flip, where it gives a shift
of [Ω][2]

_δ_ [. When] _[ n][b]_ [ is large, this energy shift is negligible]
compared to the ground state energy of the remaining
term _−_ [Ω][2]

_δ_ _[H][se]_ [, which maximizes the expected number of]
spin exchanges. In particular, the ground state energy of
this term is dominated by independent sets with the central vertex absent, which have anywhere between _nb_ and



_H_ [(2)] = _−_ [Ω][2]

_δ_




_Hse_ + 
_u∈V_




- ��
_nu −_ (1 _−_ _nu_ ) - (1 _−_ _nv_ ) _._

( _u,v_ ) _∈E_



_|G⟩_ is the ground state of _H_ [(2)] in the manifold of independent sets with _H_ cost = _−δα_ . This corresponds to
the unique largest independent set of the star graph with
_α_ = _ℓnb_ + 1 vertices, including the central vertex and

2
alternating vertices on each branch (see Fig. 3(c), main
text). The eigenenergy of _|G⟩_ in _H_ [(2)] corresponds to the
second-order energy shift of _|G⟩_ . It has nonzero contributions only from the second term of _H_ [(2)], which evaluates
to _−_ [Ω] _δ_ [2] - _u_ _V_ _[n][u]_ [ =] _[ −]_ [Ω] _δ_ [2] _[α]_ [. The other terms are zero be-]

_∈_

cause no spin-exchange operations are possible and no
vertices can be added to the largest independent set.
Therefore at second-order the energy of _|G⟩_ is given by



_u∈V_ _[n][u]_ [ =] _[ −]_ [Ω] _δ_ [2]




 _δ_



_⟨G|H_ cost + _H_ [(2)] _|G⟩_ = _−δα −_ [Ω][2] (D1)

_δ_ _[α.]_


2 _nb_ possible spin exchanges, depending on if the domain
wall is on the boundary (one possible spin exchange) or
in the bulk (two spin exchanges) of that branch. In comparison, independent sets with the central vertex present
have only one or two total possible spin exchanges.
Therefore _|E⟩_ is well-approximated as the ground state
of _−_ [Ω][2]

_δ_ _[H][se]_ [ restricted to the independent sets with the]
central vertex absent. On each branch this acts as a onedimensional hopping Hamiltonian with open boundary
conditions for the single domain wall. _|E⟩_ is therefore the
product of the ground state over all _nb_ branches



25


**2.** **Quantum runtime**


We now compute the minimum gap ∆QAA( _ℓ, nb_ ) and
analyze its scaling as a function of _nb_ at fixed _ℓ_ . We will
show that ∆QAA( _ℓ, nb_ ) scales as




- 1 - _π_

sin

~~�~~ _ℓ/_ 4 + 1 _ℓ/_ 2 + 2




- [�] _[n]_ _b_ [�]

_,_


(D6)



∆QAA( _ℓ, nb_ ) = _O_





Ω



up to polynomial factors in _nb_, which are subleading compared to Eq. (D6), which is exponentially small in _nb_ .
This matches the scaling predicted from leading-order
perturbation theory in (Ω _/δ_ ) _⋆_ in Eq. (15) from the main
text.
Following the resolvent formalism discussed in Appendix C 1, we will evaluate the estimated minimum gap
˜∆QAA. Recall from Eqs. (C3) and (C4) that ˜∆QAA is
given by the off-diagonal matrix element of an effective
Hamiltonian _H_ eff ( _z_ ) acting on the subspace spanned by
_|G⟩_ and _|E⟩_,


˜∆QAA = 2 _| ⟨G| H_ eff ( _z_ ) _|E⟩|_ (D7)


_Q_
= 2 _⟨G| H_ cost _−_ _Hq_ + _Hq_ _,_
���� _z −_ _QH_ QAA _Q_ _[H][q][ |E⟩]_ ����


where _H_ QAA = _H_ cost _−_ _Hq_ is evaluated at (Ω _/δ_ ) _⋆_,
and _z ≃_ _E⋆_ is a parameter with dimensions of energy. By the resolvent formalism equation for the minimum gap in Eq. (C12), ∆ [˜] QAA( _ℓ, nb_ ) gives ∆QAA( _ℓ, nb_ )
up to a computable proportionality factor that depends on _dH_ eff ( _z_ ) _/dz_ and which is close to one. We
numerically verify the correctness of Eq. (C12) in
Fig. 10(d) by computing ∆QAA( _ℓ, nb_ ) for _ℓ_ = 2 _,_ 4 via
both exact diagonalization and by numerically evaluating Eq. (C12). To compute Eq. (C12), we first
compute _H_ eff ( _z_ ), which gives us ∆ [˜] QAA by Eq. (D7).
We compute the proportionality factor by evaluating
_dH_ eff ( _z_ ) _/dz_ using the finite difference method. When
this correction factor is applied to ∆ [˜] QAA( _ℓ, nb_ ), the
result matches ∆QAA( _ℓ, nb_ ) computed via exact diagonalization to high accuracy, as expected. We
observe numerically that ∆ [˜] QAA _≃_ 4 _._ 53∆QAA for _ℓ_ = 2,
and ∆ [˜] QAA _≃_ 7 _._ 85∆QAA for _ℓ_ = 4, approximately independently of _nb_ . Therefore, as argued in Appendix C 1,
˜∆QAA captures the relevant scaling of ∆QAA in _nb_ .
To simplify the computation of Eq. (D6), we use a
slightly different choice of _|E⟩_ from the previous Appendix D 1. This is allowed as long as _|G⟩_ _, |E⟩_ are reasonable approximations to the eigenstates involved in the
avoided level crossing (see Appendix C 2). We let _H_ QAA [(] _[i]_ [)]
equal _H_ QAA restricted to the _i_ th branch of the star graph.
We let _|Ei⟩_ be the ground state of _H_ QAA [(] _[i]_ [)] [, and choose]
_|E⟩_ = _⊗_ _[n]_ _i_ =1 _[b]_ _[|E][i][⟩]_ _[.]_ [ Note that] _[ |E⟩]_ [is equal to the ground]
state of _H_ QAA from second-order degenerate perturbation theory [Eq. (D2)], to leading order in (Ω _/δ_ ) _⋆_ .



_⟨x_ 1 _x_ 2 _. . . xnb_ _|E⟩_ =



_nb_



_i_ =1



1   - _πxi_

sin

~~�~~ _ℓ/_ 4 + 1 _ℓ/_ 2 + 2




_,_ (D2)



where _|xi⟩_ _, xi ∈{_ 1 _,_ 2 _, . . ., ℓ/_ 2 + 1 _}_ is the state with the
domain wall on the _i_ th branch between sites 2 _xi −_ 2
and 2 _xi −_ 1. We confirm numerically that the overlap
of Eq. (D2) with the true ground state of _H_ [(2)] quickly
approaches one as _nb_ grows for _ℓ_ _∈{_ 2 _,_ 4 _,_ 6 _,_ 8 _}_ .
The corresponding perturbed energy at second-order
is then

_⟨E|H_ cost + _H_ [(2)] _|E⟩_



_≃−δ_ ( _α −_ 1) _−_ [Ω][2]



_δ_ _[⟨E|][H][se][|E⟩]_ _[.]_ [ (D3)]




[Ω][2]

_δ_ [(] _[α][ −]_ [1)] _[ −]_ [Ω] _δ_ [2]



By our earlier reasoning, _⟨E|Hse|E⟩_ = _cℓnb_ where
_cℓ_ _∈_ [1 _,_ 2] is a computable number depending on _ℓ._ For
_ℓ_ = 2, each configuration in _|E⟩_ can spin-exchange _nb_
times (once on each branch), so _cℓ_ = 1. As _ℓ_ increases,
the _|E⟩_ localizes on configurations that can spin-exchange
2 _nb_ times (with the domain walls in the bulk of each
branch), so _cℓ_ _→_ 2.
Having computed _|G⟩_ _, |E⟩_ and their energies as a function of Ω _/δ_, we can now estimate (Ω _/δ_ ) _⋆_ and _E⋆_ to second
order in Ω _/δ_ . (Ω _/δ_ ) _⋆_ is the value of Ω _/δ_ where the two
perturbed energies, Eqs. (D1) and (D3), intersect, given
by




  - 1
(Ω _/δ_ ) _⋆_ = (D4)

_cℓnb −_ 1 _[.]_



This quantity goes to zero as _nb →∞_, verifying that
our perturbation theory converges as _n →∞_ at fixed _ℓ_ .
Fig. 10(b) shows the predicted and numerically computed
(via exact diagonalization) va _√_ lue of (Ω _/δ_ ) _⋆_ for _ℓ_ = 2 and
4, which have _cℓ_ = 1 and 2, respectively. We reach

system sizes of 100 and 97 for _ℓ_ = 2 and 4, respectively,
by symmetrizing the Hamiltonian over the branches of
the star graph.
The corresponding ground state energy is computed by
evaluating Eq. (D1) at (Ω _/δ_ ) _⋆_ . This gives, in units of _δ_,




_._ (D5)




_−_ _[E][⋆]_




_[⋆]_

_[α]_
_n_ [=] _n_



_n_




- 1
1 +
_cℓnb −_ 1



Figure 10(c) shows the predicted and actual values of
_−E⋆/n_ for the same instances at _ℓ_ = 2 _,_ 4. As expected,
the predicted values converge to the true values as _nb_
increases.


26





(b) (c) (d)



spin exchanges


spin exchanges


FIG. 10. Perturbative avoided level crossing in the star graph. (a) There are two types of suboptimal independent sets of size
_α −_ 1 in the star graph (dark blue vertices are present in the independent set, light blue vertices are absent). Sets with the
central vertex absent have a single domain wall on each of _nb_ branches that can hop to neighboring sites via spin exchanges,
yielding _O_ ( _nb_ ) possible spin exchanges per independent set. When the central vertex is present, only one branch has a domain
wall, so there are _O_ (1) possible spin exchanges. These latter independent sets have negligible amplitude in _|E⟩_, which favors
independent sets with more possible spin exchanges. The predicted (solid lines) and numerically computed (data points) values
of (Ω _/δ_ ) _⋆_ (b) and _−E⋆/n_ (c) match as _n_ increases at fixed branch length _ℓ_ . As _n →∞_, (Ω _/δ_ ) _⋆_ _→_ 0. (d) The minimum
gap computed via exact diagonalization matches the gap computed by numerically evaluating the resolvent method formula
Eq. (C12) in Appendix C 1. At fixed _ℓ_, the minimum gap decreases exponentially as a function of _nb_ (and therefore _n_ ).




_|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _[|E][i][⟩]_ _[.]_


(D10)



We now evaluate Eq. (D7). The first term yields
_⟨G| H_ cost _|E⟩_ = 0. The second term is of the same
order as Eq. (D6) because our _|E⟩_ is equal to the
prediction from second-order degenerate perturbation
theory to leading order in _nb_ (see Eq. (15), main
text). Therefore it remains to compute the third term,
_⟨G| Hq_ _z−QHQ_ QAA _Q_ _[H][q][ |E⟩]_ [.] We begin by simplifying the
outermost factors of _Hq_ . First, we define the state


_|E_ [˜] _i⟩_ = (1 _−|Ei⟩⟨Ei|_ )(1 _−|G⟩⟨G|_ ) _Hq_ [(] _[i]_ [)] _|Ei⟩_ _,_ (D8)


where _Hq_ [(] _[i]_ [)] is _Hq_ restricted to a single branch _i_ . Then,



have


_Q_
_⟨G| Hq_
_z −_ _QH_ QAA _Q_ _[H][q][ |E⟩]_

           - 1
= _nb_ ( _⊗_ _[n]_ _i_ =1 _[b]_ _[⟨][x][i]_ [ = 1] _[|]_ [)] _[ Q]_
_z −_ _QH_ QAA _Q_



Here we have specified without loss of generality that the
factor of _|E_ [˜] _i⟩_ occurs on _i_ = 1, which yields the factor of
_nb_ .


We will now make the approximation that _Q_ factorizes
between branches,



_QHq |E⟩_ =



_nb_

- _|E_ [˜] _i⟩⊗j_ = _i |Ej⟩_ _,_ (D9)

_i_ =1



_QH_ QAA _Q ≈_



_nb_

- _QH_ QAA [(] _[i]_ [)] _[Q,]_ (D11)

_i_ =1



where we have used the fact that _Hq |E⟩_ is a sum of _nb_
terms, in each of which _nb −_ 1 branches are in _|Ei⟩_ .


Meanwhile, when _Hq_ acts on _|G⟩_ on the left hand side
of the third term of Eq. (D7), one term in _Hq_ removes the
central vertex from _|G⟩_, yielding the state _⊗_ _[n]_ _i_ =1 _[b]_ _[|][x][i]_ [ = 1] _[⟩]_ [,]
where _|xi_ = 1 _⟩_ denotes that the domain wall on the _i_ th
branch is on the first site (see Appendix D 1). _Hq |G⟩_ also
contains terms in which vertices are removed from the
branches of _|G⟩_, while the central vertex is left excited.
These terms cannot have better scaling with _nb_ than the
term with the central vertex removed from _|G⟩_, which we
confirm numerically. They are higher order because to
connect to _|G⟩_ via these terms, one must first go through
_⊗_ _[n]_ _i_ =1 _[b]_ _[|][x][i]_ [ = 1] _[⟩]_ [to add the central vertex. Therefore, we]



where _H_ QAA [(] _[i]_ [)] [is] _[ H]_ [QAA][ restricted to a single branch] _[ i]_ [. This]
is an approximation because it neglects terms in _H_ QAA
which act on the central vertex of the graph. This leaves
us with (up to polynomial factors in _nb_ )


_Q_
_⟨G| Hq_
_z −_ _QH_ QAA _Q_ _[H][q][ |E⟩∼]_

1
( _⊗_ _[n]_ _i_ =1 _[b]_ _[⟨][x][i]_ [ = 1] _[|]_ [)] _[ Q]_ _|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _[|E][i][⟩]_ _[.]_

_z −_ ~~[�]~~ _[n]_ _i_ =1 _[b]_ _[QH]_ QAA [(] _[i]_ [)] _[Q]_

(D12)


Note now that [ _QH_ QAA [(] _[i]_ [)] _[Q, QH]_ QAA [(] _[j]_ [)] _[Q]_ [] = 0, so that we]


may use the identity


1

(D13)
_z −_ ~~[�]~~ _[n]_ _i_ =1 _[b]_ _[QH]_ QAA [(] _[i]_ [)] _[Q]_



27


the state on the branch _i_ which is not in _|Ei⟩_, we may
safely replace _Q_ with _Q_ 1 = 1 _−|E_ 1 _⟩⟨E_ 1 _|_, and obtain


_Q_
_⟨G| Hq_ _i_ =1 _[⟨][x][i]_ [ = 1] _[|]_ [)]
_z −_ _QH_ QAA _Q_ _[H][q][ |E⟩∼]_ [(] _[⊗][n][b]_







_nb_

- _zi_

_i_ =1



1
=
(2 _πi_ ) _[n][b][−]_ [1]




_dz_ 1 _. . . dznb_




- _δ_ _z −_




- _|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _[|E][i][⟩]_ _._


(D18)



1

_zi −_ _QH_ QAA [(] _[i]_ [)] _[Q]_



1
_× Q_

_z −_ ( _nb −_ 1) _ϵ −_ _Q_ 1 _H_ QAA [(1)] _[Q]_ [1]




_,_



_×_



_nb_



_i_ =1



where the _zi_ integrals are taken on a contour encircling
the real axis. Therefore, we have


_Q_
_⟨G| Hq_
_z −_ _QH_ QAA _Q_ _[H][q][ |E⟩]_



_nb_

- _zi_

_i_ =1








- _δ_ _z −_



1
_∼_
(2 _πi_ ) _[n][b][−]_ [1]




_dz_ 1 _. . . dznb_



1   
_|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _[|E][i][⟩]_ _._
_zi −_ _QH_ QAA [(] _[i]_ [)] _[Q]_

(D14)



_×_ ( _⊗_ _[n]_ _i_ =1 _[b]_ _[⟨][x][i]_ [ = 1] _[|]_ [)] _[ Q]_



_nb_



_i_ =1



Note now that _Q_ acts trivially on _|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _[|E][i][⟩]_ [, because]
_|E_ [˜] 1 _⟩_ has no overlap with _|E_ 1 _⟩_ . Furthermore, _H_ QAA [(] _[n][b]_ [)] [only]
changes the state on branch _nb_, so that we can write


1

_|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _[|E][i][⟩]_
_znb −_ _QH_ QAA [(] _[n][b]_ [)] _[Q]_

1
= _|E_ [˜] 1 _⟩_ ( _⊗_ _[n]_ _i_ =2 _[b][−]_ [1] _|Ei⟩_ ) _|Enb_ _⟩_ _._ (D15)

_znb −_ _H_ QAA [(] _[n][b]_ [)]


We can repeat this process _nb −_ 2 more times to obtain


_Q_
_⟨G| Hq_
_z −_ _QH_ QAA _Q_ _[H][q][ |E⟩]_



_nb_ 
- _zi_ ( _⊗_ _[n]_ _i_ =1 _[b]_ _[⟨][x][i]_ [ = 1] _[|]_ [)]

_i_ =1



1    _∼_ (2 _πi_ ) _[n][b][−]_ [1] _dz_ 1 _. . . dznb_




- _δ_ _z −_



1
_× Q_

_z_ 1 _−_ _QH_ QAA [(1)] _[Q]_




- 1 ��
_|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _|Ei⟩_ _._

_zi −_ _H_ QAA [(] _[i]_ [)]



(D16)


We then make the replacement
1 where _ϵ_ is the en_zi−H_ QAA [(] _[i]_ [)] _[|E][i][⟩→]_ [2] _[πiδ]_ [(] _[z][i][ −]_ _[ϵ]_ [)] _[ |E][i][⟩]_ [,]

ergy of _|Ei⟩_ under _H_ QAA. This is valid by our choice of
integration contour and because _|Ei⟩_ is an eigenstate of
_H_ QAA [(] _[i]_ [)] [. Performing the] _[ z][i]_ [ integrals yields]


_Q_
_⟨G| Hq_ _i_ =1 _[⟨][x][i]_ [ = 1] _[|]_ [)] (D17)
_z −_ _QH_ QAA _Q_ _[H][q][ |E⟩∼]_ [(] _[⊗][n][b]_



1
_× Q_

_z −_ ( _nb −_ 1) _ϵ −_ _QH_ QAA [(1)] _[Q]_




- _|E_ [˜] 1 _⟩⊗_ _[n]_ _i_ =2 _[b]_ _[|E][i][⟩]_ _._



At this point, the final factor of _Q_ may be dropped, because 1
_z−_ ( _nb−_ 1) _ϵ−Q_ 1 _H_ QAA [(1)] _[Q]_ [1] _[|][E]_ [ ˜][1] _[⟩]_ [has no overlap with] _[ |E]_ [1] _[⟩]_ [.]

The expression becomes


_Q_
_⟨G| Hq_
_z −_ _QH_ QAA _Q_ _[H][q][ |E⟩∼]_ [(] _[⟨][x]_ [1][ = 1] _[|E]_ [1] _[⟩]_ [)] _[n][b][−]_ [1]

1
_× ⟨x_ 1 = 1 _|_ _|E_ [˜] 1 _⟩_ _._

_z −_ ( _nb −_ 1) _ϵ −_ _Q_ 1 _H_ QAA [(1)] _[Q]_ [1]

(D19)


The factor of _⟨x_ 1 = 1 _|_ 1
_z−_ ( _nb−_ 1) _ϵ−Q_ 1 _H_ QAA [(1)] _[Q]_ [1] _[|][E]_ [ ˜][1] _[⟩]_ [should]

scale at most polynomially with _nb_ and is thus subleading, by the arguments presented in Appendix C 1. The
term _⟨x_ 1 = 1 _|E_ 1 _⟩_ ) _[n][b][−]_ [1] scales as Eq. (D6). Therefore, we
conclude that ∆ [˜] QAA (and therefore ∆QAA) has the same
asymptotic scaling with _nb_ as Eq. (D6).


**Appendix E: Runtime of the modified QAA**


In this section, we will analyze the optimized runtime
∆ _[−]_ QAA [1] [of the modified QAA [Eq. (][16][), main text]. We]
will show that ∆ _[−]_ QAA [1] [scales as the square root of the]
classical Markov chain runtime lower bounds from Appendix A under motivated assumptions about the energy
landscape. We numerically verify this when the _Hℓ_ energy scale _λ →∞_ for system sizes of up to 460 vertices in
Fig. 4(c) of the main text. Here, we provide an analytic
arguments supporting these numerical observations. We
first analyze the case where _λ →∞_ next in Appendix E 1.
Perturbative corrections to our arguments for the case
when _λ_ is finite are discussed in Appendix E 2.


**1.** **Infinite** _λ_ **case**


In the _λ →∞_ limit, the adiabatic dynamics are projected onto the ground subspace of _Hℓ_ . The ground subspace of _Hℓ_ is spanned by the uniform superpositions of
each independent set size _{|Sb⟩}b_ =0 _,...,α_ [Eq. (9), main
text] when there exists a path between any two independent sets of the same size via spin exchanges. Here we
assume this condition is met, and discuss exceptions in
Appendix E 2. Each uniform superposition _|Sb⟩_ experiences an energy shift of _−δb_ from _H_ cost and couples to
neighboring independent set sizes under _Hq_ with coupling
strength _tb_ = _⟨Sb| Hq |Sb_ 1 _⟩_ = Ω _b_ ~~�~~ _Db/Db_ 1. Therefore,

_−_ _−_



At this point, formally, the factors of _Q_ = 1 _−|G⟩⟨G|−_

- _nb_
_i_ =1 _[|E][i][⟩⟨E][i][|]_ [ act on all factors in the wavefunction. How-]
ever, since all but one of the _nb_ factors in the tensor product on the right are _|Ei⟩_, and since _H_ QAA [(1)] [only changes]


28





(d)



Bixon-Jortner basis


FIG. 11. Minimum gap of the modified QAA at infinite _λ_ . (a) The original one-dimensional tight-binding Hamiltonian _Htb_ has
a weak coupling _tα−_ 1 between the last and second-to-last sites (top). _Htb_ can be partially diagonalized to generate an effective
Bixon-Jortner model that weakly couples all _H_ bulk eigenstates to the last site of the tight-binding model (bottom). (b) The
lowest energy eigenvalues of _Htb_ as a function of _δ/_ Ωfor a representative instance with _n_ = 720 vertices (bottom) are paired
with schematic eigenenergies of _H_ bulk and the last site _|Sα⟩_ at three different detunings (top). For _δ < δ⋆_, the spectral gap of
_Htb_ is equal to the spectral gap of _H_ bulk. At the resonance condition _δ_ = _δ⋆_ between the last site and the _H_ bulk ground state
_|ψ_ 0 _⟩_, the weak coupling _tα−_ 1 sets the gap. For _δ > δ⋆_, Wannier-Stark localization sets in and the gap is proportional to _δ_ .
_α_ [2]
(c) We show a representative example of the couplings _t_ ( _x_ ) and position dependent mass _m_ ( _x_ ) = _t_ ( _x_ ) [from a 720-vertex hard]

unit-disk graph instance. (d) For the same instance, we show the effective potential _V_ ( _x_ ), neglecting the second-derivative term
_∂x_ [2] _[t]_ [(] _[x]_ [), and the] _[ H]_ bulk [ground state wavefunction] _[ ψ]_ 0 [(] _[x]_ [) for] _[ δ]_ [ = 0 and] _[ δ]_ [ =] _[ δ]_ _⋆_ [. At] _[ δ]_ [ = 0, the ground state is delocalized in the]
middle of the bulk (top). At _δ_ = _δ⋆_, the wavefunction is localized near the weak coupling (bottom).



_α_ - _−_ 1 [ _δb |Sb⟩⟨Sb|_ + _tb_ ( _|Sb⟩⟨Sb−_ 1 _|_ + h _._ c _._ )] _._

_b_ =0



the effective dynamics are given by the one-dimensional
tight-binding Hamiltonian _Htb_ [Eq. (18), main text],



where


_H_ bulk = _−_



(E3)


We then diagonalize _H_ bulk and re-express _Htb_ in terms
of its eigenenergies _El_ and eigenvectors _|ψl⟩_ (where
_l_ = 0 _, . . ., α −_ 1 is ordered from lowest to highest energy):


_Htb_ = _−δα |Sα⟩⟨Sα|_ (E4)



_Htb_ = _−_



_α_

- [ _δb |Sb⟩⟨Sb|_ + _tb_ ( _|Sb⟩⟨Sb−_ 1 _|_ + h _._ c _._ )] _._ (E1)

_b_ =1



Our goal is to show that the minimum gap ∆QAA of
_Htb_ goes like the smallest coupling min _b tb_ . For simplicity,
we will focus on instances where the smallest coupling is
between the largest independent sets of size _α_ and suboptimal independent sets of size _α −_ 1, i.e. min _b tb_ = _tα−_ 1.
This was overwhelmingly the most common case, representing 99.87% of the hundreds of instances studied in
Appendix B. If ∆QAA _∝_ _tα_ 1, then the modified op
_−_
timized QAA runtime ∆ _[−]_ QAA [1] _[∝]_ _[t]_ _α_ _[−]_ [1] 1 [is quadratically]

_−_
smaller than the classical Markov chain runtime _∝_ _t_ _[−]_ _α_ [2] 1 [,]

_−_
up to polynomial factors in _n_ . These polynomial factors are insignificant because numerically, _t_ _[−]_ _α_ [2] 1 [is expo-]

_−_
nentially large in _[√]_ ~~_n_~~ for the Maximum Independent Set
problem on unit-disk graphs (see Appendix B).

We first leverage the assumption that _tα−_ 1 is the smallest parameter in _Htb_ . We bipartition the system into two
parts: the last site, corresponding to _|Sα⟩_, and the remaining sites which form the “bulk” of the chain. These
two parts are connected by the weakest coupling _tα−_ 1:


_Htb_ = _H_ bulk _−_ _δα |Sα⟩⟨Sα| −_ _tα_ 1( _|Sα⟩⟨Sα_ 1 _|_ + h.c.) _,_

_−_ _−_
(E2)



Eq. (E4) is a Bixon-Jortner model [70], a standard model
in quantum optics where uncoupled levels interact with
each other only by coupling to a common mode. Here,
the uncoupled eigenstates _|ψl⟩_ of _H_ bulk are each coupled
to the last site of the tight-binding chain (the common
mode) with strength _tα_ 1 _⟨ψl|Sα_ 1 _⟩_, as in Fig. 11(a).

_−_ _−_
The coupling to the common mode is generated by projecting the last site onto the energy eigenstates of _H_ bulk:
_⟨ψl| Hq |Sα⟩_ = _tα_ 1 _⟨ψl| Sα_ 1 _⟩_ .

_−_ _−_
We now consider what happens to the spectral gap of
_Htb_ as we vary the detuning _δ_ at fixed Ω= 1, which we
visualize in Fig. 11(b). We let _δ⋆_ denote the detuning corresponding to when the ground state of _H_ bulk, _|ψ_ 0 _⟩_, and
the last site _|Sα⟩_ are resonant in energy (i.e., _E_ 0 = _−δ⋆α_ ).
From the canonical solution of the Bixon-Jortner problem [70], it follows that once _E_ 0 _, E_ 1 _, · · · Eα−_ 1 _> −δ⋆α_,
the spectral gap increases due to level repulsion as _δ_ is



+



_α_ - _−_ 1 [ _El |ψl⟩⟨ψl| −_ _tα_ 1 _⟨ψl|Sα_ 1 _⟩_ ( _|ψl⟩⟨Sα|_ + h.c.)] _._

_−_ _−_
_l_ =0


increased. In the language of the original tight-binding
Hamiltonian, when _δ > δ⋆_, the electric field _δ_ dominates
so that the instance-specific details of the couplings _tb_ become irrelevant, and Wannier-Stark localization occurs in
the bulk (see Fig. 11(b), top right). Therefore, the spectral gap is set by _δ_ and the smallest coupling _tα−_ 1 does
not play a role in determining the gap for _δ > δ⋆_ . When
_δ < δ⋆_, the spectral gap of _Htb_ is set by the spectral gap
of _H_ bulk, which we denote as ∆bulk (see Fig. 11(b), top
left).
The gap is sensitive to the smallest coupling _tα−_ 1 at _δ⋆._
Then, the ground state energy of _H_ bulk _, |ψ_ 0 _⟩_, is resonant
with the energy of the last site _|Sα⟩_, i.e., _E_ 0( _δ⋆_ ) = _−δ⋆α_ .
Here we show that the minimum gap ∆QAA is given by
the gap at the resonance,


∆QAA = _tα−_ 1 _⟨ψ_ 0 _|Sα−_ 1 _⟩_ + _O_ ( _t_ [2] _α−_ 1 [)] _[,]_ (E5)


when the following condition holds:


1. The spectral gap ∆bulk of _H_ bulk is at least polynomially small in _n_ for all values of _δ_ .


This first condition guarantees two things: first, that
two-level Landau-Zener physics occurs at _δ_ = _δ⋆_, as the
bulk ground state _|ψ_ 0 _⟩_ and the last site _|Sα⟩_ are energetically well-separated from higher excited eigenstates
of _Htb_ . This ensures that at _δ_ = _δ⋆_, the gap is given
by the Bixon-Jortner coupling _tα_ 1 _⟨ψ_ 0 _|Sα_ 1 _⟩_ _._ Second,

_−_ _−_
it guarantees that the avoided level crossing at _δ_ = _δ⋆_ is
the _minimum_ gap, as the gap for _δ < δ⋆_, ∆bulk, is larger
than Eq. (E5).
∆QAA is thus quadratically smaller than the classical
Markov Chain runtime lower bounds up to polynomial
factors in _n_ when a second condition holds:


2. _⟨ψ_ 0 _|Sα−_ 1 _⟩_ is, at least, polynomially small in 1 _/n_ .


This condition guarantees that the magnitude of the
Bixon-Jortner matrix coupling ∆QAA = _tα_ 1 _⟨ψ_ 0 _|Sα_ 1 _⟩_

_−_ _−_
at _δ⋆_ is set by _tα−_ 1 and not by localization of _|ψ_ 0 _⟩_ at sites
other than _|Sα−_ 1 _⟩_ . Therefore, it is sufficient to show that
_|ψ_ 0 _⟩_ at _δ⋆_ has at least polynomial in _n_ overlap near the
( _α −_ 1)st site in the chain. If both of these conditions
hold, ∆ _[−]_ QAA [1] [is quadratically enhanced over the inverse]
of the classical Markov chain runtime up to polynomial
factors in _n_ .
We show next that both of these conditions are met under motivated assumptions about the couplings _tb_ . We
numerically analyze hundreds of hard Maximum Independent Set instances on large graphs (from 460 to 720
vertices). Our numerical investigations of the couplings
_tb_ reveal that while the specifics of the couplings vary
from instance to instance, _in the bulk_ they can, empirically, be well-described by a smooth function of the site
index _b_ along the tight-binding chain. Note that this condition often breaks down at the interface between the _α_
and _α_ _−_ 1 because _tα−_ 1 is exponentially small in _[√]_ ~~_n_~~ ~~,~~ but
we have crucially split that term from the bulk. In passing we note that the normalized couplings, _t_ ( _x_ ) _≡_ _tb/α_



29


appears to converge to a near-universal curve across hundreds of instances as a function of _x_ = _b/α_ for small to
intermediate 0 _< x <_ 0 _._ 5, and as ~~_√_~~ 1 ~~_α_~~ for small _x_ (one can
easily check this for the _x_ = 1 _/α_ case). The normalized
couplings peak at a constant value _≃_ 0 _._ 69 before displaying instance-to-instance variation as they become small
for _x →_ 1, as displayed in Fig. 12(a).
Motivated by these numerical observations, we now
state constraints on the couplings that imply both conditions are satisfied.


**Theorem 6.** _Assume that the couplings tb for b_ =
0 _, . . ., α −_ 1 _are a smooth, weakly concave function t_ ( _x_ )
_of x_ = _αb_ _[, that][ t]_ [(1)] _[ →]_ [0] _[ as]_ _n_ 1 _[γ]_ _[for some][ γ >]_ [ 0] _[, and]_

- 1
0 _[t]_ [(] _[x]_ [)] _[−]_ [1] _[/]_ [2] _[dx][ is at most polynomially large in the sys-]_
_tem size n. Furthermore, assume δ⋆_ _is sufficiently large_
_such that V_ ( _x_ ) = _−δx −_ 2 _t_ ( _x_ ) + _α_ 1 [2] _[∂]_ _x_ [2] _[t]_ [(] _[x]_ [)] _[ is locally min-]_
_imized for_ 1 _−_ [1]

_α_ _[< x <]_ [ 1] _[. Then both conditions (1) and]_
_(2) hold._


_Proof._ We appeal to the continuum limit of _H_ bulk, taken
as the system size _n →∞_ . This is equivalent to taking the largest independent set size _α →∞_, since for
the unit-disk graphs embedded on a two-dimensional lattice with constant filling fraction, _α_ is proportional to
_n_ . We can take _H_ bulk to the continuum limit because
we assumed that the couplings _tb_ are a smooth function of the site _x_ . The new continuum, time-independent
Schrodinger equation for the eigenstates _ψ_ ( _x_ ) in the bulk
is, for arbitrary _δ_,

  -   
_−_ _α_ [1][2] _[∂][x][t]_ [(] _[x]_ [)] _[∂][x]_ [ +] _[ V]_ [ (] _[x]_ [)] _ψ_ ( _x_ ) = _εψ_ ( _x_ ) _,_ (E6)


where _V_ ( _x_ ) = _−δx −_ 2 _t_ ( _x_ ) + _α_ 1 [2] _[∂]_ _x_ [2] _[t]_ [(] _[x]_ [) and] _[ ε]_ [ is the en-]
ergy density (energy normalized by _α_ ). Note that the
site-dependent couplings have two major contributions.
First, they induce a _position-dependent mass_ going as
_α_ [2]
_m_ ( _x_ ) =
_t_ ( _x_ ) [, which imposes a metric on the chain. Sec-]
ond, the couplings induce a potential energy given by

_−_ 2 _t_ ( _x_ ). The term that goes as the second derivative in
the couplings is kept as it may grow with _n_ when _t_ ( _x_ )
goes to zero at the boundaries _x_ = 0 _,_ 1. Away from
the boundaries of the bulk, this second derivative term
is negligible as _α →∞_ . In Fig. 11(c), we visualize _t_ ( _x_ )
and _m_ ( _x_ ) for an example unit-disk graph instance with
_n_ = 720 vertices. We plot the corresponding potential
_V_ ( _x_ ), neglecting the second derivative term, in Fig. 11(d)
for _δ_ = 0 and _δ_ = _δ⋆._
We can arrive at a more conventional positionindependent problem by performing two similarity transforms. The first is a point canonical transformation,




   - _x_
_u_ ( _x_ ) =

0



1

_dy,_ (E7)

~~�~~ _t_ ( _y_ )



which transforms the position dependent mass term into
a position independent kinetic term: _∂xt_ ( _x_ ) _∂x →_ _∂u_ [2][. We]
then employ the standard integrating factor to remove


30


FIG. 12. Parameters of the one-dimensional tight-binding Hamiltonian. (a) We show the mean couplings _t_ ( _x_ ) generated from
229 unique 720-vertex unit-disk graph instances with largest independent set size _α_ = 217. Error bars give the maximum and
minimum coupling over all instances. _t_ ( _x_ ) is well-described by a smooth function with universal behavior for _x_ ≲ 0 _._ 3. There
are significant instance-by-instance variations in the couplings as _x →_ 1 _._ We find that the mean couplings _t_ ( _x_ ) are well-fit to
the functional form _y_ = 1 _._ 80(1) ~~_[√]_~~ ~~_x_~~ (1 _−_ _x_ ) [1] _[.]_ [04(1)] (black line). (b) The mean value of _u_ (1) = �01 _[t]_ [(] _[y]_ [)] _[−]_ [1] _[/]_ [2] _[dy]_ [ grows polynomially]
with the system size _n_ . As a result, the gap of _H_ bulk vanishes at most polynomially in 1 _/n._ Error bars give the maximum and
minimum value of _u_ (1) over 1000 instances for each system size.



terms that are first order in the spatial derivative, leading
to a typical Schrodinger problem: - _−_ _α_ [1][2] _[∂]_ _u_ [2][+] _[U]_ [(] _[u]_ [)] - _ψ_ ( _u_ ) =

_εψ_ ( _u_ ), for a doubly-transformed effective potential _U_ ( _x_ ).
The similarity transformations do not alter the smoothness nor the convexity of the original potential. Moreover, the contributions from _α_ 1 [2] _[∂]_ _x_ [2] _[t]_ [(] _[x]_ [) do not change the]
convexity of the potential. As such, the effective potential _U_ meets the weak convexity criterion stipulated in
Andrews and Clutterbucks’ proof of the fundamental gap
conjecture for one-dimensional systems [71]. Therefore,
we can apply the fundamental gap conjecture to bound
∆bulk for all _δ_ as



3 _π_ [2]
∆bulk _≥_ ( _αu_ (1)) [2] _[.]_ (E8)



near the site corresponding to _|Sα−_ 1 _⟩_ . This validates the
second condition of our argument. As a result, we have
shown that in the _λ →∞_ limit, ∆ _[−]_ QAA [1] [is quadratically]
smaller than the classical Markov chain runtime lower
bounds.


_a._ _Numerical justification_


By examining 1000 unit-disk Maximum Independent
Set problem instances for each system size between 460
and 720 vertices, in Fig. 12(a) we find a simple qualita1
tive model for _t_ ( _x_ ) is given by _t_ ( _x_ ) = _Ax_ 2 (1 _−_ _x_ ) _[c]_ . The
factor of [1]

2 [encodes the exact scaling as] _[ x][ →]_ [0 and the fit]
parameter _c_ accounts for instance-to-instance variations
as _x →_ 1. We find that the fitted values of _c_ fall between _c ∈{_ 1 _._ 03 _,_ 1 _._ 09 _}_ across different instances, leading
to appropriate conditions for _t_ ( _x_ ) such that _u_ (1) is only
polynomially large in _n_ . We confirm numerically that
_u_ (1) grows approximately linearly with _n_ in Fig. 12(b).
Thus, our numerical results confirm that ∆bulk is at worst
polynomially small in 1 _/n_, under the assumption of the
validity of our continuum analysis. Therefore, it is welljustified to focus on the resonant level crossing between
the last site and the ground state of the bulk only to
determine ∆QAA.
This numerical evidence also supports our assumption
about _V_ ( _x_ ) being locally minimized for 1 _−_ [1]

_α_ _[< x <]_ [ 1.]
One might worry that the diverging mass near the edges
of the tight-binding model causes the bulk ground state
wavefunction to be classically forbidden from penetrating
the region of the penultimate site on the chain. Indeed,
by solving Eq. (E6) for the ground state with energy density _−δ_ and using the WKB approximation, one notices
that there are two classically forbidden regimes: from
smaller _x_ due to the an increase in the potential, and at
_x →_ 1 due to terms originating from the diverging mass



Thus, as long as the couplings can be well-described by
a smooth _t_ ( _x_ ) and _u_ (1) grows at most polynomially in _n_,
∆bulk is polynomially small in 1 _/n_ . This proves our first
condition.
To validate our second condition – that the ground
state of the bulk is localized around the penultimate site
on the chain – we provide a semi-classical argument. Note
that the semi-classical approximation is well-justified in
the limit of large system sizes _α →∞_ as the effective
_α_ [2]
mass _m_ ( _x_ ) =
_t_ ( _x_ ) [, diverges at the edges (equivalently,]
_t_ ( _x_ ) _→_ 0). The resonance condition implies that the
ground state energy density of the bulk, _ε_, at the crossing is _−δ⋆_ . The classical minimum of the potential approaches the edge of the chain in the regime of _δ_ = _δ⋆_ .
As shown in Fig. 11(d), for _δ_ = _δ⋆_, in order to minimize
energy, the particle seeks to lower its potential due to the
electric field gradient versus the potential due to tunneling. As the semi-classical expectation becomes exact in
the limit of an infinite mass, the particle localizes near
the edge where the classical minimum of the potential
lies. Thus, within an asymptotically exact semi-classical
argument, the ground-state of the bulk should localize


(e.g. terms proportional to [ _∂x_ [2] _[t]_ [(] _[x]_ [)]] _[/t]_ [(] _[x]_ [)). However, the]
latter classically forbidden regime, following the qualitative model for _t_ ( _x_ ) = _Ax_ [1] _[/]_ [2] (1 _−x_ ) _[c]_, occurs for _x >_ 1 _−_ _[c]_

2 _α_ [,]
where _c_ is numerically fitted to be within 1 _._ 03 and 1 _._ 09.
This suggests that the classically forbidden regime occurs
within the penultimate site, which occupies 1 _−_ [1]

_α_ _[< x <]_ [ 1]
on the continuum, which can be seen by simply inverting
the mapping from the continuum back to discrete sites
on a chain. Thus our numerics also strongly suggest that
the wavefunction is localized around _|Sα−_ 1 _⟩_, such that
_⟨ψ_ 0 _|Sα−_ 1 _⟩_ is sufficiently large and ∆QAA = _tα−_ 1, up to
polynomial factors in _n_ .


_b._ _Optimizing the modified QAA_



For QAA to achieve a runtime which scales as ∆ _[−]_ QAA [1]
in practice, the algorithm schedule (Ω( _t_ ) _, δ_ ( _t_ )) must be
optimized so that its parameters change slowly near the
location of the avoided level crossing (see Fig. 3(a), main
text). In particular, by choosing _|dH/dt| ∝_ ∆ [2] QAA [within]
a _O_ (∆QAA) interval around the location of the minimum
gap, the total QAA runtime is _O_ (∆ _[−]_ QAA [1] [) [][11][]. It is there-]
fore useful to be able to estimate the location of the
avoided crossing, so that the algorithm schedule can be
optimized. Techniques to optimize QAA are a subject of
active research, and recent work indicates that it is possible to optimize QAA on a wide class of disordered cost
Hamiltonians when using the reflection about the uniform superposition state, 1 _−_ [1] _[n]_ - _[′][ |][z][⟩⟨][z][′][|]_ [, to drive the]



form superposition state, 1 _−_ 2 [1] _[n]_ - _z,z_ _[′][ |][z][⟩⟨][z][′][|]_ [, to drive the]

evolution, instead of _Hq_ [41]. Here we describe a simple
way to optimize the modified QAA when _λ →∞_, which
achieves a total runtime, including optimization, that is
asymptotically smaller than the SA runtime _O_ (∆ _[−]_ QAA [2] [).]
The full quadratic speedup, with runtime _O_ (∆ _[−]_ QAA [1] [), is]
recovered if quantum phase estimation is used as a subroutine in optimizing the QAA. A partial speedup, with
runtime _O_ (∆QAA _[−]_ [10] _[/]_ [7][), is obtained if only projective mea-]
surements in the _σz_ and _σx_ bases are used. We leave the
optimization of the modified QAA at arbtitrary _λ_ as a
subject of future research, possibly by generalizing the
results of Ref. [41].
Our arguments follow from Appendix E 1, whose results we summarize here. When _λ →∞_, the QAA system
Hamiltonian simplifies to an effective one-dimensional
tight-binding Hamiltonian _Htb_ [Eq. (18)]. The sites of
_Htb_ correspond to the uniform superpositions of each
independent set size, _{|Sb⟩}_ ( _b_ = 0 _,_ 1 _, . . ., α_ ). Suppose
the Ω _α_ �f _D_ nal coupli _α/Dα−_ 1, is small compared to all other couplings.ng between _|Sα−_ 1 _⟩_ and _|Sα⟩_, equal to

Then, this coupling can be treated perturbatively, and
the system is described by a Bixon-Jortner model [70].
Let us take Ω= 1 and consider the system ground state
as a function of _δ_, as visualized in Fig 11(b). At _δ < δ⋆_,
where _δ⋆_ denotes the location of the avoided crossing,
the system ground state is the ground state _|ψ_ 0 _⟩_ of a restricted Hamiltonian _H_ bulk, which includes all sites up



31


to _|Sα−_ 1 _⟩_ . The avoided level crossing occurs when the
energy _E_ 0( _δ_ ) of _|ψ_ 0 _⟩_ is resonant with the energy _−δα_ of
last site of the chain, _|Sα⟩_ . Thus, the avoided crossing
occurs when _E_ 0( _δ⋆_ ) = _−δ⋆α_ to high _O_ (∆ [2] QAA [) accuracy]
by the arguments of Appendix E 1. For _δ > δ⋆_, _|ψ_ 0 _⟩_ is
the first excited state of _Htb_ .
Therefore, if one can estimate ground state energy _E_ 0
of _H_ bulk, and compare its value to the resonance condition _E_ 0( _δ⋆_ ) = _−δ⋆α_, one can estimate _δ⋆_ . Because
QAA can prepare _|ψ_ 0 _⟩_ efficiently, finding _E_ 0 is computationally simple. Note that this is _distinct_ from generically finding the ground state of the system Hamiltonian _Htb_ . In particular, suppose we run QAA for time
_T_ with a linear schedule for _δ_ ( _t_ ), stopping the evolution at the desired value of _δ_ . The precise choice of _T_ is
algorithm-dependent and discussed below, but we always
choose 1 _/T_ to be much less than 1 _/_ ∆ [2] bulk [, where ∆][bulk][ is]
the minimum gap of _H_ bulk, but larger than ∆QAA. Because _T_ _[−]_ [1] _[/]_ [2] is small compared to the energy difference
between the first and second excited state, this schedule
should remain adiabatic with respect to all but the smallest gap ∆QAA. This schedule is still highly diabatic with
respect to ∆QAA, however, for which an instantaneous
ramp speed _∝_ ∆ [2] QAA [is needed to maintain adiabaticity.]
When the QAA evolution is stopped at _δ < δ⋆_, the state
thus prepared by QAA will therefore have high overlap
with the ground state of _Htb_ (and thus _H_ bulk), while for
_δ > δ⋆_ it will have high overlap with the first excited state
of _Htb_ (thus the ground state of _H_ bulk). In particular, for
all values of _δ_, because of the chosen ramp time, the prepared wavefunction will have unit amplitude in _|ψ_ 0 _⟩_, up
to small corrections from all other instantaneous eigenstates of _Htb_, which contribute small errors to the energy
of the state.
Therefore _|ψ_ 0 _⟩_ can be prepared using QAA, and one
can measure its energy with error _ε_ in time _ε_ _[−][γ]_ . The
value of _γ_ depends on the method used to compute the
energy: _γ_ = 1 using quantum phase estimation [72], and
_γ_ = 5 _/_ 2 using projective measurements in the _σz_ and
_σx_ bases. The value of 5 _/_ 2 is the combined result of
shot noise and the time required for a single QAA run.
In particular, with a _N_ runs of time _T_ each, we expect
shot noise at the level of _O_ ( _N_ _[−]_ [1] _[/]_ [2] ) and nonadiabatic
corrections to _E_ 0 at the level of _O_ ( _T_ _[−]_ [2] ) [73]. To make
both of these _O_ ( _ε_ ) one can choose _T_ = _ε_ _[−]_ [1] _[/]_ [2] _, N_ = _ε_ _[−]_ [2],
for a total time of _ε_ _[−]_ [5] _[/]_ [2] . Because quantum phase estimation does not require repeated runs, we can simply
choose _T_ = ∆ _[−]_ QAA [1] [so that nonadiabatic corrections of]
order _T_ _[−]_ [2] = _O_ (∆ [2] QAA [) are negligible, and still retain]
_γ_ = 1.
Our procedure in Algorithm 1 thus uses binary search
to efficiently find _δ⋆_ by minimizing the absolute value
of the prepared energy of _|ψ_ 0 _⟩_ minus _−δα_ . In particular, we use this procedure to estimate _δ⋆_ to some finite,
high accuracy depending on _γ_ . We find that it is optimal to estimate _δ⋆_ to _O_ (∆ [2] QAA _[/]_ [(1+] _[γ]_ [)] ) accuracy. We then
run the modified QAA using an optimized schedule with
runtime _O_ (∆ _[−]_ QAA [1] [), as in Ref. [][11][], for candidate guesses]




[1]  
2 _[n]_


**Algorithm 1:** Optimizing the modifed QAA

**Data:** A subroutine that estimates _E_ 0( _δ_ ) with error _ε_
in time _ε_ _[−][γ]_, for _δ < δ⋆._ An initial guess _r_ for
the ratio _Dα−_ 1 _/Dα,_ and a scale factor _k >_ 1
with which we will increase _r_ by during each
iteration of the optimization.
**while** _An independent set of size α has not been found_
_using the modified QAA._ **do**

_r ←_ _kr_
Use subroutine to constrain _δ⋆_ to an _O_ ( _r_ _[−]_ [1] _[/]_ [(1+] _[γ]_ [)] )
interval in time _O_ ( _r_ _[γ/]_ [(1+] _[γ]_ [)] ). Draw _r_ [1] _[/]_ [2] _[−]_ [1] _[/]_ [(1+] _[γ]_ [)]

regularly spaced guesses for _δ⋆_ from this interval.
**for** _each guess for δ⋆_ _in the O_ ( _r_ _[−]_ [1] _[/]_ [(1+] _[γ]_ [)] ) _interval,_
_in O_ ( _r_ _[−]_ [1] _[/]_ [2] ) _increments_ **do**

Run the modified QAA in time _O_ ( _r_ [1] _[/]_ [2] ) using a
schedule that slows down at the current guess
of _δ⋆_, such that _|dH/dt| ∝_ 1 _/r_ in an _O_ ( _r_ _[−]_ [1] _[/]_ [2] )
range of the guess for _δ⋆_ .
**end**
**end**


of _δ⋆_ within this range of possible values. By using a grid
search for _δ⋆_, the optimal solution can be found with a
speedup for any _γ >_ 0. The total runtime of Algorithm 1
is _O_ (∆QAA _[−]_ [2] _[γ/]_ [(1+] _[γ]_ [)] ), which results in a speedup over SA
for any _γ >_ 0, because the SA runtime is _O_ (∆ _[−]_ QAA [2] [).]
This runtime is the result of a compromise between measurement time, which improves the precision with which
_δ⋆_ is known, and the time spent grid searching for _δ⋆_
using QAA with an optimized schedule. In particular,
if a time ∆QAA _[−]_ [2] _[γ/]_ [(1+] _[γ]_ [)] is spent measuring _δ⋆_ to accuracy

_O_ (∆QAA [2] _[/]_ [(1+] _[γ]_ [)] ), one wins a factor of _O_ (∆QAA [2] _[/]_ [(1+] _[γ]_ [)] ) in runtime
relative to the _O_ (∆ _[−]_ QAA [2] [) time that is required when grid]
searching for _δ⋆_ with _no_ knowledge of _δ⋆_ . As a result, a
total time of _O_ (∆QAA _[−]_ [2] _[γ/]_ [(1+] _[γ]_ [)] ) is also spent grid searching
for _δ⋆_ .
Note that in practice, one does not know ∆QAA _a pri-_
_ori_, and must therefore search for this as well. This is
done efficiently in Algorithm 1 through a grid search on
an exponentially spaced grid. Finally, we note that the
two methods discussed above (phase estimation and projective measurements) are only suggestions for the subroutine required by Algorithm 1. Any method (quantum
or classical) which can estimate _E_ 0( _δ_ ) to error _ε_ in time
_ε_ _[−][γ]_ would suffice.


**2.** **Finite** _λ_ **case**


_a._ _Numerical observations_


Here we extend the arguments for a quadratic speedup
in Appendix E 1 to the case where _λ_ is finite. We first
numerically compare the runtime of the modified QAA at
finite _λ_ and the unmodified QAA ( _λ_ = 0) for the top 1%
hardest instances of each system size, up to _n_ = 80. To



32


compute ∆QAA for each instance and setting of _λ_, we use
the ITensor implementation [50] of DMRG to find matrix
product state representations of the ground and first excited state with bond dimension of up to 1500. We consider the system converged to its true ground state _|ψ_ 0 _⟩_
once the truncation error falls below a threshold value of
10 _[−]_ [8] . In practice, this criterion is typically satisfied after
_O_ (10 [2] ) sweeps. Once _|ψ_ 0 _⟩_ is obtained, we compute the
first excited state by repeating this procedure but with
the Hamiltonian _H_ _[′]_ = _H_ + _V |ψ_ 0 _⟩⟨ψ_ 0 _|_, where _V_ = 10 is an
energy penalty that ensures that the ground state of _H_ _[′]_

has negligible overlap with _|ψ_ 0 _⟩_ . We then minimize the
corresponding energy gap between the ground and first
excited state over Ω _/δ_ to obtain ∆QAA, using a large energy penalty _U_ = 100 on independent set violations [see
Eq. (1)].
We display the numerical results in Fig. 13(a). We observe that for _λ_ = 5, ∆ _[−]_ QAA [1] [is proportional to the square]
root of the SA runtime lower bound (the light blue data
points are parallel to the line _y_ = _[√]_ ~~_x_~~ ~~)~~ . Furthermore,
setting _λ_ = 1 is sufficient to obtain a speedup on the
vast majority of instances (medium blue data points). In
both cases, the modified QAA vastly outperforms the unmodified QAA ( _λ_ = 0, dark blue points). The fact that
the unmodified QAA does not frequently outperform SA
suggests that typical instances of the unmodified QAA
do not have favorable localization or delocalization in
the ground and first excited eigenstates at the avoided
level crossing, which would ensure a speedup over SA.
Thus, the modification to QAA appears crucial to obtain a speedup over SA on these instances.
To support these numerical observations, in the following section we further obtain analytic conditions that
are sufficient, albeit not necessary, to guarantee the
quadratic speedup, up to subleading polynomial factors
in _n_ . As in Appendix E 1, we focus on instances where
the smallest coupling is between the largest independent sets of size _α_ and suboptimal independent sets of
size _α −_ 1, which was overwhelmingly the most common case for the instances studied in Appendix B. We
then show that when ∆QAA _≃_ Ω _α_ - _Dα/Dα−_ 1 in the

_λ →∞_ case, the same conditions hold for for finite
_λ/_ Ω _, λ/δ_ ≳ ∆ _[−]_ _ℓ,α_ [1] _[,]_ [ ∆] _[−]_ _ℓ,α_ [1] 1 [, where ∆] _[ℓ,b]_ [ is the spectral gap]

_−_
of the Laplacian Hamiltonian _Hℓ_ when restricted to independent sets of size _b_ . To obtain the speedup in practice,
it is necessary that the scaling advantage is maintained
when the Hamiltonian energy scales are normalized in
units of _λ_ . By dividing the energy scales of the Hamiltonian by _λ_, one can see that this is equivalent to the
condition that _λ_ ∆ _[−]_ QAA [1] [is quadratically smaller than the]
classical Markov chain runtime lower bounds, up to subleading polynomial factors in _n_, where ∆QAA is the minimum gap in units of Ω. Thus, the speedup is obtained
when ∆ _[−]_ _ℓ,α_ [1] _[,]_ [ ∆] _[−]_ _ℓ,α_ [1] 1 [grow at most polynomially in] _[ n]_ [. In]

_−_
practice, we find that ∆ _[−]_ _ℓ,α_ [1] 1 _[≥]_ [∆] _ℓ,α_ _[−]_ [1] [, so ∆] _[ℓ,α][−]_ [1][ deter-]

_−_
mines the strength of _λ_ sufficient for ensuring delocalization.
Figure 13(b) shows the scaling of ∆ _ℓ,α−_ 1 as a function


33


FIG. 13. Modified QAA runtime at finite _λ_ . (a) The modified QAA runtime for _λ_ = 5 scales as the square root of the SA
runtime for the top 1% hardest instances of each system size up to _n_ = 80 (light blue points). The speedup is also observed for
the vast majority of instances for _λ_ = 1 (medium blue points). In both cases, the modified QAA significantly outperforms the
unmodified QAA ( _λ_ = 0, dark blue points). (b) For the top 5% hardest instances of each system size up to _n_ = 135, ∆ _ℓ,α−_ 1
is generally larger than 1 _/n_ . The box endpoints mark the 25th and 75th percentiles, and the box midpoint marks the 50th
percentile. We omit data for eight instances for which computing ∆ _ℓ,α−_ 1 was too computationally expensive.



of _n_ for the top 5% hardest instances up to _n_ = 135 _._
We observe that ∆ _ℓ,α−_ 1 ≳ 1 _/n_ for the vast majority of
instances, consistent with polynomial scaling in _n_ . A minority of instances (24%) have ∆ _ℓ,α−_ 1 = 0 due to a very
small fraction (median 0 _._ 2%) of configurations disconnected by spin exchanges, leading to degenerate ground
states of _Hℓ_ in the manifold of independent sets of size
_α −_ 1. For these instances, we plot the spectral gap of
_Hℓ_ in the same manifold, restricted to the largest set of
configurations connected under spin exchanges. One can
see using perturbation theory that the smaller set(s) of
disconnected configurations do not change the dynamics
significantly, and the larger set determines the minimum
gap. At small Ω _/δ_, the QAA Hamiltonian will energetically favor the connected subspace with the smaller expectation value of _−_ (Ω [2] _/δ_ ) _Hse_ under perturbation theory. This corresponds to the larger connected subspace,
because the number of disconnected configurations in
practice is very small (and thus, so is its expectation in
_Hse_, which is upper-bounded by the maximum degree of
a vertex in the configuration graph). We emphasize that
the numerical results in Fig. 13(a) show that in practice,
much smaller values of _λ_ may be necessary to obtain the
speedup, depending on the graph instance. All instances
obtain a speedup for either _λ_ = 1 or _λ_ = 5, which is
smaller than ∆ _[−]_ _ℓ,α_ [1] 1 _[.]_ [ This shows that while our condition]

_−_
is sufficient to obtain the speedup, it is not necessary in
general.


Finally, it is interesting to note the connection between
the gap ∆ _ℓ,b−_ 1 and the time needed for SA to sample
from the equilibrium Gibbs distribution, restricted to a
manifold of independent sets of the same size. This corresponds to SA sampling uniformly among independent
sets of the same size. Consider an SA algorithm that
only uses spin-exchange updates to explore independent



sets of the same size (of course, this SA algorithm is
only ergodic among independent sets of the same size,
assuming all configurations can be connected via spin
exchanges). One can check that _Hℓ_ is identical to the
transition matrix used by SA, up to an overall rescaling
and multiple of the identity. Thus, ∆ _ℓ,b_ sets the mixing
time for SA to sample from the uniform distribution in
that manifold. This idea can be generalized: consider an
SA algorithm now using both spin-exchange and spinflip updates. Again, the matrices within a manifold are
identical up to rescaling when restricted to maximal independent sets (independent sets to which no vertices
can be added without removing an existing vertex). The
fraction of maximal independent sets is approximated by
the quantity 1 _−_ _[nD][b]_

_Db−_ 1 [, which is close to one on instances]
with a large SA runtime lower bound. Thus, _Hℓ_ and the
SA transition matrix are near-identical, up to rescaling.
As a result, ∆ _[−]_ _ℓ,b_ [1] [sets the equilibration time to uniformly]
sample independent sets within that manifold. SA will
thus need _O_ (∆ _[−]_ _ℓ,α_ [1] 1 [) updates to converge to uniformly]

_−_
sample independent sets for the _α −_ 1 manifold. Because
this quantity is polynomial in _n_, SA rapidly mixes within
the _α −_ 1 manifold. The same is true of the manifold of
independent sets of size _α_, because ∆ _[−]_ _ℓ,α_ [1] 1 _[≥]_ [∆] _ℓ,α_ _[−]_ [1] [. Thus,]

_−_
we expect the SA runtime _τ_ SA( _ε_ ) is set by the time to find
an optimal solution, which is exponential in _[√]_ ~~_n_~~ ~~,~~ rather
than the time to equilibrate within a manifold of independent sets of the same size. This is consistent with the
numerical results in Fig. 2, which put together, suggests
that _τ_ SA( _ε_ ) is a good proxy for the SA time to find an
optimal solution.


_b._ _Sufficient analytic conditions for the speedup_


We now show that ∆QAA _≃_ Ω _α_ ~~�~~ _Dα/Dα−_ 1 for fi
nite _λ/δ, λ/_ Ω ≳ ∆ _[−]_ _ℓ,α_ [1] _[,]_ [ ∆] _[−]_ _ℓ,α_ [1] 1 [.] To this end, we will

_−_
use the resolvent formalism developed in Appendix C 1,
and let _|G⟩_ = _|Sα⟩_ _, |E⟩_ = _|Sα−_ 1 _⟩_ . When _λ/δ, λ/_ Ω ≳
∆ _ℓ,α_ _[−]_ [1] _[,]_ [ ∆] _[−]_ _ℓ,α_ [1] 1 [, we expect these states to have significant]

_−_
overlap with the ground and first-excited state of _H_ QAA
at (Ω _/δ_ ) _⋆_ . As a result,


˜∆QAA = 2 _| ⟨E| H_ eff ( _E⋆_ ) _|G⟩|_ (E9)


_Q_
= 2 _−⟨E| Hq |G⟩_ + _⟨E| HqQ_
���� _E⋆_ _−_ _QHQ_ _[QH][q][ |G⟩]_ ����



34


is a good estimator of ∆QAA (see Appendix C 2), where
_H_ = _H_ cost _−_ _Hq_ + _λHℓ_ is the modified QAA Hamiltonian. The frst term of this expression is the coupling

_−_ Ω _α_ ~~�~~ _Dα/Dα−_ 1 from the _λ →∞_ limit, which is re
sponsible for the quadratic speedup. To argue that the
speedup is maintained at finite _λ_, it remains to argue
that the second term does not cancel with the first to
reduce the gap. We do this by analyzing the dependence
of this second term on _λ_ .


We first simplify the second term. Let _|G⟩_ [˜] = 1
_α_ Ω _[H][q][ |G⟩]_ [,]
where the _α_ Ωfactor is used to make _⟨G|_ [˜] _G⟩≃_ [˜] 1. Note that
_|G⟩_ [˜] has support only on independent sets of size _α −_ 1.
We now write the second term from Eq. (E9) as



_Q_ _Q_
_⟨E| HqQ_
_E⋆_ _−_ _QHQ_ _[QH][q][ |G⟩]_ [=] _[ α]_ [Ω] _[⟨E|][ H][q][Q]_ _E⋆_ _−_ _QHQ_ _[Q][ |][G⟩]_ [ ˜]

_Q_ _Q_
= _α_ Ω _⟨E| HqQ_
_E⋆_ _−_ _QHQ_ _[QH][q][Q]_ _E⋆_ _−_ _Q_ ( _H_ cost + _Hℓ_ ) _Q_ _[Q][ |][G⟩]_ [ ˜]

_Q_ _Q_
= _α_ Ω _⟨E| HqQ_ (E10)
_E⋆_ _−_ _QHQ_ _[QH][q][Q]_ _E⋆_ + _δ_ ( _α −_ 1) _−_ _QHℓQ_ _[Q][ |][G⟩]_ [ ˜]



where in the second line we used the Woodbury matrix
identity, and dropped a term which is unable to connect
_|G⟩_ [˜] to _|E⟩_ . Now, because we have taken _λ_ ∆ _ℓ,α_ 1 _≫_ Ω _, δ_,

_−_
we may make the approximation


_Q_
_ℓ_ _[|][G⟩]_ [ ˜] _[,]_ (E11)
_E⋆_ + _δ_ ( _α −_ 1) + _QHℓQ_ _[Q][ |][G⟩≈]_ [ ˜] _[H]_ [+]


where _Hℓ_ [+] denotes the Moore-Penrose pseudoinverse of
_Hℓ_, restricted to the space of sets of size _α −_ 1. Here we
rely on the fact that _E⋆_ + _δ_ ( _α −_ 1) = _O_ ( _δ_ ), as argued
in Appendix C 3 because the avoided level crossing happens at (Ω _/δ_ ) _⋆_ _≪_ 1. If the perturbative avoided level
crossing condition is not met, then the same conclusion
holds if we take _λ/δ, λ/_ Ω ≳ _n_ ∆ _[−]_ _ℓ,α_ [1] _[, n]_ [∆] _[−]_ _ℓ,α_ [1] 1 [, which in-]

_−_
troduces a subleading factor of _n_ to the runtime. We
note that this approximation neglects a term that is
_O_ (Ω _/_ [ _λ_ ∆ _ℓ,α−_ 1] _, δ/_ [ _λ_ ∆ _ℓ,α−_ 1]), which we will argue below
is subleading. The second term of Eq. (E9) thus reduces
to


_Q_
_⟨E| HqQ_
_E⋆_ _−_ _QHQ_ _[QH][q][ |G⟩]_

_Q_
= _α_ Ω _⟨E| HqQ_ _ℓ_ _[|][G⟩]_ [ ˜] _[.]_ (E12)
_E⋆_ _−_ _QHQ_ _[QH][q][H]_ [+]


The central point of our argument is that the factor of
_Hℓ_ [+][, which scales as] _[ O]_ [(1] _[/λ]_ [), ensures that the leading] _[ λ]_ [-]
dependence of this expression is _O_ (1 _/λ_ ). This will make
it impossible for the second term of Eq. (E9) to always



cancel exponentially with the first term. To see this, suppose for the sake of contradiction that for a specific value
of _λ_, the second term was equal to _α_ Ω� _Dα/Dα−_ 1(1+ _ε_ ),

for some exponentially small _ε_ (leading to a suppressed
gap in Eq. (E9) of order _α_ Ω� _Dα/Dα−_ 1 _ε_ ). Then, if

Eq. (E12) is _O_ (1 _/λ_ ), doubling _λ_ will yield a gap from
Eq. (E9) equal to _α_ Ω� _Dα/Dα−_ 1(1 _/_ 2 _−_ _ε/_ 2), which still

achieves the quadratic speedup, losing only a factor of
two.
It therefore remains to argue that Eq. (E12) decreases
with _λ_ as 1 _/λ_ or faster. Since _Hℓ_ [+] [scales as 1] _[/λ]_ [, the only]
way this could not be the case is if the _λ_ -dependence of
the denominator _E⋆_ _−_ _QHQ_ changes the scaling to be
slower than 1 _/λ_ . This would occur if there were a leading order _O_ (1 _/λ_ ) term in _E⋆_ _−_ _QHQ_ . However, since
we have chosen _|G⟩_ _, |E⟩_ to satisfy the overlap condition
of Theorem 5 in Appendix C, we know that the smallest eigenvalue of _QHQ −_ _E⋆_ is at least ( _E_ 2 _−_ _E⋆_ ), up to
polynomial factors in 1 _/n_, where _E_ 2 is the energy of the
second excited state of _H_ at the gap closing. In the limit
we are considering, by standard perturbation theory in
Ω _, δ/λ_, the leading (in particular, zeroth-order) contribution to _E_ 2 _−_ _E⋆_ will be independent of _λ_ . As a result,
the leading contribution to Eq. (E12) will be _O_ (1 _/λ_ ).
It is now also clear why the
_O_ (Ω _/_ [ _λ_ ∆ _ℓ,α−_ 1] _, δ/_ [ _λ_ ∆ _ℓ,α−_ 1]) term we dropped is
unimportant. By nearly identical arguments to the
above, this term will have a leading _O_ (1 _/λ_ [2] ) scaling,
which will not modify the overall argument that the
second term in Eq. (E9) cannot cancel with the first
term for generic values of _λ_ (due to the _λ_ -dependence of
the second term).


[1] S. Arora and B. Barak, _[Computational complexity: A](https://theory.cs.princeton.edu/complexity/book.pdf)_
_[modern approach](https://theory.cs.princeton.edu/complexity/book.pdf)_ (Cambridge University Press, 2016).

[[2] A. Montanaro, NPJ Quantum Inf.](https://doi.org/10.1038/npjqi.2015.23) **2**, 15023 (2016).

[[3] T. Albash and D. A. Lidar, Rev. Mod. Phys.](https://doi.org/10.1103/RevModPhys.90.015002) **90**, 015002
[(2018).](https://doi.org/10.1103/RevModPhys.90.015002)

[[4] D. J. Earl and M. W. Deem, Phys. Chem. Chem. Phys.](https://doi.org/10.1039%2Fb509983h)
**7** [, 3910 (2005).](https://doi.org/10.1039%2Fb509983h)

[5] E. Farhi, J. Goldstone, S. Gutmann, J. Lapan, A. Lundgren, and D. Preda, Science **[292](https://doi.org/10.1126/science.1057726)**, 472 (2001).

[[6] A. Lucas, Front. Phys.](https://doi.org/10.3389%2Ffphy.2014.00005) **2** (2014).

[[7] A. P. Young, S. Knysh, and V. N. Smelyanskiy, Phys.](https://link.aps.org/doi/10.1103/PhysRevLett.104.020502)
Rev. Lett. **[104](https://link.aps.org/doi/10.1103/PhysRevLett.104.020502)**, 020502 (2010).

[[8] M. Guidetti and A. P. Young, Phys. Rev. E](https://doi.org/10.1103%2Fphysreve.84.011102) **84** (2011).

[[9] I. Hen and A. P. Young, Phys. Rev. E](https://doi.org/10.1103%2Fphysreve.84.061152) **84** (2011).

[[10] E. Farhi, J. Goldstone, and S. Gutmann, arXiv:quant-](https://arxiv.org/abs/quant-ph/0201031)
[ph/0201031 [quant-ph] (2002).](https://arxiv.org/abs/quant-ph/0201031)

[[11] J. Roland and N. J. Cerf, Phys. Rev. A](https://doi.org/10.1103%2Fphysreva.65.042308) **65** (2002).

[[12] S. Muthukrishnan, T. Albash, and D. A. Lidar, Phys.](https://doi.org/10.1103/PhysRevX.6.031010)
Rev. X **6** [, 031010 (2016).](https://doi.org/10.1103/PhysRevX.6.031010)

[13] E. Crosson and A. W. Harrow, in _[57th Ann. IEEE](https://doi.org/10.1109/FOCS.2016.81)_
_[Sympm. on Founds. of Comp. Sci. (FOCS)](https://doi.org/10.1109/FOCS.2016.81)_ (2016) pp.
714–723.

[14] M. Szegedy, in _[45th Ann. IEEE Sympm. on Founds. of](https://doi.org/10.1109/FOCS.2004.53)_
_[Comp. Sci. (FOCS)](https://doi.org/10.1109/FOCS.2004.53)_ (2004) pp. 32–41.

[[15] R. D. Somma, S. Boixo, H. Barnum, and E. Knill, Phys.](https://doi.org/10.1103%2Fphysrevlett.101.130504)
[Rev. Lett.](https://doi.org/10.1103%2Fphysrevlett.101.130504) **101** (2008).

[[16] A. Montanaro, Proc. R. Soc. A: Math. Phys. Eng. Sci.](https://doi.org/10.1098/rspa.2015.0301)
**471** [, 20150301 (2015).](https://doi.org/10.1098/rspa.2015.0301)

[17] M. W. Johnson, M. H. S. Amin, S. Gildert, T. Lanting,
F. Hamze, N. Dickson, R. Harris, A. J. Berkley, J. Johansson, P. Bunyk, E. M. Chapple, C. Enderud, J. P.
Hilton, K. Karimi, E. Ladizinsky, N. Ladizinsky, T. Oh,
I. Perminov, C. Rich, M. C. Thom, E. Tolkacheva, C. J. S.
Truncik, S. Uchaikin, J. Wang, B. Wilson, and G. Rose,
Nature **473** [, 194 (2011).](https://doi.org/10.1038/nature10012)

[18] S. W. Shin, G. Smith, J. A. Smolin, and U. Vazirani,

[arXiv:1401.7087 [quant-ph] (2014).](https://arxiv.org/abs/1401.7087)

[19] T. F. Rønnow, Z. Wang, J. Job, S. Boixo, S. V. Isakov,
D. Wecker, J. M. Martinis, D. A. Lidar, and M. Troyer,
Science **[345](https://doi.org/10.1126/science.1252319)**, 420 (2014).

[20] S. Boixo, T. F. Rønnow, S. V. Isakov, Z. Wang,
D. Wecker, D. A. Lidar, J. M. Martinis, and M. Troyer,
Nat. Phys. **[10](https://doi.org/10.1038%2Fnphys2900)**, 218 (2014).

[21] H. G. Katzgraber, F. Hamze, Z. Zhu, A. J. Ochoa, and
H. Munoz-Bauza, Phys. Rev. X **5** [, 031026 (2015).](https://doi.org/10.1103/PhysRevX.5.031026)

[22] S. Boixo, V. N. Smelyanskiy, A. Shabani, S. V. Isakov,
M. Dykman, V. S. Denchev, M. H. Amin, A. Y. Smirnov,
[M. Mohseni, and H. Neven, Nat. Commun.](https://doi.org/10.1038/ncomms10327) **7**, 10327
[(2016).](https://doi.org/10.1038/ncomms10327)

[23] S. Ebadi, A. Keesling, M. Cain, T. T. Wang, H. Levine,
D. Bluvstein, G. Semeghini, A. Omran, J.-G. Liu,
R. Samajdar, X.-Z. Luo, B. Nash, X. Gao, B. Barak,
E. Farhi, S. Sachdev, N. Gemelke, L. Zhou, S. Choi,
H. Pichler, S.-T. Wang, M. Greiner, V. Vuleti´c, and
M. D. Lukin, Science **376** [, 1209 (2022).](https://doi.org/10.1126/science.abo6587)

[24] V. S. Denchev, S. Boixo, S. V. Isakov, N. Ding, R. Bab[bush, V. Smelyanskiy, J. Martinis, and H. Neven, Phys.](https://doi.org/10.1103/PhysRevX.6.031015)
Rev. X **6** [, 031015 (2016).](https://doi.org/10.1103/PhysRevX.6.031015)

[25] B. Altshuler, H. Krovi, and J. Roland, PNAS **[107](https://www.pnas.org/doi/abs/10.1073/pnas.1002116107)**, 12446
[(2010).](https://www.pnas.org/doi/abs/10.1073/pnas.1002116107)

[26] S. Lamm, P. Sanders, C. Schulz, D. Strash, and R. F.



35


Werneck, J. Heuristics **[23](https://doi.org/10.1007/s10732-017-9337-x)**, 207 (2017).

[27] D. Gu´ery-Odelin, A. Ruschhaupt, A. Kiely, E. Tor[rontegui, S. Mart´ınez-Garaot, and J. Muga, Rev. Mod.](https://doi.org/10.1103%2Frevmodphys.91.045001)
Phys. **[91](https://doi.org/10.1103%2Frevmodphys.91.045001)** (2019).

[[28] E. J. Crosson and D. A. Lidar, Nat. Rev. Phys.](https://doi.org/10.1038%2Fs42254-021-00313-6) **3**, 466
[(2021).](https://doi.org/10.1038%2Fs42254-021-00313-6)

[29] A. D. King, J. Raymond, T. Lanting, R. Harris, A. Zucca,
F. Altomare, A. J. Berkley, K. Boothby, S. Ejtemaee,
C. Enderud, E. Hoskinson, S. Huang, E. Ladizinsky,
A. J. R. MacDonald, G. Marsden, R. Molavi, T. Oh,
G. Poulin-Lamarre, M. Reis, C. Rich, Y. Sato, N. Tsai,
M. Volkmann, J. D. Whittaker, J. Yao, A. W. Sandvik,
and M. H. Amin, Nature **[617](https://doi.org/10.1038/s41586-023-05867-2)**, 61 (2023).

[30] B. F. Schiffer, D. S. Wild, N. Maskara, M. Cain, M. D.
[Lukin, and R. Samajdar, arXiv:2306.13131 [quant-ph]](https://arxiv.org/abs/2306.13131)
(2023).

[[31] B. Clark, C. Colbourn, and D. Johnson, Discrete Math.](https://doi.org/10.1016/0012-365X(90)90358-O)
**86** [, 165 (1990).](https://doi.org/10.1016/0012-365X(90)90358-O)

[32] H. Pichler, S.-T. Wang, L. Zhou, S. Choi, and M. D.
[Lukin, arXiv:1808.10816 [quant-ph] (2018).](https://arxiv.org/abs/1808.10816)

[33] N. Metropolis, A. W. Rosenbluth, M. N. Rosenbluth,
[A. H. Teller, and E. Teller, J. Chem. Phys.](https://doi.org/10.1063/1.1699114) **21**, 1087
[(1953).](https://doi.org/10.1063/1.1699114)

[34] W. K. Hastings, Biometrika **[57](https://doi.org/10.1093/biomet/57.1.97)**, 97 (1970).

[35] M. Znidariˇc, [ˇ] [Phys. Rev. A](https://doi.org/10.1103%2Fphysreva.71.062305) **71** (2005).

[36] The error _ε <_ 1 _/_ 2 is the total variation distance (equal
to half the _l_ 1 distance) between the Gibbs distribution
and the distribution prepared by SA.

[37] D. A. Levin, Y. Peres, E. L. Wilmer, J. G. Propp, and
D. B. Wilson, _[Markov chains and mixing times](https://pages.uoregon.edu/dlevin/MARKOV/markovmixing.pdf)_ (American Mathematical Society, 2017).

[[38] P. Diaconis and D. Stroock, The Annals of Applied Prob-](https://doi.org/10.1214/aoap/1177005980)
ability **[1](https://doi.org/10.1214/aoap/1177005980)**, 36 (1991).

[39] The SA and QMC runtime lower bounds in Eqs. (5)
and (19) assume that the independence polynomial of
the graph instance is unimodal, i.e., _D_ 0 _≤_ _D_ 1 _≤· · · ≤_
_Db_ _[⋆]_ _≥· · · ≥_ _Dα−_ 1 _≥_ _Dα_ for some _b_ _[⋆]_ . In Appendix B,
we study 24,000 unit disk graph instances with system
sizes of up to 720 vertices, and find that every instance
has a unimodal independence polynomial, which may be
of independent interest [67]. If the independence polynomial is not unimodal, then the same bounds apply, but
the maximum must be taken over all _b > b_ _[⋆]_, as in Appendix A.

[40] J.-G. Liu, X. Gao, M. Cain, M. D. Lukin, and S.-T.
[Wang, SIAM J. Sci. Comput.](https://doi.org/10.1137/22M1501787) **45**, A1239 (2023).

[41] M. Jarret, B. Lackey, A. Liu, and K. Wan,
[arXiv:1810.04686 [quant-ph] (2019).](https://arxiv.org/abs/1810.04686)

[42] Nonperturbative calculation of transition amplitudes, in

_[Atom-Photon Interactions](https://doi.org/https://doi.org/10.1002/9783527617197.ch3)_ (John Wiley & Sons, Ltd,
1998) Chap. 3, pp. 165–255.

[[43] M. H. S. Amin, Phys. Rev. Lett.](https://doi.org/10.1103%2Fphysrevlett.100.130503) **100** (2008).

[[44] M. H. S. Amin and V. Choi, Phys. Rev. A](https://doi.org/10.1103/PhysRevA.80.062326) **80**, 062326
[(2009).](https://doi.org/10.1103/PhysRevA.80.062326)

[[45] V. Choi, Quantum Inf. Process.](https://doi.org/10.1007/s11128-020-2582-1) **19**, 90 (2020).

[46] F. R. K. Chung, _[Spectral graph theory](https://mathweb.ucsd.edu/~fan/cbms.pdf)_, Vol. 92 (CBMS
Regional Conference Series in Mathematics, 1997).

[[47] N. G. Dickson and M. H. Amin, Phys. Rev. A](https://link.aps.org/doi/10.1103/PhysRevA.85.032303) **85**, 032303
[(2012).](https://link.aps.org/doi/10.1103/PhysRevA.85.032303)

[48] T. Lanting, A. D. King, B. Evert, and E. Hoskinson,

Phys. Rev. A **[96](https://link.aps.org/doi/10.1103/PhysRevA.96.042322)**, 042322 (2017).


[49] S. R. White, Phys. Rev. Lett. **[69](https://doi.org/10.1103/PhysRevLett.69.2863)**, 2863 (1992).

[[50] M. Fishman, S. White, and E. Stoudenmire, SciPost](https://doi.org/10.21468%2Fscipostphyscodeb.4)
[Phys. Codebases (2022).](https://doi.org/10.21468%2Fscipostphyscodeb.4)

[51] S. V. Isakov, G. Mazzola, V. N. Smelyanskiy, Z. Jiang,
[S. Boixo, H. Neven, and M. Troyer, Phys. Rev. Lett.](https://doi.org/10.1103%2Fphysrevlett.117.180402) **117**
[(2016).](https://doi.org/10.1103%2Fphysrevlett.117.180402)

[52] We include the factor of _M_ in the definition of _τ_ QMC( _ε_ )
to reflect the space-time complexity of a single QMC update. Because we allow our QMC update rule to modify
all _M_ Trotter slices, this complexity of _O_ ( _M_ ). Our results
are unchanged if the normalization factor on _τ_ QMC( _ε_ ) is
taken to be _n/m_ instead of _n/M_, where _m_ is the number
of Trotter slices modified during a single update.

[[53] D. S. Fran¸ca and R. Garc´ıa-Patr´on, Nat. Phys.](https://doi.org/10.1038/s41567-021-01356-3) **17**, 1221
[(2021).](https://doi.org/10.1038/s41567-021-01356-3)

[54] D. Bluvstein, H. Levine, G. Semeghini, T. T. Wang,
S. Ebadi, M. Kalinowski, A. Keesling, N. Maskara,
H. Pichler, M. Greiner, V. Vuleti´c, and M. D. Lukin,
Nature **604** [, 451 (2022).](https://doi.org/10.1038/s41586-022-04592-6)

[[55] A. Browaeys, D. Barredo, and T. Lahaye, J. Phys. B](https://doi.org/10.1088/0953-4075/49/15/152001) **49**,
[152001 (2016).](https://doi.org/10.1088/0953-4075/49/15/152001)

[56] A. Browaeys and T. Lahaye, Nat. Phys. **[16](https://doi.org/10.1038/s41567-019-0733-z)**, 132 (2020).

[57] M.-T. Nguyen, J.-G. Liu, J. Wurtz, M. D. Lukin, S.-T.
[Wang, and H. Pichler, Phys. Rev. X Quantum](https://link.aps.org/doi/10.1103/PRXQuantum.4.010316) **4**, 010316
[(2023).](https://link.aps.org/doi/10.1103/PRXQuantum.4.010316)

[[58] H. Krovi, M. Ozols, and J. Roland, Phys. Rev. A](https://doi.org/10.1103/PhysRevA.82.022333) **82**,
[022333 (2010).](https://doi.org/10.1103/PhysRevA.82.022333)

[59] M. B. Hastings, Quantum **5** [, 597 (2021).](https://doi.org/10.22331%2Fq-2021-12-06-597)



36


[[60] A. Gily´en and U. Vazirani, arXiv:2011.09495 [quant-ph]](https://arxiv.org/abs/2011.09495)

(2020).

[61] D. Gamarnik, PNAS **118** [, e2108492118 (2021).](https://www.pnas.org/doi/abs/10.1073/pnas.2108492118)

[62] E. Farhi, D. Gamarnik, and S. Gutmann,
[arXiv:2005.08747 [quant-ph] (2020).](https://arxiv.org/abs/2005.08747)

[63] H. Bernien, S. Schwartz, A. Keesling, H. Levine, A. Omran, H. Pichler, S. Choi, A. S. Zibrov, M. Endres,
[M. Greiner, V. Vuleti´c, and M. D. Lukin, Nature](https://doi.org/10.1038/nature24622) **551**,
[579 (2017).](https://doi.org/10.1038/nature24622)

[64] M. B. Hastings, Quantum **3** [, 201 (2019).](https://doi.org/10.22331%2Fq-2019-11-11-201)

[[65] Y. Peres and P. Sousi, arXiv:1108.0133 [math.PR] (2013).](https://arxiv.org/abs/1108.0133)

[[66] J. Houdayer, Eur. Phys. J. B](https://doi.org/10.1007%2Fpl00011151) **22**, 479 (2001).

[67] V. E. Levit and E. Mandrescu, in _[Proc. of the 1st Int.](http://www.yaroslavvb.com/papers/levit-independence.pdf)_
_[Conf. on Algebraic Inform.](http://www.yaroslavvb.com/papers/levit-independence.pdf)_ (2005).

[[68] F. V. Fomin and P. Kaski, Commun. ACM](https://doi.org/10.1145/2428556.2428575) **56**, 80–88
[(2013).](https://doi.org/10.1145/2428556.2428575)

[69] M. Werner, A. Garc´ıa-S´aez, and M. P. Estarellas,
[arXiv:2301.13861 [quant-ph] (2023).](https://arxiv.org/abs/2301.13861)

[70] E. J. Heller, _[The Semiclassical Way to Dynamics and](https://doi.org/10.2307/j.ctvc77gwd)_
_[Spectroscopy](https://doi.org/10.2307/j.ctvc77gwd)_ (Princeton University Press, 2018).

[[71] B. Andrews and J. Clutterbuck, J. Am. Math. Soc.](https://www.ams.org/journals/jams/2011-24-03/S0894-0347-2011-00699-1/S0894-0347-2011-00699-1.pdf) **24**
[(2011).](https://www.ams.org/journals/jams/2011-24-03/S0894-0347-2011-00699-1/S0894-0347-2011-00699-1.pdf)

[[72] A. Y. Kitaev, arXiv:quant-ph/9511026 [quant-ph] (1995).](https://arxiv.org/abs/quant-ph/9511026)

[73] C. D. Grandi and A. Polkovnikov, in _[Quantum Quench-](https://doi.org/10.1007%2F978-3-642-11470-0_4)_
_[ing, Annealing and Computation](https://doi.org/10.1007%2F978-3-642-11470-0_4)_ (Springer Berlin Heidelberg, 2010) pp. 75–114.


