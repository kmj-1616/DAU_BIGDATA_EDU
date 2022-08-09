iris
head(iris,4)
str(iris)
table(iris$Species)
head(iris) #위에서 밑으로 6개
tail(iris) #밑에서 위로 6개
nrow(iris) #행의 개수
summary(iris)

#subset(data,select=(대상여변수명)) :변수만추출(열)
temp <- subset(iris, select = c(Sepal.Length, Petal.Length))
head(temp)

library(googleVis)
Fruits
#Fruits 데이터프레임에서 subset을 이용해 수치데이터만 선택해보세요
subset(Fruits, select = c(Year, Sales, Expenses, Profit))

subset(iris, select = -Species)
subset(iris, select = c(-Sepal.Length, -Sepal.Width))
subset(iris, select = -c(Sepal.Length, Sepal.Width))

#subset(data,subset=(조건)) :대상자만 추출(행)
mean(iris$Sepal.Length)
temp <- subset(iris, subset=(Sepal.Length>mean(Sepal.Length)))
head(temp)
temp
temp <- subset(iris, subset = (Sepal.Length>mean(Sepal.Length) &
                         Petal.Length>mean(Petal.Length)))
plot(iris$Sepal.Length, iris$Petal.Length, pch=19, col="red")

library(dplyr)
#select
temp <- select(iris, Petal.Length, Petal.Width)
head(temp, 2)

temp <- iris %>% 
  select(Petal.Length, Petal.Width)

#Fruits 데이터프레임에서 수치데이터만 선택하세요
temp <- select(Fruits, Year, Sales:Profit)
temp

temp <- Fruits %>%
  select(Year, Sales:Profit)
head(temp)

#Fruits 데이터프레임에서 Date 변수를 제거하세요
df <- select(Fruits, -Date)
df

df <- Fruits %>% 
  select(-Date)
head(df)


#filter
filter(Fruits, Fruit=="Oranges")
filter(Fruits, Profit>=10)
filter(Fruits, Profit<mean(Profit))
mean(Fruits$Profit)
filter(Fruits, Year==2010, Location=="West") #AND
filter(Fruits, Year==2010 | Location=="West") #OR

Fruits %>% 
  filter(Year==2010, Location=="West")
Fruits %>% 
  filter(Year==2010 | Location=="West")

#Mutate
Fruits
df <- select(Fruits, -Date)
df
#(1)
Tax <- Fruits$Sales*0.1
Tax
df <- cbind(df, Tax)
df

df <- select(df, -Tax)
#(2)
df$Tax <- df$Sales*0.1
df

df$SProfit <- df$Profit-df$Tax
df

#(3)mutate
Fruits
Newdf <- select(Fruits, -Date)
Newdf
Newdf <- mutate(Newdf, Tax=Sales*0.1, SProfit=Profit-Tax)
Newdf

Newdf <- Newdf %>% 
  mutate(Tax=Sales*0.1, SProfit=Profit-Tax)

#1)Fruits 데이터프레임에서 'East' 데이터만 추출해서 그 중 수치데이터인
#Sales, Expenses, Profit의 평균과 표준편차를 산출하세요
Fruits
df1 <- filter(Fruits, Location=="East")
df1
summarise(df1, mean(Sales), sd(Sales),
          mean(Expenses), sd(Expenses),
          mean(Profit), sd(Profit))
df1 <- Fruits %>% 
  filter(Location=="East") %>% 
  summarise(mean(Sales), sd(Sales),
            mean(Expenses), sd(Expenses),
            mean(Profit), sd(Profit))

#2)Fruits 데이터프레임에서 계산상의 문제로 판매액이 지금의 데이터보다 50$ 적게 입력되었다.
#따라서 정확한 비용을 산출하고 이 변수를 NewSales라고 두고 이 값의
#세금(Ntax), 순이익(Nprofit)을 산출하여 순이익을 년도별로 기술통계량을 산출하세요.
#최대, 최소, 평균, 표준편차
Fruits
df2 <- mutate(Fruits, NewSales=Sales+50, Ntax=NewSales*0.1, Nprofit=NewSales-Ntax)
df2 <- group_by(df2, Year)
summarise(df2, max(Nprofit),min(Nprofit),sd(Nprofit))

df2 <- Fruits %>% 
  mutate(NewSales=Sales+50, Ntax=NewSales*0.1, Nprofit=NewSales-Ntax) %>% 
  group_by(Year) %>% 
  summarise(max(Nprofit),min(Nprofit),sd(Nprofit))

#불러오기
#excel
getwd()
setwd("C:/Users/권미정/Desktop/Lecdata/R_data")

install.packages("readxl")
library(readxl)
ED <- read_excel("sample2.xlsx", sheet = 2)
ED
CD <- read.csv("sample1.csv", header=T)
CD

install.packages("reshape2")
library(reshape2)
ReCD <- melt(CD, id.vars = "LOCAL")
names(ReCD) <- c("LOCAL","Month","Rain")
ReCD

install.packages("psych")
library(psych)
describe(ReCD$Rain)
boxplot(ReCD$Rain)
describeBy(ReCD$Rain, ReCD$Month)

dcast(ReCD,LOCAL-Month)
dcast(ReCD,Month-LOCAL)

library(reshape2)
head(tips)
plot(tips$total_bill, tips$tip)

#1) 성별에 따라서 팁의 평균이 차이가 있을 것이다
describeBy(tips$tip, tips$sex)
var.test(tip~sex, tips)
t.test(tip~sex, data=tips, var.equal=T)
nrow(tips)
#2) 흡연여부에 따라서 팁의 평균의 차이가 있을 것이다
describeBy(tips$tip, tips$smoker)
var.test(tip~smoker, tips)
t.test(tip~smoker, tips, var.equal=T)
#3) 식당에 온 시간에 따라서 팁의 평균의 차이가 있을 것이다
describeBy(tips$tip, tips$time)
var.test(tip~time, tips)
t.test(tip~time, tips, var.equal=T)

#1)과일판매액의 지역별 평균 차이를 분석하시오
Fruits
library(psych)
describeBy(Fruits$Sales, Fruits$Location)
var.test(Sales~Location, data=Fruits)
t.test(Sales~Location, data=Fruits, var.equal=T)
#var.test 결과에서 p-value<0.05면 var.equal=F
#var.test 결과에서 p-value>0.05면 var.equal=T

#2)그룹이 3개 이상 anova 분산 분석, 변량분석
head(tips, 2)
table(tips$day)
describeBy(tips$tip, tips$day)
Result <- aov(tip~day, tips)
summary(Result)

#iris 데이터를 이용하여 iris 종류에 따른 Sepal.Length 평균 차이 분석
head(iris,2)
describeBy(iris$Sepal.Length, iris$Species)
Result <- aov(iris$Sepal.Length~iris$Species)
summary(Result)

#사후검정(Post Hoc)
#Duncan's method: PostHocTest(aov_R, method="duncan")
install.packages("DescTools")
library(DescTools)
PostHocTest(Result, method="scheffe")
PostHocTest(Result, method="duncan")

#Fruits 데이터에서 과일별로 이익의 평균 차이 분석
Fruits
describeBy(Fruits$Fruit, Fruits$Profit)
Result <- aov(Fruits$Fruit~Fruits$Profit)
Summary(Result)