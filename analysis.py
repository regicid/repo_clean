from classs import CurtyMarsili
import os
import pickle
import numpy as np
import sys
Results = []
path = sys.argv[1]
a = os.listdir(path)
for i in a:
	try:
		r = pickle.load(open(path+"/"+i,"rb"))
		Results.append(r)
	except:
		print(i)


R = np.zeros((13,len(Results)))

for i in range(len(Results)):
	#a = np.mean(Results[i].q_history[-10000:])
	a = Results[i].q
	b = Results[i].anti_conformist.mean()
	c = (Results[i].follower*Results[i].α).mean()
	d = (Results[i].follower*~Results[i].α).mean()
	e = (~Results[i].follower).mean()
	f = Results[i].c
	g = Results[i].Ω
	h = np.mean(Results[i].prop_i[-5000:])
	j = np.abs(np.array(Results[i].q_history[-5000:]) - .5).mean()
	k = np.max(Results[i].anti_history[-10000:]) - np.min(Results[i].anti_history[-10000:])
	in_deg = np.zeros(Results[i].N,dtype="int")
	z = np.unique(Results[i].network,return_counts=True)
	in_deg[z[0]] = z[1]
	l = max(in_deg)
	m = Results[i].α_dandy 
	p = Results[i].p
	R[:,i] = np.array([a,b,c,d,e,f,g,h,j,k,l,m,p])

np.save(path.lower()+".npy",R)
