from classs import CurtyMarsili
import numpy as np
import multiprocessing as mtp
Z = np.linspace(0,1,40)
Results = []
def get_cm(z):
    CM = CurtyMarsili(N=3000,z=z,T = 25000,selection_force=0,σ_mut=0)
    CM.dynamics(20000)
    return CM
P = mtp.Pool(40)
runs = P.map_async(get_cm,Z)
P.close()
P.join()
for run in runs.get():
    Results.append(run)
import pickle
pickle.dump(Results,open("results_fig2","wb"))
