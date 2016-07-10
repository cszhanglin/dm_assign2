library("Matrix")
library("arules")
setwd("E:/study_material/master_slides/data_mining/homework2")
#加载数据
titanic=read.transactions("titanic.csv",format="basket",sep=",",rm.duplicates=TRUE)

#得到频繁项集并保存
frequentsets=eclat(titanic,parameter=list(support=0.05,maxlen=6))
write(frequentsets, file="frequentsets.csv", sep=",", quote=TRUE, row.names=FALSE) 
#查看频繁项集
inspect(frequentsets)
inspect(sort(frequentsets)[1:10]) 

#使用apriori算法得到关联规则
rules = apriori(titanic,parameter = list(support = 0.1,confidence = 0.8,minlen=2)) 
#查看规则总体状态和具体规则的前10项
summary(rules)
inspect(rules[1:10])

#根据提升度对关联结果降序排序并查看前10项
rules.sorted = sort(rules, decreasing=TRUE, by="lift")


#生成一个关联规则的子集矩阵，
subset.matrix = is.subset(rules.sorted, rules.sorted)
#将矩阵对角线以下的元素置为空
subset.matrix[lower.tri(subset.matrix, diag=T)] = NA
#将子集矩阵中每列元素和大于等于1的列找出来
redundant = colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
#从规则矩阵中去掉这些列
rules.pruned = rules.sorted[!redundant]
#检查最终生成的结果集
summary(rules.pruned)
write(rules.pruned, file="rules.csv", sep=",", quote=TRUE, row.names=FALSE) 
inspect(rules.pruned[1:10])

#加载包arulesViz， 画出关联规则的图形表示方法
library(arulesViz)
plot(rules.pruned)
plot(rules.pruned, method="graph", control=list(type="items"))
plot(rules.pruned, method="paracoord", control=list(reorder=TRUE))