#!/bin/bash


cp ca_131_268.xvg first_set.xvg
cp ca_207_113.xvg second_set.xvg

awk '$0!~/#/ && $0!~/@/ {print}' first_set.xvg >> first_set_cut.xvg
awk '$0!~/#/ && $0!~/@/ {print}' second_set.xvg >> second_set_cut.xvg

gfortran combine.f -o combine.x
./combine.x
gfortran 3d_2.f -o 3d_2.x
./3d_2.x

gnuplot -persist <<-EOFMarker
    set termopt enhanced
    set encoding iso_8859_1
    set title "Conformational dynamics of receptor."
    set pointsize 1
    set xlabel "L_{G} [\305]"
    set ylabel "L_{L} [\305]"
    plot '3d-output.dat' using 2:1:3 with image notitle
EOFMarker

rm first_set_cut.xvg second_set_cut.xvg first_set.xvg second_set.xvg


