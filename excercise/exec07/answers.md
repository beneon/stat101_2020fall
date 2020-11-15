# 第七章习题解析

(1) 建立检验假设，确定检验水准
$H_0: \mu_1=\mu_2$，对照组和治疗组治疗前后血脂差值无差异
$H_1: \mu_1 \neq \mu_2$，对照组和治疗组治疗前后血脂差值有差异
$\alpha=0.05$
(2) 计算检验统计量
已知总体$\mu_0=1.8$，在$H_0$成立的假设下，2样本均值差符合t分布.
由$\bar{d_t}$=1.2 mmol/L, $\sum{d_t^2}=22.1$，$n_t=15$；$\bar{d_c}$=0.9 mmol/L, $\sum{d_c^2}=16.2$, $n_c=18$
可得
$s_t=\sqrt{\frac{\sum{d_t^2}-n_t\bar{d_t}^2}{n_t-1}}=0.19$
$s_c=\sqrt{\frac{\sum{d_c^2}-n_t\bar{d_c}^2}{n_c-1}}=0.31$
作方差齐性检验
$F_{17,14}=\frac{s_c^2}{s_t^2}=2.66$
通过查表可得，在$\alpha=0.05$的水平下，$F_{\alpha,17,14}=2.43$, F大于临界值，于是P<0.05, 拒绝认为2样本具有方差齐性。
于是t值计算公式为：
$t=\frac{\bar{d_t}-\bar{d_c}}{\sqrt{s_t^2/n_t+s_c^2/n_c}}=\frac{0.3}{0.088}=3.33$
其自由度为
$v=\frac{(s_t^2/n_t+s_c^2/n_c)^2}{\frac{(s_t^2/n_t)^2}{n_t-1}+\frac{(s_c^2/n_c)^2}{n_c-1}}=28.7$

(3) 根据p值做出推断结论
对自由度向下取整查找t值表中自由度为28的，$\alpha=0.05$双侧检验的临界值t为2.048。由于$t=3.33>t_{\alpha/2,28}$，P<0.05，拒绝H0，接受H1，故认为对照组和治疗组治疗前后血脂差值有差异，对照组治疗前后的血脂差异大于对照组。

统计表示例：

组别|n|治疗前后血脂差值|
--|--|--|
治疗组|15|$1.2\pm 0.19$|
对照组|18|$0.9\pm 0.31$|
t||3.33|
p||<0.05|


2. 
(1) 建立检验假设，确定检验水准
$H_0: \mu_1=\mu_2$，男性和女性MDAS评分无差异
$H_1: \mu_1 \neq \mu_2$，男性和女性MDAS评分有差异
$\alpha=0.05$

(2) 计算检验统计量
不知道总体标准差的情况下，2样本均值差符合t分布
从题目数据可得：
$\bar{x_{m}}=17.95, s_{m}=1.37, n_m=168$,
$\bar{x_{f}}=14.20, s_{f}=1.01, n_m=132$
作方差齐性检验
$F_{168,132}=\frac{s_m^2}{s_f^2}=1.84$
通过查表可得$F_{\alpha/2,168,132}$为（分子分母自由度分别向下取最接近数据，本题均取100）可得临界值为1.39，$F_{168,132}=1.84$>1.39, 拒绝方差齐性假设

$t=\frac{\bar{x_m}-\bar{x_f}}{\sqrt{s_m^2/n_m+s_c^2/n_f}}=\frac{3.75}{0.14}=27.3$
其自由度为
$v=\frac{(s_m^2/n_m+s_f^2/n_f)^2}{\frac{(s_m^2/n_m)^2}{n_m-1}+\frac{(s_f^2/n_f)^2}{n_f-1}}=296.86$

(3) 根据p值做出推断结论
查表向下找最接近的自由度为200，临界值为1.97，由于t=27.3>1.97, P<0.05。拒绝H0，接受H1，故认为男性和女性MDAS评分有差异，男性MDAS评分大于女性MDAS评分。

统计表示例：

组别|n|MDAS评分|
--|--|--|
男性|168|$17.95\pm 1.37$|
女性|132|$14.20\pm 1.01$|
t||27.3|
p||<0.05|