import subprocess
import os
import numpy as np
import pickle
import subprocess
from shlex import split
import math

N = 16 
os.system("mkdir Results")
PARAM = np.linspace(0,15,80)
P = np.linspace(.51,.55,5)
#P = [.52]

for p in P:
	for i in range(math.ceil(len(PARAM)/N)):
		KWARGS = PARAM[N*i:N*(i+1)]
		pickle.dump(KWARGS,open("./KWARGS_"+str(i),"wb"))
		bash = "srun -N 1 -o logs.out --partition=secondgen python try.py "+str(i) + " " + str(p)
		subprocess.Popen(bash.split(),stdout=subprocess.PIPE)	
