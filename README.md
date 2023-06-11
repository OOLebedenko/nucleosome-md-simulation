<div align="justify">

# MD simulation of nucleosome core particle (NCP)

This repository contains the scripts and data for setting up and running MD simulation of nucleosome with full-length histone
tails

### System requirements

Key packages and programs:

- [Amber Molecular Dynamics Package](https://ambermd.org/) (version >=20)

### Installation

The topology files needed for MD simulation are too large for a distribution on github. We archived the full MD protocol
on Zenodo at: https://zenodo.org/record/7270388#.Y2Dy93tByUk

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7270388.svg)](https://doi.org/10.5281/zenodo.7270388)

```code-block:: bash
    # download the archive from Zenodo
    wget https://zenodo.org/record/8031458/files/ncp_md_simulation_protocol.zip
```

The ff99SB_disp force field, TIP4P-D and TIP4P-D_disp water are not a part of the standard Amber distribution. 
In addition, the current organization of $AMBERHOME/dat/leap/ files doesn't allow loading both ff99SB protein force field
and bsc1 nucleic force field, because of the conflict between parm99 parameters (for ff99SB) and parm10 parameters (for bsc1).

To resolve these issues, we provide the required cmd, frcmod and lib files for [ff99SB_disp](md_setup/amber_parms/ff99SB_disp/), [TIP4PD](md_setup/amber_parms/TIP4PD/),
[TIP4PD_disp](md_setup/amber_parms/TIP4PD_disp/) and [bsc1_parm99](md_setup/amber_parms/bsc1_parm99/).
You should copy these files into the standard Amber directories.

```code-block:: bash
    
    ## copy cmd files
    cp md_setup/amber_parms/ff99SB_disp/cmd/leaprc.protein.ff99SBdisp $AMBERHOME/dat/leap/cmd/.
    cp md_setup/amber_parms/TIP4PD_disp/cmd/leaprc.water.tip4pd_disp $AMBERHOME/dat/leap/cmd/.
    cp md_setup/amber_parms/TIP4PD/cmd/leaprc.water.tip4pd $AMBERHOME/dat/leap/cmd/.
    cp md_setup/amber_parms/bsc1_parm99/cmd/leaprc.ff99SB.bsc1 $AMBERHOME/dat/leap/cmd/.
    cp md_setup/amber_parms/bsc1_parm99/cmd/leaprc.ff99SBdisp.bsc1 $AMBERHOME/dat/leap/cmd/.
  
    # copy parm files 
    cp md_setup/amber_parms/ff99SB_disp/parm/frcmod.ff99SBdisp $AMBERHOME/dat/leap/parm/.
    cp md_setup/amber_parms/TIP4PD_disp/parm/frcmod.tip4pd_disp $AMBERHOME/dat/leap/parm/.
    cp md_setup/amber_parms/TIP4PD/parm/frcmod.tip4pd $AMBERHOME/dat/leap/parm/.
    cp md_setup/amber_parms/bsc1_parm99/parm/frcmod.parmbsc1.oldff $AMBERHOME/dat/leap/parm/.
     
    # copy lib files  
    cp md_setup/amber_parms/ff99SB_disp/lib/all_amino94disp.lib $AMBERHOME/dat/leap/lib/.
    cp md_setup/amber_parms/ff99SB_disp/lib/all_aminoct94disp.lib $AMBERHOME/dat/leap/lib/.
    cp md_setup/amber_parms/ff99SB_disp/lib/all_aminont94disp.lib $AMBERHOME/dat/leap/lib/.
    cp md_setup/amber_parms/TIP4PD_disp/lib/tip4pdbox_disp.off $AMBERHOME/dat/leap/lib/.
    cp md_setup/amber_parms/TIP4PD/lib/tip4pdbox.off $AMBERHOME/dat/leap/lib/.
    cp md_setup/amber_parms/bsc1_parm99/lib/parmBSC1.lib.oldff $AMBERHOME/dat/leap/lib/.
    
```

Links to sample scripts and parameter files can be found in [md_setup/md_protocol/README.md](md_setup/md_protocol/README.md)

### Run MD simulation

Four combinations of protein force fields and water models are used: (Amber ff99SB / OPC), (Amber ff19SB / OPC), (Amber
ff99SB-disp / TIP4P-D_disp) and (Amber ff14SB / TIP4P-D). The details on construction of the MD models and description of the
MD simulation parameters can be found in [md_setup/README.md](md_setup/README.md). Please, use these models to start all
of your trajectories.

The business logic of the MD protocol:

1) Initial equilibration of the histone tails in the bigger simulation box. After 100-ns initial run, all tails adopt
   more compact conformations. At this point, the simulation is stopped
2) Re-solvation of nucleosome structure (with equilibrated tails) using a smaller box
3) Running the production trajectory in a smaller box

The following example of starting this protocol is for (Amber ff14SB / TIP4P-D). The scripts are for a local GPU
machine; it is straightforward to adapt them for a remote cluster (either GPU or CPU).

```code-block:: bash

    ## 1. tails equlibration (100 ns)
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



