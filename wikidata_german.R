setwd("~/repo_clean/")
rm(list = ls())
library(stringr)
languages = c("french","english","german")
language = "german"
Tableau = read.csv(str_c("Cultural_",language,".csv"),stringsAsFactors = F)

extract = function(Chunk){
chunk = Tableau[Chunk,]
chunk2 = chunk
for(i in 1:nrow(chunk)){
if(is.na(chunk$Wikidata[i]) | nchar(chunk$Wikidata[i])==0){
url<-chunk$URL_total[i]
tryCatch({
  Text<-readLines(url)
  Text<-Text[grep('<li id="t-whatlinkshere">',Text)]
  Text<-unlist(strsplit(Text,'"'))
  c<-grep('https://www.wikidata.org/wiki/',Text)
  if(length(c)>0){
  chunk2$Wikidata[i] = Text[c]}
  print(i)}, error=function(e){})
}
}
return(chunk2)}


##library(foreach)
#library(doParallel)
#n = 20
#registerDoParallel(20)
Tableau = dplyr::filter(Tableau,Birth_dates<1841)
b = 1:nrow(Tableau)
#b = split(b, cut(seq_along(b), n, labels = FALSE))
a = extract(b)
#ia = foreach(Chunk=iter(b), .packages=c("stringr")) %dopar% { extract(Chunk) }

write.csv(a,str_c("Cultural_",language,"_2.csv"))

