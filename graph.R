library("reshape2")
library("ggplot2")
library(ggthemes)
#p <- ggplot(mtcars, aes(wt, mpg))
#p + geom_point()
#p + geom_point(aes(colour = factor(cyl),shape = factor(cyl))) + geom_line()

publicboard = c(0.7123,
                0.7145,
                0.7168,
                0.7170,
                0.7130,
                0.7144,
                0.7177,
                0.7170,
                0.7160,
                0.7162,
                0.7152,
                0.7186)

CV = c(0.736452,
        0.736195,
        0.739306,
        0.739599,
        0.738241,
        0.738572,
        0.738472,
        0.738466,
        0.737603,
        0.738835,
        0.737894,
        0.739039)


CV_Var = c(0.009150,
          0.010455,
          0.007546,
          0.007710,
          0.008668,
          0.007977,
          0.008839,
          0.008750,
          0.007759,
          0.007815,
          0.009649,
          0.008445)

num_of_stack_feats = 0:11

df_train = data.frame(
  value = c(publicboard,CV),
  var = c(rep(0,12), CV_Var),
  stack = c(num_of_stack_feats,num_of_stack_feats),
  group = c(rep("30% testing data", 12), rep("CV", 12))
)


###########
test_data
theme_set(theme_gray(base_size = 15))
ggplot(df_train, aes(x=stack, y=value, colour=group)) + 
  geom_errorbar(aes(ymin=value+var, ymax=value-var, colour=group), width=0.2) +
  geom_line() +
  labs(list(
            x = "Number of Randomized Stacking Features", y = "AUC")) +
  geom_point(aes(shape = factor(group)), size = 4)  + 
  guides(shape = FALSE,
         colour = guide_legend(override.aes = list(shape = c(16, 17),
                                                   linetype = c("solid", "solid"))))+
  #theme_minimal(base_size =20) + 
  theme(legend.title = element_blank(),
        legend.position="bottom") +
  ylim(0.71, 0.75) 

