# Title     : TODO
# Objective : TODO
# Created by: Administrator
# Created on: 2020/10/10
library(dplyr)

pt = c(rep(1,5),rep(2,5))
bp = c(162,145,178,142,186,164,160,163,159,166)

df = data.frame(pt = pt, bp=bp)
# 极差(range)的计算演示
df_range = df %>% group_by(pt) %>% summarise(max=max(bp),min=min(bp),range=max-min)
# IQR的计算演示
df_iqr = df %>% group_by(pt) %>% summarise(q1=quantile(bp,0.25),q3=quantile(bp,0.75),iqr=q3-q1)
# 方差(variance)的计算演示
df_var = df %>% group_by(pt) %>% mutate(
  xbar=mean(bp),
  `x-xbar` =bp-xbar,
  `(x-xbar)^2` = `x-xbar`^2, `sum((x-xbar)^2)` = cumsum(`(x-xbar)^2`),
  `expectation((x-xbar)^2)` = cummean(`(x-xbar)^2`)
)

