##How do the trends in the private wealth/income ratio (indicating concentration of wealth) and the public wealth/income ratio (indicating government revenue capacity) interact, and what are the implications for taxation policies targeting capital income or wealth to address income inequality and support public services?

install.packages("renv")
library(renv)

### Data taken from the World Inequality Database

# Load the necessary packages
library(readr)
library(tidyr)
install.packages("WDI")
library(WDI)
library(tidyverse)
library(readxl) #for excel files
install.packages("devtools")
devtools::install_github("WIDworld/wid-r-tool")
library(wid)
library(dplyr)
install.packages("testthat")

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

library(ggplot2)

# Plot 1
plot <- ggplot(combined, aes(x = year)) +
  geom_line(aes(y = private, color = "Private")) +
  geom_line(aes(y = public, color = "Public")) +
  geom_line(aes(y = personal, color = "Personal")) +
  labs(title = "Wealth/Income Ratio Over Time",
       x = "Year",
       y = "Value") +
  scale_color_manual(values = c("Private" = "blue", "Public" = "red", "Personal" = "green")) +
  theme_minimal() +
  theme(plot.background = element_rect(fill = "white"))

# Save Plot 1 as a file
ggsave("wealth_income_ratio_plot.png", plot, width = 10, height = 6, units = "in")

##download global income and wealth inequality data
df_f1 <- read_excel("./data/WIR2022s.xlsx", sheet = "data-F1")

library(ggplot2)

# Make a plot on global income and wealth inequality
plot2 <- df_f1 %>% 
  select(cat = ...1, 2:4) %>%
  pivot_longer(2:4, names_to = "group", values_to = "value") %>%
  ggplot(aes(x = cat, y = value, fill = group)) +
  geom_col(position = "dodge") + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) + 
  geom_text(aes(x = cat, y = value, group = group, label = scales::label_percent(accuracy=1)(value)), vjust = -0.08,
            position = position_dodge(0.9)) + 
  labs(title = "Global income and wealth inequality",
       x = "", y = "Share of total income or wealth", fill = "")

##save the plot
ggsave("global_income_wealth_inequality_plot.png", plot2, width = 10, height = 6, units = "in")

##download the data
df_f4 <- read_excel("./data/WIR2022s.xlsx", sheet = "data-F4")
df_f4

##make a Plot for wealth inequality across the world
plot3 <- df_f4 %>% pivot_longer(3:5, names_to = "level", values_to = "value") %>%
  ggplot(aes(x = iso, y = value, fill = level)) +
  geom_col(position = "dodge") + 
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(title = "The extreme concentration of capital: wealth inequality across the world",
       x = "", y = "Share of national wealth (%)", fill = "")

#save the plot
ggsave("concentration_of_wealth.png", plot3, width = 10, height = 6, units = "in")

library(testthat)
library(dplyr)
library(tidyr)
library(ggplot2)

# Assume df_f4 contains the data
countries <- df_f4$iso

# Unit test to check if all countries are included in the plot
test_that("All countries are included in the plot", {
  expect_equal(length(unique(countries)), nrow(df_f4),
               info = "Number of unique countries should match the number of rows in the data frame.")
})

