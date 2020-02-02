library(rvest)
library(dplyr)
library(stringr)

# Creo una url base a la que les añado los números de las páginas
base <- "https://www.artecontexto.com"
url <- "https://www.artecontexto.com/es/blog.html?p=0"

# Hay cuatro artículos por página y necesito 26, luego 7 páginas son suficientes. Extraigo los enlaces a noticias 
# dentro de cada página.

href<-list()
for (i in 1:7){
  href[[i]] <- paste0(url, i) %>%
    read_html() %>%
    html_nodes("div.titulo-post a") %>%
    html_attr("href")
  if(length(href[[i]])==0){
    break()
  } else {
    next()
  }
}

# Vale, pues parece ser que cada una tenía 5, fallo mío, tengo más donde elegir.

# Creamos los enlaces utilizando la url base y lo que se ha extraído.

enlaces <- lapply(href, function(href){
  paste0(base, href)
})
enlaces<-unlist(enlaces)
href<-unlist(href)

# Creamos un dataframe vacío que ir llenando en el loop de scrapeo
BDD <- matrix(nrow = 1, ncol = 6) %>%
  as.data.frame()
colnames(BDD) <- c("articulo", "autor", "fecha", "titular",
                   "medio", "tema")
for (i in 1:length(enlaces)){
  html <- read_html(enlaces[i])
  
  nodes <- html_nodes(html, "div.izquierda-11-blog>p")
  articulo <- html_text(nodes)
  BDD[i,1] <- paste(articulo, collapse = " ")
  
  nodes <- html_nodes(html, "div.autor_post2 strong")
  BDD[i,2] <- html_text(nodes)
  
  nodes <- html_nodes(html, "span.texto-p")
  BDD[i,3] <- html_text(nodes[1])  
  
  nodes <- html_nodes(html, "h1.titulo-post")
  BDD[i,4] <- html_text(nodes)
  
  BDD[i,5] <- "artecontexto"
  
  BDD[i,6] <- "critica de arte"
  
  Sys.sleep(1.5)
  
  print(paste(i, "de", length(enlaces), collapse = " "))
}


# Eliminamos saltos de línea
BDD$articulo <- gsub("[\r\n]", "", BDD$articulo)

# Cambiamos el nombre y limpiamos el entorno

critica.revista <- BDD

rm(list = setdiff(ls(), "critica.revista"))
