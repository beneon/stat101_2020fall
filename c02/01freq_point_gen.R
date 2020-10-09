library(ggplot2)
library(dplyr)

#parameter zone
mean = 4.5
sd = 0.5
n = 140

#construct df and plot
df = data.frame(id=seq(1,n),rbc=round(rnorm(n,mean,sd),2))

gen_freqency_table = function(x,breaks,title4group){
  round_digits = 2
  list_hist = hist(x,breaks=breaks,include.lowest = TRUE, right=FALSE,plot=FALSE)
  num_breaks = length(list_hist$breaks)
  num_x = length(x)
  df = data.frame(
    start = list_hist$breaks[1:num_breaks-1],
    end = list_hist$breaks[2:num_breaks],
    mid = round(list_hist$mids,round_digits),
    freq = list_hist$counts,
    percent = round(list_hist$counts/num_x*100,round_digits)
  )
  df$freq_cum = cumsum(df$freq)
  df$perc_cum = cumsum(df$percent)
  df[num_breaks-1,'perc_cum']=100
  df$grp = paste("[",df$start,",",df$end,")")
  df <- df %>% select(grp,mid,freq,freq_cum,percent,perc_cum)
  colnames(df) <- c(title4group, 'middle value', 'frequency', 'cumulative frequency', 'percentage(%)', 'cumulative percentage(%)')
  return(df)
}

df_freq_table <- gen_freqency_table(df$rbc,breaks = 10,title4group = 'rbc count,x10^12/L')
View(df_freq_table)
df %>% ggplot(aes(x=rbc))+geom_histogram(bins=14)