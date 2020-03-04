# Partimos del archivo de noticias del TFM. Filtrando por palabras extraigo los que contengan ciertos terminos en las
# url, lo que implica que televisión/cine van a estar mezclado, pero entiendo que no es relevante para distinguir 
# los artículo de crítica de arte.

library(dplyr)

# En los url se indica la pertenencia a la sección televisión, la sobrerrepresentación de LL en el corpus me ha hecho
# coger tan solo 30 aleatorios de entre esos. 


toreo <- Reduce(union, list(grep("toro", noticias.df$url),
                            grep("toreo", noticias.df$url),
                            grep("fermines", noticias.df$url),
                            grep("chupinazo", noticias.df$url)))

toreo <- noticias.df[toreo, c("articulo", "autor", "fecha", "titular", "medio", "medio")]
toreo[6] <- "toreo"
colnames(toreo)[6] <- "tema"


# ¿Cómo ha quedado la representación por medio? 
table(toreo$medio)


rm(list=setdiff(ls(), "toreo"))

# Por algún motivo no se elimina pequeños.v, importar estos artículos de manera única, sin todo el entorno.