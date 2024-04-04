### Data taken from the World Inequality Database

url_summary <- "https://wir2022.wid.world/www-site/uploads/2022/03/WIR2022TablesFigures-Summary.xlsx"
download.file(url = url_summary, destfile = "./data/WIR2022s.xlsx", mode = "wb") 

excel_sheets("./data/WIR2022s.xlsx")

#download data for wealth/income ratio in the US

    ##net public wealth to net national income ratio
    wwealg <- download_wid(indicators = "wwealg", areas = "US", years = "all")
    ##net private wealth to net national income ratio
    wwealp <- download_wid(indicators = "wwealp", areas = "US", years = "all")
    ##net personal wealth to net national income ratio
    wwealh <- download_wid(indicators = "wwealh", areas = "US", years = "all")

##create variable names
public<- wwealg %>% select(country, year, public = value)
public
private <- wwealp %>% select(country, year, private = value)
private
personal <- wwealh %>% select(country, year, personal = value)
personal 

# Combine all three data frames
combined <- private %>% left_join(public) %>% left_join(personal)
#Joining with `by = join_by(country, year)`
#Joining with `by = join_by(country, year)`


##download global income and wealth inequality data
df_f1 <- read_excel("./data/WIR2022s.xlsx", sheet = "data-F1")

##download the wealth inequality data across countries
df_f4 <- read_excel("./data/WIR2022s.xlsx", sheet = "data-F4")
df_f4

