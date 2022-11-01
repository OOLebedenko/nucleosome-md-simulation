<div align="justify">

## Here, you can find the sample scripts. The full protocol (scripts and data) is deposited on Zenodo.
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7270388.svg)](https://doi.org/10.5281/zenodo.7270388)



### The parameter files using for runnig MD trajectories with Amber engine:

0) The example of the script building the simulation box:
    - [build.sh](build.sh)
    - for outputs of this scripts see archive deposited on Zenodo
1) Two-stage minimization
    - [min_1.in](min_1.in)
    - [min_2.in](min_2.in)
2) Heating
    - [heat.in](heat.in)
3) Equilibration
    - [equil.in](equil.in)
4) 1-ns step of production run
    - [run00001.in](run00001.in)

5) The example of the script running the MD simulation
   - [run.sh](run.sh)

All parameters (including default) are listed in [all_params.txt](all_params.txt) (maybe useful to port protocol to
Gromacs or other one)


</div>
