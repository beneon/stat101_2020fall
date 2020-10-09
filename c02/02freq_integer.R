# Title     : integer freqency table and histogram
# Objective : TODO
# Created by: Administrator
# Created on: 2020/10/9
library(dplyr)
library(ggplot2)
source('./c02/gen_freq_table.R')
x = c(rep(1,5),rep(2,7),rep(3,8),rep(4,5),rep(5,4),rep(6,3),rep(7,3),rep(8,3),rep(9,3),rep(10,2),rep(11,2),rep(12,2),13,14,15)

df = data.frame(x=x)
df %>% ggplot(aes(x=x))+geom_histogram()
df_freq = gen_freqency_table(x,1:16,'candy')