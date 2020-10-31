library(ggplot2)
library(dplyr)
library(broom)
library(tidyr)
library(plotly)
#未干预前，已知总体分布均值为18.6，标准差4.1
para1 = list(
  mean=18.6,
  sd=4.1,
  color='red',
  fill='red',
  alpha=0.5
)

z_area = list(
  p025 = 1.96,
  p05 = 1.64,
  p005 = 2.58
)

mean_guess = 21
real_mean_g2 = 20
z_lim = z_area$p005

sample_size=30
plot_range = c(15,25)

g_basic = ggplot(data=data.frame(x=plot_range),aes(x))+geom_vline(aes(xintercept=mean_guess))
g1=g_basic+stat_function(fun=dnorm,args=list(mean=mean_guess,sd=para1$sd/sqrt(sample_size)),color='blue')+
  stat_function(fun=dnorm,args=list(mean=mean_guess,sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='blue',
                alpha=0.5,
                xlim=c(plot_range[1],mean_guess-z_lim*para1$sd/sqrt(sample_size)))+
  stat_function(fun=dnorm,args=list(mean=mean_guess,sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='blue',
                alpha=0.5,
                xlim=c(mean_guess+z_lim*para1$sd/sqrt(sample_size),plot_range[2]))

g1


g2 = g_basic+stat_function(fun=dnorm,args = list(
  mean=real_mean_g2,
  sd=para1$sd/sqrt(sample_size)),color='black')+
  
  stat_function(fun=dnorm,args = list(mean=real_mean_g2,sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='black',
                alpha=0.2,
                xlim=c(plot_range[1],real_mean_g2-z_lim*para1$sd/sqrt(sample_size))
  )+
  stat_function(fun=dnorm,args = list(mean=real_mean_g2,sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='black',
                alpha=0.2,
                xlim=c(real_mean_g2+z_lim*para1$sd/sqrt(sample_size),plot_range[2])
  )
  
g2

g3 = g_basic+
  stat_function(fun=dnorm,args = list(
    mean=mean_guess-z_lim*para1$sd/sqrt(sample_size),
    sd=para1$sd/sqrt(sample_size)),color='black')+
  
  stat_function(fun=dnorm,args = list(mean=mean_guess-z_lim*para1$sd/sqrt(sample_size),sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='black',
                alpha=0.2,
                xlim=c(plot_range[1],mean_guess-2*z_lim*para1$sd/sqrt(sample_size))
  )+
  stat_function(fun=dnorm,args = list(mean=mean_guess-z_lim*para1$sd/sqrt(sample_size),sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='black',
                alpha=0.2,
                xlim=c(mean_guess,plot_range[2])
  )+
  
  stat_function(fun=dnorm,args = list(
    mean=mean_guess+z_lim*para1$sd/sqrt(sample_size),
    sd=para1$sd/sqrt(sample_size)),color='red')+

    stat_function(fun=dnorm,args = list(mean=mean_guess+z_lim*para1$sd/sqrt(sample_size),sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='red',
                alpha=0.2,
                xlim=c(plot_range[1],mean_guess)
  )+
  stat_function(fun=dnorm,args = list(mean=mean_guess+z_lim*para1$sd/sqrt(sample_size),sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill='red',
                alpha=0.2,
                xlim=c(mean_guess+2*z_lim*para1$sd/sqrt(sample_size),plot_range[2])
  )

g3