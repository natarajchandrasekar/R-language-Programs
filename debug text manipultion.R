library(udpipe)


sentence="hey guys, welcome to the class, lets learn about text analytics"

z<-udpipe(sentence,"english")
View(z)

library(ggraph)

textplot_dependencyparser(z)

require(readtext)

data_mobydick <- readtext("https://www.gutenberg.org/cache/epub/2701/pg2701.txt")
View (data_mobydick)


names(data_mobydick)<-"moby dick"

textplots(
  kwic(tokens(data_mobydick),pattern="Whale"),
  kwic(tokens(data_mobydick),pattern="ahab"))

library(quantenda.textmodels)

data(data_corpus_irishbudget2010,package="quantenda.textmodels")


dt_dfm<-(tokens(data_corpus_irishbudget2010))
View(dt_dfm)

refscores<-c(rep(NA,4),1,-1,rep(NA,8))
View(refscores)

ws<-textmodel_wordscores(dt_dfm,y=refscores,smooth=1)
View(ws)

texplot_scaled(ws,highlighted=c("minister","have","our","budget"),highlighted_color=:"red")


pred<-predict(ws,se.fit=TRUE)
View(pred)


texplot_scaled(pred,margin=" documents",
               groups=docavrs(data_corpus_irishbudget2010,"party"))

pred_lbg<-predict(ws,se.fit=TRUE,rescaling="lbg")
View(pred_lbg)

textplot_scaled(pred_lbg,margin="documents",
                groups=docvars(data_corpus_irishbudget2010,"party"))


wf<-textmodels_wordfish(dfm(tokens(data_corpus_irishbudget2010)),dir=c(6,5))
View(wf)

textplot_scaled(wf,margin="features",
                highlighted=c("government","global","children","bank","economy","the","citizenship","productivity","deflicit"),
                              highlighted_color="red")

textplot_scaled(wf,groups=data_corpus_irishbudget2010$party)



ca<-textmodel_ca(dt_dfm)
View(ca)


summary(ca)

textplot_scaled(ca,margin="documents",
                groups=docvars(data_corpus_irishbudget2010,"party"))
View(textplot_scaled)