set n [molinfo top get name]
set ni [lindex [split [lindex [split $n {_}] 1] {.}] 0]


set outname "zdist_${ni}.agr"

# open a file
set f [open $outname w]
 
puts $f {@    title "Distance between protein and membrane center"  }
puts $f {@    xaxis  label "Time (ns)"                              } 
puts $f {@    yaxis  label "Distance (\c\E\C)"                      }
puts $f {@TYPE xy                                                   }    
puts $f {@ legend on                                                }
puts $f {@ legend box on                                            }
puts $f {@ legend loctype view                                      }
puts $f {@ legend 0.78, 0.8                                         }
puts $f {@ legend length 2                                          } 
puts $f "\@ s$ni legend \"[molinfo top get name]\"                     "
puts $f "\@target G0.S$ni                                              "

# Select phosphorus atoms
set membraneP [atomselect top "name P"] 
# select alpha carbons
set proteinCA [atomselect top "name CA"]

# get number of frames
set nf [molinfo top get numframes]
for {set i 1 } { $i < $nf} {incr i} {
	# update selections to the frame
	$membraneP frame $i
	$proteinCA frame $i
        # get the centerof mass of catoms
	set com_membraneP [measure center $membraneP]		
	set com_proteinCA [measure center $proteinCA]
	#get the z-component of the center of masses
	set comZ_membraneP [lindex $com_membraneP 2]
	set comZ_proteinCA [lindex $com_proteinCA 2]
	#get the z distance
	set dZ [expr abs($comZ_proteinCA - $comZ_membraneP) ]
	# write to file
	puts $f "[expr ($i-1.0)/10.0] $dZ"

}
#close file
close $f
