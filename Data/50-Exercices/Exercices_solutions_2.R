#Solucionario
rm(list=ls())
# Cree una carpeta nueva y defina su directorio de trabajo con la función ` setwd() `
    # El directorio será diferente para cada computador
# setwd("~/Google Drive/R - Statistics Manual/R-Curso_Basico-2016/Ejercicios")
  # En lugar de esto, trabajar con proyectos


#Instale y cargue el Package "tideverse".
if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('car')) install.packages('car'); library('car')
if (!require('stats')) install.packages('stats'); library('stats')


# Importe los datos del archivo ` Exercices.csv ` a una variable de nombre ` datos_raw ` y visualicelo en la Consola.
library(readr)
datos_raw = read_csv("Exercices_2.csv")
datos_raw

#Recodifique los valores 0 y 1 de la variable `Sexo` por 'femenino' y 'masculino' respectivamente. Además, asegurese que estas variables sean de tipo factor. Haga lo mismo para la variable `Cond` tal que 0 y 1 sean 'control' y 'experimental' respectivamente.
datos = datos_raw %>% mutate(Sexo = ifelse(Sexo == 1, "femenino", "masculino")) %>% mutate(Sexo = as.factor(Sexo))
datos = datos %>% mutate(Cond = ifelse(Cond == 0, "control", "experimental")) %>% mutate(Cond = as.factor(Cond))

#Elimine los items de la escala Psy y quedese solo con su puntaje total.
datos = datos %>% select(Id,Sexo,Cond,Edad,RT,PsyScore)

#Elimine las observaciones en donde las variables tengan `NA`.

datos = datos %>% na.omit(datos)

#Cree un modelo factorial de ANOVA de 2 vias para ver como `Sexo` y `Cond` predicen la tarea de `RT`. Agrege un analisis de comparaciones multiples para todos los predictores.

#Ajustamos el modelo con la funcion de ANOVA aov()
fit = aov(RT ~ Sexo*Cond, datos)

#Summario de Parámetros y Coeficientes
summary(fit)

#Comparaciones Multiples mediante función TukeyHSD() {stats}
TukeyHSD(fit)

#Opcional: Ingrese la misma fórmula que ingreso a ANOVA en un modelo de Regresión. Compare los resultados.
#Insertamos nuestra fórmula al Modelo de Regresión Simple
fit = lm(RT ~ Sexo+Cond + Sexo*Cond, datos)

#Resumen de Coeficientes y Parametros del modelo
summary(fit)

#Explore la posible relación en ausencia de predictor claro entre `RT` y `PsyScore`. Visualise los datos con el `pirateplot` que estime pertinente.
cor.test(~ RT + PsyScore, data = datos)

if (!require('ggpubr')) install.packages('ggpubr'); library('ggpubr')

ggscatter(datos, x = "PsyScore", y = "Edad",
          color = "black", shape = 21, size = 4, # Points color, shape and size
          add = "reg.line",  # Add regressin line
          add.params = list(color = "blue", fill = "lightgray"), # Customize reg. line
)

#Examine si existen diferencias de `Sexo` para la variable `PsyScore`. Visualise los datos con el `pirateplot` que estime pertinente.

#levene test {car} para homogeneidad de las varianzas
leveneTest(datos$PsyScore ~ datos$Sexo)

#Ingresamos nuestro modelo en la función t.test()
t.test(PsyScore ~ Sexo, datos,  var.equal = T, paired = F)

# Cargamos librerias
if (!require('yarrr')) c(library(devtools), devtools::install_github("ndphillips/yarrr"));  library('yarrr')

# Mostramos gráfico con opciones por defecto
pirateplot(PsyScore ~ Sexo, datos)
