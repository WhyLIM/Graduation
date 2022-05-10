 # @Author: Min Li
 # @Email: mli.bio@outlook.com
 # @Last Modified by: Min Li
 # @Timestamp for Last Modification: 2022-01-08 14:40:05
 # @Description: This code is used to find the Weighted Core Network(WCN) from 1509 DEGs 
 # and divide it into modules, using ne.PCA.

library(ne.PCA)
setwd("D:/Study/Project/Graduation/0_prer_work/")

rm(list = ls())
nodes <- read.csv("nodes.csv", sep = "\t")
edges <- read.csv("links.csv", sep = "\t")
ne.PCA(nodes, edges)
