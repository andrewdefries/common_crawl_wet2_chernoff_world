##################
library(wordcloud)
library(tm)
library(plyr)
library(stringr)
##################

files<-list.files(pattern=".txt")

wordblock<-Corpus(DirSource(getwd()))

wordblock<-tm_map(wordblock, tolower)

#wordblock_no_stop <-tm_map(wordblock, removeWords, stopwords("english"))

png("wordcloud_result.png")

wordcloud(wordblock)

#png("wordcloud_result_nostop.png")

#wordcloud(wordblock_no_stop)


############################
#Now for sentiment


# function score.sentiment
#https://sites.google.com/site/miningtwitter/questions/sentiment/analysis


score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
   # Parameters
   # sentences: vector of text to score
   # pos.words: vector of words of postive sentiment
   # neg.words: vector of words of negative sentiment
   # .progress: passed to laply() to control of progress bar

   # create simple array of scores with laply
   scores = laply(sentences,
   function(sentence, pos.words, neg.words)
   {
      # remove punctuation
      sentence = gsub("[[:punct:]]", "", sentence)
      # remove control characters
      sentence = gsub("[[:cntrl:]]", "", sentence)
      # remove digits?
      sentence = gsub('\\d+', '', sentence)

      # define error handling function when trying tolower
      tryTolower = function(x)
      {
         # create missing value
         y = NA
         # tryCatch error
         try_error = tryCatch(tolower(x), error=function(e) e)
         # if not an error
         if (!inherits(try_error, "error"))
         y = tolower(x)
         # result
         return(y)
      }
      # use tryTolower with sapply 
      sentence = sapply(sentence, tryTolower)

      # split sentence into words with str_split (stringr package)
      word.list = str_split(sentence, "\\s+")
      words = unlist(word.list)

      # compare words to the dictionaries of positive & negative terms
      pos.matches = match(words, pos.words)
      neg.matches = match(words, neg.words)

      # get the position of the matched term or NA
      # we just want a TRUE/FALSE
      pos.matches = !is.na(pos.matches)
      neg.matches = !is.na(neg.matches)

      # final score
      score = sum(pos.matches) - sum(neg.matches)
      return(score)
      }, pos.words, neg.words, .progress=.progress )

   # data frame with scores for each sentence
   scores.df = data.frame(text=sentences, score=scores)
   return(scores.df)
}

###This function does it all

# import positive and negative words
pos = readLines("positive_words.txt")
neg = readLines("negative_words.txt")


#############
#https://github.com/jeffreybreen/twitter-sentiment-analysis-tutorial-201107/blob/master/R/sentiment.R

sentence<-wordblock


###########
##scores = laply(sentences, function(sentence, pos.words, neg.words) {


sentence = gsub('[[:punct:]]', '', sentence)
		sentence = gsub('[[:cntrl:]]', '', sentence)
		sentence = gsub('\\d+', '', sentence)
		# and convert to lower case:
		sentence = tolower(sentence)

		# split into words. str_split is in the stringr package
		word.list = str_split(sentence, '\\s+')
		# sometimes a list() is one level of hierarchy too much
		words = unlist(word.list)
########

pos.words<-pos
neg.words<-neg

########

pos.matches = match(words, pos.words)
		neg.matches = match(words, neg.words)

		# match() returns the position of the matched term or NA
		# we just want a TRUE/FALSE:
		pos.matches = !is.na(pos.matches)
		neg.matches = !is.na(neg.matches)

		# and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
		score = sum(pos.matches) - sum(neg.matches)

########
# and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():

score = sum(pos.matches) - sum(neg.matches)

##return(score)
##}, pos.words, neg.words, .progress=.progress )

#	scores.df = data.frame(score=score.sentiment, text=sentence)
#	return(scores.df)

###############################################
###############################################
write.table(pos.matches, file="pos_matches.out")
write.table(neg.matches, file="neg_matches.out")
write.table(score, file="Overall_Score.txt")

write.table(subset(words, pos.matches), file="PositiveWordList.txt")
write.table(subset(words, neg.matches), file="NegativeWordList.txt")
