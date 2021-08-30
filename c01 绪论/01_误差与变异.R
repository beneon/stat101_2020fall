# Title     : 误差与变异
# Objective : TODO
# Created by: Administrator
# Created on: 2021/7/16

library(tidyverse)
library(dplyr)
library(ggplot2)

dataset <- read_csv(file.path('01 basic concept', '01_dataset.csv'))
dataset$gender <- factor(dataset$gender, labels=c('male', 'female'))

sample_calc <- function(df,n,col_name){
  df_sample <- sample_n(df,n)
  mean_val = df_sample %>% summarise_at(vars(col_name),mean)
  return(mean_val[[1]])
}

trials_total = 200
df_stats = data.frame(
  'age_n_3'=vector('double',trials_total),
  'sbp_n_3'=vector('double',trials_total),
  'age_n_6'=vector('double',trials_total),
  'sbp_n_6'=vector('double',trials_total),
  'age_n_10'=vector('double',trials_total),
  'sbp_n_10'=vector('double',trials_total),
  'age_biased_n_3'=vector('double',trials_total),
  'sbp_biased_n_3'=vector('double',trials_total)
)
for(i in 1:trials_total){
  df_stats[i,'age_n_3'] <- sample_calc(dataset,3,'age')
  df_stats[i,'sbp_n_3'] <- sample_calc(dataset,3,'sbp')
  df_stats[i,'age_n_6'] <- sample_calc(dataset,6,'age')
  df_stats[i,'sbp_n_6'] <- sample_calc(dataset,6,'sbp')
  df_stats[i,'age_n_10'] <- sample_calc(dataset,10,'age')
  df_stats[i,'sbp_n_10'] <- sample_calc(dataset,10,'sbp')
  df_stats[i,'age_biased_n_3'] <- sample_calc(dataset %>% filter(gender=='male'),3,'age')
  df_stats[i,'sbp_biased_n_3'] <- sample_calc(dataset %>% filter(gender=='male'),3,'sbp')
}

df_stats_melt = df_stats %>% pivot_longer(cols=everything(),names_to='type',values_to = 'mean')
df_stats_melt$type = factor(
  df_stats_melt$type,levels = c(
    'age_biased_n_3',
    'age_n_3',
    'age_n_6',
    'age_n_10',
    'sbp_biased_n_3',
    'sbp_n_3',
    'sbp_n_6',
    'sbp_n_10'
  )
)
df_stats_melt %>% ggplot(aes(x=type,y=mean))+geom_boxplot()+geom_hline(yintercept = mean(dataset$sbp))+geom_hline(yintercept = mean(dataset$age))
