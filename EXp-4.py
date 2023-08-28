from __future__ import division
import math
# initialisation of variables
ncore = float(input('Enter the ncore:'))  # refractive index of core
nclad = float(input('Enter the nclad:'))  # refractive index of cladding
NA = math.sqrt(ncore**2-nclad**2)  # numerical aperture
# RESULTS
print("The numerical aperture =", round(NA, 5))
