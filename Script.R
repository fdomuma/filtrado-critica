# En los url se indica la pertenencia a la sección televisión, la sobrerrepresentación de LL en el corpus me ha hecho
# coger tan solo 80 aleatorios de entre esos. 


# Me tengo que asegurar de que este es un buen método para extraer televisión como tema. Cine se puede estar mezclando
# aunque también podría dejarlo así de momento porque de todas formas se diferencia bastante bien de crítica de arte.
# Que es exactamente lo que voy a hacer para una primera prueba, los temas no tienen porqué estar separados extremadamente
# separados.

television <- Reduce(union, list(grep("television", noticias.df$url),
                       sample(grep("cinetv", noticias.df$url), 80),
                       grep("netflix", noticias.df$url),
                       grep("peliculas", noticias.df$url)))

critica.df <- cbind(critica.df, "elpais")

colnames(critica.df)[5] <- "medio"

critica.df <- rbind(noticias.df[television, c("articulo", "autor", "fecha", "titular", "medio")])

write.csv(critica.df, "noticias.csv")
