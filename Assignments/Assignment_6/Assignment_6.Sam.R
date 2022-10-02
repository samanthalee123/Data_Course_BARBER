library(tidyverse)
#down load data to R
dat0<-read_csv("./Data/BioLog_Plate_Data.csv")

#clean data into long form.

dat1<-dat0 %>% 
  pivot_longer(names_to = "time", values_to = "absorbance", 
               cols = starts_with("Hr"),names_prefix = "Hr_") %>%
  mutate(time= as.numeric(time))
  
#create a column that specifies if the sample is soil or water
  
soildat<-dat1 %>% 
 pivot_wider(names_from = "Sample ID", values_from = "absorbance") %>% 
  pivot_longer(cols = starts_with("Soil"), names_to = "Soil", values_to = "Absorbance")

waterdat<-dat1 %>% 
  pivot_wider(names_from = "Sample ID", values_from = "absorbance") %>% 
  rename(.Waste_Water=Waste_Water) %>% 
  rename(.Clear_Creek=Clear_Creek) %>% 
  pivot_longer(cols = starts_with("."), names_to = "Water", values_to = "Absorbance")

col_order <- c("Rep", "Well", "Dilution",
               "Substrate", "Absorbance", "time", "Soil", "Water")

dat2<-full_join(soildat,waterdat) %>% 
  select(-Clear_Creek, -Waste_Water,-Soil_1,-Soil_2)

Fdat<-dat2[col_order]

Fdat1<-Fdat %>% 
  pivot_longer(cols= 7:8, names_to = "Type", values_to = "Trash") %>% 
  select(-Trash)

#Graph 1

Fdat1 %>%             
group_by("Substrate") %>% 
filter(Dilution==0.1) %>% 
ggplot(aes(time,Absorbance, color=Type))+
geom_smooth(se = FALSE)+
facet_wrap(~Substrate)+
  theme_bw()
  
  
#Graph 2
library(tidyverse)
library(gganimate)
library(lubridate)


dat1 %>% 
  select(`Sample ID`,time, absorbance,Rep) %>% 
  group_by("Itaconic Acid") %>% 
  summarize(absorbance, #N= the new column we made n() the function for telling us number we want to observe. 
            Mean_absorbance= mean(absorbance),
            time=time,
            Rep=Rep ) %>% 
  ggplot(aes(time,Mean_absorbance, color= 'Sample ID'))+
  geom_point()+
  facet_wrap(~"Rep")


  




