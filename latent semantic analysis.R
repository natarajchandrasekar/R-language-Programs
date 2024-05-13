library (tm)
library(ggplot2)
library(lsa)

#CREATING DATA

text<- c("transporting food by cars will cause global warming. So we should go local.",
         "we should try to convince our parents to stop using cars because it will cause global warming.",
         "some food,such as mango,requires a warm weather to grow. so they have to be transported to canada",
         "a typical electronic circuit can be built with a battery, a bulb, just like water flows through a tube.",
         "electricity flows from batteries to bulb, just  like water flows through a tube.",
         "batteries have chemical energy in it. Then electrons flow through a light bulb to light it up.",
         "birds can fly because they have feather and they are light.",
         "why some birds like pigeon can fly while some others like chicken cannot?",
         "feather is important for birds fly. if feather on a bird's wings can be removed,this bird cannot fly.")
text
#factoring
View<-factor(rep(c("view1","view2","view3"),each=3))
View

#converting it to dataframe
df<-data.frame(text,View,stringsAsFactors =FALSE)
df

#preparing corpus
Corpus<-Corpus(VectorSource(df$text))
Corpus<-tm_map(Corpus,tolower)
Corpus<-tm_map(Corpus,removePunctuation)
Corpus<-tm_map(Corpus,function(x)removeWords(x,stopwords("english")))
Corpus<-tm_map(Corpus,stemDocument,language="english")

#term-document matrix
td.mat<-as.matrix(TermDocumentMatrix(Corpus))
td.mat

#distance matrix
dist.mat<-dist(t(as.matrix(td.mat)))

#classical multidimensional scaling
fit<-cmdscale(dist.mat,eig=TRUE,k=2)
fit

#converting to data frame
points<-data.frame(x=fit$points[,1],y=fit$points[,2])
View(points)

#distance matrix plot
ggplot(points,aes(x=x,y=y))+
  geom_point(data=points,aes(x=x,y=y,color=df$view))+
  geom_point(data=points,aes(x=x,y=y-0.2 ,label=row.names(df)))

#weighting
td.mat.lsa<-lw_bintf(td.mat)*gw_idf(td.mat)
View(td.mat.lsa)

#Lsa
lsaspace<-lsa(td.mat.lsa)
lsaspace

#computing distance matrix from lsa
dist.mat.lsa<-dist(t(as.textmatrix(lsaspace)))
dist.mat.lsa

#classical multidimensional scaling for lsa
fit_lsa<-cmdscale(dist.mat.lsa,eig=TRUE,k=2)
fit_lsa


#converting to dataframe
points_lsa<-data.frame(x=fit$points[,1],y=fit$points[,2])
View(points_lsa)

#distance matrix plot lsa
ggplot(points_lsa,aes(x=x,y=y))+
  geom_point(data=points_lsa,aes(x=x,y=y,color=df$view))+
  geom_point(data=points_lsa,aes(x=x,y=y-0.2 ,label=row.names(df)))

#importing 3d 
library(scatterplot3d)

#classical multidimensional scaling for LSA
fit2<-cmdscale(dist.mat.lsa,eig = TRUE,k=3)
fit2

colors<-rep(c("blue","green","red"),each=3)
colors

#3d plot
scatterplot3d(fit2$points[,1],fit2$points[,2],fit2$points[,3],
              color=colors,pch=16,main="semantic space scaled to 3d",
              xlab="x",ylab="y",zlab="z",type="h")