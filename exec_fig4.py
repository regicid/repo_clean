import numpy as np
import pandas as pd
import pickle
import sys
import multiprocessing as mtp
import os
from tqdm import tqdm_notebook as tqdm
os.system("mkdir ./Results_fig4")

from classs import CurtyMarsili

i = sys.argv[1]
z = pickle.load(open("KWARGS_"+i,"rb"))
def get_cm(o):
    CM = CurtyMarsili(z=.9,z2=.9,N=3000,selection_force = 0,σ_mut = 0,α_dandy = o,p = .52)
    CM.dynamics(2*10**5)
    CM.compressor()
    o = np.round(o,2)
    pickle.dump(CM,open(f"./Results_fig4/result_{o}","wb"))

l = mtp.Pool()
runs = l.map_async(get_cm,z)
l.close()
l.join()
Results = []
for run in runs.get():
    Results.append(run)
