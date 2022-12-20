<div align="justify">

# MD simulation of nucleosome core particle (NCP)

This repository contains the scripts and data for setup and running MD simulation of nucleosome with full-length histone
tails

### System requirements

Key packages and programs:

- [Amber Molecular Dynamics Package](https://ambermd.org/) (>=20)

### Installation

The topology files needed for MD simulation are too large for a distribution on github. We archived the full MD protocol
on Zenodo at: https://zenodo.org/record/7270388#.Y2Dy93tByUk

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7270388.svg)](https://doi.org/10.5281/zenodo.7270388)

```code-block:: bash
    # download archive from Zenodo
    wget https://zenodo.org/record/7270388/files/ncp_md_simulation_protocol.zip
```

The TIP4P-D water is not a standard choice for MD simulations within the program Amber. We provide the required frcmod
and lib files for [TIP4P-D(leap parms)](md_setup/amber_parms/TIP4P-D/). You should copy these files into the standard
Amber directories.

```code-block:: bash

    cp md_setup/amber_parms/TIP4P-D/leaprc.water.tip4pd $AMBERHOME/dat/leap/cmd/.
    cp md_setup/amber_parms/TIP4P-D/tip4pdbox.off $AMBERHOME/dat/leap/lib/.
    cp md_setup/amber_parms/TIP4P-D/frcmod.tip4pd $AMBERHOME/dat/leap/parm/.
    
```

For sample scripts and parameter files, see [md_setup/md_protocol/README.md](md_setup/md_protocol/README.md)

### Run MD simulation

Four combinations of protein force fields and water models are used: (Amber ff99SB / OPC), (Amber ff19SB / OPC), (Amber
ff99SB-disp / TIP4P-D) and (Amber ff14SB / TIP4P-D). The details on construction of the MD models and description of the
MD simulation parameters can be found in [md_setup/README.md](md_setup/README.md). Please, use these models to start all
of your trajectories.

The business logic of the MD protocol:

1) Initial equilibration of the histone tails in the bigger simulation box. After 100-ns initial run, all tails adopt
   more compact conformations. At this point, the simulation is stopped
2) Resolvation of nucleosome structure (with equilibrated tails) using a smaller box
3) Running the production trajectory in a smaller box

The following example of starting this protocol is for (Amber ff14SB / TIP4P-D). The scripts are for a local GPU
machine; it is straightforward to adapt them for a remote cluster (either GPU or CPU).

```code-block:: bash

    ## 1. tails equlibration step (100 ns)
    cd md_setup/md_protocol/TIP4P-D/ff14SB/wt/01_equil_histone_tails
    bash run_job_equil.sh
    
    ## 2. run production trajectory
    cd md_setup/md_protocol/TIP4P-D/ff14SB/wt/02_production   
    bash build_box_prod.sh
    bash run_job_prod.sh
```

### Link to the Gitter chat

[![Gitter](https://img.shields.io/gitter/room/DAVFoundation/DAV-Contributors.svg?style=flat-square)](https://gitter.im/nucleosome-md-simulation/community)

</div>



