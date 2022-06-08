from sklearn.cluster import KMeans
import numpy as np
import sys

from numpy import genfromtxt

my_data = genfromtxt('data.txt', delimiter=', ')
    
k = int(sys.argv[1])
km = KMeans(
    n_clusters=k, init='random',
    n_init=10, max_iter=100, 
    tol=1e-04, random_state=0
)
y_km = km.fit_predict(my_data)

cluster = list()
for elt in km.cluster_centers_:
	x, y = '%f' % elt[0], '%f' % elt[1]
	cluster.append(list([x,y]))

np.savetxt("cluster.txt", np.array(cluster), delimiter=",", fmt='%s')
# print(km.cluster_centers_)





