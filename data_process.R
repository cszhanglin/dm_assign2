library("dplyr")
setwd("~/homework2 ")
titanic = read.csv('train.csv',header = T)
titanic = select(titanic,Survived,Pclass,Sex,Age,SibSp,Parch)

#Survived类型中，使用“survived”代替数据1，使用“dead”代替数据0。
titanic[titanic$Survived == '1','Survived'] = 'survived'
titanic[titanic$Survived == '0','Survived'] = 'dead'

#Pclass类型中，使用“first”代替数据1，使用“second”代替数据2，使用“third”代替数据3
titanic[titanic$Pclass == '1','Pclass'] = 'first'
titanic[titanic$Pclass == '2','Pclass'] = 'second'
titanic[titanic$Pclass == '3','Pclass'] = 'third'

#Age类型中，年龄小于10的为“kid”，大于10小于20的为“teenager”，
# 大于20小于40的为“youth”,大于40小于60的为“middle-ager”，
# 大于60的为“elder”
ageNum = as.numeric(as.character(titanic$Age))
ageNum [is.na(ageNum)] = -1
titanic[ageNum  == -1,'Age'] = 'unknown'
titanic[ageNum  >=  0.0 & ageNum  < 10.0,'Age'] = 'kid'
titanic[ageNum  >= 10.0 & ageNum  < 20.0 ,'Age'] = 'teenager'
titanic[ageNum  >= 20.0 & ageNum  < 40.0 ,'Age'] = 'youth'
titanic[ageNum  >= 40.0 & ageNum  < 60.0 ,'Age'] = 'middle-ager'
titanic[ageNum  >= 60.0,'Age'] = 'elder'

#SibSp类型中，其中有兄弟姐妹或者配偶的为“hasSibSp”，没有的为“noSibSp”
titanic[titanic$SibSp > 0,'SibSp'] = 'hasSibSp'
titanic[titanic$SibSp == 0,'SibSp'] = 'noSibSp'


#Parch类型中，其中有父母或者孩子的为“hasParch”，没有的为“noParch”
titanic[titanic$Parch> 0,'Parch'] = 'hasParch'
titanic[titanic$Parch== 0,'Parch'] = 'noParch'

write.csv(titanic,file = "titanic.csv",row.names = F)



