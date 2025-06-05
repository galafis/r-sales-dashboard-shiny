# 🇧🇷 Dashboard de Vendas E-commerce | 🇺🇸 E-commerce Sales Dashboard

## 🇧🇷 Português

### 📊 Descrição
Dashboard interativo desenvolvido em R e Shiny para análise completa de dados de vendas de e-commerce. O projeto demonstra competências em visualização de dados, desenvolvimento de aplicações web interativas e análise de negócios.

### 🛠️ Tecnologias Utilizadas
- **R**: Linguagem principal para análise de dados
- **Shiny**: Framework para aplicações web interativas
- **DT**: Tabelas interativas
- **plotly**: Gráficos interativos
- **shinydashboard**: Interface de dashboard
- **dplyr**: Manipulação de dados
- **ggplot2**: Visualizações estáticas

### 📋 Pré-requisitos
```r
# Instalar pacotes necessários
install.packages(c("shiny", "shinydashboard", "DT", "plotly", 
                   "dplyr", "ggplot2", "lubridate", "scales"))
```

### 🚀 Como Usar
1. Clone o repositório:
```bash
git clone https://github.com/galafis/r-sales-dashboard-shiny.git
cd r-sales-dashboard-shiny
```

2. Execute o aplicativo:
```r
# No R ou RStudio
shiny::runApp()
```

3. Acesse o dashboard no navegador (geralmente http://localhost:3838)

### 📁 Estrutura do Projeto
```
r-sales-dashboard-shiny/
├── app.R                 # Aplicação Shiny principal
├── data/
│   ├── sales_data.csv    # Dados de vendas simulados
│   └── generate_data.R   # Script para gerar dados
├── R/
│   ├── ui.R             # Interface do usuário
│   ├── server.R         # Lógica do servidor
│   └── utils.R          # Funções auxiliares
├── www/
│   └── style.css        # Estilos customizados
├── README.md            # Este arquivo
└── .gitignore          # Arquivos ignorados pelo Git
```

### 📈 Funcionalidades
- **Visão Geral**: KPIs principais e métricas de performance
- **Análise Temporal**: Vendas por período com filtros interativos
- **Análise de Produtos**: Performance por categoria e produto
- **Análise Geográfica**: Vendas por região
- **Análise de Clientes**: Segmentação e comportamento
- **Relatórios**: Exportação de dados e gráficos

### 🎯 Competências Demonstradas
- Desenvolvimento de aplicações web com Shiny
- Visualização interativa de dados
- Análise exploratória de dados (EDA)
- Interface de usuário responsiva
- Manipulação e transformação de dados
- Métricas de negócio e KPIs

### 📊 Resultados e Insights
O dashboard permite identificar:
- Tendências de vendas ao longo do tempo
- Produtos e categorias mais rentáveis
- Padrões sazonais de consumo
- Performance por região geográfica
- Segmentação de clientes por valor

### 🔄 Próximos Passos
- [ ] Integração com APIs de dados reais
- [ ] Implementação de machine learning para previsões
- [ ] Deploy em servidor de produção
- [ ] Autenticação de usuários
- [ ] Relatórios automatizados por email

---

## 🇺🇸 English

### 📊 Description
Interactive dashboard developed in R and Shiny for comprehensive e-commerce sales data analysis. This project demonstrates skills in data visualization, interactive web application development, and business analytics.

### 🛠️ Technologies Used
- **R**: Main language for data analysis
- **Shiny**: Framework for interactive web applications
- **DT**: Interactive tables
- **plotly**: Interactive charts
- **shinydashboard**: Dashboard interface
- **dplyr**: Data manipulation
- **ggplot2**: Static visualizations

### 📋 Prerequisites
```r
# Install required packages
install.packages(c("shiny", "shinydashboard", "DT", "plotly", 
                   "dplyr", "ggplot2", "lubridate", "scales"))
```

### 🚀 How to Use
1. Clone the repository:
```bash
git clone https://github.com/galafis/r-sales-dashboard-shiny.git
cd r-sales-dashboard-shiny
```

2. Run the application:
```r
# In R or RStudio
shiny::runApp()
```

3. Access the dashboard in your browser (usually http://localhost:3838)

### 📁 Project Structure
```
r-sales-dashboard-shiny/
├── app.R                 # Main Shiny application
├── data/
│   ├── sales_data.csv    # Simulated sales data
│   └── generate_data.R   # Script to generate data
├── R/
│   ├── ui.R             # User interface
│   ├── server.R         # Server logic
│   └── utils.R          # Helper functions
├── www/
│   └── style.css        # Custom styles
├── README.md            # This file
└── .gitignore          # Files ignored by Git
```

### 📈 Features
- **Overview**: Main KPIs and performance metrics
- **Temporal Analysis**: Sales by period with interactive filters
- **Product Analysis**: Performance by category and product
- **Geographic Analysis**: Sales by region
- **Customer Analysis**: Segmentation and behavior
- **Reports**: Data and chart export

### 🎯 Skills Demonstrated
- Web application development with Shiny
- Interactive data visualization
- Exploratory data analysis (EDA)
- Responsive user interface
- Data manipulation and transformation
- Business metrics and KPIs

### 📊 Results and Insights
The dashboard enables identification of:
- Sales trends over time
- Most profitable products and categories
- Seasonal consumption patterns
- Performance by geographic region
- Customer segmentation by value

### 🔄 Next Steps
- [ ] Integration with real data APIs
- [ ] Machine learning implementation for predictions
- [ ] Production server deployment
- [ ] User authentication
- [ ] Automated email reports

---

## 📄 Licença | License
MIT License - veja o arquivo LICENSE para detalhes | see LICENSE file for details

## 📞 Contato | Contact
**GitHub**: [@galafis](https://github.com/galafis)

---
*Desenvolvido com ❤️ em R e Shiny | Developed with ❤️ in R and Shiny*

