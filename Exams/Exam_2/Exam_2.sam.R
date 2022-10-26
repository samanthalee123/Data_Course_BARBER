library(tidyverse)
library(janitor)
library(broom)
library(modelr)
library(easystats)


#1 read data
dat1<-read_csv("unicef-u5mr.csv") %>% 
  clean_names()

#2 clean and tidy data
dat2<-dat1 %>% 
  pivot_longer(-c(country_name,continent,region),names_to = "year", values_to = "deaths")

cleandat<-dat2 %>% 
  mutate(year= year %>%  str_remove("u5mr_") %>% as.numeric())

#3 plot each country's deaths over time
cleandat %>% 
  ggplot(aes(year,deaths))+
  geom_point()+
  geom_abline(size= 0.05)+
  facet_wrap(~continent)+
  theme_bw()

#4 saved plot as BARBER_1.png in figures_exam2 folder.

#5 plot mean deaths for all countries
mean<-cleandat %>% 
  group_by(continent,year) %>% 
  filter(!is.na(deaths)) %>%
  summarise(Mean_U5MR = mean(deaths))

mean %>% 
  ggplot(aes(year,Mean_U5MR,color=continent))+
  geom_line()+
  theme_bw()
  
#6 saved figure as BARBER_plot_2 in figures_exam2 folder. 


#7 create 3 models. 

mod1<-glm(data = cleandat %>% 
          filter(!is.na(deaths)),
          formula = deaths ~ year)

mod2<-glm(data = cleandat %>% 
             filter(!is.na(deaths)),
           formula = deaths ~ year + continent)

mod3<-glm(data = cleandat %>% 
            filter(!is.na(deaths)),
          formula = deaths ~ year*continent)


#8 compare mod 1-3. 

compare_performance(mod1,mod2,mod3,rank = TRUE)
#Best model is shown to be mod3. the AIC is 1 BIC is 1 R2 is 0.640 versus 0.6 and 0.22 from mod 2 and  mod 1. 
# I also got a 100%  in my performance score for mod3 which helped me rank mod1-3.


#9 plot the 3 models' predictions.

gather_predictions(cleandat, mod1,mod2,mod3) %>% 
  ggplot(aes(x=year,y=pred,color=continent)) +
  geom_point() + geom_line() +
  facet_wrap(~model)+
  theme_bw()


#10 bonus:

add_predictions(cleandat,mod3,type= "response") %>% 
  filter(!is.na(deaths))


predict(mod3,data.frame(year=2020,
                        country_name="Ecuador"),
                        type = "response")
