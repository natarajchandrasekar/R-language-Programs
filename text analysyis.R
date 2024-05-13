devtools::install_github("bradleyboehmke/harrypotter")
library(tidyverse)
library(stringr)
library(tidytext)
library(harrypotter)

View(philosophers_stone[1:2])

text_tb<-tibble(chapter = seq_along(philosophers_stone),text = philosophers_stone)

view(text_tb)
 
text_tb %>% unnest_tokens(word,text)
titles <-c()

titles
series <- tibble()

for(i in seq_along(titles)){
  clean <- tibble( chapter = seq_along(books[i]])),text=books[[i]])%>%
 unnest_tokens(work,text) %>% mutate(book
  select(book,everything())
series<- rbind(series,clean)}
View(clean)
View(series)

series$book <-factor(series$book, levels = rev(titles))
view(series)