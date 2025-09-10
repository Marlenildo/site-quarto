#' SCRIPT PARA ANÁLISE DE DADOS EXPERIMENTAIS EM R
#' 
#' Curso: [Curso de Estatística com R para Experimentação Agrícola]
#' Autor: [DSc. Marlenildo Ferreira Melo]
#' Data: [03 de setembro de 2025]
#' Versão do R: [R version 4.5.1 (2025-06-13 ucrt)]
#' Versão do RStudio: [2025.05.1 Build 513]
#' 
#' Objetivo: Análise de dados experimentais utilizando pacotes específicos em R
#' Descrição: Este script cobre desde a instalação e carregamento de pacotes,
#' importação e organização de dados, até a realização de análises estatísticas
#' como estatísticas descritivas e análise de variância (ANOVA).
#' Requisitos: R e RStudio instalados, pacotes necessários instalados


#' ============================================================================
# 1. Configurando o diretório de trabalho----
#' ===========================================================================
#' Defina o diretório de trabalho para o local onde seus arquivos estão armazenados.
#' Altere o caminho abaixo para o diretório desejado no seu computador.
#' Exemplo de caminho no Windows: ("C:/Users/SeuUsuario/Documentos/ProjetoR")
#' Use barras normais (/) ou duplas (\\) no Windows

setwd("C:/Users/marle/OneDrive/Documentos/Projetos R/site/logo_script")
setwd("C:\\Users\\marle\\OneDrive\\Documentos\\Projetos R\\site\\logo_script")
getwd() # Verifica o diretório de trabalho atual


#' ============================================================================
# 2. Instalando pacotes----
#' ============================================================================
## 2.1 Instalação individual de pacotes----
install.packages("tidyverse")   # Para manipulação e visualização de dados
install.packages("dplyr")       # Para manipulação e visualização de dados
install.packages("readxl")      # Para ler arquivos do Excel
install.packages("ExpDes.pt")   # Para planejamento e análise de experimentos agrícolas
install.packages("easyanova")   # Para facilitar análises de variância
install.packages("rstatix")     # Para estatísticas descritivas e testes inferenciais
install.packages("emmeans")     # Para estatísticas descritivas e testes inferenciais
install.packages("janitor")     # Para limpeza e organização de dados
install.packages("kableExtra")  # Para tabelas formatadas

## 2.2 Instalando pacotes de uma vez só----
install.packages(
  "tidyverse",
  "readxl",
  "ExpDes.pt",
  "easyanova",
  "rstatix",
  "emmeans",
  "janitor",
  "kableExtra"
)


#' ============================================================================
# 3. Carregando pacotes----
#' ============================================================================

#' Pacotes para manipulação e leitura de dados
library(tidyverse)   # Inclui dplyr, ggplot2, readr, tidyr, etc.
library(dplyr)       # Manipulação de dados
library(readxl)      # Para importar planilhas Excel
library(readr)       # Para importar arquivos de texto

#' Pacotes para análise de experimentos
library(ExpDes.pt)   # ANOVA para DIC, DBC, parcelas subdivididas etc.
library(easyanova)   # ANOVA e testes complementares de forma simplificada

#' Pacotes para estatística e pós-testes
library(rstatix)     # Testes estatísticos (normalidade, homogeneidade, etc.)
library(emmeans)     # Médias ajustadas e comparações múltiplas

#' Pacotes para organização e visualização de dados
library(janitor)     # Limpeza e organização de dados
library(kableExtra)  # Tabelas formatadas


#' ============================================================================
# 4. Importando dados----
#' ============================================================================

## 4.1 Importando dados de um arquivo Excel pacote readxl----
dados_ruins_dic <- read_excel("dados_ruins_dic.xlsx", sheet = "Planilha1")

## 4.2 Importando dados de um arquivo .txt (arquivo de texo bloco de notas) pacote readr
dados_ruins_dic <- read_delim("dados_ruins_dic.txt", 
                              delim = "\t", escape_double = FALSE, 
                              trim_ws = TRUE)



dados_ruins_dic # Visualização rápida no console

View(dados_ruins_dic) # Visualização em uma aba separada
#' ============================================================================
# 5. Renomear colunas específicas----
#' ============================================================================

## 5.1 Usando pacote dplyr----
dados_organizados_dplyr <- dados_ruins_dic |>
  rename(
    tratamento = Tratamento,
    repeticao = `Repetição`,
    altura_planta_cm = `Altura da planta (cm)`,
    peso_fresco_g = `Peso fresco (g)`
  )

dados_organizados_dplyr

## 5.1 Usando pacote janitor----
#' formato "snake_case"

dados_organizados_janitor <- dados_ruins_dic |>
  janitor::clean_names()

dados_organizados_janitor


#' ============================================================================
# 6. Visualizando os dados----
#' ============================================================================

## 6.1 Visualização dos dados originais----

dados_organizados_janitor # Visualização rápida no console
View(dados_organizados_janitor) # Visualização em uma aba separada (Atalho F2)
head(dados_organizados_janitor) # Primeiras linhas dos dados
tail(dados_organizados_janitor) # Últimas linhas dos dados
names(dados_organizados_janitor) # Nomes das colunas

## 5.2 Visualização da estrutura dos dados e resumo estatístico----

str(dados_organizados_janitor) # Estrutura dos dados
glimpse(dados_organizados_janitor) # Visão geral dos dados (dplyr)
summary(dados_organizados_janitor) # Resumo estatístico dos dados

  
#' ============================================================================
# 6. Convertendo variáveis em fatores----
#' ===========================================================================
  
## 6.1 Usando a função `as.factor()`----
  
dados_organizados_janitor$tratamento <- as.factor(dados_organizados_janitor$tratamento)
dados_organizados_janitor$repeticao <- as.factor(dados_organizados_janitor$repeticao)
  
  
str(dados_organizados_janitor) # Estrutura dos dados
glimpse(dados_organizados_janitor) # Visão geral dos dados (dplyr)
summary(dados_organizados_janitor) # Resumo estatístico dos dados
  
## 6.2 Usando a função `convert_as_factor` do pacote rstatix----
  
dados_organizados_janitor <- dados_organizados_janitor |>
  convert_as_factor(tratamento, repeticao)
  
  
str(dados_organizados_janitor) # Estrutura dos dados
glimpse(dados_organizados_janitor) # Visão geral dos dados (dplyr)
summary(dados_organizados_janitor) # Resumo estatístico dos dados


#' ============================================================================
# 7. Conhecendo os tipos de variáveis no R----
#' ============================================================================

#' Exemplo de banco de dados com todos os tipos de variáveis
#'   em experimentação agrícola (Delineamento em Blocos Casualizados)
dados_tipos <- read_excel("dados_tipos.xlsx", sheet = "Planilha1")

  
# Conferindo estrutura e resumo do banco
str(dados_tipos)          # Estrutura das variáveis
glimpse(dados_tipos)      # Visão geral das variáveis com dplyr
summary(dados_tipos)      # Resumo estatístico dos dados
  
  
# Renomeando colunas para facilitar o manuseio  
dados_tipos_organizado <- dados_tipos |>
    janitor::clean_names()

# Visualizando parte do banco
head(dados_tipos_organizado) |> view()


#' EXPLICAÇÃO DOS TIPOS DE VARIÁVEIS

#' 1) bloco -> Variável numérica inteira (discreta)
#' Representa os blocos do experimento (repetições). É usada para controlar
#' a variabilidade do campo. No R, aparece como "numeric" (ou "integer").

#' 2) tipo_adubo -> Variável de texto (character), pode ser transformada em fator
#' Representa a descrição do tratamento aplicado.
#' Exemplo: "Testemunha", "Adubo verde".

#' 3) tratamento -> Variável categórica nominal (factor)
#' É o identificador do tratamento (T1, T2, ...).
#' Não tem ordem lógica, apenas categorias distintas.

#' 4) data_coleta -> Variável do tipo Date
#' Representa a data em que os dados foram coletados.

#' 5) nota_vigor -> Variável ordinal
#' Escala de 1 a 5 indicando o vigor da planta.
#' Existe uma ordem (1 < 2 < 3 < 4 < 5).

#' 6) numero_folhas -> Variável numérica inteira (discreta)
#' Conta o número de folhas da planta.
#' Só assume valores inteiros (5, 6, 7...).

#' 7) altura_cm -> Variável numérica contínua
#' Medida da altura em centímetros.
#' Pode assumir qualquer valor real dentro de um intervalo.

#' 8) sobreviveu -> Variável lógica (boolean)
#' Indica se a planta sobreviveu (TRUE) ou morreu (FALSE).

#' 9) observacao -> Variável categórica nominal
#' Anotações pré-definidas sobre a planta: "Normal", "Doença", "Atraso".
#' Não existe ordem entre as categorias.

#' 10) comentario_livre -> Variável de texto livre (character)
#' Comentários mais detalhados feitos pelo avaliador.
#' Exemplo: "Necessita irrigação extra", "Presença de pragas".

# ============================================================================
# 6. Convertendo variáveis em fatores no banco 'dados_tipos' ----
# ============================================================================

# Carregando pacote necessário
library(rstatix)
library(dplyr)

## 6.1 Usando a função `as.factor()` ----

# Convertendo variáveis categóricas para fator
dados_tipos_organizado$tipo_de_adubo <- as.factor(dados_tipos_organizado$tipo_de_adubo)
dados_tipos_organizado$tratamento <- as.factor(dados_tipos_organizado$tratamento)
dados_tipos_organizado$observacao <- as.factor(dados_tipos_organizado$observacao)
dados_tipos_organizado$bloco <- as.factor(dados_tipos_organizado$bloco) # opcional: bloco também como fator

# Conferindo estrutura e resumo do banco
str(dados_tipos_organizado)          # Estrutura das variáveis
glimpse(dados_tipos_organizado)      # Visão geral das variáveis com dplyr
summary(dados_tipos_organizado)      # Resumo estatístico dos dados

#' Estrutura geral do banco
dados_tipos_organizado |> view() # com v minúsculo - Visualização em uma aba separada (Atalho F2)
dados_tipos_organizado |> View() # com v maiúsculo - Visualização em uma aba separada (Atalho F2)
dados_tipos_organizado |>  str() # Estrutura das variáveis
dados_tipos_organizado |> glimpse() # Visão geral dos dados (dplyr)
dados_tipos_organizado |> summary() # Resumo estatístico dos dados



## 6.2 Usando a função `convert_as_factor()` do pacote rstatix ----

# Conversão das variáveis categóricas para fatores de forma mais prática
dados_tipos <- dados_tipos %>%
  convert_as_factor(tipo_adubo, tratamento, observacao, bloco)

# Conferindo novamente
str(dados_tipos)          # Estrutura das variáveis
glimpse(dados_tipos)      # Visão geral com dplyr
summary(dados_tipos)      # Resumo estatístico


#' ============================================================================
# 7. Estatísticas descritivas----
#' ===========================================================================

## 7.1 Estatísticas descritivas gerais usando pacote dplyr----

#' Média geral
dados_organizados_janitor |>
  summarise(
    n = n(),  # Contagem total de observações
    media_altura = mean(altura_da_planta_cm, na.rm = TRUE),  # Média da altura
    sd_altura = sd(altura_da_planta_cm, na.rm = TRUE),      # Desvio padrão da altura
    media_peso = mean(peso_fresco_g, na.rm = TRUE),      # Média do peso fresco
    sd_peso = sd(peso_fresco_g, na.rm = TRUE)           # Desvio padrão do peso fresco
  )

#' Média por tratamento
dados_organizados_janitor |>
  group_by(tratamento) |>  # Agrupa por tratamento
  summarise(
    n = n(),  # Contagem total de observações
    media_altura = mean(altura_da_planta_cm, na.rm = TRUE),  # Média da altura
    sd_altura = sd(altura_da_planta_cm, na.rm = TRUE),      # Desvio padrão da altura
    media_peso = mean(peso_fresco_g, na.rm = TRUE),      # Média do peso fresco
    sd_peso = sd(peso_fresco_g, na.rm = TRUE)           # Desvio padrão do peso fresco
  )

## 7.2 Estatísticas descritivas usando pacote rstatix----

#' Estatísticas descritivas gerais *média e desvio-padrão*
dados_organizados_janitor |>
  rstatix::get_summary_stats(altura_da_planta_cm, peso_fresco_g, type = "mean_sd")

#' Estatísticas descritivas por tratamento *média e desvio-padrão*
dados_organizados_janitor |>
  group_by(tratamento) |>  # Agrupa por tratamento
  rstatix::get_summary_stats(altura_da_planta_cm, peso_fresco_g, type = "mean_sd")

#' Estatísticas descritivas por tratamento *média e erro-padrão*
dados_organizados_janitor |>
  group_by(tratamento) |>  # Agrupa por tratamento
  rstatix::get_summary_stats(altura_da_planta_cm, peso_fresco_g, type = "mean_se")

#' Estatísticas descritivas completas por tratamento
dados_organizados_janitor |>
  group_by(tratamento) |>  # Agrupa por tratamento
  rstatix::get_summary_stats(altura_da_planta_cm, peso_fresco_g)




#' ============================================================================
# 8. Análise de variância (ANOVA)----
#' ===========================================================================

## An
### 8.1 Usando a função `aov()`----
modelo <- aov(altura_da_planta_cm  ~ tratamento, data = dados_organizados_janitor)
summary(modelo)

## 8.2 Usando a função `anova_test` do pacote rstatix----
dados_organizados_janitor |> anova_test(altura_da_planta_cm ~ tratamento) 


## 8.3 Usando a função `dic()` do pacote ExpDes.pt----

dic(
  trat = dados_organizados_janitor$tratamento,
  resp = dados_organizados_janitor$altura_da_planta_cm,
  quali = TRUE,
  mcomp = "tukey"
)

## 8.3 Usando a função `ea1` do pacote easyanova----
easyanova::ea1(dados_organizados_janitor[-2], design = 1, plot = 2, list = TRUE)

## 8.1 Usando o pacote easyanova (ANOVA)----


## 8.1 Usando o pacote ExpDes.pt (DIC)----

#' ANOVA para DIC
#' O pacote ExpDes.pt é específico para experimentos agrícolas
#' e facilita a análise de delineamentos experimentais comuns.
#' Ele é especialmente útil para análises de variância (ANOVA)
#' em delineamentos inteiramente casualizados (DIC),
#' delineamentos em blocos casualizados (DBC),
#' parcelas subdivididas, entre outros.
#' Ele também oferece funções para realizar testes complementares,
#' como o teste de Tukey, e para gerar gráficos básicos.
#' #' A função `dic()` do pacote ExpDes.pt é usada para realizar a análise de variância (ANOVA)
#' em um delineamento inteiramente casualizado (DIC).
#' Ela calcula a ANOVA para uma variável resposta em função de um fator de tratamento,
#' considerando as repetições do experimento.
#' #' A função também pode realizar testes complementares, como o teste de Tukey,
#' para comparar as médias dos tratamentos.
#' #' A sintaxe básica da função `dic()` é a seguinte:
#' #' ```R
#' dic(response, treatment, block = NULL, quali = NULL, mcomp = "tukey", sigT = 0.05, sigF = 0.05, group = TRUE, console = TRUE)
#' 
#' 





#'  ============================================================================
#'  Fim do Script
#'  ============================================================================