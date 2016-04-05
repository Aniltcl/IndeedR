indeedgetresults <- function(query=NA,city=NA,state=NA,sort="relevance",radius=25,start=0,limit=10,maxage=NA,publisher=4013469286425094,version=2,format="XML",highlight=1,filter=1,latlong=0,country="US",useragent="Mozilla/%2F4.0%28Firefox%29"){
        queryurl <- "http://api.indeed.com/ads/apisearch?"
        #QuerySetup gets the important boring terms out of the way.
        queryurl <- c(queryurl,"publisher=",publisher,"&version=",version,"&format=",format)
        
        #Set up actual search terms and Location.
        
        
}
        