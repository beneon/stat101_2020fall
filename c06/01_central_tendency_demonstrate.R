library(dplyr)
library(ggplot2)
library(plotly)
#样本均值的抽样误差
#总体均值18.6，标准差4.1，共2160人
mean = 18.6
sd = 4.1
pop = rnorm(2160,mean,sd)

#从中反复抽样，每次样本量为20
sample_size = 20

#重复试验100次
trials = seq(1,100,by=1)
sample_means = function(){
  sample_20 = sample(pop,sample_size)
  return(round(mean(sample_20),2))
}

df_samples = data.frame(trials_num=trials) %>% 
  rowwise() %>% 
  mutate(means=sample_means())

# 样本均值的散点图
g1 = df_samples %>% ggplot(aes(x=trials,y=means))+
  geom_point()+
  geom_hline(yintercept = 18.6)


# 样本均值分布的概率密度图
g2 = df_samples %>% ggplot(aes(x=means))+
  geom_density(color='red')+
  stat_function(fun=dnorm,args=list(
    mean=18.6,
    sd=4.1/sqrt(20)
  ), color='blue')

g1
g2
