library("shiny")
library("shinycustomloader")

library("dplyr")
library("ggplot2")
library("ggtext")
library("reactable")

tips = reshape2::tips %>% arrange(size)
tips$day = factor(tips$day, levels = c("Thur", "Fri", "Sat", "Sun"))


bar_chart <- function(value, max_value, height = "16px", fill = "#00bfc4", background = NULL) {
  width = paste0(value / max_value * 100, "%")
  bar <- div(style = list(background = fill, width = width, height = height))
  valeur = scales::number(value, accuracy = 0.1)
  if (value < 10) valeur = scales::number(value, accuracy = 0.01)
  chart <- div(style = list(flexGrow = 1, marginLeft = "8px", background = background), bar)
  div(style = list(display = "flex", alignItems = "center"),
      valeur, chart)
}

max_bill = max(tips$total_bill)
max_tip = max(tips$tip)
min_tip = min(tips$tip)
