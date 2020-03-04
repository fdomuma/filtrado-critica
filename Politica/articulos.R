# Partimos del archivo de noticias del TFM. Filtrando por palabras extraigo los que contengan ciertos terminos en las
# url, lo que implica que televisión/cine van a estar mezclado, pero entiendo que no es relevante para distinguir 
# los artículo de crítica de arte.

library(dplyr)

# En los url se indica la pertenencia a la sección televisión, la sobrerrepresentación de LL en el corpus me ha hecho
# coger tan solo 30 aleatorios de entre esos. 


politica <- Reduce(union, list(grep("politico", noticias.df$url),
                               grep("politicas", noticias.df$url),
                               grep("presidente", noticias.df$url),
                               grep("parlamento", noticias.df$url),
                               grep("congreso", noticias.df$url),
                               grep("gobierno", noticias.df$url)))

politica <- noticias.df[politica, c("articulo", "autor", "fecha", "titular", "medio", "medio")]
politica[6] <- "politica"
colnames(politica)[6] <- "tema"


# ¿Cómo ha quedado la representación por medio? 
table(politica$medio)


rm(list=setdiff(ls(), "politica"))

# Por algún motivo no se elimina pequeños.v, importar estos artículos de manera única, sin todo el entorno.