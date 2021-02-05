#This rank_hospital function reads data from a file called "outcome-of-care-measures.csv",
#then ranks per state the 30-day mortality rate of the patients who had heart attacks, 
#heart failure, or pneumonia. After that, this function will generate a data frame 
#with information about hospitals that have a specific ranking in each state.

library(tidyverse)
rank_hospital <- function(outcome, num = "best"){
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    outcomes <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    if (!(outcome %in% names(outcomes))) {stop("invalid outcome")}
    coln <- outcomes[outcome]
    my_df <- data[,c(2,7,coln)]
    my_df[,3] <- as.numeric(my_df[,3])
    my_df_good <- my_df[complete.cases(my_df),]
    
    by_state <- split(my_df_good, my_df_good[,2])
    rate_rank <- function(x){arrange(x, x[,3], x[,1] )}
    #the smalldf function build a one-row df to store the num ranked hospital 
    #and state in each state. 
    smalldf <- function(y, z){sdf <- data.frame(hospital = y[z, 1], 
                                                state = y[z, 2])
                              sdf}
    new_df <- data.frame(hospital = character(), state = character())
    for (i in 1:length(by_state)){
        
        rank_state <- rate_rank(data.frame(by_state[i]))
        #rbind the new_df every loop with the smalldf to get all states data. 
        if (num == "best"){new_df <- rbind(new_df, smalldf(rank_state, 1))}
        else if (num == "worst") {new_df <- rbind(new_df, 
                                                  smalldf(rank_state,
                                                          nrow(rank_state)))}
        else if (num > nrow(rank_state))
            #made a new df specifically for NA. 
        {new_df <- rbind(new_df, data.frame(hospital = NA,
                                            state = rank_state[1,2]))}
        else {new_df <- rbind(new_df, smalldf(rank_state, num))}
    }
    new_df
}
head(rank_hospital("heart attack", 20), 10)
tail(rank_hospital("pneumonia", "worst"), 3)
tail(rank_hospital("heart failure"), 10)