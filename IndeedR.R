indeedget25 <- function(query="",city="",state="",sort="relevance",radius=25,start=0,limit=25,maxage=NA,publisher=4013469286425094,version=2,format="XML",highlight=1,filter=1,latlong=0,country="US",useragent="Mozilla/%2F4.0%28Firefox%29"){
        queryurl <- "http://api.indeed.com/ads/apisearch?"
        #QuerySetup gets the important boring terms out of the way.
        queryurl <- paste(queryurl,"publisher=",publisher,"&v=",version,"&format=",format,sep="")
        
        query <- gsub("\\s","+",query)
        #Set up actual search terms and Location.
        queryurl <- paste(queryurl,"&q=",query,"&l=",city,"%2c+",state,sep="")
        queryurl <- paste(queryurl,"&radius=",radius,"&start=",start,"&limit=",limit,sep="")
        queryurl <- paste(queryurl,"&fromage=",maxage,"&highlight=",highlight,"&filter",filter,sep="")
        queryurl <- paste(queryurl, "&latlong",latlong,"&country=",country,"&useragent=",useragent,sep="")
        
        library(XML)
        
        tree <- xmlTreeParse(queryurl)
        root <- xmlRoot(tree)
        result <- xmlToDataFrame(getNodeSet(root,"//results/result"))
        result
        
        
}

indeedallresults <- function(query="",city="",state="",sort="relevance",radius=25,start=0,limit=25,maxage=NA,publisher=4013469286425094,version=2,format="XML",highlight=1,filter=1,latlong=0,country="US",useragent="Mozilla/%2F4.0%28Firefox%29"){
  result <- indeedget25(query,city,state,sort,radius,start,limit,maxage,publisher,version,format,highlight,filter,latlong,country,useragent)
  frame <- data.frame()
  frame <- rbind(frame,result)
  
  while(nrow(result)==limit){
    #Sys.sleep(10)
    result <- indeedget25(query,city,state,sort,radius,nrow(frame)+1,limit,maxage,publisher,version,format,highlight,filter,latlong,country,useragent)
    frame <- rbind(frame,result)
    
  }
  frame
}

getcities <- function(url="http://en.wikipedia.org/wiki/List_of_United_States_cities_by_population"){
  cities <- read_html(url)%>%html_table(fill=TRUE)%>%.[[4]]
  #Remove "Citations" from city names.
  cities <- cities %>% mutate(City = gsub("\\[[[:digit:]]+\\]","",City))
  cities
}

cityloop <- function(query, top=0, ...){
  cities <- getcities()
  df <- data.frame()
  for(city in 1:nrow(cities)){
    if(city == top){return(df)}
    currentcity <-cities$City[city] 
    currentstate <- cities$`State[5]`[city]
    print(paste(city, "of", nrow(cities), currentcity,",",currentstate))
    result <- indeedallresults(query = query, city=currentcity, state = currentstate)
    result <- result %>% mutate(querycity = paste(currentcity,", ",currentstate, sep=""))
    df <- rbind(df,result)
    #Sys.sleep(5)
    if(city %% 5==0){Sys.sleep(30)}
  }
  df
}
        