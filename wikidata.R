setwd("~/repo_clean/")
rm(list = ls())
library(stringr)
languages = c("french","english","german")
language = "french"
Tableau = read.csv(str_c("Cultural_",language,".csv"),stringsAsFactors = F)
i = 0

I = i+1
for(i in I:nrow(Tableau)){
if(is.na(Tableau$Wikidata[i]) | nchar(Tableau$Wikidata[i])){
  url<-Tableau$URL_total[i]
  Text<-readLines(url)
  Text<-Text[grep('<li id="t-whatlinkshere">',Text)]
  Text<-unlist(strsplit(Text,'"'))
  c<-grep('https://www.wikidata.org/wiki/',Text)
  if(length(c)==0){
    Tableau$Wikidata[i]<-"No Wikidata"
  }else{Tableau$Wikidata[i]<-Text[c]}
  print(i)}}
write.csv(Tableau,str_c("Cultural_",language,"_2.csv"))





