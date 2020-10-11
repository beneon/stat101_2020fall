# Title     : var x + y
# Objective : demonstrate var(x+y) = var(x)+var(y)+2cov(x,y)
# Created by: Administrator
# Created on: 2020/10/11
library(ggplot2)
library(dplyr)

n = 50
x = rnorm(n,10,2)
y = rnorm(n,10,2)

var_x = var(x)
var_y = var(y)
var_x_y = var(x+y)
cov_x_y = cov(x,y)
#输出var(x)+var(y)+2cov(x,y)
print(2*cov_x_y + var_x + var_y)
#输出var(x+y)
print(var_x_y)
# 可以看到var(x+y)=var(x)+var(y)+2cov(x,y)

df = data.frame(x,y)
df = df %>% mutate(m_x = mean(x), m_y = mean(y))
df %>% ggplot(aes(x=x,y=y))+geom_point()+
  geom_hline(yintercept = df$m_y)+
  geom_vline(xintercept = df$m_x)