
library(udpipe)#for data prep in NLP 

#importing database
data(brussels_listings,package = 'udpipe')

#viewing database
View(brussels_listings)

#segregating a column
x<-table(brussels_listings$neighbourhood)
View(x)

#sorting
x<-sort(x)
View(x)

library(textplot)#For complex relations in texts

#word Frequency bar chart
textplot_bar(x,panel="Locations",col.panel="darkgrey",
             xlab="listings",cextext=0.75,addpct=TRUE,
             cexpct=0.5)

#importing data base
data(brussels_reviews_anno,package='udpipe')
View(brussels_reviews_anno)

#segregating data
y<-subset(brussels_reviews_anno,
          xpos %in% "NN"&language %in% "n1" &!is.na(lemma))
View(y)

#document term frequencies
y<-document_term_frequencies(y,document="doc_id",term="lemma")
View(y)

#document term matrix
dtm<-document_term_matrix(y)
dtm

#removing low frequency words
dtm<-dtm_remove_lowfreq(dtm,maxterms = 60)
dtm

#correaltion matrix
cor<-dtm_cor(dtm)
View(cor)

library(glasso)#for graphical lasso

#word coorelation plot
#textplot_correlation_glasso(cor,exclude_zero=TRUE)

#segregating data
w<-subset(brussels_reviews_anno,xpos %in% "JJ" &language %in%
            
            "fr")
View(w)

#cooccuring terms
w<-cooccurrence(w,group="doc_id",term="lemma")
View(w)


#cooccurence plot 
textplot_cooccurrence(w,top_n=25,subtitle="showing only top 25")

#dependency parsing
#creating data
sentence="Hey friends, welcome to the class .Lets learn about text analytics"

#tokenize an dpos tag for each word in data
z<-udpipe(sentence,"english")
View(z)

library(ggraph)

#dependeny parser plot
textplot_dependencyparser(z)

