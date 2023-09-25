from casadi import *
import numpy as np
import sys

# Declare variables
x = SX.sym("x",2)

# Form the NLP
f = x[0]**2 + x[1]**2 # objective
g = x[0]+x[1]-10      # constraint
nlp = {'x':x, 'f':f, 'g':g}

# Pick an NLP solver
MySolver = "ipopt"

# Solver options
if (len(sys.argv) >= 2):
    opts = { "ipopt.linear_solver" : sys.argv[1] }
else:
    opts = {}

# Allocate a solver
solver = nlpsol("solver", MySolver, nlp, opts)

# Solve the NLP
sol = solver(lbg=0)

# Print solution
print("-----")
assert np.allclose(sol["f"], 50)
assert np.allclose(sol["x"], [5,5])
assert np.allclose(sol["lam_x"], [0,0])
assert np.allclose(sol["lam_g"], -10)
