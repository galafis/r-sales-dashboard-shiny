# Aplicação Shiny - Dashboard de Vendas E-commerce
# E-commerce Sales Dashboard - Shiny Application

# Carregar bibliotecas básicas
library(shiny)

# Gerar dados simulados simples
generate_sample_data <- function() {
  set.seed(123)
  n <- 1000
  
  dates <- seq(as.Date("2023-01-01"), as.Date("2024-12-31"), by = "day")
  sample_dates <- sample(dates, n, replace = TRUE)
  
  categories <- c("Eletrônicos", "Roupas", "Casa", "Livros", "Esportes")
  regions <- c("Norte", "Nordeste", "Centro-Oeste", "Sudeste", "Sul")
  
  data.frame(
    date = sample_dates,
    category = sample(categories, n, replace = TRUE),
    region = sample(regions, n, replace = TRUE),
    sales = round(runif(n, 50, 2000), 2),
    quantity = sample(1:10, n, replace = TRUE),
    stringsAsFactors = FALSE
  )
}

# Interface do usuário
ui <- fluidPage(
  titlePanel("📊 Dashboard de Vendas E-commerce | E-commerce Sales Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      h3("🔧 Filtros | Filters"),
      
      dateRangeInput("date_range",
                     "Período | Date Range:",
                     start = "2023-01-01",
                     end = "2024-12-31"),
      
      selectInput("category",
                  "Categoria | Category:",
                  choices = c("Todas | All" = "all",
                             "Eletrônicos" = "Eletrônicos",
                             "Roupas" = "Roupas",
                             "Casa" = "Casa",
                             "Livros" = "Livros",
                             "Esportes" = "Esportes")),
      
      selectInput("region",
                  "Região | Region:",
                  choices = c("Todas | All" = "all",
                             "Norte" = "Norte",
                             "Nordeste" = "Nordeste",
                             "Centro-Oeste" = "Centro-Oeste",
                             "Sudeste" = "Sudeste",
                             "Sul" = "Sul")),
      
      hr(),
      h4("📈 Métricas | Metrics"),
      verbatimTextOutput("metrics")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("📊 Visão Geral | Overview",
                 h3("Resumo de Vendas | Sales Summary"),
                 plotOutput("sales_plot"),
                 br(),
                 h4("Vendas por Categoria | Sales by Category"),
                 plotOutput("category_plot")),
        
        tabPanel("🗺️ Análise Regional | Regional Analysis",
                 h3("Vendas por Região | Sales by Region"),
                 plotOutput("region_plot"),
                 br(),
                 tableOutput("region_table")),
        
        tabPanel("📅 Análise Temporal | Temporal Analysis",
                 h3("Tendência de Vendas | Sales Trend"),
                 plotOutput("trend_plot"),
                 br(),
                 h4("Vendas Mensais | Monthly Sales"),
                 tableOutput("monthly_table")),
        
        tabPanel("📋 Dados | Data",
                 h3("Dados Filtrados | Filtered Data"),
                 dataTableOutput("data_table"))
      )
    )
  )
)

# Lógica do servidor
server <- function(input, output) {
  
  # Gerar dados
  sales_data <- generate_sample_data()
  
  # Dados filtrados
  filtered_data <- reactive({
    data <- sales_data
    
    # Filtro de data
    data <- data[data$date >= input$date_range[1] & data$date <= input$date_range[2], ]
    
    # Filtro de categoria
    if (input$category != "all") {
      data <- data[data$category == input$category, ]
    }
    
    # Filtro de região
    if (input$region != "all") {
      data <- data[data$region == input$region, ]
    }
    
    return(data)
  })
  
  # Métricas
  output$metrics <- renderText({
    data <- filtered_data()
    total_sales <- sum(data$sales)
    total_quantity <- sum(data$quantity)
    avg_sale <- mean(data$sales)
    
    paste(
      "💰 Vendas Totais | Total Sales: R$", format(total_sales, big.mark = ".", decimal.mark = ","), "\n",
      "📦 Quantidade Total | Total Quantity:", format(total_quantity, big.mark = "."), "\n",
      "📊 Venda Média | Average Sale: R$", format(round(avg_sale, 2), decimal.mark = ","), "\n",
      "📈 Registros | Records:", nrow(data)
    )
  })
  
  # Gráfico de vendas
  output$sales_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) == 0) return(NULL)
    
    # Vendas por mês
    data$month <- format(data$date, "%Y-%m")
    monthly_sales <- aggregate(sales ~ month, data, sum)
    
    barplot(monthly_sales$sales,
            names.arg = monthly_sales$month,
            main = "Vendas Mensais | Monthly Sales",
            xlab = "Mês | Month",
            ylab = "Vendas (R$) | Sales (R$)",
            col = "steelblue",
            las = 2)
  })
  
  # Gráfico por categoria
  output$category_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) == 0) return(NULL)
    
    category_sales <- aggregate(sales ~ category, data, sum)
    
    pie(category_sales$sales,
        labels = paste(category_sales$category, "\nR$", format(category_sales$sales, big.mark = ".")),
        main = "Distribuição por Categoria | Distribution by Category",
        col = rainbow(nrow(category_sales)))
  })
  
  # Gráfico por região
  output$region_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) == 0) return(NULL)
    
    region_sales <- aggregate(sales ~ region, data, sum)
    
    barplot(region_sales$sales,
            names.arg = region_sales$region,
            main = "Vendas por Região | Sales by Region",
            xlab = "Região | Region",
            ylab = "Vendas (R$) | Sales (R$)",
            col = "lightgreen")
  })
  
  # Tabela regional
  output$region_table <- renderTable({
    data <- filtered_data()
    if (nrow(data) == 0) return(NULL)
    
    region_summary <- aggregate(cbind(sales, quantity) ~ region, data, sum)
    region_summary$avg_sale <- round(region_summary$sales / region_summary$quantity, 2)
    
    colnames(region_summary) <- c("Região | Region", "Vendas (R$) | Sales", "Quantidade | Quantity", "Venda Média | Avg Sale")
    region_summary
  })
  
  # Gráfico de tendência
  output$trend_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) == 0) return(NULL)
    
    daily_sales <- aggregate(sales ~ date, data, sum)
    
    plot(daily_sales$date, daily_sales$sales,
         type = "l",
         main = "Tendência Diária de Vendas | Daily Sales Trend",
         xlab = "Data | Date",
         ylab = "Vendas (R$) | Sales (R$)",
         col = "blue",
         lwd = 2)
  })
  
  # Tabela mensal
  output$monthly_table <- renderTable({
    data <- filtered_data()
    if (nrow(data) == 0) return(NULL)
    
    data$month <- format(data$date, "%Y-%m")
    monthly_summary <- aggregate(cbind(sales, quantity) ~ month, data, sum)
    monthly_summary$avg_sale <- round(monthly_summary$sales / monthly_summary$quantity, 2)
    
    colnames(monthly_summary) <- c("Mês | Month", "Vendas (R$) | Sales", "Quantidade | Quantity", "Venda Média | Avg Sale")
    monthly_summary
  })
  
  # Tabela de dados
  output$data_table <- renderDataTable({
    data <- filtered_data()
    colnames(data) <- c("Data | Date", "Categoria | Category", "Região | Region", "Vendas (R$) | Sales", "Quantidade | Quantity")
    data
  }, options = list(pageLength = 15, scrollX = TRUE))
}

# Executar aplicação
shinyApp(ui = ui, server = server)

