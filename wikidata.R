library(stringr)
library(foreach)
library(doParallel)
languages = c("french","english","german")
n = 15
language = "french"
Tableau = read.csv(str_c("Cultural_",language,".csv"),stringsAsFactors = F)
for(i in 1:nrow(Tableau)){
if(is.na(Tableau$Wikidata[i]) | nchar(Tableau$Wikidata[i])){
  tryCatch({url<-Tableau$URL_total[i]
  Text<-readLines(url)
  Text<-Text[grep('<li id="t-whatlinkshere">',Text)]
  Text<-unlist(strsplit(Text,'"'))
  c<-grep('https://www.wikidata.org/wiki/',Text)
  if(length(c)==0){
    Tableau$Wikidata[i]<-"No Wikidata"
  }else{Tableau$Wikidata[i]<-Text[c]}
  print(i)},i, error=function(e){})
}}
write.csv(Tableau,str_c("Cultural_",language,"_2.csv"))





