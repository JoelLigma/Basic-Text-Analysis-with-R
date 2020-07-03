Title: "Test Mining Analysis"
Author: "Joel"

# set working directory
setwd("C:/Users/joell/Desktop/New Data/")

# load libraries
library(tm) # for corpus and term document matrix creation/processing
library(SnowballC) # for stemming
library(wordcloud) # visualization
library(RColorBrewer) # for plot colors
library(cluster) # clustering terms
library(rpart) 

# load the data
# can be saved as rdata file to save space and decrease loading times for larger files
text_file <- read.csv("book4.csv")

#Investigate the file
head(text_file)
str(text_file)
summary(text_file)

## TEXT PREPROCESSING

# create corpus and clean up text before creating document term matrix
book_corpus <- VCorpus(VectorSource(text_file$Text))
book_corpus <- tm_map(book_corpus, content_transformer(tolower))
book_corpus <- tm_map(book_corpus, removeNumbers)
book_corpus <- tm_map(book_corpus, removePunctuation)
book_corpus <- tm_map(book_corpus, removeWords, stopwords("english"))
book_corpus <- tm_map(book_corpus, stemDocument)
book_corpus <- tm_map(book_corpus, stripWhitespace)
# after plotting the word cloud and bar chart it is clear that "thou", "now" and "one" should be removed
# they don't offer much insight
book_corpus <- tm_map(book_corpus, removeWords, c("thou", "now", "one"))

# create term document matrix (terms as rows, documents as columns)
tdm <- TermDocumentMatrix(book_corpus)

# count row (i.e, terms)
# must convert to matrix to work with as dtm is stored as a memory efficient sparse matrix doesn't store
# empty fields
tdm$nrow 

# inspect the term document matrix, make sure to subset when its very large 
inspect(tdm[1:30, 1:30])

# there are a lot of terms and perhaps high sparsity lets trim down and remove terms
# remove words that are over 99% sparse (i.e., do not appear in 99% of documents)
tdm <- removeSparseTerms(tdm, 0.99)
tdm$nrow #now 54 terms left
tdm$ncol #7619 sentences 
inspect(tdm[1:51, 1:3])

inspect(tdm)

# we reduced the size (the original dtm saved as a regular matrix requires lots of memory)

# define tdm as matrix
m = as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
d # lets see frequency of words

# plot wordcloud
set.seed(1)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


# lets make a bar chart of frequent words
barplot(d[1:10,]$freq, las = 1, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")

# check for associated terms for "hester", "pearl" and "little"
# normally set a limit for corrs to a reasonable r size, but this is sparse data & we trimmed terms

findAssocs(tdm, terms = c("hester", "pearl"), corlimit = .0)

findAssocs(tdm, terms = c("little"), corlimit = .0) 

# lets cluster the documents, but first find optimal k
wss <- numeric(10) 
for (k in 1:10) wss[k] <- sum(kmeans(tdm, centers=k)$withinss)
plot(wss, type="b",xlab = "Number of K") #s eems like 2 or 3 will cover it

book.kmeans <- kmeans(tdm,3)
book.kmeans$cluster # lets looks at cluster membership
