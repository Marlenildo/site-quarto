library(ssh)
ssh-keygen -t ed25519 -C "marlenildo@gmail.com"?

# Substitua pelos seus dados
droplet <- ssh_connect(host = "root@162.243.12.89")
# password: marlenildo
droplet <- ssh_connect(host = "root@162.243.12.89", keyfile = "C:/Users/marle/.ssh/id_ed25519")

library(quarto)
quarto_render()

# Envia todos os arquivos da pasta _site para o droplet
scp_upload(droplet, files = "_site/",to = "/var/www/meu_site/")

ssh_exec_wait(droplet, "mkdir -p /var/www/meu_site")

##
library(ssh)

# Conectar ao droplet (supondo que droplet já esteja definido)
# droplet <- ssh_connect(host = "root@SEU_IP_DO_DROPLET", keyfile = "C:/Users/marle/.ssh/id_ed25519")

# Enviar arquivos
scp_upload(droplet, "site/_site/*", to = "/var/www/meu_site/")

####

no termianal
sudo nano /etc/nginx/sites-available/meu_site

server {
  listen 80;
  server_name 162.243.12.89;
  
  root /var/www/meu_site;
  index index.html;
  
  location / {
    try_files $uri $uri/ =404;
  }
}
