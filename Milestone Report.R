library(stringi)
library(ggplot2)
library(wordcloud)
library(NLP)
library(tm)


file.info("data/en_US/en_US.blogs.txt")$size / 1024 ^ 2
file.info("data/en_US/en_US.news.txt")$size / 1024 ^ 2
file.info("data/en_US/en_US.twitter.txt")$size / 1024 ^ 2
sample.size <- 10000

blogs_text <-
  readLines("data/en_US/en_US.blogs.txt", encoding = "UTF-8", n = sample.size)
news_text <-
  readLines("data/en_US/en_US.news.txt", encoding = "UTF-8",)
twitter_text <-
  readLines("data/en_US/en_US.twitter.txt", encoding = "UTF-8")

length(blogs_text)
length(news_text)
length(twitter_text)

stri_stats_general(blogs_text)
stri_stats_general(news_text)
stri_stats_general(twitter_text)

blogs_words   <- stri_count_words(blogs_text)
summary(blogs_words)
qplot(blogs_words)
news_words    <- stri_count_words(news_text)
summary(news_words)
qplot(news_words)
twitter_words    <- stri_count_words(twitter_text)
summary(twitter_words)
qplot(twitter_words)

blogs_text = sample(blogs_text, sample.size)
news_text = sample(news_text, sample.size)
twitter_text = sample(twitter_text, sample.size)

create_corpus <- function(text_data){
  sample.size <- 10000
  corpus_temp <-   VCorpus(VectorSource( sample(text_data, sample.size) ))
  corpus_temp <- tm_map(corpus_temp, removeNumbers)
  corpus_temp <- tm_map(corpus_temp, stripWhitespace)
  corpus_temp <- tm_map(corpus_temp, removePunctuation,preserve_intra_word_dashes = TRUE)
  corpus_temp <- tm_map(corpus_temp, content_transformer(tolower))  
}

blogs_corpus <- create_corpus(blogs_text)
news_corpus <- create_corpus(news_text)
twitter_corpus <- create_corpus(twitter_text)

ter