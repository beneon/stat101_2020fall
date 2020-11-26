library(ggplot2)
library(dplyr)
sample_size = 25
x = rnorm(sample_size,10,2)
beta0=3
beta1=2.5
u = rnorm(sample_size,0,4.5)
y=beta0+beta1*x+u
df = data.frame(x=x,y=y)
fit = lm(y~x,data=df)
hat_beta0=fit$coefficients[1]
hat_beta1=fit$coefficients[2]
df = df %>%
  mutate(x=round(x,2),y=round(y,2)) %>%
  mutate(hat_y=hat_beta0+hat_beta1*x,mean_y=mean(y),hat_u=y-hat_y)

df %>% ggplot(aes(x=x,y=y))+
  geom_point()

df %>% ggplot(aes(x=x,y=y))+
  geom_point()+
  geom_hline(aes(yintercept=mean(y)))+
  geom_vline(aes(xintercept=mean(x)))+
  geom_smooth(method='lm')+
  geom_segment(aes(xend=x,yend=hat_y))