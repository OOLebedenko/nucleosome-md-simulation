<div align="justify">

# MD simulation of nucleosome core particle (NCP)

This repository contains the scripts and data for setup and running MD simulation of nucleosome with full-length histone
tails

### System requirements

Key packages and programs:

- [Amber Molecular Dynamics Package](https://ambermd.org/) (>=20)

### Installation

```code-block:: bash
    # clone repo
    git clone git@github.com:OOLebedenko/nucleosome_project.git
```

### Run MD simulation
The prepared initial structure of the NCP with full-length histone tails
is [wt.pdb](md_setup/intial_structure/wt.pdb). The corresponding details on construction
of MD model and MD parameters are placed into [md_setup/README.md](md_setup/README.md)

The business logic of the MD protocol:

1) Initial equilibration of the histone tails in the bigger simulation box. After 100-ns initial run, all tails adopted
   more compact conformations. At this point, the simulation is stopped
2) Resolvation of nucleosome structure with collapsed tails
3) Run of the production trajectory in smaller box

The current version of protocol supports MD simulation using two water model [TIP4P-D](md_setup/md_protocol/TIP4P-D)
or [OPC](md_setup/md_protocol/OPC) in the NPT ensemble equipped with the Bussi thermostat. The next example of running
is for [TIP4P-D](md_setup/md_protocol/TIP4P-D)  (the same is for [OPC](md_setup/md_protocol/OPC))

```code-block:: bash

    ## 1. tails equlibration step (100 ns)
    cd md_setup/md_protocol/TIP4P-D/01_equil_histone_tails
    bash run_job.sh
    
    ## 2. run production trajectory
    cd md_setup/md_protocol/TIP4P-D/02_production   
    bash build.sh
    bash run_job.sh
```
</div>


