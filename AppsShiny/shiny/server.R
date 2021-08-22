server <- function(input, output, session) ({

  # on prepare la table a afficher
  output$Tableau = renderReactable({
    reactable(tips, 
              defaultPageSize = 12,
              columns = list(total_bill = colDef(name = "total_bill", 
                                                 align = "left", 
                                                 cell = function(value) {
                                                  bar_chart(value, 
                                                            max_value = max_bill, 
                                                            fill = "forestgreen", 
                                                            background = "lightgreen")
                                                                        }
                                                ),
                             tip = colDef(style = function(value) {
                               normalized <- (value - min_tip) / (max_tip - min_tip)
                                orange_pal <- function(x) rgb(colorRamp(c("white", "navy"))(x), maxColorValue = 255)
                                color <- orange_pal(normalized)
                                list(background = color)
                                                                    }
                                          ),
                             day = colDef(cell = function(value) {
                               # balise avec les classes "tag" (pour la forme) et "status-day" pour les couleurs
                               class <- paste0("tag status-", tolower(value))
                               htmltools::div(class = class, value)})
                          )
              )
                                  })
  
  # on met a jour la liste deroulante
  observe({
    # les colonnes numeriques
    var_num = vapply(tips,
                     is.numeric,
                     logical(1))
    # les colonnes characteres ou facteurs
    var_char = vapply(tips,
                      \(x) is.character(x) | is.factor(x),
                      logical(1))
    
    updateSelectInput(session = session,
                      inputId = "Choix",
                      label = "Choix de la colonne du graphique",
                      choices = if (input$Choix_type == "numérique") {
                        names(var_num)[var_num]
                      } else {
                        names(var_char)[var_char]
                      }
    )
  })
  
  # on calcule les graphiques, modes et moyennes
  val_graph = reactive({
      dtf2 = tips[input$Choix]
      colnames(dtf2) = "x"
      
      if (is.numeric(dtf2$x)) {
        # le graphique
        gg = ggplot(dtf2, aes(x)) + geom_histogram(bins = 20) + ggtitle(paste0("**Histogramme de ", input$Choix, "**"))
      } else {
        dtf2 = dtf2 %>% count(x)
        # le graphique
        gg = ggplot(dtf2, aes(x, n)) + geom_bar(stat = "identity") + ggtitle(paste0("**Diagramme en barres de ", input$Choix, "**"))
      } 
      
      gg = gg + theme(plot.title = element_markdown(color = "white",
                                                    hjust = 0.5,
                                                    margin = margin(8,8,8,8),
                                                    padding = margin(6,6,6,6),
                                                    r = unit(8, "pt"),
                                                   fill = "seagreen"))
    
    return(gg)
  })
  
  # on prepare l'histogramme ou le diagramme en barres de la colonne choisie
  output$Graphique = renderPlot(val_graph())
})