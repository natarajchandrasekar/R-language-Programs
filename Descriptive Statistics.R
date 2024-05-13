library(modeest)
Starbucks<-read.csv("C:\\Users\\WELCOME\\Documents\\Data Science files\\Assignment-DS\\Starbucks-(DataSet).csv")
View(Starbucks)
str(Starbucks)

#MEAN

Carbmean<-mean(Starbucks$Total.Carbohydrates..g.)
print(Carbmean)
Sugarmean<-mean(Starbucks$Sugars..g.)
print(Sugarmean)
Transmean<-mean(Starbucks$Trans.Fat..g.)
print(Transmean)
Cholmean<-mean(Starbucks$Cholesterol..mg.)
print(Cholmean)

#MEDIAN

Dietmed<-median(Starbucks$Dietary.Fibre..g.)
print(Dietmed)
Promed<-median(Starbucks$Protein..g.)
print(Promed)
Calmed<-median(Starbucks$Calories)
print(Calmed)
Sodmed<-median(Starbucks$Sodium..mg.)
print(Sodmed)

#MODE

Caffmod<-mfv(Starbucks$Caffeine..mg.)
print(Caffmod)
Ironmod<-mfv(Starbucks$Iron....DV.)
print(Ironmod)
Calcmod<-mfv(Starbucks$Calcium....DV.)
print(Calcmod)
Totmod<-mfv(Starbucks$Total.Fat..g.)
print(Totmod)


#STANDARD DEVIATION

Prosd<-sd(Starbucks$Protein..g.)
print(Prosd)
Sudsd<-sd(Starbucks$Sugars..g.)
print(Sudsd)
Cholsd<-sd(Starbucks$Cholesterol..mg.)
print(Cholsd)


#VARIANCE

Transvar<-var(Starbucks$Trans.Fat..g.)
print(Transvar)
Proteinvar<-var(Starbucks$Protein..g.)
print(Proteinvar)


#RANGE


Calrar<-max(Starbucks$Calories)-min(Starbucks$Calories)
print(Calrar)
Totrar<-max(Starbucks$Saturated.Fat..g.)-min(Starbucks$Saturated.Fat..g.)
print(Totrar)

#SKEWNESS & KURTOSIS

library(moments)
Starbucks<-read.csv("C:\\Users\\WELCOME\\Documents\\Data Science files\\Assignment-DS\\Starbucks-(DataSet).csv")
View(Starbucks)
kurtosis(Starbucks$Calories)
skewness(Starbucks$Calories)
skewness(Starbucks$Protein..g.)



