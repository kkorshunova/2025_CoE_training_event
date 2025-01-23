#!/bin/bash

# calculate number of atoms in the bilayer system
atoms=`expr 2 \* $(expr $(wc -l < leaflet_2.gro) - 3)`

# write the comment line in the .gro file
echo Mixed POPC/PIP2 bilayer > system.gro;
# copy the number of atoms to the 2nd line 
echo $atoms >> system.gro; 
# copy the lines containing atom coordinates from leaflet_1_compression.gro
tail -n +3 leaflet_1_comp.gro | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' | tail -n +2 | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' >> system.gro;  
# copy the lines containing atom coordinates from leaflet_2.gro
tail -n +3 leaflet_2.gro | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' | tail -n +2 | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' >> system.gro; 
# copy the unit cell vectors from leaflet_2.gro to the last line
tail -n 1 leaflet_2.gro >> system.gro;

