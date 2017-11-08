import numpy as np
from matplotlib import pyplot as plt
from matplotlib import animation
from O_n import O_n

L=4
d=3
n=3
J=1
h=0
mcsteps=100000
beta=1.0#1/(2.202)

mc1=O_n(n,J,*[L for i in range(d)])
mc2=O_n(n,J,*[L for i in range(d)])


# nbin=1000
# p=np.zeros(nbin,dtype=np.float64)
# m2=np.zeros(nbin,dtype=np.float64)


# for i in range(nbin):
# 	ss = np.random.normal(0,1,size=(n,L,100000))
# 	ss /= np.linalg.norm(ss,axis=0)

# 	P = np.einsum("i...,i...->...",ss[:,0,:],ss[:,1,:])+np.einsum("i...,i...->...",ss[:,1,:],ss[:,2,:])+\
# 	    np.einsum("i...,i...->...",ss[:,2,:],ss[:,3,:])+np.einsum("i...,i...->...",ss[:,3,:],ss[:,0,:])

# 	np.exp(-beta*P,out=P)

# 	p[i] = np.sum(P)
# 	m2[i] = (((ss.mean(axis=1))**2)*P).sum()

# nboots = 1000

# boots = (np.random.choice(nbin,size=nbin) for i in xrange(nboots))
# boot_vals = ((m2[ind]/p[ind]).mean() for ind in boots)
# mean = sum(boot_vals)/nboots

# boots = (np.random.choice(nbin,size=nbin) for i in xrange(nboots))
# boot_vals = ((m2[ind]/p[ind]).mean() for ind in boots)
# boot_sq = ((mean-val)**2 for val in boot_vals)

# error = np.sqrt(sum(boot_sq)/nboots)

# print mean,error

# for i in xrange(100):
# 	M1 = mc1.metropolis(beta,mcsteps=mcsteps,dm=1,Nm=4)
# 	M2 = mc2.sw(beta,mcsteps=mcsteps,dm=1,Nm=4)
# 	# M2 = mc2.wolff(beta,mcsteps=mcsteps,dm=1,Nm=4)
# 	print i,np.mean(M1,axis=0)[0],np.mean(M2,axis=0)[0]
# 	# print mc1.spins
