library(tidyverse)
library(janitor)
library(modelr)
library(easystats)
library(broom)
library(AICcmodavg)
library(knitr)

#cleaning data
dat<-read_csv("./Facultysalaries_1995.csv")
cleandat<-clean_names(dat)

colnames(cleandat)<-gsub("avg_","",colnames(cleandat))
cleandat

#organizing full, assoc, and assist columns. 
full<-cleandat %>% 
  select(c("fed_id","univ_name","state","tier","num_full_profs", starts_with("full")))
  
assoc<-cleandat %>% 
  select(c("fed_id","univ_name","state","tier","num_assoc_profs", starts_with("assoc")))
  
  
assist<-cleandat %>% 
  select(c("fed_id","univ_name","state","tier","num_assist_profs", starts_with("assist")))

#creating a column in my new data sets that share the name "rank"

full$rank <- "full"
assoc$rank <- "assoc"
assist$rank <- "assist"

colnames(full)<-gsub("full_prof_","",colnames(full))
colnames(full)<-gsub("_full_profs","",colnames(full))
full

colnames(assoc)<-gsub("assoc_prof_","",colnames(assoc))
colnames(assoc)<-gsub("_assoc_profs","",colnames(assoc))
assoc

colnames(assist)<-gsub("assist_prof_","",colnames(assist))
colnames(assist)<-gsub("_assist_profs","",colnames(assist))
assist

finaldat<-rbind(full,assoc,assist)
#creating fig 1 
finaldat%>% 
  filter(!tier=="VIIB") %>% 
  ggplot(aes(rank,salary,fill=rank))+
  geom_boxplot()+
  facet_wrap(~tier)+
  theme_minimal()+
  theme(axis.text.x = element_text (angle = 45))



#Anova model

glm(data = finaldat,
    formula = salary~ state+ tier + rank)


anova<-aov(salary~state+ tier+ rank, data = finaldat)
summary(anova)

#Text doc was created for the anova table that shows below. 

#        Df   Sum Sq   Mean Sq  F value  Pr(>F)    
#state   51  5682396  111420   30.66 <2e-16 ***
# tier   2  7072361 3536180  972.96 <2e-16 ***
# rank  2 16529771 8264885 2274.04 <2e-16 ***
# Residuals   3299 11990072    3634                   
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


#loading second set of data


dat2<-read_csv("./juniper_oils.csv")

#cleaning data
cleandat2<-dat2 %>% 
  pivot_longer(c("alpha-pinene","para-cymene","alpha-terpineol","cedr-9-ene","alpha-cedrene","beta-cedrene","cis-thujopsene","alpha-himachalene","beta-chamigrene","cuparene","compound 1","alpha-chamigrene","widdrol","cedrol","beta-acorenol","alpha-acorenol","gamma-eudesmol","beta-eudesmol","alpha-eudesmol","cedr-8-en-13-ol","cedr-8-en-15-ol","compound 2","thujopsenal"),
               names_to = "chemicals", values_to = "concentration" )

#graph 2 for years since birth and concentration. 
cleandat2 %>% 
  group_by(chemicals) %>% 
  ggplot(aes(YearsSinceBurn,concentration))+
  geom_smooth()+
  facet_wrap(~chemicals,scales="free_y")


#making my model

model2<-glm(data = cleandat2, 
      formula = concentration~ chemicals * YearsSinceBurn)
summary(model2)

# created a table with my model and filtered out the values I wanted.   
mod2<-tidy(model2) %>% 
  filter(p.value<0.05)


# A tibble: 6 × 5
#term            estim…¹ std.e…² stati…³  p.value
#<chr>             <dbl>   <dbl>   <dbl>    <dbl>
#1 chemicalsalpha…   7.88    1.93     4.08 4.97e- 5
#2 chemicalscedr-…   7.62    1.93     3.95 8.72e- 5
#3 chemicalscedrol  22.5     1.93    11.7  5.12e-29
#4 chemicalscis-t…  17.3     1.93     8.95 2.93e-18
#5 chemicalswiddr…   5.82    1.93     3.01 2.69e- 3
#6 chemicalscis-t…   0.332   0.141    2.35 1.90e- 2







