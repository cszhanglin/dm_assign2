library("dplyr")
setwd("~/homework2 ")
titanic = read.csv('train.csv',header = T)
titanic = select(titanic,Survived,Pclass,Sex,Age,SibSp,Parch)

#Survived�����У�ʹ�á�survived����������1��ʹ�á�dead����������0��
titanic[titanic$Survived == '1','Survived'] = 'survived'
titanic[titanic$Survived == '0','Survived'] = 'dead'

#Pclass�����У�ʹ�á�first����������1��ʹ�á�second����������2��ʹ�á�third����������3
titanic[titanic$Pclass == '1','Pclass'] = 'first'
titanic[titanic$Pclass == '2','Pclass'] = 'second'
titanic[titanic$Pclass == '3','Pclass'] = 'third'

#Age�����У�����С��10��Ϊ��kid��������10С��20��Ϊ��teenager����
# ����20С��40��Ϊ��youth��,����40С��60��Ϊ��middle-ager����
# ����60��Ϊ��elder��
ageNum = as.numeric(as.character(titanic$Age))
ageNum [is.na(ageNum)] = -1
titanic[ageNum  == -1,'Age'] = 'unknown'
titanic[ageNum  >=  0.0 & ageNum  < 10.0,'Age'] = 'kid'
titanic[ageNum  >= 10.0 & ageNum  < 20.0 ,'Age'] = 'teenager'
titanic[ageNum  >= 20.0 & ageNum  < 40.0 ,'Age'] = 'youth'
titanic[ageNum  >= 40.0 & ageNum  < 60.0 ,'Age'] = 'middle-ager'
titanic[ageNum  >= 60.0,'Age'] = 'elder'

#SibSp�����У��������ֵܽ��û�����ż��Ϊ��hasSibSp����û�е�Ϊ��noSibSp��
titanic[titanic$SibSp > 0,'SibSp'] = 'hasSibSp'
titanic[titanic$SibSp == 0,'SibSp'] = 'noSibSp'


#Parch�����У������и�ĸ���ߺ��ӵ�Ϊ��hasParch����û�е�Ϊ��noParch��
titanic[titanic$Parch> 0,'Parch'] = 'hasParch'
titanic[titanic$Parch== 0,'Parch'] = 'noParch'

write.csv(titanic,file = "titanic.csv",row.names = F)


