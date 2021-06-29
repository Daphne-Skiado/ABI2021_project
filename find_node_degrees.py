import networkx as nx
import sys
import matplotlib.pyplot as plt

network = nx.read_edgelist('network_edges',data=False)

less100 = open('less100degree.txt','w')
more100 = open('more100degree.txt','w')
for n,d in network.degree:
	if d <= 100:
		less100.write(n+'\n')
	else:
		more100.write(n+'\n')
less100.close()
more100.close()
