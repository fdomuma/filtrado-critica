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


# Scraping por medio
library(rvest)

## Elpais

for (i in 1:length(enlaces)) {
  ## ARTICULO
  html<-read_html(enlaces[i])
  nodes<-html_nodes(html, "div#cuerpo_noticia.articulo-cuerpo p")
  text<-html_text(nodes)
  text<-str_replace_all(text, "[\r\n]" , "")
  text<-paste(text, collapse = "")
  noticias.df[i,1]<-text
  
  ## AUTOR
  nodes<-html_nodes(html, "span.autor-nombre")
  text<-html_text(nodes)
  text<-str_replace_all(text, "[\r\n]" , "")
  text<-paste(text, sep=";", collapse=";")
  noticias.df[i,2]<-text
  
  ## FECHA
  nodes<-html_nodes(html, ".articulo-actualizado a")
  if (length(nodes) == 0){
    next()
  } else {
    text<-html_text(nodes)
    text<-str_replace_all(text, "[\r\n]" , "")
    text<- substr(text, 1,10)
    # Me he encontrado un error con la p?ginas que se actualizan, hay fechas
    # repetidas, luego le inserto la primera y listo.
    noticias.df[i,3]<-text[1]
    
    ## TITULAR
    nodes<-html_nodes(html, "h1#articulo-titulo.articulo-titulo")
    if (length(nodes) == 0){
      sin.titulo.v[i]<-i
      next()
    } else{
      text<-html_text(nodes)
      noticias.df[i,4]<-text
    }
  }
}