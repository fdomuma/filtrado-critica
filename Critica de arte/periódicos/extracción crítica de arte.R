# Este documento sirve para crear un pequeño corpus de artículos de crítica de arte y comprobar que los métodos 
# aplicados al lado sirven para filtrarlos.

library(stringr)

# Leo los marcadores y elimino los tres primeros porque no se corresponden a enlaces de noticias
critica <- readLines("bookmarks_22_1_20.html")
critica <- critica[4:length(critica)]


# Cojo la posición de comienzo del enlace que siempre es 26, después calculo la de final que es tres menos que el comienzo
# de ADD
str_locate(critica, "http")
posicion.add <- str_locate(critica, "ADD")
posicion.add <- posicion.add[,1] 
posicion.add <- posicion.add -3

# Extraigo los enlaces

enlaces <- substr(critica, 26, posicion.add)
print(enlaces)


# Scraping
library(rvest)

critica.df <- data.frame()

for (i in 1:length(enlaces)) {
  ## ARTICULO
  html<-read_html(enlaces[i])
  nodes<-html_nodes(html, "div#cuerpo_noticia.articulo-cuerpo p")
  text<-html_text(nodes)
  text<-str_replace_all(text, "[\r\n]" , "")
  text<-paste(text, collapse = "")
  critica.df[i,1]<-text
  
  ## AUTOR
  nodes<-html_nodes(html, "span.autor-nombre")
  text<-html_text(nodes)
  text<-str_replace_all(text, "[\r\n]" , "")
  text<-paste(text, sep=";", collapse=";")
  critica.df[i,2]<-text
  
  ## FECHA
  nodes<-html_nodes(html, ".articulo-actualizado a")
  if (length(nodes) == 0){
    next()
  } else {
    text<-html_text(nodes)
    text<-str_replace_all(text, "[\r\n]" , "")
    text<- substr(text, 1,10)
    # Me he encontrado un error con la páginas que se actualizan, hay fechas
    # repetidas, luego le inserto la primera y listo.
    critica.df[i,3]<-text[1]
    
    ## TITULAR
    nodes<-html_nodes(html, "h1#articulo-titulo.articulo-titulo")
    if (length(nodes) == 0){
      sin.titulo.v[i]<-i
      next()
    } else{
      text<-html_text(nodes)
      critica.df[i,4]<-text
    }
  }
}

# Nombres de columnas
critica.df[5] <- "elpais"
critica.df[6] <- "critica de arte"
colnames(critica.df)<-c("articulo", "autor", "fecha", "titular", "medio", "tema")

## Eliminar registros que no se corresponden a noticias
registros.vacios.v<-which(critica.df$artículo == "")
critica.df<-critica.df[-registros.vacios.v,]

## Dejar todo en min?sculas
critica.df$artículo<-tolower(critica.df$artículo)
critica.df$autor<-tolower(critica.df$autor)
critica.df$fecha<-tolower(critica.df$fecha)
critica.df$titular<-tolower(critica.df$titular)

## Le cambio el nombre para facilitar la unión posterior y elimino todo lo que no sean los artículos

critica.elpais <- critica.df

rm(list=setdiff(ls(), "critica.elpais"))
