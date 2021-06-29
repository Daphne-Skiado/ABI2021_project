NET_SRC=find_node_degrees.py
PLOT_SRC=create_boxplot.py
LANGUAGE=python
NET_EXE=$(LANGUAGE) $(NET_SRC)
PLOT_EXE=$(LANGUAGE) $(PLOT_SRC)
TXT_FILES=$(wildcard *.txt)


all : protein_domains_vs_string_degree.png

#download the Homo sapiens part of STRING, write protein interactions with combined score larger than 500 to file network_edges
network_edges:
	curl --silent  https://stringdb-static.org/download/protein.links.v11.0/9606.protein.links.v11.0.txt.gz | gzip -d | gawk -F' ' '{if($$3>500 && NR!=1) {split($$1, subfield1, ".") ; split($$2, subfield2, ".") ; print subfield1[2]" "subfield2[2]}}' > $@
	
#create the interaction network and partition the proteins according to their node degree
less100degree.txt more100degree.txt: $(NET_SRC) network_edges
	$(NET_EXE)
	
#couldn't automatically download protein domains info so proteins_w_domains.txt is manually stored
#store in proteins_list.txt the Ensembl protein ID of each protein with a protein domain registered
proteins_list.txt: proteins_w_domains.txt
	cat proteins_w_domains.txt | grep 'PF' | cut  -f 2 > $@

#create boxplot comparing the number of domains of proteins with node degrees >100 to the ones with node degrees <=100
protein_domains_vs_string_degree.png: proteins_list.txt less100degree.txt more100degree.txt
	$(PLOT_EXE) $^

