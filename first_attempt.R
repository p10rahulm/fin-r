# request.headers = list(
# "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
# "Accept-Encoding"="gzip, deflate, br",
# "Accept-Language"="en-US,en;q=0.8",
# "Connection"="keep-alive",
# "Host"="www.nseindia.com",
# "Referer"="https://www.nseindia.com/products/content/equities/equities/eq_security.htm",
# "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
# "X-Requested-With"="XMLHttpRequest",
# "Upgrade-Insecure-Requests"="1"
# )
# r <- GET("", 
#          query = request.headers
# )
symbol = "INFY"
url <- paste0("https://www.nseindia.com/products/dynaContent/common/productsSymbolMapping.jsp?symbol=",symbol,"&segmentLink=3&symbolCount=2&series=ALL&dateRange=24month&fromDate=&toDate=&dataType=PRICEVOLUMEDELIVERABLE")
# GET(url, verbose())
# url <-  "https://www.nseindia.com/products/dynaContent/common/productsSymbolMapping.jsp?symbol=LT&segmentLink=3&symbolCount=2&series=ALL&dateRange=24month&fromDate=&toDate=&dataType=PRICEVOLUMEDELIVERABLE"
a <- GET(url, add_headers("Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
                     "Accept-Encoding"="gzip, deflate, br",
                     "Accept-Language"="en-US,en;q=0.8",
                     "Connection"="keep-alive",
                     "Host"="www.nseindia.com",
                     "Referer"="https://www.nseindia.com/products/content/equities/equities/eq_security.htm",
                     "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
                     "X-Requested-With"="XMLHttpRequest",
                     "Upgrade-Insecure-Requests"="1"), set_cookies("JSESSIONID" = "395631D03E11EC01BEB7E2A2BDF6B212", "NSE-TEST-1" = "1843404810.20480.0000"), verbose())
# GET(url, set_cookies(a = 1, b = 2))
# GET(url, add_headers(a = 1, b = 2), set_cookies(a = 1, b = 2))
# GET(url, authenticate("username", "password"))
# GET(url, verbose())
b <- rawToChar(a$content)
starting_point <- "<div id='csvContentDiv' style='display:none;'>"
b <- substr(b,regexpr(starting_point, b)[1]+nchar(starting_point),nchar(b))
end_point <- ":</div>\r\n\t<input type='hidden'"
b <- substr(b,1,regexpr(end_point, b)[1]-1)
substr(b,nchar(b)-15,nchar(b))
c <- gsub(pattern = ":",replacement = "\n",x = b,perl = T)

con <- textConnection(c)
data <- read.csv(con)
close(con)
