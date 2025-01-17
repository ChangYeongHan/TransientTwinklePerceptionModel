library(dplyr)
library(TukeyC)
library(readr)
library(sjstats)
library(nlme)
library(lmtest)
library(multcomp)
library(agricolae)
library(lsr)
library(lawstat)

Data2 <- read_csv("dir/Exp_12.csv")

View(Data2)
Data2$Sub <- factor(Data2$Sub)
Data2$First <- factor(Data2$First)
Data2$Hz <- factor(Data2$Hz)
TTP72 <- subset(Data2,First == 72)
TTP120 <- subset(Data2,First == 120)

TTP72_typical <- subset(TTP72, type == 1)
TTP120_typical <- subset(TTP120,type == 1)

TTP72_comp <- subset(TTP72, Hz == 90 | Hz == 120 | Hz == 144 )

TTP120_comp <- subset(TTP120, Hz == 60 | Hz == 72 | Hz == 80 )

TTP72_comp.out <- aov(Thres ~ type*Hz + Error(Sub/(type*Hz)), data = TTP72_comp)
summary(TTP72_comp.out)
effectsize::eta_squared(TTP72_comp.out, partial = TRUE)

TTP72_typical.out <- aov(Thres ~ Hz + Error(Sub/(Hz)), data = TTP72_typical)
summary(TTP72_typical.out)
effectsize::eta_squared(TTP72_typical.out, partial = TRUE)

levene.test(TTP72_typical$Thres,TTP72_typical$Hz)
tk_TTP72<-with(TTP72_typical, TukeyC(TTP72_typical.out,which='Hz'))
summary(tk_TTP72)

TTP120_comp.out <- aov(Thres ~ type*Hz + Error(Sub/(type*Hz)), data = TTP120_comp)
summary(TTP120_comp.out)
effectsize::eta_squared(TTP120_comp.out, partial = TRUE)

TTP120_typical.out <- aov(Thres ~ Hz + Error(Sub/(Hz)), data = TTP120_typical)
summary(TTP120_typical.out)
effectsize::eta_squared(TTP120_typical.out, partial = TRUE)

levene.test(TTP120_typical$Thres,TTP120_typical$Hz)
tk_TTP120<-with(TTP120_typical, TukeyC(TTP120_typical.out,which='Hz'))
summary(tk_TTP120)


Data3 <- read_csv("dir/Exp_3.csv")

View(Data3)
Data3$frame <- factor(Data3$frame)
Data3$Sub <- factor(Data3$Sub)

Data3.out <- aov(Thres ~ frame + Error(Sub/frame), data = Data3)
summary(Data3.out)
effectsize::eta_squared(Data3.out, partial = TRUE)

levene.test(Data3$Thres,Data3$frame)
tk_Data3<-with(Data3, TukeyC(Data3.out,which='frame'))
summary(tk_Data3)



Data4 <- read_csv("dir/Exp_4.csv")

View(Data4)
Data4$frame <- factor(Data4$frame)
Data4$Sub <- factor(Data4$Sub)
Data4$Oddity <- factor(Data4$Oddity)

Data4.out <- aov(Thres ~ frame + Error(Sub/(frame)), data = Data4)
summary(Data4.out)
effectsize::eta_squared(Data4.out, partial = TRUE)

levene.test(Data4$Thres,Data4$frame)
tk_Data4<-with(Data4, TukeyC(Data4.out,which='frame'))
summary(tk_Data4)

Data4_odd.out <- aov(Thres ~ Oddity + Error(Sub/(Oddity)), data = Data4)
summary(Data4_odd.out)
effectsize::eta_squared(Data4.out, partial = TRUE)

