#Solucionario

# Cree una carpeta nueva y defina su directorio de trabajo con la función ` setwd() `
    # El directorio será diferente para cada computador
    # TRABAJAR con Proyectos
# setwd("~/Google Drive/R - Statistics Manual/R-Curso_Basico-2016/Ejercicios")


#Instale y cargue el Package "tideverse".
if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')


# Importe los datos del archivo ` Exercices_1 ` a una variable de nombre ` datos_raw ` y visualicelo en la Consola.
library(readr)
datos_raw = read_csv("Exercices_1.csv")
datos_raw


#Esta base de datos comprende una serie de 60 items. Sin embargo, no todos los items nos son útiles. Aquellos que utilizaremos contendrán una letra "r" en su nombre. Cree una nueva dase de datos que contenga solo los ítems útiles, manteniendo las variables demográficas (id, sexo y edad).
datos = datos_raw %>% select(id, edad, sexo, matches("ir"))


#La memoria es frágil! Recodifique los valores 0 y 1 de la variable "sexo" por "femenino" y "masculino" respectivamente. Además, asegurese que estas variables sean de tipo factor.
datos = datos %>% mutate(sexo = ifelse(sexo == 0, "femenino", "masculino")) %>% mutate(sexo = as.factor(sexo))


#Omita los valores no disponibles "NA" de la base de datos.
datos = datos %>% na.omit(datos)


#Imagine que sujetos de más de 30 años no están contemplados en la definición de nuestra muestra. Creemos una variable lógica que permita identificarlos.
datos = datos %>% mutate(Edad_Logica = edad > 30)


#Ahora eliminemos de nuestra muestra a estos sujetos y borremos la variable que los identificaba.
datos = datos %>% filter(Edad_Logica == F)
datos = datos %>% select(-Edad_Logica)


#En honor al tiempo, asumiremos que los ítems ir3, ir9, ir16, ir23, ir29, ir40, ir31 contituyen una "dimensión" de esta escala. Creemos una nueva variable "puntaje_total" que sea la suma de estos items y agréguelo a la base de datos existente.
datos = datos %>% mutate(puntaje_total = ir3 + ir9 + ir16 + ir23 + ir29 + ir40 + ir31)


#Haga un breve sumario de los promedios de la variable "puntaje_total" según "sexo"
datos %>% group_by(sexo)  %>% summarise(puntaje_total = mean(puntaje_total))


#Visualice estas variables utilizando "Pirate plot".
if (!require('yarrr')) install.packages('yarrr');  library('yarrr')
pirateplot(formula = puntaje_total ~ sexo, datos)