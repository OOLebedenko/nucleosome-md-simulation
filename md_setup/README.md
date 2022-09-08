<div align="justify">

## MD setup:

### 1. Construction of nucleosome model

The initial NCP coordinates were constructed based on the crystallographic structure PDB:3LZ0. This template of NCP does
not contain the coordinates of all residues at the end of histone tails. We used the following multi-step protocol to model the
missing residues (see Fig. 1) :

1) clip histone tails from the original structure 3LZ0 according to H3:K39-R134, H4:N25, H2A:T16-K118, and H2B:E32-A121 (to "symmetrize" the pairs of histones)
2) generate free histone tails with `tleap` within Amber20 using force field ff14SB
3) rotate free histone tails to obtain linearly extended tail conformations
   (dihedral angles for each residue Φ=−60° and Ψ=150°).
4) glue free histone tails onto the body of the corresponding histone by superimposing N, Cα and C' atoms in the
   overlapping residues.
5) remove steric clashes between glued histone tails and surrounding nucleosomal DNA or histone cores. For
   this purpose, certain selected Φ and Ψ angles in rebuilt tails were set as in crystallographic structure with partial histone
   tail coordinates (PDB:1AOI). Those residues with adjusted Φ and Ψ are highlighted magenta in the plot below.
   
<p align="center">
  <img src="figures/md_model.png">
  <figcaption> Figure 1. The protocol for preparing the initial coordinates of the NCP with full-length histone tails.
                         The histone core residues taken from the original structure 3LZ0 are colored green. 
                         The rebuilt histone tail residues are colored yellow. 
                         The Φ,Ψ-adjusted residues are colored magenta
</p>

### 2. MD simulation
The NCP structure with linearly extended histone tails was protonated to match the experimental ph 7. The Na+ and Cl-
ions have been added to neutralize the system and to match 100 mM NaCl. The system was solvated with TIP4P-D water (12 Å
minimal separation between the NCP atoms and the boundary of the rectangular box). 

<span style="color:blue">*Note! This solvated system has already been prepared: [box.pdb (TIP4P-D water)](md_protocol/TIP4P-D/wt/01_equil_histone_tails/1_build) or [box.pdb (OPC water)](md_protocol/OPC/wt/01_equil_histone_tails/1_build).*</span>
We suggest that everyone uses these models as a starting point for their simulations (tails equilibration => re-solvation => production run)

After 100-ns initial run, all tails
adopted more compact conformations; at this point, the simulation was stopped and the system was re-solvated (rectangular
box with dimensions 197 Å, 241 Å and 138 Å). These box dimensions were estimated from the previously recorded MD
trajectories of the NCP totalling 41 μs ([Peng J, et al. (2021)](https://www.nature.com/articles/s41467-021-25568-6)). For this purpose, the MD trajectories were scanned searching for the most extended tail conformations (in x, y, and z dimensions). The found maximal dimensions were used to construct a new (more compact) simulation box. This box was then solvated (with tleap "closeness" parameter set to zero). This re-solvation algorithm significantly reduces the size of the water box, thus increasing the speed of the simulation. At the same time it virtually guarantees that NCP would not interact with its periodic images during the subsequent production run. The initial large box and the final reduced-size box are shown in Fig. 2.
   
The re-solvated configuration was used to start the production run. During the simulations, the equations
of motion were integrated using the leapfrog algorithm with a time step of 2 fs. Bonds involving hydrogen atoms were
constrained using SHAKE algorithm. The non-bonded interactions were calculated with cutoff of 10.5 Å, as recommended for
disordered proteins. Long-range interactions were treated using a particle-mesh Ewald summation scheme with default
parameters for grid spacing and spline interpolation. Constant pressure was maintained using Berendsen barostat with
relaxation time 2 ps. Bussi thermostat was used to stabilize temperature at 25°C. The same protocol was used for (Amber
ff14SB / OPC) simulation, including the size of the simulation cell that was identical to (Amber ff14SB / TIP4P-D)
trajectory.


<p align="center">
  <img src="figures/resolvated_box.png">
  <figcaption> Figure 2. The dimensions of simulation box which has been used before and after the equilibration of histone tails. 
                         The panel A illustrates the bigger initial box for simulation of the nucleosome with the fully 
                         extended histone tails (structure <a href="md_protocol/TIP4P-D/wt/01_equil_histone_tails/1_build">box.pdb (TIP4P-D water)</a>). 
                         The bigger box was constructed with the minimal separation of 12 Å between the NCP atoms 
                         and the boundary. The panel B illustrates the smaller box which is used for simulation of the nucleosome 
                         with collapsed histone tails after finishing the equilibration run (initial 100 ns). The dimensions of the smaller box 
                         were obtained from the previously published long MD trajectories of the nucleosome. 
</p>
</div>
