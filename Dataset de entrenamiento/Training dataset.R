library(dplyr)

table(critica.elpais$medio)
entrenamiento <- sample_n(group_by(critica.elpais, medio), 20)

table(critica.revista$medio)
entrenamiento <- bind_rows(entrenamiento, sample_n(critica.revista, 20))

table(literatura$medio)
entrenamiento <- bind_rows(entrenamiento, sample_n(group_by(literatura, medio), 10))
entrenamiento <- bind_rows(entrenamiento, sample_n(literatura, 10)) # Sólo sale en tres medios, añadimos 10 aleatorios
                                                                    # que podrían reponerse

table(musica$medio)
entrenamiento <- bind_rows(entrenamiento, sample_n(musica, 40))

table(politica$medio)
entrenamiento <- bind_rows(entrenamiento, sample_n(politica, 40))

table(television$medio)
entrenamiento <- bind_rows(entrenamiento, sample_n(group_by(television, medio), 10))
entrenamiento <- bind_rows(entrenamiento, sample_n(television, 10)) # Sólo sale en tres medios, añadimos 10 aleatorios
                                                                    # que podrían reponerse

table(toreo$medio)
entrenamiento <- bind_rows(entrenamiento, sample_n(toreo, 40))

write.csv(entrenamiento, "entrenamiento")
