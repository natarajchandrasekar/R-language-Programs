#importing libraries
library(tidyverse)
library(stringr)
library(tidytext)
library(harrypotter)
library(textdata)

#sentiment dataset
View(Sentiments)

#lexicons
get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")


View(get_sentiments("afinn"))
View(get_sentiments("bing"))
view(get_sentiments("nrc"))

#book names
titles<- c("phiosphoers_stone","chambers of secrets","prisoner of azaban","goblet of fire","order of phoneix","half blood prince","deathlyhallows")
titles

#book list
books<-list((phiosphoers_stone,chambers_of_secrets,prisoner_of_azkaban,goblet_of_fire,order_of_phoneix,half_blood_prince,deathly_hallows)
View(books)
books

#tokening
series<-tribble()

for(i in seq_along(titles)){
  clean<-tibble(chapter=seq_along(books[[i]]),text=boooks[[i]])%>%
    unnest_tokens(word,text)%>%mutate(book=titles[i])%>%
    select(book,everything())
  series<-rbind(series,clean)}
View(clean)
View(series)

#setting book in order
series$book<-factor(series$book,levels=rev(titles))
View(series)

#nrc sentiment for books
senti<-series%>%right_join(get_sentiments("nrc"))%>%filter(!is.na(sentiment))%>%
  count(sentiment,sort=TRUE)
View(senti)

#visualize sentiment across eacg each book
series%>%group_by(book)%>%
  mutate(word_count=1:n(), index=word_count%/% 500+1)%>%
  inner_join(get_sentiments("bing"))%>%
  count(book,index=index,sentiment)%>%ungroup()%>%
  spread(sentiment,n,fill=0)%>%
  mutate(sentiment=posistive-negative,
         book= factor(book,levels=titles))%>%
  ggplot(aes(index,sentiment,fil=book))+
  geom_bar(alpha=0.5,stat="identity",show.legend = FALSE)+
  facet_wrap(~book,ncol = 2,scales = "free_x")

#comparing sentiments
afinn<-series%>%group_by(book)%.%mutate(word_count=1;n(),
          index=word_count%/%500+1)%>%
  inner_join(get_sentiments("afinn"))%>%group_by(book,index)%>%
  summarise(sentiment=sum(value))%>% mutate(method="AFINN")
View(afinn)

bing_and_nrc<-bind_rows(series%>%group_by(book)%>%
              mutate(word_count=1:n(),index=word_count%/%500+1)%>%
              inner_join(get_sentiments("bing"))%>%
              mutate(method="bing"),series%>%group_by(book)%>%
              mutate(word_count=1:n(),index=word_count%/% 500+1)%>%
              inner_join(get_sentiments("nrc")%>%
              filter(sentiment%in%c("positive,"negative)))%>%
              mutate(method="NRC"))%>%
              count(book,method,index=index,sentiment)%>%
              ungroup()%>%spread(sentiment,n,fill=0)%>%
              mutate(sentiment=positive-negative)%>%
              select(book,index,nethod,sentiment)
View(bing and nrc)
#Visualzing sentiment comparison
bind_rows(afinn,bing_and_nrc)%>%ungroup()%>%
  mutate(book=factor(book,levels=titles))%>%
  ggplot(aes(index,sentiment,fill=method))+
  geom_bar(alpha=0.8,STAT="identity",show.legend = FALSE)+
  facet_grid(book~method)


#common sentiment words
bing_word_counts<-series%>%inner_join(get_sentiments("bing"))%>%
  count(word,sentiment,sort=TRUE)%>%ungroup()
View(bing_word_counts)

#visulize top 10 bing words
bing_word_counts%>%group_by(sentiments)%>%top_n(10)%>%
  ggplot(aes(reorder(word,n),n,fill=sentiment))+
  geom_bar(alpha=0.8,stat="identity",show.legend = FALSE)+
  facet_wrap(~sentiment,scales="free_y")+
   labs(y="CONTRIBUTION TO SENTIMENT",x=NULL)+coord_flip()