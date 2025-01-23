set ref [atomselect 0 "protein and name CA"]
foreach chain {A B C} {
	set sel [atomselect 1 "protein and name CA and chain $chain"]
	set selall [atomselect 1 "all"]
	set fit [measure fit $sel $ref]
	$selall move $fit
	set rmsd [measure rmsd $sel $ref]
	puts "CA-RMSD between chain $chain of chol-b and apo = $rmsd"
} 

set ref [atomselect 0 "protein and backbone"]
foreach chain {A B C} {
	set sel [atomselect 1 "protein and backbone and chain $chain and not name OXT"]
	set selall [atomselect 1 "all"]
	set fit [measure fit $sel $ref]
	$selall move $fit
	set rmsd [measure rmsd $sel $ref]
	puts "backbone-RMSD between chain $chain of chol-b and apo = $rmsd"
} 

set ref [atomselect 0 "protein and noh"]
foreach chain {A B C} {
	set sel [atomselect 1 "protein and noh and chain $chain and not name OXT"]
	set selall [atomselect 1 "all"]
	set fit [measure fit $sel $ref]
	$selall move $fit
	set rmsd [measure rmsd $sel $ref]
	puts "heavy atom-RMSD between chain $chain of chol-b and apo = $rmsd"
} 


# RMSD per Residue between apo and chain C of chol-b.
set ref [atomselect 0 "protein and noh"]
set chain C
set sel [atomselect 1 "protein and noh and chain $chain and not name OXT"]
set selall [atomselect 1 "all"]
set fit [measure fit $sel $ref]
$selall move $fit
foreach aminoa [$ref get resid] {
	set refres [atomselect 0 "protein and noh and resid $aminoa"]
	set selres [atomselect 1 "protein and noh and chain $chain and not name OXT and resid $aminoa"]
	set selresall [atomselect 1 "protein and chain $chain and resid $aminoa"]
	set rmsdres [measure rmsd $selres $refres]
        $selresall set user $rmsdres
}

