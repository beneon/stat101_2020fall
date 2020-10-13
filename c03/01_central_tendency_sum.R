# sum of sample variables follow normal dist.

library(purrr)
library(ggplot2)
library(dplyr)

balls = c(rep(1,5),rep(2,11),rep(3,18),rep(4,10),rep(5,4),rep(6,3),rep(7,3),rep(8,3),rep(9,3),rep(10,2),rep(11,2),rep(12,2),13,14,15)
hist(balls)

ball_sample = function(n){
  # n: size of sample
  box_of_ball = c(-3,-2,-1,0,1,2,3)
  #box_of_ball = balls
  sample_rst = sample(box_of_ball,n,replace = TRUE)
  return(sum(sample_rst))
}

trials = 100000
sample_size = 50
reference_mean = 0
#reference_mean = mean(balls)

trial_num = 1:trials
sample_sizes = rep(sample_size,trials)
sums = map_dbl(sample_sizes,ball_sample)
means = map_dbl(sample_sizes,ball_sample)/sample_size
df = data.frame(
  trial_num,sums,means
)

df %>% ggplot(aes(x=sums))+geom_density()
df %>% ggplot(aes(x=means))+geom_density()+geom_vline(xintercept = reference_mean,color='green',size=1)+geom_vline(xintercept = mean(means),linetype='dashed',color='red',size=1)