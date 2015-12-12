
#PART 2: I would like to use POS-tagging to analyze each collection
rm(list=ls())
setwd("/Users/Orly/ps239t-final-project")
library(tm) # loading recommended libraries
library(RTextTools) 
library(qdap)
library(qdapDictionaries)
library(NLP)
library(openNLP)

#Import the data
collections<-Corpus(DirSource("Data/POS_Tagging"))

head(as.character(collections$content[[2]])) #checking the order
#I am curious to see how sentence detection will work when applied to these collections of poetry
# Combining sections of text for each collection
HD <- paste(collections$content[[1]], collapse = " ")
Pound <-paste(collections$content[[2]], collapse = " ")
Eliot <-paste(collections$content[[3]], collapse = " ")

# Split into sentences
sentencesE <- sent_detect(Eliot)
sentencesH <- sent_detect(HD)
sentencesP <- sent_detect(Pound)
?sent_detect
#Running part-of-speech tagging over each collection

?pos_tags()
??tagPOS
posdE <- tagPOS(sentencesE)
posdE <- tagPOS(sentencesE)
posdE <- tagPOS(sentencesE)

posdE <- pos(sentencesE)
posdH <- pos(sentencesH)
posdP <- pos(sentencesP)

# taking a peek at the results
posdE

#visualizing POS for each collection
plot(posdE)
plot(posdH)
plot(posdP)

#looking at sentences with tags in-line, list of tags by sentence, & word counts
posdE$POStagged
dim(posdE$POStagged)
posdE$POStagged[,1] #isolating vector of tagged sentences, assigning to variable
#I am interested in the POS tag "IN"

taggedsentencesE <-posdE$POStagged[,1]
taggedsentencesH <-posdH$POStagged[,1]
taggedsentencesP <-posdP$POStagged[,1]

taggedsentencesP <- as.character(taggedsentencesP)
taggedsentencesH <- as.character(taggedsentencesH)
taggedsentencesE <- as.character(taggedsentencesE)

#split on spaces in each list
HDlist <- split(taggedsentencesH," ")
Eliotlist <- split(taggedsentencesH," ")
Poundlist <- split(taggedsentencesH," ")

?lapply

#loop through the collections and use part-of-speech tagging to identify all instances of "like" and "as" when they are classified as IN
#The idea is that this kind of tagging can help identify instances of figurative expression, specifically simile
?annotate
extractPOS <- function(x, thisPOSregex) {
  x <- as.String(x)
  wordAnnotation <- annotate(x, list(Maxent_Sent_Token_Annotator(), Maxent_Word_Token_Annotator()))
  POSAnnotation <- annotate(x, Maxent_POS_Tag_Annotator(), wordAnnotation)
  POSwords <- subset(POSAnnotation, type == "word")
  tags <- sapply(POSwords$features, '[[', "POS")
  thisPOSindex <- grep(thisPOSregex, tags)
  tokenizedAndTagged <- sprintf("%s/%s", x[POSwords][thisPOSindex], tags[thisPOSindex])
  untokenizedAndTagged <- paste(tokenizedAndTagged, collapse = " ")
  untokenizedAndTagged
}
?Maxent_Sent_Token_Annotator

extractPOS(taggedsentencesE, "IN"))

#getting list of tags for each sentence
posdE.list <- posdE[[2]][[2]]
posdH.list <- posdH[[2]][[2]]
posdP.list <- posdP[[2]][[2]]

posdP.list

# Shorten tags to two characters
posdE.list<-lapply(posdE.list, function(x) sapply(x, function(x) substr(x,1,2)))
posdH.list<-lapply(posdH.list, function(x) sapply(x, function(x) substr(x,1,2)))
posdP.list<-lapply(posdP.list, function(x) sapply(x, function(x) substr(x,1,2)))

# Get bigrams of POS tags
posE.grams <- lapply(posdE.list, function(x) ngrams(paste(x, collapse = " "), 2))
posH.grams <- lapply(posdH.list, function(x) ngrams(paste(x, collapse = " "), 2))
posP.grams <- lapply(posdP.list, function(x) ngrams(paste(x, collapse = " "), 2))

# Get the list of bigrams for each sentence
gramE.list <-sapply(posE.grams, function(x) x$all_n$n_2)
gramH.list <-sapply(posH.grams, function(x) x$all_n$n_2)
gramP.list <-sapply(posP.grams, function(x) x$all_n$n_2)

# Pull out all the bigrams into a single list, since we no longer are interested in sentence divisions
gramE.listu <- unlist(gramE.list, recursive=FALSE)
gramH.listu <- unlist(gramH.list, recursive=FALSE)
gramP.listu <- unlist(gramP.list, recursive=FALSE)

# Join bigrams with a hyphen into a single unit
gramE.listu<-sapply(gramE.listu, function(x) paste(x, sep=' ',collapse = '-'))
gramH.listu<-sapply(gramH.listu, function(x) paste(x, sep=' ',collapse = '-'))
gramP.listu<-sapply(gramP.listu, function(x) paste(x, sep=' ',collapse = '-'))

# Count the instances of all bigram units
gramE.counts <- as.vector(table(gramE.listu))
gramH.counts <- as.vector(table(gramH.listu))
gramP.counts <- as.vector(table(gramP.listu))


# Take a look
gramE.counts
gramH.counts
gramP.counts

#calculating degree of grammatical entropy (complexity)
# Get the probability of randomly choosing a particular bigram from the text
probE<-gramE.counts/sum(gramE.counts)
probH<-gramH.counts/sum(gramH.counts)
probP<-gramP.counts/sum(gramP.counts)

# Calculate the Shannon entropy of the collections
ShannonE.entropy <- -sum(log2(probE)*probE)
ShannonH.entropy <- -sum(log2(probH)*probH)
ShannonP.entropy <- -sum(log2(probP)*probP)
ShannonE.entropy
ShannonH.entropy
ShannonP.entropy


