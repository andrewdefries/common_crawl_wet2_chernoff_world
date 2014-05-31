library(wordcloud)
library(tm)


files<-list.files(pattern=".txt")

wordblock<-Corpus(DirSource(getwd()))

wordblock<-tm_map(wordblock, tolower)

#wordblock_no_stop <-tm_map(wordblock, removeWords, stopwords("english"))

png("wordcloud_result.png")

wordcloud(wordblock)

png("wordcloud_result_nostop.png")

wordcloud(wordblock_no_stop)
