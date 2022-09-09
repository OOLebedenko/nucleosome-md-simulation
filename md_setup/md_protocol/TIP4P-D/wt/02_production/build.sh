#! /bin/bash -f

######################################################################################################################################################################################
#                                                   1. extract last frame from trajectory of tails equilibration  
######################################################################################################################################################################################

$AMBERHOME/bin/ambpdb -p ../../01_equil_histone_tails/wt/1_build/nucleosome.prmtop -c ../../01_equil_histone_tails/wt/6_run/run00100.nc > 0_prepare/wt_equlibrated_tails.pdb

######################################################################################################################################################################################
#                                                   2. solvate system
######################################################################################################################################################################################

$AMBERHOME/bin/tleap -s -f 1_build/tleap_draft_box.rc


######################################################################################################################################################################################
#                                                   3. calculate number of Na+ and Cl- ions needed to neutralize system and to match the target salt concentration 
######################################################################################################################################################################################

# target NaCl concentration
target_nacl_concentration=0.15  # mol/l

# avogadro_constant
avogadro_constant=6.022140857e+23 # mol-1

# number of NaCl molecules in the 1 L NaCl solution
n_nacl_in_one_liter=$(awk "BEGIN {print $target_nacl_concentration * $avogadro_constant; exit}")

# The density of water is ~0.997 g/mL at the room temperature, and thus, the weight of 1 L water is ~997 g.
# Since the weight of 1 mol H2O is ~18.02 g
# e.g. 1 L water is composed of ~3.33 × 10^25 H2O molecules (55.3 mol).
n_h20_in_one_liter=3.33E+25

# extract number of added water molecules by tleap
n_n20=$(grep -i "Added" leap.log | awk '{print $2}')

# calcucate the number of NaCl molecules to match the target concentration
n_nacl_target=$(awk "BEGIN {printf $n_nacl_in_one_liter / $n_h20_in_one_liter * $n_n20; exit}") 
n_nacl_target=${n_nacl_target%.*}

# extract number of added ions by tleap to neutralize system
n_na=$(grep -i "Na+ ion" leap.log | awk '{print $1}')
n_cl=$(grep -i "Cl- ion" leap.log | awk '{print  $1}')


# final number of Na+ and Cl- to neutralize system and to match the target salt concentration 
n_na=$((n_na + n_nacl_target))
n_cl=$((n_cl + n_nacl_target))



######################################################################################################################################################################################
#                                                       3. resolvate system to match experimental NaCl concentration
######################################################################################################################################################################################

# save input file for tleap
cp 1_build/tleap_draft_box.rc 1_build/tleap_box.rc
sed -i s/draft_//g 1_build/tleap_box.rc
sed -i "s/addions mol Na+ 0/addions mol Na+ ${n_na}/g" 1_build/tleap_box.rc
sed -i "s/addions mol Cl- 0/addions mol Cl- ${n_cl}/g" 1_build/tleap_box.rc

$AMBERHOME/bin/tleap -s -f 1_build/tleap_box.rc
