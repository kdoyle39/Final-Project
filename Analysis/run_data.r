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
