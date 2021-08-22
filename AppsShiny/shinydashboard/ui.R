dashboardPage(
  
  # Entete de l'appli
  dashboardHeader(title = "ShinyDashboard"),
  
  # Boutons de controles
  dashboardSidebar(
    # liste deroulante du type de colonne, par defaut numerique
    selectInput(inputId = "Choix_type",
                label = "Choix du type de colonne",
                choices = c("numérique", "caractères"),
                selected = "numérique"),
    # liste deroulante des colonnes
    selectInput(inputId = "Choix",
                label = "Choix de la colonne",
                choices = "total_bill")
  ),
  # Disposition des sorties
  
  # le tableau
  dashboardBody(
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
      box(title = "Les données brutes",
          status = "warning",
          width = 8,
          solidHeader = TRUE,
          # collapsible = TRUE,
          reactableOutput(outputId = "Tableau")),
      column(width = 4,
             # le chiffre
             valueBoxOutput(outputId = "Chiffre",
                            width = 12),
             # le graphique
             box(title = "Le graphique",
                 width = 12,
                 status = "success",
                 solidHeader = TRUE,
                 # collapsible = TRUE,
                 # animation de chargement du graphique avec withLoader
                 withLoader(plotOutput(outputId = "Graphique"))))
  ))
)