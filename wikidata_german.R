library(stringr)
library(foreach)
library(doParallel)
languages = c("french","english","german")
n = 15
language = "german"
Tableau_german = read.csv(str_c("Cultural_",language,".csv"),stringsAsFactors = F)
for(i in 1:nrow(Tableau_german)){
if(is.na(Tableau_german$Wikidata[i]) | nchar(Tableau_german$Wikidata[i])){
  tryCatch({url<-Tableau_german$URL_total[i]
  Text<-readLines(url)
  Text<-Text[grep('<li id="t-whatlinkshere">',Text)]
  Text<-unlist(strsplit(Text,'"'))
  c<-grep('https://www.wikidata.org/wiki/',Text)
  if(length(c)==0){
    Tableau_german$Wikidata[i]<-"No Wikidata"
  }else{Tableau_german$Wikidata[i]<-Text[c]}
  print(i)},i, error=function(e){})
}}
write.csv(Tableau_german,str_c("Cultural_",language,"_2.csv"))





