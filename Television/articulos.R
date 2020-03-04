# Partimos del archivo de noticias del TFM. Filtrando por palabras extraigo los que contengan ciertos terminos en las
# url, lo que implica que televisión/cine van a estar mezclado, pero entiendo que no es relevante para distinguir 
# los artículo de crítica de arte.


# En los url se indica la pertenencia a la sección televisión, la sobrerrepresentación de LL en el corpus me ha hecho
# coger tan solo 30 aleatorios de entre esos. 


television <- Reduce(union, list(grep("television", noticias.df$url),
                                 sample(grep("cinetv", noticias.df$url), 30),
                                 grep("netflix", noticias.df$url),
                                 grep("peliculas", noticias.df$url)))

television <- noticias.df[television, c("articulo", "autor", "fecha", "titular", "medio", "medio")]
television[6] <- "television"
colnames(television)[6] <- "tema"


# ¿Cómo ha quedado la representación por medio? 
table(television$medio)


rm(list=setdiff(ls(), "television"))

# Por algún motivo no se elimina pequeños.v, importar estos artículos de manera única, sin todo el entorno.
