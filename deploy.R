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
system("git commit -m "Criado app agrofit e atualizado"")
system("git push origin main")

# Envia os arquivos para o droplet
system('scp -r _site/* root@162.243.12.89:/var/www/meu_site/')

git clone https://github.com/Marlenildo/agrofit.git /srv/shiny-server/meu_app

ssh root@62.243.12.89

#rendereizar app
############################################################
# Script: deploy_shiny.R
# Objetivo: Atualizar o app Shiny no droplet direto do GitHub
# Autor: [Seu Nome]
############################################################

# Configurações
http://162.243.12.89/meu_app

droplet_user <- "root"                    # usuário SSH do droplet
droplet_ip   <- "162.243.12.89"      # IP do droplet
shiny_dir    <- "/srv/shiny-server/api_agrofit" # pasta do app no servidor
github_repo  <- "https://github.com/Marlenildo/agrofit.git"

# Pergunta se quer atualizar
resposta <- readline("Deseja atualizar o app Shiny no droplet? (s/n): ")
if(tolower(resposta) == "s"){
  
  # Conecta via SSH e executa comandos no droplet:
  # 1) Cria pasta se não existir
  # 2) Clona o repositório se estiver vazio
  # 3) Puxa atualizações do GitHub
  comando <- sprintf(
    "ssh %s@%s 'mkdir -p %s && cd %s && if [ ! -d .git ]; then git clone %s .; else git pull origin main; fi'",
    droplet_user, droplet_ip, shiny_dir, shiny_dir, github_repo
  )
  
  system(comando)
  cat("✅ App Shiny atualizado no droplet!\n")
}

rm -rf /srv/shiny-server/meu_app
mkdir -p /srv/shiny-server/app_agrofit
cd /srv/shiny-server/app_agrofit
git clone https://github.com/Marlenildo/agrofit.git .
chown -R shiny:shiny /srv/shiny-server/app_agrofit
chmod -R 755 /srv/shiny-server/app_agrofit
