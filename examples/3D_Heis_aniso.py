from O_n_MonteCarlo import O_n
import sys,os



L = int(sys.argv[1])
delta = float(sys.argv[2])
beta = float(sys.argv[3])
nbin = int(sys.argv[4])
metrop = eval(sys.argv[5])

mc = O_n(3,-1.0,L,L,L,delta=-delta)


path="test_data"
if metrop:
	filename = "3D_Heis_aniso_metrop_bins_L_{L:}_delta_{delta:}_beta_{beta:}.dat".format(L=L,delta=delta,beta=beta)
else:
	filename = "3D_Heis_aniso_wolff_bins_L_{L:}_delta_{delta:}_beta_{beta:}.dat".format(L=L,delta=delta,beta=beta)

filename = os.path.join(path,filename)

mcsteps = 10000

#if os.path.isfile(filename):
#	for line in open(filename,"r"):
#		nbin -= 1

#if nbin <= 0:
#	exit()


for i in range(5):
	print "equilibration: {}".format(i+1)
	if metrop:
		Ms = mc.metropolis(beta,mcsteps)
	else:
		Ms = mc.hybrid(beta,mcsteps)

line = (" ".join(["{:30.15e}" for i in range(5)]))+"\n"

with open(filename,"w") as IO:
	for i in range(nbin):
		print "bin: {}".format(i+1)
		if metrop:
			Ms = mc.metropolis(beta,mcsteps,Nm=5,dm=1)
		else:
			Ms = mc.hybrid(beta,mcsteps,Nm=5,dm=1)

		Mbin = Ms.mean(axis=0)
		IO.write(line.format(*Mbin))
		IO.flush()





