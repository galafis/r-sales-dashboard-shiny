# Script para gerar dados simulados de vendas de e-commerce
# Generate simulated e-commerce sales data

library(dplyr)
library(lubridate)

set.seed(123)

# Configurações
n_records <- 5000
start_date <- as.Date("2023-01-01")
end_date <- as.Date("2024-12-31")

# Produtos e categorias
categories <- c("Eletrônicos", "Roupas", "Casa e Jardim", "Livros", "Esportes", "Beleza")
products <- c(
  "Smartphone", "Laptop", "Tablet", "Fones de Ouvido", "Smartwatch",
  "Camiseta", "Jeans", "Vestido", "Tênis", "Jaqueta",
  "Sofá", "Mesa", "Cadeira", "Luminária", "Tapete",
  "Romance", "Técnico", "Biografia", "Ficção", "Autoajuda",
  "Bicicleta", "Tênis Corrida", "Bola", "Raquete", "Equipamento",
  "Perfume", "Maquiagem", "Creme", "Shampoo", "Protetor Solar"
)

# Regiões
regions <- c("Norte", "Nordeste", "Centro-Oeste", "Sudeste", "Sul")

# Estados por região
states_by_region <- list(
  "Norte" = c("AC", "AP", "AM", "PA", "RO", "RR", "TO"),
  "Nordeste" = c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE"),
  "Centro-Oeste" = c("DF", "GO", "MT", "MS"),
  "Sudeste" = c("ES", "MG", "RJ", "SP"),
  "Sul" = c("PR", "RS", "SC")
)

# Função para gerar dados
generate_sales_data <- function() {
  
  # Gerar datas com sazonalidade
  dates <- sample(seq(start_date, end_date, by = "day"), n_records, replace = TRUE)
  
  # Adicionar sazonalidade (mais vendas no final do ano)
  month_weights <- c(0.8, 0.8, 0.9, 0.9, 1.0, 1.0, 1.1, 1.1, 1.0, 1.2, 1.5, 2.0)
  dates <- sample(seq(start_date, end_date, by = "day"), n_records, replace = TRUE,
                  prob = month_weights[month(seq(start_date, end_date, by = "day"))])
  
  # Gerar dados
  sales_data <- data.frame(
    id = 1:n_records,
    date = dates,
    year = year(dates),
    month = month(dates),
    quarter = quarter(dates),
    weekday = wday(dates, label = TRUE),
    
    # Produtos
    category = sample(categories, n_records, replace = TRUE),
    product = sample(products, n_records, replace = TRUE),
    
    # Geografia
    region = sample(regions, n_records, replace = TRUE, prob = c(0.1, 0.2, 0.15, 0.4, 0.15)),
    
    # Preços com variação por categoria
    unit_price = case_when(
      category == "Eletrônicos" ~ round(runif(n_records, 200, 3000), 2),
      category == "Roupas" ~ round(runif(n_records, 30, 300), 2),
      category == "Casa e Jardim" ~ round(runif(n_records, 50, 1500), 2),
      category == "Livros" ~ round(runif(n_records, 15, 80), 2),
      category == "Esportes" ~ round(runif(n_records, 40, 800), 2),
      category == "Beleza" ~ round(runif(n_records, 20, 200), 2)
    ),
    
    # Quantidade
    quantity = sample(1:5, n_records, replace = TRUE, prob = c(0.5, 0.25, 0.15, 0.07, 0.03)),
    
    # Cliente
    customer_id = sample(1:1000, n_records, replace = TRUE),
    customer_segment = sample(c("Bronze", "Prata", "Ouro", "Platina"), n_records, 
                             replace = TRUE, prob = c(0.4, 0.3, 0.2, 0.1)),
    
    # Canal de venda
    sales_channel = sample(c("Online", "Loja Física", "Mobile App"), n_records, 
                          replace = TRUE, prob = c(0.6, 0.25, 0.15))
  )
  
  # Adicionar estado baseado na região
  sales_data$state <- sapply(sales_data$region, function(r) {
    sample(states_by_region[[r]], 1)
  })
  
  # Calcular valores
  sales_data$total_value <- sales_data$unit_price * sales_data$quantity
  
  # Adicionar desconto baseado no segmento
  sales_data$discount_rate <- case_when(
    sales_data$customer_segment == "Bronze" ~ 0,
    sales_data$customer_segment == "Prata" ~ 0.05,
    sales_data$customer_segment == "Ouro" ~ 0.10,
    sales_data$customer_segment == "Platina" ~ 0.15
  )
  
  sales_data$discount_amount <- sales_data$total_value * sales_data$discount_rate
  sales_data$final_value <- sales_data$total_value - sales_data$discount_amount
  
  # Adicionar margem de lucro
  sales_data$cost <- sales_data$unit_price * 0.6  # 40% de margem média
  sales_data$profit <- sales_data$final_value - (sales_data$cost * sales_data$quantity)
  
  return(sales_data)
}

# Gerar e salvar dados
cat("Gerando dados de vendas...\n")
sales_data <- generate_sales_data()

# Salvar arquivo CSV
write.csv(sales_data, "data/sales_data.csv", row.names = FALSE)

cat("Dados gerados com sucesso!\n")
cat("Total de registros:", nrow(sales_data), "\n")
cat("Período:", min(sales_data$date), "a", max(sales_data$date), "\n")
cat("Valor total de vendas: R$", format(sum(sales_data$final_value), big.mark = ".", decimal.mark = ","), "\n")

# Resumo dos dados
cat("\n=== RESUMO DOS DADOS ===\n")
cat("Categorias:", paste(unique(sales_data$category), collapse = ", "), "\n")
cat("Regiões:", paste(unique(sales_data$region), collapse = ", "), "\n")
cat("Canais de venda:", paste(unique(sales_data$sales_channel), collapse = ", "), "\n")
cat("Segmentos de cliente:", paste(unique(sales_data$customer_segment), collapse = ", "), "\n")

