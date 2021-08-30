library(ggplot2)
library(dplyr)
source('./c02/gen_freq_table.R')
#parameter zone
mean = 4.5
sd = 0.5
n = 140

#construct df and plot
df = data.frame(id=seq(1,n),rbc=round(rnorm(n,mean,sd),2))



df_freq_table <- gen_freqency_table(df$rbc,breaks = 10,title4group = 'rbc count,x10^12/L')
View(df_freq_table)
df %>% ggplot(aes(x=rbc))+geom_histogram(bins=14)