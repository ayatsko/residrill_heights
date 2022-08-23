# preliminary residrill data processing

# 1. explore characteristics of drilled trees
setwd("/Users/abbeyyatsko/Desktop/residrill")
trees <- read.csv("residrill_tree_metadata.csv")

#libraries
library(ggplot2)

str(trees)

# how many of each tree species were sampled?
x <- as.vector(table(trees$species))

# Corymbia clarksoniana    Eucalyptus cullenii              Gardenia?   Larsenaikia ochreata 
# 14                     21                      1                      6 
# Melaleuca stenostachya 
# 10 

ggplot(trees, aes(x = species)+
  geom_bar(stat = "count")+
  theme_classic()

# what was the spread of tree sizes (in dbh_cm) by site?

ggplot(trees, aes(x = site, y = dbh_cm))+
  geom_violin()+
  geom_jitter()+
  theme_classic()

