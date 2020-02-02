








# Por la nueva distribución que he planteado, este script se va a quedar como tanteo previo y 
# no como parte definitiva del proyecto.  














# En los url se indica la pertenencia a la sección televisión, la sobrerrepresentación de LL en el corpus me ha hecho
# coger tan solo 80 aleatorios de entre esos. 


# Preparo algunos de television/cine

# Me tengo que asegurar de que este es un buen mÃ©todo para extraer televisión como tema. Cine se puede estar mezclando
# aunque también podría dejarlo así de momento porque de todas formas se diferencia bastante bien de crítica de arte.
# Que es exactamente lo que voy a hacer para una primera prueba, los temas no tienen porqué estar separados extremadamente
# separados.

television <- Reduce(union, list(grep("television", noticias.df$url),
                                 sample(grep("cinetv", noticias.df$url), 80),
                                 grep("netflix", noticias.df$url),
                                 grep("peliculas", noticias.df$url)))

television <- noticias.df[television, c("articulo", "autor", "fecha", "titular", "medio", "medio")]
television$medio <- "television"

# Preparo algunos de toreo

toros <- Reduce(union, list(grep("television", noticias.df$url),
                            sample(grep("cinetv", noticias.df$url), 80),
                            grep("netflix", noticias.df$url),
                            grep("peliculas", noticias.df$url)))


# Preparo algunos de literatura

libros <- Reduce(union, list(grep("television", noticias.df$url),
                             sample(grep("cinetv", noticias.df$url), 80),
                             grep("netflix", noticias.df$url),
                             grep("peliculas", noticias.df$url)))

# Preparo algunos de política 

politica <- Reduce(union, list(grep("television", noticias.df$url),
                               sample(grep("cinetv", noticias.df$url), 80),
                               grep("netflix", noticias.df$url),
                               grep("peliculas", noticias.df$url)))

# Preparo algunos de musica

musica <- Reduce(union, list(grep("television", noticias.df$url),
                             sample(grep("cinetv", noticias.df$url), 80),
                             grep("netflix", noticias.df$url),
                             grep("peliculas", noticias.df$url)))


# Compruebo los pesos


# Junto todos los temas

critica.df <- cbind(critica.df, "elpais")

colnames(critica.df)[5] <- "medio"
colnames(critica.df)[1] <- "articulo"

corpus <- rbind(critica.df, television, toros, libros, musica, politica)
corpus$medio <- gsub("elpais", "critica de arte", corpus$medio)


write.csv(corpus, "noticias.csv")
