#######################INDIAN###################################
require(httr)
require(httpuv)
require(jsonlite)
# yelp
# substitute your codes for the xxxx's
consumerKey = "2aifVe3MSenp4H8JOZm08g"
consumerSecret = "jeS6rbhofi_AHlHGJx5JGV550VA"
token = "ajihPQoK3DfL8c10RwW96NIC8ehEkvq4"
token_secret = "oX0XzaLvSKlLv-TBwspc6CpQnZE"
myapp = oauth_app("YELP", key=consumerKey, secret=consumerSecret)
sig=sign_oauth1.0(myapp, token=token,token_secret=token_secret)


# 20 Indian restaurants in Chicago
limit <- 20
URL <- paste0("http://api.yelp.com/v2/search/?limit=",limit,"&location=Chicago&term=indian%restaurant")


#convert json dataframe
responseList=GET(URL, sig) 
responseContent = content(responseList) 

#convert list to JSON
jsonResponseContent <- toJSON(responseContent) 
newResponseList=fromJSON(jsonResponseContent) 
newDataframeObj <- data.frame(newResponseList) 



#Select column from your new dataframe
bRate <- newDataframeObj[,"businesses.rating"] 
bName <- newDataframeObj[,"businesses.name"] 
bReview <- newDataframeObj[,"businesses.review_count"] 
bLocation <- newDataframeObj[,"businesses.location"] 
  bCity <- bLocation[,"city"] 
  bState <- bLocation[,"state_code"] 
  bCountry <- bLocation[,"country_code"] 
bIsClosed <- newDataframeObj[,"businesses.is_closed"] 
bIsClaimed <- newDataframeObj[,"businesses.is_claimed"] 



#convert all list object to json object
library(jsonlite)
bRatejson <- toJSON(bRate, pretty=TRUE) 
bNamejson <- toJSON(bName, pretty=TRUE) 
bReviewjson <- toJSON(bReview, pretty=TRUE) 
bCityjson <- toJSON(bCity, pretty=TRUE) 
bStatejson <- toJSON(bState, pretty=TRUE) 
bCountryjson <- toJSON(bCountry, pretty=TRUE) 
bIsClosedjson <- toJSON(bIsClosed, pretty=TRUE) 
bIsClaimedjson <- toJSON(bIsClaimed, pretty=TRUE) 


#convert json back to R object- matrix
Ratings.mat <- fromJSON(bRatejson)
Name.mat <- fromJSON(bNamejson) 
Reviews.mat <- fromJSON(bReviewjson) 
City.mat <- fromJSON(bCityjson) 
State.mat <- fromJSON(bStatejson) 
Country.mat <- fromJSON(bCountryjson) 
isClosed.mat <- fromJSON(bIsClosedjson) 
isClaimed.mat <- fromJSON(bIsClaimedjson) 


csv.file <- data.frame(Name.mat, Reviews.mat, Ratings.mat, City.mat, State.mat, Country.mat, isClosed.mat, isClaimed.mat) 
write.csv(csv.file, file="IndianData.csv")




######################CHINESE################################
URL <- paste0("http://api.yelp.com/v2/search/?limit=",limit,"&location=Chicago&term=Chinese%restaurant")


#convert json dataframe
responseList=GET(URL, sig) #response
responseContent = content(responseList) 

#convert list to JSON
jsonResponseContent <- toJSON(responseContent) 
newResponseList=fromJSON(jsonResponseContent) 
newDataframeObj <- data.frame(newResponseList) 


#Select column from your new dataframe
bRate <- newDataframeObj[,"businesses.rating"] 
bName <- newDataframeObj[,"businesses.name"] 
bReview <- newDataframeObj[,"businesses.review_count"] 
bLocation <- newDataframeObj[,"businesses.location"] 
names(bLocation)
bCity <- bLocation[,"city"] 
bState <- bLocation[,"state_code"] 
bCountry <- bLocation[,"country_code"] 
bIsClosed <- newDataframeObj[,"businesses.is_closed"] 
bIsClaimed <- newDataframeObj[,"businesses.is_claimed"] 



#convert all list object to json object
library(jsonlite)
bRatejson <- toJSON(bRate, pretty=TRUE) 
bNamejson <- toJSON(bName, pretty=TRUE) 
bReviewjson <- toJSON(bReview, pretty=TRUE) 
bCityjson <- toJSON(bCity, pretty=TRUE) 
bStatejson <- toJSON(bState, pretty=TRUE) 
bCountryjson <- toJSON(bCountry, pretty=TRUE) 
bIsClosedjson <- toJSON(bIsClosed, pretty=TRUE) 
bIsClaimedjson <- toJSON(bIsClaimed, pretty=TRUE) 


#convert json back to R object- matrix
Ratings.mat <- fromJSON(bRatejson)
Name.mat <- fromJSON(bNamejson) 
Reviews.mat <- fromJSON(bReviewjson) 
City.mat <- fromJSON(bCityjson) 
State.mat <- fromJSON(bStatejson) 
Country.mat <- fromJSON(bCountryjson) 
isClosed.mat <- fromJSON(bIsClosedjson) 
isClaimed.mat <- fromJSON(bIsClaimedjson) 


csv.file <- data.frame(Name.mat, Reviews.mat, Ratings.mat, City.mat, State.mat, Country.mat, isClosed.mat, isClaimed.mat) #dataframe
write.csv(csv.file, file="ChineseData.csv")
