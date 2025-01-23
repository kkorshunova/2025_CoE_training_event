#!/bin/bash

# First, remove water, add missing atoms, and change selenomethionines to methionines in
# the 1y2o.pdb via e.g. chimera. Name it 1y2o_modified.gro

gmx pdb2gmx -f 1y2o_modified.pdb -o 1y2o_modified.gro -water tip3p -ignh < pdb2gmx_input
gmx editconf -f 1y2o_modified.gro -o 1y2o_box.gro -c -box 10 10 25 -bt triclinic
gmx solvate -cp 1y2o_box.gro -cs spc216.gro -o 1y2o_solvated.gro -p topol.top
gmx grompp -f ions.mdp -c 1y2o_solvated.gro -p topol.top -o ions.tpr
echo 13|gmx genion -s ions.tpr -o 1y2o_solvated_ions.gro -p topol.top -pname NA -nname CL -np 140 -nn 150
gmx grompp -f minim.mdp -c 1y2o_solvated_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
gmx grompp -f md.mdp -c em.gro -p topol.top -o md_1ns.tpr
gmx mdrun -v -deffnm md_1ns
