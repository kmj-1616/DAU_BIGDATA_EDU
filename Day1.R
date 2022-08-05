#데이터의 확인하기
(a<-20)
a<-20
a->b
<- 
a <- 10
b <- "ABC"
c <- TRUE
d <- T
e <- FALSE
class(a)
class(b)
class(c)
class(d)
class(e)


DA <- "2022-08-04"
class(DA)
DE <- as.Date(DA)
class(DE)
DN <- as.numeric(DE)
TT <- as.Date("1970-01-01")
tt <- as.numeric(TT)

#태어난 지 며칠째인지 계산하기
Sys.Date() #오늘 
as.numeric(Sys.Date())-as.numeric(as.Date("2001-10-06"))

#vector
x <- c(1,4,6,8,20,34,5,9)
x[5]
x[2:6]
x[c(1,7)]
x[c(1:4,7)]

#matrix
M1 <- matrix(x, nrow=2, ncol=4)
M1
M2 <- matrix(x, nrow=2, ncol=4, byrow = T) #행부터 채우기
M2
M2[2,2]
M2[,3]
M2[2,3:4]
M2[1,c(1:2,4)]

#array
AR1 <- array(1:40,c(4,5,2))
AR1
AR1[,,2]
AR1[2,,]
AR1[,3,]
AR1[2,3,2]

#dataframe
Id <- c(1:4)
Age <- c(45,27,56,75)
Status <- c("Poor","Improved","Excellent","Poor")
Type <- c("T1","T2","T2","T1")

df <- data.frame(Id,Type,Status,Age)
M1
class(M1)
class(AR1)
class(df)
class(x)
str(df)
df$Age #가장 많이 씀
df[,4] #옆으로
df["Age"] #밑으로
df$Type
with(df,
     print(Age)) #$ 안 쓸 때 p.30
with(df,{
  print(Age)
  plot(Age)
  summary(Age)
})
str(df)
df$Type <- factor(df$Type) #자료형 바꾸기 p.31
df$Type <- as.factor(df$Type)
df$Status <- factor(df$Status, order=T,
                    levels = c("Poor","Improved","Excellent")) #levels 순서 부여


install.packages("googleVis")
library(googleVis)
Fruits

#aggregate
aggregate(Sales~Fruit, Fruits, sum) #(계산될컬럼~기준될컬럼,데이터,함수)
aggregate(Sales~Date, Fruits, mean)
#mean,min,max,sd(평균, 최솟값, 최댓값, 표준편차)
#지역별 이익을 최대값, 최소값을 구하세요.
aggregate(Profit~Location, Fruits, max)
aggregate(Profit~Location, Fruits, min)

library(dplyr)
#group_by, summarise[ze]
#1) sales를 과일별로 합
G.t <- group_by(Fruits, Fruit)
summarise(G.t, sum(Sales))
summarise(G.t, mean(Sales))
summarise(G.t, M_Profit=mean(Profit), SD_Profit=sd(Profit))

# %>% : Ctrl+Shift+m
Fruits %>% 
  group_by(Fruit) %>% 
  summarise(mean(Sales), sd(Sales))

#2) sales를 연도별로 평균
Fruits %>% 
  group_by(Year) %>% 
  summarise(mean(Sales))

#3) profit을 지역별로 최대 최소값
Fruits %>% 
  group_by(Location) %>% 
  summarise(max(Profit), min(Profit))

#정렬 sort(), order()
x
#1,4,5,6,8,9,20,34
sort(x)
sort(x, decreasing=T)

order(x) #index 출력
x[order(x)]
x[order(x, decreasing=T)]

x[order(-x)]

#arrange()
Fruits
arrange(Fruits, Fruit)
Fruits %>% 
  arrange(Fruit)


arrange(Fruits, Fruit, desc(Year))
Fruits %>% 
  arrange(Fruit, desc(Year))

#과일별로 지역에 따라 이익의 순서대로 정렬하시오.
Fruits %>% 
  arrange(Fruit, Location, Profit)
