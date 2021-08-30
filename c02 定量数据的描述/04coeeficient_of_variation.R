# Title     : coefficient of variation
# Objective : generate 3 dataset, calculate their cv, coupled with graph
# Created by: Administrator
# Created on: 2020/10/11
# 程序说明. cv_trial负责进行一次试验, 对三个样本,
# 样本量均为100, 而其分布的CV分别为20%, 33%和50%
# cv_trial会返回在这次试验中, 三个样本小于0的项的数量
# 之后我们将cv_trial反复运行100次, 在这100次中
# 三种样本小于0的项的数量的分布规律, 我们用直方图来显示
# 其中cv_20指CV值为20%, cv_33指cv值为33%, 而cv_50指cv值为50%

library(dplyr)
library(ggplot2)
library(purrr)
library(tidyr)

cv_trial = function(trials){
  id = 1:100
  # cv 20%
  x1 = rnorm(100,5,1)
  # cv: 33%
  x2 = rnorm(100,3,1)
  # cv: 50:
  x3 = rnorm(100,2,1)

  df = data.frame(trials,id,x1,x2,x3)

  df_rst = df %>% 
    mutate(cv_20= x1<0, cv_33= x2<0, cv_50= x3<0)  %>%
    summarise(cv_20=sum(cv_20), cv_33 = sum(cv_33), cv_50 = sum(cv_50))
  return(df_rst)
}

id = 1:100
l_df = map(id,cv_trial)
df_rst = do.call(rbind.data.frame, l_df)
df_rst = df_rst %>% pivot_longer(
  cols=c('cv_20','cv_33','cv_50'),
  names_to = 'cv_grp',
  values_to = 'freq'
)
df_rst %>% ggplot(aes(x=freq,fill=cv_grp))+geom_histogram(position='dodge')


