import tensorly as tl
from tensorly.decomposition import parafac
import numpy as np
import time

# Hopefully tensorly and CP syntax has not changed too much
# Using numpy backend
dims = [100,100,100]
tic = time.perf_counter()

for i in range(10):
    test_array = tl.tensor(np.random.randn(*dims))
    # for newer versions, BUG if tol=0 and no return errors (todo fix unnorm error comput)
    try:
        parafac(test_array, rank=10, tol=0, n_iter_max=100) # no stopping before 100 iters
    except:
        print("Need compute error")
        parafac(test_array, rank=10, tol=0, n_iter_max=100, return_errors=True) # no stopping before 100 iters

toc = time.perf_counter() - tic
print(f"Runtime for 10 CPs is {toc}")
with open("results.txt","a") as f:
    f.write(f"Runtime for 10 CPs is {toc}\n")