# Partimos del archivo de noticias del TFM. Filtrando por palabras extraigo los que contengan ciertos terminos en las
# url, lo que implica que televisión/cine van a estar mezclado, pero entiendo que no es relevante para distinguir 
# los artículo de crítica de arte.

library(dplyr)

# En los url se indica la pertenencia a la sección televisión, la sobrerrepresentación de LL en el corpus me ha hecho
# coger tan solo 30 aleatorios de entre esos. 


musica <- Reduce(union, list(grep("festival", noticias.df$url),
                             grep("disco", noticias.df$url),
                             grep("cantante", noticias.df$url),
                             grep("starlite", noticias.df$url)))

musica <- noticias.df[musica, c("articulo", "autor", "fecha", "titular", "medio", "medio")]
musica[6] <- "musica"
colnames(musica)[6] <- "tema"


# ¿Cómo ha quedado la representación por medio? 
table(musica$medio)


rm(list=setdiff(ls(), "musica"))

# Por algún motivo no se elimina pequeños.v, importar estos artículos de manera única, sin todo el entorno.