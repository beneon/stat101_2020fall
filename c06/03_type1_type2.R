library(ggplot2)
library(dplyr)
library(broom)
library(tidyr)
library(plotly)
# 清除内存
rm(list=ls())
# 样本量
sample_size = 90
z_alpha = 0.05
# 显示范围
plot_range = c(15,25)

# 我们先定义两个总体，第一个总体是N(18.6,4.1^2), 第二个总体是N(20,4.1^2)
para1 = list(
  mean=18.6,
  sd=4.1,
  color='red',
  fill='red',
  alpha=0.5
)
para2 = list(
  mean=20,
  sd=4.1,
  color='blue',
  fill='blue',
  alpha=0.5
)

# 计算正态分布临界值的一个辅助函数
crit_cal = function(alpha,mean=0,sd=1,is_2tail=TRUE,is_left=FALSE){
  if(!is_2tail){
    return(qnorm(1-alpha,mean,sd))
  }else{
    if(!is_left){
      return(qnorm(1-alpha/2,mean,sd))    
    }else{
      return(qnorm(alpha/2,mean,sd))
    }
  }
}

# 计算t分布临界值的一个辅助函数
crit_cal_t = function(alpha,df,mean=0,sd=1,is_2tail=TRUE,is_left=FALSE){
  if(!is_2tail){
    return(qt(1-alpha,df))
  }else{
    if(!is_left){
      return(qt(1-alpha/2,df))    
    }else{
      return(qt(alpha/2,df))
    }
  }
}


# 绘制两个正态曲线，0.05，双侧检验，也就是2.5，97.5两个位点
g_basic = ggplot(data=data.frame(x=plot_range),aes(x=x))+geom_vline(xintercept=para1$mean,color=para1$color)+geom_vline(xintercept=para2$mean,color=para2$color)

#参照总体(1)的正态曲线
g_para1 = g_basic+stat_function(fun=dnorm,args=list(mean=para1$mean,sd=para1$sd/sqrt(sample_size)),color=para1$color)+
  #双侧0.05条件下，参照总体的排除区间(红色涂色表示)
  stat_function(fun=dnorm,args=list(mean=para1$mean,sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill=para1$color,
                alpha=para1$alpha,
                xlim=c(
                  plot_range[1],
                  crit_cal(z_alpha,para1$mean,para1$sd/sqrt(sample_size),is_2tail=TRUE,is_left = TRUE)
                )
  )+
  stat_function(fun=dnorm,args=list(mean=para1$mean,sd=para1$sd/sqrt(sample_size)),
                geom='area',
                fill=para1$color,
                alpha=para1$alpha,
                xlim=c(
                  crit_cal(z_alpha,para1$mean,para1$sd/sqrt(sample_size),is_2tail=TRUE,is_left = FALSE),
                  plot_range[2]
                )
  )

#实际总体的正态曲线
g_para1_para2 = g_para1+
  stat_function(fun=dnorm,args=list(mean=para2$mean,sd=para2$sd/sqrt(sample_size)),color=para2$color)+
  #双侧0.05条件下，实际总体的排除区间
  stat_function(fun=dnorm,args=list(mean=para2$mean,sd=para2$sd/sqrt(sample_size)),
                geom='area',
                fill=para2$color,
                alpha=para2$alpha,
                xlim=c(
                  plot_range[1],
                  crit_cal(z_alpha,para2$mean,para2$sd/sqrt(sample_size),is_2tail=TRUE,is_left = TRUE)
                )
  )+
  stat_function(fun=dnorm,args=list(mean=para2$mean,sd=para2$sd/sqrt(sample_size)),
                geom='area',
                fill=para2$color,
                alpha=para2$alpha,
                xlim=c(
                  crit_cal(z_alpha,para2$mean,para2$sd/sqrt(sample_size),is_2tail=TRUE,is_left = FALSE),
                  plot_range[2]
                )
  )

#二类错误区间
g_para1_err2 = g_para1_para2+
  stat_function(fun=dnorm,args=list(mean=para2$mean,sd=para2$sd/sqrt(sample_size)),
                geom='area',
                fill='green',
                alpha=0.5,
                xlim=c(
                  crit_cal(z_alpha,para1$mean,para1$sd/sqrt(sample_size),is_2tail = TRUE, is_left=TRUE),
                  crit_cal(z_alpha,para1$mean,para1$sd/sqrt(sample_size),is_2tail = TRUE, is_left=FALSE)
                )
  )

# display g_para1_para2 and g_para1_err2
g_para1_para2
g_para1_err2


# sample size estimation



