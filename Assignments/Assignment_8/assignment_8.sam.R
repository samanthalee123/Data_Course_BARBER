library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)

#1 load data
dat<-read_csv("./mushroom_growth.csv")


#2-#3 exploring relationships between response and predictors. 

mod1<-glm(data=dat,formula = GrowthRate~ Nitrogen)

summary(mod1)
# this does not turn out to be a great model according to the coefficients. 
#there are no significant tValues. 

mod2<-glm(data=dat,formula = GrowthRate~ Nitrogen + Light)

#I plotted out mod2 to get an idea of what light would show vs growth rate. 
glm(data=dat,formula = GrowthRate~ Nitrogen + Light) %>% 
  ggplot(aes(Light,GrowthRate))+
  geom_point()+
  geom_smooth(method=lm)+
  theme_bw()

summary(mod2) 
#Yay! This gives me some significant values to work with! 



mod3<-glm(data=dat,formula = GrowthRate~ Nitrogen * Light)

summary(mod3)
# I am finding that nitrogen and light have an ok connection-
#but I can find a better one with light I think. 

mod4<-glm(data=dat,formula = GrowthRate~ Light * Humidity)
summary(mod4)

#5
#Mod4 shows to be the most significant model! but I will compare models to make sure. 



#4 calculating sq error for each model.


compare_performance(mod1,mod2,mod3,mod4, rank = TRUE) %>% 
  plot()
#this confirms that mod4 is the best one I created. 
# the values for all of the models in Rank best the worst. 

#Name | Model |        R2 |   RMSE |  Sigma | AIC weights | BIC weights | Performance-Score
#-----------------------------------------------------------------------------------------
 # mod4 |   glm |     0.432 | 74.337 | 75.035 |       1.000 |       1.000 |           100.00%
#mod3 |   glm |     0.216 | 87.350 | 88.171 |    7.36e-16 |    7.36e-16 |            28.32%
#mod2 |   glm |     0.209 | 87.734 | 88.350 |    7.76e-16 |    4.19e-15 |            27.53%
#mod1 |   glm | 5.695e-04 | 98.607 | 99.067 |    2.31e-26 |    6.77e-25 |             0.00%


#6 predictions

predict(mod4,data.frame(Light= 30,
                        Nitrogen=50,
                        Humidity= "High"), type = "response")
#shows our growth rate as 309.8


#7 plotting predictions. 
add_predictions(dat,mod4, type = "response") %>%
  ggplot(aes(pred,Light))+
  geom_point()+
  facet_wrap(~Humidity)





nonlinear<-read_csv("./non_linear_relationship.csv")

glm(data=nonlinear,formula = response~ predictor)






