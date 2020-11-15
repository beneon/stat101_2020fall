library(dplyr)
library(ggplot2)

id = seq(1,45,1)
grp = c(
  rep(1,15),
  rep(2,15),
  rep(3,15)
  )

score = c(
  rnorm(15,13,1.2),
  rnorm(15,14.5,1.3),
  rnorm(15,10.3,0.9)
)

df = data.frame(id,grp,score)
mean_val=mean(df$score)
# 没有加入分组信息的时候
g1 = ggplot(data=df,aes(x=id,y=score))+
  geom_point()+
  geom_hline(yintercept=mean_val)+
  geom_segment(aes(xend=id,yend=mean_val),color='green',size=1)
g1

# 加入分组信息以后，分别用各组的均值（红点）作为该组的代表
# 现在各个黑点到对应组红点的距离（蓝色）：
# 首先计算统计指标
df_stat = df %>% group_by(grp) %>% 
  summarise(mean=mean(score),sd=sd(score)) %>% select(grp,mean,sd)
df = left_join(df,df_stat,by='grp')
df_mask = df$id == 18
df_sel = df[df_mask,]
g2 = df_sel %>% ggplot(aes(x=grp,y=score))+
  geom_point()+
  geom_hline(yintercept = mean_val)+
  geom_point(aes(x=grp,y=mean),size=2,color='red')+
  geom_segment(aes(x=grp+0.01,xend=grp+0.01,yend=mean),color='blue',size=1)+
  geom_segment(aes(xend=grp,y=mean,yend=mean_val),color='red',size=1)+
  geom_segment(aes(x=grp+0.02,xend=grp+0.02,yend=mean_val),color='green',size=1)+
  xlim(1,3.1)
g2

g3 = df %>% ggplot(aes(x=grp,y=score,group=grp))+
  geom_boxplot()+
  geom_jitter()
g3