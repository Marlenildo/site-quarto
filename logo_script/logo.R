
# LOGO 1----
# Carregar as bibliotecas necessárias
library(ggplot2)
library(dplyr)

# Criar dados para duas curvas normais que formam o "M"
x <- seq(-8, 58, length.out = 200)

# Primeira curva (pico à esquerda)
mu1 <- 15
sigma1 <- 5
curve1 <- dnorm(x, mean = mu1, sd = sigma1) * 600 + dnorm(x, mean = mu1, sd = sigma1 * 2) * 300

# Segunda curva (pico à direita)
mu2 <- 35
sigma2 <- 5
curve2 <- dnorm(x, mean = mu2, sd = sigma2) * 600 + dnorm(x, mean = mu2, sd = sigma2 * 2) * 300

# Combinar as curvas para criar o efeito "M"
data <- data.frame(
  x = x,
  y1 = curve1,  # Curva inferior
  y2 = curve1 + curve2,  # Curva superior
  y3 = curve2  # Curva intermediária
)

# Ajustar para escala de 0 a 900 no eixo y
data$y1 <- data$y1 * 1.2
data$y2 <- data$y2 * 1.2
data$y3 <- data$y3 * 1.2


ggplot(data, aes(x = x)) +
  # Camada de fundo estilizado (efeito nebuloso)
  geom_area(aes(y = y1), fill = "#4A90E2", alpha = 0.3) +
  geom_area(aes(y = y2), fill = "#F5A623", alpha = 0.5) +
  geom_area(aes(y = y3), fill = "#D0021B", alpha = 0.9)+
  
  geom_area(aes(y = y3), fill = "green", alpha = 0.2)+
  theme_minimal() 


ggplot(data, aes(x = x)) +
  # Camada de fundo estilizado (efeito nebuloso)
  geom_area(aes(y = y1), fill = "#4A90E2", alpha = 1) +
  # geom_area(aes(y = y2), fill = "#F5A623", alpha = 0.5) +
  # geom_area(aes(y = y3), fill = "#D0021B", alpha = 0.9)+
  
  geom_area(aes(y = y3), fill = "green", alpha = 1)+
  coord_equal() +
  theme_void()


# LOGO 3----

#install.packages("dplyr")

# Load libraries
library(ggplot2)
library(dplyr)

# Create sequence for x
x <- seq(-4, 4, length.out = 500)

# Normal distribution curves
y1 <- dnorm(x, mean = -1.5, sd = 0.6)   # left curve
y2 <- dnorm(x, mean =  1.5, sd = 0.6)   # right curve

# Put into a data frame
df <- data.frame(
  x = c(x, x),
  y = c(y1, y2),
  group = rep(c("left", "right"), each = length(x))
)

# Scale and shift curves so they look like stylized arcs
df <- df %>%
  mutate(
    y = y * 3,          # scale height
    x = x * 0.8,        # compress horizontally
    y = y - 0.1         # shift down a bit
  )

# Plot
ggplot(df, aes(x, y, group = group)) +
  geom_line(linewidth = 2, color = "#1f4e85") +   # blue thick line
  coord_equal() +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "white", color = NA)
  )


# LOGO 4----

# Load libraries

library(ggplot2)
library(dplyr)

# Create sequence for x
x <- seq(-4, 4, length.out = 500)

# Normal distribution curves
y1 <- dnorm(x, mean = -1.5, sd = 0.6)   # left curve
y2 <- dnorm(x, mean =  1.5, sd = 0.6)   # right curve

# Put into a data frame
df <- data.frame(
  x = c(x, x),
  y = c(y1, y2),
  group = rep(c("left", "right"), each = length(x))
)

# Scale and shift curves so they look like stylized arcs
df <- df %>%
  mutate(
    y = case_when(
      group == "left"  ~ y * 3.5,   # left peak taller
      group == "right" ~ y * 2.8    # right peak shorter
    ),
    x = x * 0.8,   # compress horizontally
    y = y - 0.1   # shift down
  )

# Plot
ggplot(df, aes(x, y, group = group)) +
  geom_line(linewidth = 6, color = "#1f4e85") +   # blue thick line
  coord_equal() +
  theme_void() 
#theme(
#plot.background = element_rect(fill = "white", color = NA)
#)



# LOGO 6----


# Create sequence for x
x <- seq(-3, 3, length.out = 500)

# Normal distribution curves
y1 <- dnorm(x, mean = -1, sd = 0.6)   # left curve
y2 <- dnorm(x, mean =  1, sd = 0.6)   # right curve

# Put into a data frame
df <- data.frame(
  x = c(x, x),
  y = c(y1, y2),
  group = rep(c("left", "right"), each = length(x))
)

# Scale and shift curves so they look like stylized arcs
df <- df %>%
  mutate(
    y = case_when(
      group == "left"  ~ y * 3.5,   # left peak taller
      group == "right" ~ y * 2.8    # right peak shorter
    ),
    x = x * 0.8,   # compress horizontally
    y = y - 0.1   # shift down
  )

# Plot
ggplot(df, aes(x, y, group = group)) +
  geom_line(linewidth = 6, color = "#1f4e85") +   # blue thick line
  coord_equal() +
  theme_void() 



# LOGO 7----
##
library(ggplot2)
library(dplyr)

# Sequência de x
x <- seq(0, 50, length.out = 200)

# Curva esquerda (pico à esquerda)
mu1 <- 15
sigma1 <- 5
curve_left <- dnorm(x, mean = mu1, sd = sigma1) * 600

# Curva direita (pico à direita)
mu2 <- 35
sigma2 <- 5
curve_right <- dnorm(x, mean = mu2, sd = sigma2) * 600

# Criar data frames separados para cada curva
df_left <- data.frame(x = x, y = curve_left)
df_right <- data.frame(x = x, y = curve_right)

# Cortar a curva esquerda para desaparecer na metade direita
df_left$y[x > (mu1 + 3*sigma1)] <- 0

# Cortar a curva direita para desaparecer na metade esquerda
df_right$y[x < (mu2 - 3*sigma2)] <- 0

# Plot com curvas azuis preenchidas
ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "green") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#1f4e85") +
  coord_equal() +
  theme_void()

# LOGO 8----
# Funcionou
# São duas curvas normais preenchidas, uma verde e outra azul
# A azul é mais alta que a verde

library(ggplot2)
library(dplyr)

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas normais
y_left  <- dnorm(x, mean = -1, sd = 0.6) * 3.5  # esquerda mais alta
y_right <- dnorm(x, mean =  1, sd = 0.6) * 2.8  # direita mais baixa

# Data frames separados para cada curva
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Plot com áreas preenchidas
ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85", alpha = 0.5) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green", alpha = 0.5) +
  coord_equal() +
  theme_void()


# LOGO 9----
library(ggplot2)
library(dplyr)

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas normais
y_left  <- dnorm(x, mean = -1, sd = 0.6) * 3.5  # esquerda mais alta
y_right <- dnorm(x, mean =  1, sd = 0.6) * 2.8  # direita mais baixa

# Data frames separados para cada curva
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Plot com áreas preenchidas e fundo transparente
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green") +
  coord_equal() +
  theme_void() 
theme(
  panel.background = element_rect(fill = NA),
  plot.background  = element_rect(fill = NA)
)

# Exibir
print(p)

# Salvar como PNG transparente
ggsave("duas_curvas_transparentes.png", plot = p, width = 6, height = 6, dpi = 300, bg = "transparent")

# LOGO 10----
library(ggplot2)
library(dplyr)

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas normais
y_left  <- dnorm(x, mean = -1, sd = 0.6) * 3.5  # esquerda mais alta
y_right <- dnorm(x, mean =  1, sd = 0.6) * 2.8  # direita mais baixa

# Data frames separados para cada curva
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Plot com áreas preenchidas, fundo transparente e apenas eixos
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85",alpha = 0.3) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green", alpha = 0.3) +
  coord_equal() +
  theme_void()
theme(
  panel.background = element_rect(fill = NA, color = NA),
  plot.background  = element_rect(fill = NA, color = NA),
  panel.grid = element_blank(),      # remove grades
  axis.line = element_line(color = "gray"),  # só eixos
  axis.ticks = element_blank(),
  axis.title = element_blank(),      # sem título nos eixos
  axis.text  = element_blank()  # mostrar números nos eixos
)

# Exibir
print(p)

# Salvar como PNG transparente
ggsave("duas_curvas_eixos.png", plot = p, width = 6, height = 6, dpi = 300, bg = "transparent")




# LOGO 12 - tentativa 2----
library(ggplot2)
library(dplyr)

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas normais
y_left  <- dnorm(x, mean = -1, sd = 0.6) * 3.5  # esquerda mais alta
y_right <- dnorm(x, mean =  1, sd = 0.6) * 2.8  # direita mais baixa

# Data frames separados para cada curva
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Altura máxima para posicionamento do texto
y_max <- max(c(y_left, y_right))

# Expandir eixo x para colocar o texto à direita
x_lim <- c(min(x), max(x) + 4)  # aumentar limite direito do eixo x

# Coordenada x para o texto
x_text <- max(x)  # dentro do novo limite, mas afastado das curvas

# Plot com áreas preenchidas e texto ao lado
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green") +
  # Texto MARLENILDO (menor, azul, topo do retângulo)
  annotate("text", x = x_text, y = y_max * 0.6, label = "MARLENILDO",
           color = "#1f4e85", size = 8.5, fontface = "bold", hjust = 0) +
  # Texto SOLUÇÕES (maior, verde, abaixo)
  annotate("text", x = x_text, y = y_max * 0.25, label = "Soluções em Curso",
           color = "green", size = 6, fontface = "bold", hjust = 0) +
  coord_equal(xlim = x_lim) +
  theme_void() +
  theme(
    panel.background = element_rect(fill = NA, color = NA),
    plot.background  = element_rect(fill = NA, color = NA)
  )

# Exibir
print(p)

# Salvar logo em PNG transparente
ggsave("logo_curvas_lado_texto_corrigido.png", plot = p, width = 8, height = 6, dpi = 300, bg = "transparent")






#13----
library(ggplot2)
library(dplyr)

# Sequência para o eixo x
x <- seq(-10, 10, length.out = 1000)

# Curva qui-quadrado (cauda à direita)
y_chi <- dchisq(x, df = 3)

# Curva da direita (normal, cauda à direita)
df_right <- data.frame(x = x-5, y = y_chi * 1)

# Curva da esquerda (espelhada, cauda à esquerda)
df_left <- data.frame(x = -x+5, y = y_chi * 1)

# Altura máxima
y_max <- max(c(df_left$y, df_right$y))

# Plot
ggplot() +
  geom_area(data = df_left,  aes(x = x, y = y), fill = "#1f4e85") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green") +
  theme_minimal()

#14----
library(ggplot2)

# Sequência para o eixo x
x <- seq(0, 10, length.out = 1000)

# Curva qui-quadrado (cauda à direita)
y_chi <- dchisq(x, df = 3)

# Curva da direita (normal, cauda à direita)
df_right <- data.frame(x = x - 5, y = y_chi)

# Curva da esquerda (espelhada, cauda à esquerda)
df_left <- data.frame(x = -x + 5, y = y_chi)

# Ajuste do ponto do texto (à direita)
x_text <- max(c(df_left$x, df_right$x)) + 0.5  # ligeiramente à direita da curva
y_max <- max(c(df_left$y, df_right$y))
# Plot com bordas nas áreas
ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "green") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#1f4e85", color = "white", size = 5) +
  theme_void() +
  coord_cartesian(ylim = c(0, max(y_chi)*1.1))+
  annotate("text", x = x_text, y = y_max * 0.6, label = "MARLENILDO",
           color = "#1f4e85", size = 8.5, fontface = "bold", hjust = 0) +
  # Texto SOLUÇÕES (maior, verde, abaixo)
  annotate("text", x = x_text, y = y_max * 0.25, label = "SOLUÇÕES",
           color = "green", size = 10, fontface = "bold", hjust = 0)


library(ggplot2)


ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "green") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#1f4e85", color = "white", size = 5) +
  theme_void() +
  coord_cartesian(ylim = c(0, y_max*1.1)) +
  # Texto MARLENILDO (direita)
  annotate("text", x = x_text, y = y_max * 0.6, label = "MARLENILDO",
           color = "#1f4e85", size = 8.5, fontface = "bold", hjust = 1) +
  # Texto SOLUÇÕES (direita, abaixo)
  annotate("text", x = x_text, y = y_max * 0.25, label = "SOLUÇÕES",
           color = "green", size = 10, fontface = "bold", hjust = 1)


#15----
library(ggplot2)

# Sequência para o eixo x
x <- seq(0, 10, length.out = 1000)

# Curva qui-quadrado (cauda à direita)
y_chi <- dchisq(x, df = 3)

# Curva da direita (normal, cauda à direita)
df_right <- data.frame(x = x - 5, y = y_chi)

# Curva da esquerda (espelhada, cauda à esquerda)
df_left <- data.frame(x = -x + 5, y = y_chi)

# Altura máxima
y_max <- max(c(df_left$y, df_right$y))

# Ponto do texto
x_text <- max(c(df_left$x, df_right$x)) + 10  # mais espaço à direita

# Plot
ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "green") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#1f4e85", color = "white", size = 5) +
  theme_void() +
  scale_x_continuous(limits = c(min(c(df_left$x, df_right$x)), x_text + 1)) +  # limites reais
  scale_y_continuous(limits = c(0, y_max * 1.1)) +
  annotate("text", x = 5.2, y = y_max * 0.8, label = "MARLENILDO",
           color = "#1f4e85", size = 20, fontface = "bold", hjust = 0) +
  annotate("text", x = 5.2, y = y_max * 0.25, label = "SOLUÇÕES",
           color = "green", size = 20, fontface = "bold", hjust = 0)

#16 LOGO - Nome em baixo----
# Funcionou
library(ggplot2)
library(dplyr)

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas normais
y_left  <- dnorm(x, mean = -1, sd = 0.6) * 3.5  # esquerda mais alta
y_right <- dnorm(x, mean =  1, sd = 0.6) * 2.8  # direita mais baixa

# Data frames separados para cada curva
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Altura máxima para posicionamento do texto
y_max <- max(c(y_left, y_right))

# Coordenada x para centralizar o texto
x_center <- mean(range(x))

# Espaço abaixo das curvas para o texto
y_text_marlenildo <- -0.6  # ajuste conforme necessário
y_text_solucoes  <- -1.2  # ajuste conforme necessário

# Plot com áreas preenchidas e texto embaixo
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green") +
  # Texto MARLENILDO (menor, azul, embaixo)
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 15, fontface = "bold", hjust = 0.5) +
  # Texto SOLUÇÕES (maior, verde, abaixo de MARLENILDO)
  annotate("text", x = x_center, y = y_text_solucoes-0.2, label = "Soluções em Curso",
           color = "green", size = 10, fontface = "bold", hjust = 0.5) +
  coord_equal(ylim = c(y_text_solucoes - 0.5, y_max + 0.5)) +  # expandir eixo y
  theme_void() +
  theme(
    panel.background = element_rect(fill = NA, color = NA),
    plot.background  = element_rect(fill = NA, color = NA)
  )

# Exibir
print(p)


# Salvar logo em PNG transparente
# Ajustar largura e altura conforme necessário

ggsave("logo_curvas_embaixo_texto.png", plot = p, width = 6, height = 6, dpi = 300, bg = "transparent", scale = 0.25)


#17 OPACA NOME EMBAIXO----

library(ggplot2)
library(dplyr)
library(showtext)  # para usar fontes personalizadas

# Escolha da fonte (deve estar instalada no sistema)
font_add_google("Audiowide", "audiowide")  # exemplo com fonte do Google


# Ativar showtext
showtext_auto()
# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas normais
y_left  <- dnorm(x, mean = -1, sd = 0.6) * 3.5
y_right <- dnorm(x, mean =  1, sd = 0.6) * 3.5

# Data frames separados para cada curva
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Altura máxima para posicionamento do texto
y_max <- max(c(y_left, y_right))
x_center <- mean(range(x))

y_text_marlenildo <- -0.6
y_text_solucoes  <- -1.2

# Plot com áreas preenchidas e texto embaixo usando fonte Montserrat
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85", alpha=0.5) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green", alpha=0.5) +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 15, fontface = "bold", hjust = 0.5,
           family = "montserrat") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "green", size = 10, fontface = "bold", hjust = 0.5,
           family = "montserrat") +
  coord_equal(ylim = c(y_text_solucoes - 0.5, y_max + 0.5)) +
  theme_void() +
  theme(
    panel.background = element_rect(fill = NA, color = NA),
    plot.background  = element_rect(fill = NA, color = NA)
  )

print(p)


ggsave("logo_curvas_embaixo_texto.png", plot = p, width = 6, height = 6, dpi = 300, bg = "transparent")

# Supondo que o gráfico esteja salvo no objeto p
# Ajuste largura e altura conforme desejar

ggsave(
  filename = "logo_marlenildo.png",  # nome do arquivo
  plot = p,                          # objeto ggplot
  width = 10,                        # largura em polegadas
  height = 6,                        # altura em polegadas
  dpi = 300,                         # resolução
  bg = "transparent"                 # fundo transparente (como no RStudio)
)


#18 TRANSPARENTE NOME EMBAIXO----
library(ggplot2)
library(dplyr)
library(showtext)

# Ativar showtext
font_add_google("Audiowide", "audiowide")
showtext_auto()

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas
y_left  <- dnorm(x, mean = -1, sd = 0.6) * 3.5
y_right <- dnorm(x, mean =  1, sd = 0.6) * 2.8
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Coordenadas do texto
x_center <- mean(range(x))
y_text_marlenildo <- -0.6
y_text_solucoes  <- -1.2

# Aumentando o size proporcionalmente
size_marlenildo <- 20   # antes era 8.5
size_solucoes  <- 25    # antes era 10

p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85", alpha=0.5) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green", alpha=0.5) +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 15, fontface = "bold",
           hjust = 0.5, family = "asimovian") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "green", size = 10, fontface = "bold",
           hjust = 0.5, family = "asimovian") +
  coord_equal(ylim = c(y_text_solucoes - 0.5, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA))
p

p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85", alpha=0.5) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "green", alpha=0.5) +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 15, fontface = "bold",
           hjust = 0.5, family = "asimovian") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "green", size = 10, fontface = "bold",
           hjust = 0.5, family = "asimovian") +
  coord_equal(ylim = c(y_text_solucoes - 0.5, max(y_left, y_right) + 0.5)) +
  theme_void() 
p
# Salvar PNG
ggsave("logo_marlenildo.png", plot = p, width = 12, height = 7, dpi = 300, bg = "transparent", scale=0.16)


p2 <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "white", alpha=0.5) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "white", alpha=0.5) +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "white", size = 15, fontface = "bold",
           hjust = 0.5, family = "asimovian") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "white", size = 10, fontface = "bold",
           hjust = 0.5, family = "asimovian") +
  coord_equal(ylim = c(y_text_solucoes - 0.5, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA))
p2
# Salvar PNG
ggsave("logo_marlenildo2.png", plot = p2, width = 12, height = 7, dpi = 300, bg = "transparent", scale=0.16)




p3 <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "green", alpha=0.5) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#1f4e85", alpha=0.5) +
  coord_equal(ylim = c(y_text_solucoes - 0.5, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA))
p3
# Salvar PNG
ggsave("logo_marlenildo3.png", plot = p3, width = 12, height = 7, dpi = 300, bg = "transparent")

# Salvar favicon 32x32 px
ggsave("favicon.png", plot = p3, width = 1, height = 1, units = "in", dpi = 64, bg = "transparent")



## LOO USADA 09092025----
library(ggplot2)
library(dplyr)
library(showtext)

# Ativar showtext
font_add_google("Audiowide", "audiowide")
showtext_auto()

# Sequência de x
x <- seq(-2.8,2.8, length.out = 500)

# Curvas mais próximas
y_left  <- dnorm(x, mean = -0.8, sd = 0.6) * 3.5
y_right <- dnorm(x, mean =  0.8, sd = 0.6) * 3.5
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Coordenadas do texto
x_center <- mean(range(x))
y_text_marlenildo <- -0.4
y_text_solucoes  <- -1

#'Colorida

#btanco trabnsparente
p_cor <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#6dd47e") +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 23, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "#6dd47e", size = 17, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  coord_equal(ylim = c(y_text_solucoes - 1.2, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA))

p_cor
ggsave("logo_baixo_branco_transp.png", plot = p_cor, width = 12, height = 7, dpi = 300, bg = "transparent", scale=0.16)





# Cor transparaente
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "white", alpha = 0.6) +
  geom_area(data = df_right, aes(x = x, y = y), fill = "white", alpha = 0.6)+
  theme_void() 
p
# Salvar PNG
ggsave("logo_branco_cor_transp_semnome.png", plot = p, width = 12, height = 5, dpi = 300, bg = "transparent")

# Salvar favicon 64x64 px
# Salvar como PNG 64x64 px com fundo transparente
ggsave("favicon.png", plot = p,
       width = 64, height = 64, units = "px",
       dpi = 72, bg = "transparent")

# Agora converte PNG → ICO
library(magick)

img <- image_read("favicon.png")
image_write(img, path = "favicon.ico", format = "ico")


#cinza trabnsparente
p2 <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#9b9b9b") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#9b9b9b") +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#9b9b9b", size = 23, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "#9b9b9b", size = 17, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  coord_equal(ylim = c(y_text_solucoes - 1.2, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA))

p2
ggsave("logo_baixo_cinza_transp.png", plot = p2, width = 12, height = 7, dpi = 300, bg = "transparent", scale=0.16)



##

library(ggplot2)
library(dplyr)
library(showtext)

# Ativar showtext
font_add_google("Audiowide", "audiowide")
showtext_auto()

# Sequência de x
x <- seq(-3.8,3.8, length.out = 500)

# Curvas mais próximas
y_left  <- dnorm(x, mean = -0.8, sd = 0.6) * 3.5
y_right <- dnorm(x, mean =  0.8, sd = 0.6) * 3.5
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Coordenadas do texto
x_center <- 0
y_text_marlenildo <- -0.3
y_text_solucoes  <- -1.2

# Ajuste da largura: limites x para igualar curva com texto
largura_texto <- 5   # ajuste até ficar igual visualmente
x_min <- -largura_texto/2
x_max <-  largura_texto/2

p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#6dd47e") +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 23, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "#6dd47E", size = 17, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  coord_cartesian(xlim = c(x_min, x_max),
                  ylim = c(y_text_solucoes, max(y_left, y_right))) +
  theme_void()


p


#Animação 1----
library(ggplot2)
library(showtext)
library(gganimate)
library(dplyr)

# Ativar showtext
font_add_google("Audiowide", "audiowide")
showtext_auto()

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas mais próximas
y_left  <- dnorm(x, mean = -0.8, sd = 0.6) * 3.5
y_right <- dnorm(x, mean =  0.8, sd = 0.6) * 3.5
df_left  <- data.frame(x = x, y = y_left)
df_right <- data.frame(x = x, y = y_right)

# Coordenadas do texto
x_center <- mean(range(x))
y_text_marlenildo <- -0.6
y_text_solucoes  <- -1.2

# Gráfico animado com curvas crescendo
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85", alpha=0.5, stat = "identity") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#6dd47e", alpha=0.5, stat = "identity") +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 15, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "#6dd47e", size = 10, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  coord_equal(ylim = c(y_text_solucoes - 0.5, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA)) +
  transition_reveal(x)  # animação da curva crescendo

# Renderizar animação
animate(p, nframes = 100, fps = 20, width = 800, height = 600,
        renderer = gifski_renderer("logo_animado.gif"))

# Animação 2----
library(ggplot2)
library(showtext)
library(gganimate)
library(dplyr)

# Ativar showtext
font_add_google("Audiowide", "audiowide")
showtext_auto()

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas finais
y_left  <- dnorm(x, mean = -0.8, sd = 0.6) * 3.5
y_right <- dnorm(x, mean =  0.8, sd = 0.6) * 3.5

# Criar frames para animação
nframes <- 100
df_left <- data.frame(
  x = rep(x, nframes),
  frame = rep(1:nframes, each = length(x)),
  y_final = rep(y_left, nframes)
)
df_left <- df_left %>%
  mutate(y = y_final * (frame / nframes))  # vai crescendo de 0 até y_final

df_right <- data.frame(
  x = rep(x, nframes),
  frame = rep(1:nframes, each = length(x)),
  y_final = rep(y_right, nframes)
)
df_right <- df_right %>%
  mutate(y = y_final * (frame / nframes))  # vai crescendo de 0 até y_final

# Coordenadas do texto
x_center <- mean(range(x))
y_text_marlenildo <- -0.6
y_text_solucoes  <- -1.2

# Gráfico animado
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85", alpha=0.5, stat="identity") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#6dd47e", alpha=0.5, stat="identity") +
  annotate("text", x = x_center, y = y_text_marlenildo, label = "MARLENILDO",
           color = "#1f4e85", size = 15, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  annotate("text", x = x_center, y = y_text_solucoes, label = "Soluções em Curso",
           color = "#6dd47e", size = 10, fontface = "bold",
           hjust = 0.5, family = "audiowide") +
  coord_equal(ylim = c(y_text_solucoes - 0.5, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA)) +
  transition_time(frame)  # animação seguindo os frames

# Renderizar animação
animate(p, nframes = nframes, fps = 20, width = 800, height = 600,
        renderer = gifski_renderer("logo_animado_duas_curvas.gif"))

#Animação 3----

library(ggplot2)
library(showtext)
library(gganimate)
library(dplyr)
library(tidyr)
library(stringr)

# Ativar showtext
font_add_google("Audiowide", "audiowide")
showtext_auto()

# Sequência de x
x <- seq(-3, 3, length.out = 500)

# Curvas finais
y_left  <- dnorm(x, mean = -0.8, sd = 0.6) * 3.5
y_right <- dnorm(x, mean =  0.8, sd = 0.6) * 3.5

# Frames de animação
nframes <- 100

# Curvas animadas
df_left <- data.frame(
  x = rep(x, nframes),
  frame = rep(1:nframes, each = length(x)),
  y_final = rep(y_left, nframes)
) %>%
  mutate(y = y_final * (frame / nframes))

df_right <- data.frame(
  x = rep(x, nframes),
  frame = rep(1:nframes, each = length(x)),
  y_final = rep(y_right, nframes)
) %>%
  mutate(y = y_final * (frame / nframes))

# Função para animar letras sequenciais caindo próximo da posição final
animate_text_seq <- function(text, y_final, x_center, nframes, spacing = 0.6, delay = 5) {
  letters <- str_split(text, "")[[1]]
  n_letters <- length(letters)
  x_pos <- seq(x_center - spacing*(n_letters-1)/2, x_center + spacing*(n_letters-1)/2, length.out = n_letters)
  
  df <- expand.grid(letter = letters,
                    x = x_pos,
                    frame = 1:nframes) %>%
    group_by(letter, x) %>%
    mutate(
      # Cada letra inicia a animação com delay proporcional à sua posição
      start_frame = (seq_len(n()) %% n_letters) * delay,
      frame_adj = pmax(frame - start_frame, 0),
      y = y_final + 0.5 * exp(-0.05 * frame_adj)  # começa levemente acima e cai suavemente
    ) %>%
    ungroup()
  
  return(df)
}

# Letras animadas dos textos
df_text1 <- animate_text_seq("MARLENILDO", y_final = -0.6, x_center = 0, nframes = nframes, spacing = 0.6, delay = 5)
df_text2 <- animate_text_seq("Soluções em Curso", y_final = -1.2, x_center = 0, nframes = nframes, spacing = 0.5, delay = 5)

# Gráfico animado
p <- ggplot() +
  geom_area(data = df_left, aes(x = x, y = y), fill = "#1f4e85", alpha=0.5, stat="identity") +
  geom_area(data = df_right, aes(x = x, y = y), fill = "#6dd47e", alpha=0.5, stat="identity") +
  geom_text(data = df_text1, aes(x = x, y = y, label = letter), color = "#1f4e85",
            size = 15, fontface = "bold", family = "Audiowide") +
  geom_text(data = df_text2, aes(x = x, y = y, label = letter), color = "#6dd47e",
            size = 10, fontface = "bold", family = "Audiowide") +
  coord_equal(ylim = c(-2.5, max(y_left, y_right) + 0.5)) +
  theme_void() +
  theme(panel.background = element_rect(fill = NA, color = NA),
        plot.background  = element_rect(fill = NA, color = NA)) +
  transition_time(frame)

# Renderizar animação
animate(p, nframes = nframes, fps = 20, width = 800, height = 600,
        renderer = gifski_renderer("logo_animado_letras_sequenciais.gif"))
