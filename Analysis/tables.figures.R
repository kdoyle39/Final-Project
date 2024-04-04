## Plot 1 = US Wealth/Income Ratios
## Plot 2 = Global Income and Wealth Inequality
## Plot 3 = Wealth Inequality across Countries


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

library(ggplot2)

# Plot 2
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

##Save Plot 2
ggsave("global_income_wealth_inequality_plot.png", plot2, width = 10, height = 6, units = "in")

##Plot 3
plot3 <- df_f4 %>% pivot_longer(3:5, names_to = "level", values_to = "value") %>%
  ggplot(aes(x = iso, y = value, fill = level)) +
  geom_col(position = "dodge") + 
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(title = "The extreme concentration of capital: wealth inequality across the world",
       x = "", y = "Share of national wealth (%)", fill = "")

#Save Plot 3
ggsave("concentration_of_wealth.png", plot3, width = 10, height = 6, units = "in")


