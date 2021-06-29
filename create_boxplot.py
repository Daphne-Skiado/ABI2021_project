import sys
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

less_file = open(sys.argv[2],'r')
less100proteins = [line[:-1] for line in less_file.readlines()]
less_file.close() 

more_file = open(sys.argv[3],'r')
more100proteins = [line[:-1] for line in more_file.readlines()]
more_file.close() 

data_file = open(sys.argv[1],'r')
data = [line[:-1] for line in data_file.readlines()]
data_file.close()

df = pd.DataFrame(data, columns = ['Proteins'])

counts_df = df['Proteins'].value_counts()
proteins = counts_df.index
counts = counts_df.tolist()
protein_counts = []
for p in range(len(counts)):
	if proteins[p] in less100proteins:
		protein_counts.append([counts[p],'degree<=100'])
	else:
		protein_counts.append([counts[p],'degree>100'])
		
df = pd.DataFrame(protein_counts, columns =['Number of domains of proteins','Node degree'])

ax = sns.boxplot(x='Node degree', y='Number of domains of proteins', data=df)
fig = ax.get_figure()
fig.savefig('protein_domains_vs_string_degree.png')
