library("Matrix")
library("arules")
setwd("E:/study_material/master_slides/data_mining/homework2")
#��������
titanic=read.transactions("titanic.csv",format="basket",sep=",",rm.duplicates=TRUE)

#�õ�Ƶ���������
frequentsets=eclat(titanic,parameter=list(support=0.05,maxlen=6))
write(frequentsets, file="frequentsets.csv", sep=",", quote=TRUE, row.names=FALSE) 
#�鿴Ƶ���
inspect(frequentsets)
inspect(sort(frequentsets)[1:10]) 

#ʹ��apriori�㷨�õ���������
rules = apriori(titanic,parameter = list(support = 0.1,confidence = 0.8,minlen=2)) 
#�鿴��������״̬�;�������ǰ10��
summary(rules)
inspect(rules[1:10])

#���������ȶԹ�������������򲢲鿴ǰ10��
rules.sorted = sort(rules, decreasing=TRUE, by="lift")


#����һ������������Ӽ�����
subset.matrix = is.subset(rules.sorted, rules.sorted)
#������Խ������µ�Ԫ����Ϊ��
subset.matrix[lower.tri(subset.matrix, diag=T)] = NA
#���Ӽ�������ÿ��Ԫ�غʹ��ڵ���1�����ҳ���
redundant = colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
#�ӹ��������ȥ����Щ��
rules.pruned = rules.sorted[!redundant]
#����������ɵĽ����
summary(rules.pruned)
write(rules.pruned, file="rules.csv", sep=",", quote=TRUE, row.names=FALSE) 
inspect(rules.pruned[1:10])

#���ذ�arulesViz�� �������������ͼ�α�ʾ����
library(arulesViz)
plot(rules.pruned)
plot(rules.pruned, method="graph", control=list(type="items"))
plot(rules.pruned, method="paracoord", control=list(reorder=TRUE))