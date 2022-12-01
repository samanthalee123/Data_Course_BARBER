#This is a redo of exam 1. 

library(tidyverse)

#1
DF<-read_csv("cleaned_covid_data.csv")

#2
A_states<-DF %>% filter(grepl("A", Province_State))


#3 plot of A states.
A_states %>% 
  ggplot(aes(Last_Update, Deaths))+
  geom_point(size=0.1)+
  geom_smooth(method=lm, color="red")+
  facet_wrap(~Province_State, scales="free")

#4
State_Max_Fatality_Ratio<-DF%>%
  group_by(Province_State)%>%
  summarize(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio,na.rm = TRUE))

# arranged in desc order. 
State_Max_Fatality_Ratio %>% 
arrange(desc(Maximum_Fatality_Ratio))


#5 the plot in desc order
State_Max_Fatality_Ratio%>%
  mutate(Province_State= factor(Province_State, levels=c("New York", "New Jersey", "Massachusetts", "Connecticut", "New Hampshire", "Pennsylvania", "District of Columbia", "Michigan", "Rhode Island", "Louisiana", "Delaware", "Maryland", "Mississippi", "Vermont", "Arizona", "Indiana", "Ohio", "South Carolina", "Georgia", "Illinois", "New Mexico", "Alabama", "Florida", "Washington", "Maine", "Virginia", "West Virginia", "Texas", "California", "Oklahoma", "Colorado", "Nevada", "Arkansas", "Missouri", "South Dakota", "Iowa", "Kansas", "North Carolina", "Kentucky", "Hawaii", "Tennessee", "North Dakota", "Montana", "Minnesota", "Oregon", "Wyoming", "Idaho", "Wisconsin", "Nebraska", "Alaska", "Utah")))%>%
  ggplot(aes(Province_State, Maximum_Fatality_Ratio))+
           geom_col()+
           theme(axis.text.x = element_text(angle=90,hjust=1))
                 
#6 Bonus
                 
DF%>%
  group_by(Last_Update)%>%
  summarize(TOTAL_DEATHS = sum(Deaths, na.rm = TRUE))%>%
  ggplot(aes(Last_Update, TOTAL_DEATHS)) +
  geom_point()
                 