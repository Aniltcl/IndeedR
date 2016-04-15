indeedgetresults <- function(query="",city="",state="",sort="relevance",radius=25,start=0,limit=10,maxage=NA,publisher=4013469286425094,version=2,format="XML",highlight=1,filter=1,latlong=0,country="US",useragent="Mozilla/%2F4.0%28Firefox%29"){
        queryurl <- "http://api.indeed.com/ads/apisearch?"
        #QuerySetup gets the important boring terms out of the way.
        queryurl <- paste(queryurl,"publisher=",publisher,"&v=",version,"&format=",format,sep="")
        
        #Set up actual search terms and Location.
        queryurl <- paste(queryurl,"&q=",query,"&l=",city,"%2c+",state,sep="")
        queryurl <- paste(queryurl,"&radius=",radius,"&start=",start,"&limit=",limit,sep="")
        queryurl <- paste(queryurl,"&fromage=",maxage,"&highlight=",highlight,"&filter",filter,sep="")
        queryurl <- paste(queryurl, "&latlong",latlong,"&country=",country,"&useragent=",useragent,sep="")
        
        library(XML)
        
        tree <- xmlTreeParse(queryurl)
        root <- xmlRoot(tree)
        frame <- xmlToDataFrame(getNodeSet(root,"//results/result"))
        frame
        
}
        