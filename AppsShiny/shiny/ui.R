fluidPage(
  
  # Entete de l'appli
  titlePanel(title = "Shiny"),
  
  # Boutons de controles
  sidebarLayout(
    sidebarPanel(
      # liste deroulante du type de colonne, par defaut numerique
      selectInput(inputId = "Choix_type",
                  label = "Choix du type de colonne",
                  choices = c("numérique", "caractères"),
                  selected = "numérique"),
      # liste deroulante des colonnes
      selectInput(inputId = "Choix",
                  label = "Choix de la colonne",
                  choices = "total_bill"),
      width = 2
    ),
  # Disposition des sorties
  
  # le tableau
  mainPanel(
    tags$head(tags$style(HTML('
      .tag {
            display: inline-block;
            padding: 2px 12px;
            border-radius: 15px;
            font-weight: 600;
            font-size: 12px;
          }

      .status-thur {
        background: firebrick;
        color: white;
                    }
      .status-fri {
        background: indianred;
        color: white;
                  }
      .status-sat {
        background: salmon;
        color: white;
      }
      .status-sun {
        background: orange;
        color: white;
      }           
    '))),
    fluidRow(
      column(8, 
          reactableOutput(outputId = "Tableau")),
             # le graphique
     column(4,
        # animation de chargement du graphique avec withLoader
         withLoader(plotOutput(outputId = "Graphique")))
  ), width = 10)
)
)