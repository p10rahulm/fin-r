

get2yeardata <- function(symbol){
  url <- paste0("https://www.nseindia.com/marketinfo/sym_map/symbolCount.jsp?symbol=",symbol)
  symbolcount <- GET(url, add_headers("Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                                      "Accept-Encoding"="gzip, deflate, br",
                                      "Accept-Language"="en-US,en;q=0.8",
                                      "Connection"="keep-alive",
                                      "Host"="www.nseindia.com",
                                      "Referer"="https://www.nseindia.com/products/content/equities/equities/eq_security.htm",
                                      "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
                                      "X-Requested-With"="XMLHttpRequest",
                                      "Upgrade-Insecure-Requests"="1"))
  symbolcount <- gsub(pattern = "\n","",rawToChar(symbolcount$content))
  symbolcount <- gsub(pattern = " ","",symbolcount)
  
  url <- paste0("https://www.nseindia.com/products/dynaContent/common/productsSymbolMapping.jsp?symbol=",symbol,"&segmentLink=3&symbolCount=",symbolcount,"&series=ALL&dateRange=24month&fromDate=&toDate=&dataType=PRICEVOLUMEDELIVERABLE")
  a <- GET(url, add_headers("Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                            "Accept-Encoding"="gzip, deflate, br",
                            "Accept-Language"="en-US,en;q=0.8",
                            "Connection"="keep-alive",
                            "Host"="www.nseindia.com",
                            "Referer"="https://www.nseindia.com/products/content/equities/equities/eq_security.htm",
                            "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
                            "X-Requested-With"="XMLHttpRequest",
                            "Upgrade-Insecure-Requests"="1"), 
           set_cookies("JSESSIONID" = "395631D03E11EC01BEB7E2A2BDF6B212", "NSE-TEST-1" = "1843404810.20480.0000") 
  )
  rm(url,symbol,symbolcount)
  b <- rawToChar(a$content)
  starting_point <- "<div id='csvContentDiv' style='display:none;'>"
  b <- substr(b,regexpr(starting_point, b)[1]+nchar(starting_point),nchar(b))
  end_point <- ":</div>\r\n\t<input type='hidden'"
  b <- substr(b,1,regexpr(end_point, b)[1]-1)
  # substr(b,nchar(b)-15,nchar(b))
  c <- gsub(pattern = ":",replacement = "\n",x = b,perl = T)
  
  rm(a,b,starting_point,end_point)
  con <- textConnection(c)
  nsedata <- read.csv(con)
  close(con)
  rm(c,con)
  return(nsedata)
}

running_min <- function(x, w, date_asc_bool){
  if(length(x)<w){return("window greater than x length")}
  if(date_asc_bool){
    runmin <- rep(as.numeric(NA),length(x))
    for(i in 1:(length(x)-w+1)){
      runmin[i] <- min(x[i:(i+w-1)])
    }
  } else {
    runmin <- rep(as.numeric(NA),length(x))
    for(i in length(x):(w)){
      runmin[i] <- min(x[i:(i-w+1)])
    }
  }
  return(runmin)
}

running_window_function <- function(fn,x, w, date_asc_bool){
  if(length(x)<w){return("window greater than x length")}
  if(date_asc_bool){
    runf <- rep(as.numeric(NA),length(x))
    for(i in 1:(length(x)-w+1)){
      runf[i] <- fn(x[i:(i+w-1)])
    }
  } else {
    runf <- rep(as.numeric(NA),length(x))
    for(i in length(x):(w)){
      runf[i] <- fn(x[i:(i-w+1)])
    }
  }
  return(runf)
}
