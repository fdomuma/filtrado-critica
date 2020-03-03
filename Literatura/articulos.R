# Partimos del archivo de noticias del TFM. Filtrando por palabras extraigo los que contengan ciertos terminos en las
# url, lo que implica que televisión/cine van a estar mezclado, pero entiendo que no es relevante para distinguir 
# los artículo de crítica de arte.

library(dplyr)

# En los url se indica la pertenencia a la sección televisión, la sobrerrepresentación de LL en el corpus me ha hecho
# coger tan solo 30 aleatorios de entre esos. 


libro <- noticias.df[grep("libro", noticias.df$url),]
libro <- data.frame(libro, rownames(libro), stringsAsFactors = FALSE)
ocurrencia <- sample_n(group_by(libro, medio), 30) #Esto da 30 de cada medio

literatura <- Reduce(union, list(as.integer(ocurrencia$rownames.libro.),
                                 grep("autor", noticias.df$url),
                                 grep("novela", noticias.df$url),
                                 grep("escritor", noticias.df$url)))

literatura <- noticias.df[literatura, c("articulo", "autor", "fecha", "titular", "medio", "medio")]
literatura[6] <- "literatura"
colnames(literatura)[6] <- "tema"


# ¿Cómo ha quedado la representación por medio? 
table(literatura$medio)


rm(list=setdiff(ls(), "literatura"))

# Por algún motivo no se elimina pequeños.v, importar estos artículos de manera única, sin todo el entorno.