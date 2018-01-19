import numpy as np
from update_O_n import metropolis,sw,wolff,metropolis_aniso,hybrid,hybrid_aniso,initran

class O_n:
	def __init__(self,n,J,*L,**kwargs):

		if any(l <= 0 for l in L):
			raise ValueError("expecting L to be greater than 0")
		if n <= 0:
			raise ValueError("expecting n to be greater than 0")

		seed = np.random.randint(np.iinfo(np.int64).max)
		initran(seed)
		periodic = kwargs.get("periodic")
		if periodic is None:
			periodic = True

		self.delta = kwargs.get("delta")

		self.d = len(L)
		self.n = n
		self.J = J
		self.dims = np.array(L,dtype=np.int32)
		self.N = np.prod(self.dims)
		self.init_spins()
		if periodic:
			from update_O_n import get_sq_nn
			self.NN,self.stag = get_sq_nn(self.dims,self.N)
		else:
			from update_O_n import get_sq_nn_open
			self.NN,self.stag = get_sq_nn_open(self.dims,self.N)

	def init_spins(self):
		self.spins = np.asarray(np.random.normal(0,1,size=(self.N,self.n)),order="F",dtype=np.float64)
		norm = np.linalg.norm(self.spins,axis=1)
		self.spins = (self.spins.T/norm).T


	def metropolis(self,beta,mcsteps=1,dm=0,Nm=1,f_id=0,h=0.0):
		if dm > 0:
			Nms = mcsteps/dm
			measure=True
		else:
			Nms = 1
			dm=1
			measure=False
		Ms = np.zeros((Nms,Nm),dtype=np.float64,order="F")
		if self.delta is not None and self.delta != self.J:
			metropolis_aniso(self.spins,self.NN,self.dims,measure,Ms,beta,self.J,self.delta,mcsteps,dm,f_id,h)
		else:
			metropolis(self.spins,self.NN,self.dims,measure,Ms,beta,self.J,mcsteps,dm,f_id,h)
		return Ms

	def sw(self,beta,mcsteps=1,dm=0,Nm=1,f_id=0,h=0.0):
		if dm > 0:
			Nms = mcsteps/dm
			measure=True
		else:
			Nms = 1
			dm=1
			measure=False
		Ms = np.zeros((Nms,Nm),dtype=np.float64,order="F")
		if self.delta is not None and self.delta != self.J:
			raise ValueError("can't use Swenson-Wang updates with anisotrpy, use either 'metropolis' or 'hybrid_aniso' updates")
		else:
			sw(self.spins,self.NN,self.dims,measure,Ms,beta,self.J,mcsteps,dm,f_id,h)
		return Ms


	def wolff(self,beta,mcsteps=1,dm=0,Nm=1,f_id=0,h=0.0):
		if dm > 0:
			Nms = mcsteps/dm
			measure=True
		else:
			Nms = 1
			dm = 1
			measure=False
		Ms = np.zeros((Nms,Nm),dtype=np.float64,order="F")
		if self.delta is not None and self.delta != self.J:
			raise ValueError("can't use Wolff updates with anisotrpy, use either 'metropolis' or 'hybrid_aniso' updates")
		else:
			wolff(self.spins,self.NN,self.dims,measure,Ms,beta,self.J,mcsteps,dm,f_id,h)
		return Ms




	def hybrid(self,beta,mcsteps=1,dm=0,Nm=1,f_id=0,h=0.0,n_wolff=6,n_metrop=4):
		if dm > 0:
			Nms = mcsteps/dm
			measure=True
		else:
			Nms = 1
			dm = 1
			measure=False
		Ms = np.zeros((Nms,Nm),dtype=np.float64,order="F")
		if self.delta is not None and self.delta != self.J:
			hybrid_aniso(self.spins,self.NN,self.dims,measure,Ms,beta,self.J,self.delta,mcsteps,n_wolff,n_metrop,dm,f_id,h)
		else:
			hybrid(self.spins,self.NN,self.dims,measure,Ms,beta,self.J,mcsteps,n_wolff,n_metrop,dm,f_id,h)
		return Ms
		

















		

		
