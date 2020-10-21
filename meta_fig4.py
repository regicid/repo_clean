import subprocess
import os
import numpy as np
import pickle
import subprocess
from shlex import split
import math

N = 12
os.system("mkdir Results_fig4")
PARAM = np.linspace(0,1.5,60)


for i in range(math.ceil(len(PARAM)/N)):
	KWARGS = PARAM[N*i:N*(i+1)]
	pickle.dump(KWARGS,open("./KWARGS_"+str(i),"wb"))
	bash = "srun -N 1 --partition=firstgen -o logs.out python exec_fig4.py "+str(i) 
	subprocess.Popen(bash.split(),stdout=subprocess.PIPE)	

