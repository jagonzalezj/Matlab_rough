

atom_style		atomic

print			"Lattice_parameter (A) Energy (eV)" file C:\Modeling_data\EnergyVSlattice_parameter.dat

#########STARTING OF THE LOOP##########
label			loop_start
variable		i_loop loop 100

units			metal


print			${i_loop}
dimension		3
boundary		p p p

print			"########################"
print			"   LOOP NUMBER ${i_loop}"
print			"########################"

variable		my_lattice_parameter equal 3.524 +${i_loop}/100

lattice			fcc ${my_lattice_parameter} 
region			my_region block 0 5 0 5 0 5
create_box		2 my_region
create_atoms	1 box

create_atoms	2 single 0.5 0 0

pair_style		eam/alloy
pair_coeff		* * C:\Modeling_data\Fe-Cbecquart2011.eam Fe C

dump			my_dump all custom 1 C:\Modeling_data\dumpfile.dat id type x y z 

min_style		cg
minimize		0 1e-8 1000 1000
#run	0

variable		total_energy equal etotal/atoms

print			"${my_lattice_parameter} ${total_energy}" append C:\Modeling_data\EnergyVSlattice_parameter.dat

clear

#next			i_loop
#jump			C:\Modeling_data\CS.sh loop_start