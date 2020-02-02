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



# Añado cuatro fragmentos de lápiz para completar un poco el corpus y extraigo los artículos

enlaces <- c("http://www.revistalapiz.com/serialidad/", 
             "http://www.revistalapiz.com/arte-y-accion/",
             "http://www.revistalapiz.com/arte-e-hipervisualidad/",
             "http://www.revistalapiz.com/los-inicios-del-videoarte/")

autores <- c("Jaime Gili", "Manuel Cirauqui", "Adolfo Montejo Navas", "Mercedes Vicente")

# He hecho un código ad hoc, pero funciona así que no me voy a preocupar en exceso. 
# De reutilizar el código habría que arreglarlo.

for (i in 36:39){
  html <- read_html(enlaces[i-35])
  
  nodes <- html_nodes(html, "div.entry-content>p")
  articulo <- html_text(nodes[1:(length(nodes)-5)])
  critica.revista[i,1] <- paste(articulo, collapse = " ")
  
  critica.revista[i,2] <- autores[i-35]
  
  critica.revista[i,3] <- " "
  
  nodes <- html_nodes(html, "h1.entry-title")
  critica.revista[i,4] <- html_text(nodes)
  
  critica.revista[i,5] <- "lapiz"
  
  critica.revista[i,6] <- "critica de arte"
  
  Sys.sleep(1.5)
}

# Eliminamos saltos de línea
critica.revista$articulo <- gsub("[\r\n]", "", critica.revista$articulo)

# Limpiamos el entorno
rm(list = setdiff(ls(), "critica.revista"))
