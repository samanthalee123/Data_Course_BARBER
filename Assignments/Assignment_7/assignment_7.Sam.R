library(tidyverse)
library(janitor)
#read csv and clean


dat<-read_csv("/Users/sam/Desktop/Data_Course_BARBER/Assignments/Assignment_7/Utah_Religions_by_County.csv")
dat<-janitor::clean_names(dat)


#tidy data


dat<-dat %>% 
pivot_longer (-c("county","pop_2010", "religious"))
col_order <- c("county", "name", "value", "pop_2010",
               "religious")
dat [col_order]

# explore data



#which county has highest value of catholic? 

max_county<- function(dat, religion){
dat %>% 
  filter(name == religion) %>% 
  filter(value == max(value)) %>% 
  pluck("county")
}

max_county(dat,"catholic") #carbon county

#which county has highest value of non_religous?
max_county(dat,"non_religious") # San Juan County


#max religion a county
max_religion<- function(dat,county){
  dat %>% 
    filter(county == county) %>% 
    filter(value == max(value)) %>% 
  pluck("name")
}

#what is the max religion for Kane county?

max_religion(dat,"Kane County") #LDS

#max religion for Weber

max_religion(dat, "Weber County") #LDS



#answer the 2 questions




#“Does population of a county correlate with the proportion of any specific religious group in that county?”
dat %>% 
   group_by(county) %>% 
  ggplot(aes(pop_2010, value, color= name))+
  geom_point()+
  facet_wrap(~county, scales = "free")
 
  
  dat %>% 
    mutate(catholic = case_when(name == "catholic" ~ TRUE, TRUE~FALSE)) %>% 
    group_by(pop_2010) %>% 
    ggplot(aes(pop_2010, value, color= name))+
    geom_point()+
    facet_wrap(~county, scales = "free")
  

#“Does proportion of any specific religion in a given county correlate with the proportion of non-religious people?”

  dat %>% 
    mutate(lds = case_when(name == "lds" ~ TRUE, TRUE~FALSE)) %>% 
    mutate(non_religious = case_when(name == "non_religious" ~ TRUE, TRUE~FALSE)) %>% 
    group_by(pop_2010) %>% 
    ggplot(aes(value, lds, color= non_religious))+
    geom_point()+
    facet_wrap(~county, scales = "free")

