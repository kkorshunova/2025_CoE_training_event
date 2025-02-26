#!/usr/bin/env python3
import numpy as np
import matplotlib.pyplot as plt

_, x1 = np.loadtxt("ca_131_268.xvg", comments=["#", "@"], unpack=True)
_, x2 = np.loadtxt("ca_207_113.xvg", comments=["#", "@"], unpack=True)

xbins = 5.9+np.arange(43)*.2
ybins = 9.9+np.arange(43)*.2

plt.hist2d(x1*10, x2*10, bins=(xbins, ybins))
cbar = plt.colorbar()
cbar.set_label("count per bin")
plt.xlabel("$L_{G}$ (nm)")
plt.ylabel("$L_{L}$ (nm)")
plt.title(r"Conformational dynamics of $\beta_2$AR")

plt.tight_layout()
plt.show()
