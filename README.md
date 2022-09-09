<div align="justify">

# MD simulation of nucleosome core particle (NCP)

This repository contains the scripts and data for setup and running MD simulation of nucleosome with full-length histone
tails

### System requirements

Key packages and programs:

- [Amber Molecular Dynamics Package](https://ambermd.org/) (>=20)
- [git-lfs](https://git-lfs.github.com/)

### Installation

```code-block:: bash
    # clone repo
    git lfs clone git@github.com:OOLebedenko/nucleosome_project.git
```

The TIP4P-D water is not the standard choice for MD simulations within the program Amber.
We provide the required frcmod and lib files for [TIP4P-D(leap parms)](md_setup/amber_parms/TIP4P-D/). 
You should copy these files into the standard Amber directories.

```code-block:: bash

    cp md_setup/amber_parms/TIP4P-D/leaprc.water.tip4pd $AMBERHOME/dat/leap/cmd/.
    cp md_setup/amber_parms/TIP4P-D/tip4pdbox.off $AMBERHOME/dat/leap/lib/.
    
```

### Run MD simulation
The initial model of NCP with full-length histone tails solvated with different water types: [box.pdb (TIP4P-D water)](md_setup/md_protocol/TIP4P-D/wt/01_equil_histone_tails/1_build) and [box.pdb (OPC water)](md_setup/md_protocol/OPC/wt/01_equil_histone_tails/1_build). The details on construction of the MD models and description of the MD simulation parameters can be found in [md_setup/README.md](md_setup/README.md). Please, use these models to start all of your trajectories.

The business logic of the MD protocol:

1) Initial equilibration of the histone tails in the bigger simulation box. After 100-ns initial run, all tails adopted
   more compact conformations. At this point, the simulation is stopped
2) Resolvation of nucleosome structure with collapsed tails
3) Running the production trajectory in smaller box

The current version of protocol supports MD simulation using two water model [TIP4P-D](md_setup/md_protocol/TIP4P-D)
or [OPC](md_setup/md_protocol/OPC) in the NPT ensemble equipped with the Bussi thermostat. The following example of starting this protocol
is for [TIP4P-D](md_setup/md_protocol/TIP4P-D)  (the same is for [OPC](md_setup/md_protocol/OPC)). The scripts are for a local GPU machine; it is straightforward to adapt them for remote cluster (either GPU or CPU).

```code-block:: bash

    ## 1. tails equlibration step (100 ns)
    cd md_setup/md_protocol/TIP4P-D/wt/01_equil_histone_tails
    bash run_job.sh
    
    ## 2. run production trajectory
    cd md_setup/md_protocol/TIP4P-D/wt/02_production   
    bash build.sh
    bash run_job.sh
```
</div>



