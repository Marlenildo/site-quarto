############################################################
#' Script: deploy.R
#' Autor: [Marlenido Melo]
#' Data: [12 set. 2025]
#'
#' Objetivo:
#'   Automatizar o processo de atualização do website Quarto
#'   publicado em um servidor remoto (droplet).
#'
#' O que este script faz:
#'   1. Renderiza o site localmente (gera a pasta _site/)
#'   2. Salva as alterações no repositório Git (commit + push)
#'   3. Envia os arquivos renderizados para o droplet via SCP
#'
#' Pré-requisitos:
#'   - Ter o Quarto instalado localmente
#'   - Ter o Git configurado no projeto
#'   - Ter acesso SSH ao droplet (chave já adicionada)
#'
#' Como usar:
#'   - Abra o RStudio na pasta do seu site
#'   - Execute: source("deploy.R")
#'   - O site será renderizado, versionado no GitHub e publicado
#'
############################################################

# Renderiza o site
system("quarto render")

# Faz commit e envia para o GitHub
system("git add .")
system("git commit -m "Atualizada estrutura o site e página de andamento do curso de R"")
system("git push origin main")

# Envia os arquivos para o droplet
system('scp -r _site/* root@162.243.12.89:/var/www/meu_site/')
