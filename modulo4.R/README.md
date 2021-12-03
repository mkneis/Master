<!-- #region nbgrader={"grade": false, "grade_id": "cell-bd0b11511d1e9d9c", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
# Relación de ejercicios 2

En estos ejercicios practicaremos la elaboración de funciones para reutilizar nuestro código, y el uso de las funciones de la familia *apply* (sapply, lapply, apply). 

### Las funciones NUNCA deben hacer print() ni mostrar nada por pantalla, sino devolver el resultado del cálculo utilizando return.
<!-- #endregion -->

<!-- #region nbgrader={"grade": false, "grade_id": "cell-6931830012e6c23e", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
**INSTRUCCIONES**: en cada trozo de código debes responder a la pregunta formulada, asegurándote de que el resultado queda guardado en la(s) variable(s) que por defecto vienen inicializadas a `NULL`. No se necesita usar variables intermedias, pero puedes hacerlo siempre que el resultado final del cálculo quede guardado exactamente en la variable que venía inicializada a NULL (debes reemplazar NULL por el código R necesario, pero nunca cambiar el nombre de esa variable). **El código de tu solución puede ocupar tantas líneas como necesites, pero deben estar situadas entre la línea "NO MODIFICAR ESTA LÍNEA ..." y la línea "FIN SOLUCION". Ninguna de esas dos líneas debe ser modificada bajo ningún concepto.** En caso contrario tu solución no será puntuada.

Después de cada ejercicio verás varias líneas de código ya hechas. Ejecútalas todas (no modifiques su código) y te dirán si tu solución es correcta o no. Si la solución es correcta, no se mostrará nada, pero si es incorrecta, verás un error indicando cuál es el test que tu solución no pasa. Además de esas pruebas, se realizarán algunas más (ocultas) a la hora de puntuar el ejercicio, pero si tu código pasa con éxito las líneas que ves, puedes estar bastante seguro de que tu solución es correcta. Asegúrate de que, al menos, todas las comprobaciones indican que tu solución es correcta antes de subir el ejercicio a la plataforma.

Una vez finalizada la actividad, guarda tu fichero en RStudio, después ciérralo, vuélvelo a abrir y ejecútalo completo, y asegúrate de que no se lanza ningún error. De esta manera comprobarás que no has olvidado nada y que es posible ejecutarlo completo desde 0 y sin errores. **No se corregirá ningún fichero que tenga errores de sintaxis y no se pueda ejecutar completo**. No pasa nada si alguna de las comprobaciones lanza errores por ser incorrecta, pero el código de la solución de cada ejercicio no puede tener errores de sintaxis. Es lo mínimo que se debe exigir.

**RECUERDA SUBIR CADA UNO DE LOS FICHEROS .Rmd TAL CUAL (sueltos), SIN COMPRIMIR Y SIN CAMBIARLES EL NOMBRE. NO SUBAS NADA MÁS QUE LOS FICHEROS .Rmd (no subas ningún HTML, ni ningún fichero ZIP ni similar)**. La plataforma ya los separa automáticamente en carpetas con vuestro nombre completo, por lo que no es necesario que se lo pongas al fichero.
<!-- #endregion -->

<!-- #region nbgrader={"grade": false, "grade_id": "cell-42564346aa5f4ad2", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
**Ejercicio 1 (3 puntos).** Crear una función que devuelva TRUE si un número es **múltiplo** de alguno de los elementos de un vector de enteros. Deberá recibir como argumentos el vector y el número. Ser múltiplo implica que el número es mayor o igual que el elemento del vector que estemos comprobando, y además el resto de dividir el número entre el elemento del vector sea 0. El operador que calcula el resto de la división entera de dos números es `%%` y ya está vectorizado. Se harán **tres versiones** distintas de esta función: 

- Resolver el ejercicio usando un bucle *while* dentro de la función. La función debe llamarse `multiplo.vector.while` 
- Resolver el ejercicio usando un bucle *for* dentro de la función. La función ahora se llamará `multiplo.vector.for`
- Resolver el ejercicio usando dentro de la función solamente operaciones aritméticas sencillas que ya están vectorizadas en R, sin utilizar ningún bucle. La función ahora se llamará `multiplo.vector.op`

Las tres funciones deben pasar todos los casos de prueba que ves a continuación.
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej1-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej1-respuesta

#' Devuelve TRUE si un número es múltiplo de alguno de los elementos de un vector de enteros
#' 
#' @param v Vector de enteros.
#' @param numero Número entero del que se busca si es múltiplo de alguno de los números del vector v.
#' @return TRUE o FALSE según si el número es múltiplo de alguno de los números del vector v.
multiplo.vector.while <- function(v, numero){
  largo<-length(v)
  lugar<-1
  resultado<- FALSE  
  while(lugar<=largo){
      if(v <= numero && numero%%v == 0){
        resultado<-TRUE
        break}
      else{
        resultado<-FALSE
        lugar<- lugar+1
    }}
return(resultado)
}

#' Devuelve TRUE si un número es múltiplo de alguno de los elementos de un vector de enteros
#' 
#' @param v Vector de enteros.
#' @param numero Número entero del que se busca si es múltiplo de alguno de los números del vector v.
#' @return TRUE o FALSE según si el número es múltiplo de alguno de los números del vector v.
multiplo.vector.for <- function(v, numero){
  resultado<- FALSE  
  for (numeros in v){
    if(numeros <= numero && numero%%numeros == 0){
        resultado<-TRUE
        break}
    else{
        resultado<-FALSE
    }}
return(resultado)
}

#' Devuelve TRUE si un número es múltiplo de alguno de los elementos de un vector de enteros
#' 
#' @param v Vector de enteros.
#' @param numero Número entero del que se busca si es múltiplo de alguno de los números del vector v.
#' @return TRUE o FALSE según si el número es múltiplo de alguno de los números del vector v.
multiplo.vector.op <- function(v, numero){
    condicion1 <- v<=numero
    condicion2 <- numero%%v == 0
    mask <- as.numeric(condicion1 & condicion2)
    sum.mask <- sum(mask)
    resultado <- sum.mask > 0
    return(resultado)
}
# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej1-test', 'locked': True, 'points': 3, 'schema_version': 3, 'solution': False, 'task': False}"}
stopifnot(multiplo.vector.while(c(5,8,34), 11) == FALSE)
stopifnot(multiplo.vector.for(c(5,8,34),6) == FALSE)
stopifnot(multiplo.vector.op(c(5,8,34),12) == FALSE)
stopifnot(multiplo.vector.while(c(7,8,6), 7) == TRUE)
stopifnot(multiplo.vector.for(c(7,8,6),14) == TRUE)
stopifnot(multiplo.vector.op(c(7,8,6),12) == TRUE)
stopifnot(multiplo.vector.while(c(-5),6) == FALSE)
stopifnot(multiplo.vector.for(c(-5),6) == FALSE)
stopifnot(multiplo.vector.op(c(-5),6) == FALSE)
stopifnot(multiplo.vector.while(c(-5),10) == TRUE)
stopifnot(multiplo.vector.for(c(-5),10) == TRUE)
stopifnot(multiplo.vector.op(c(-5),10) == TRUE)

check.not.command = function(command, f){ stopifnot(!any(sapply(deparse(f), function(x) grepl(command, x)))) }

check.not.command("%in%", multiplo.vector.while)
check.not.command("for", multiplo.vector.while)

check.not.command("while", multiplo.vector.for)
check.not.command("%in%", multiplo.vector.for)

check.not.command("for", multiplo.vector.op)
check.not.command("while", multiplo.vector.op)                                                                
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-9fd328c340860990", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
**Ejercicio 2 (2 puntos).** Crear una función `multk` que, dado un número entero positivo y un segundo argumento `k` también entero positivo, devuelva un vector con los números múltiplos de `k` que existen (empezando en 0) menores o iguales que el primer número. Por ejemplo, para el número 17 y tomando `k = 3`, la llamada a `multk(17, 3)` debe devolver el vector (0, 3, 6, 9, 12, 15) ya que tenemos que buscar los múltiplos de 3 menores o iguales que 17. **No está permitido usar ningún tipo de bucle ni tampoco sapply/lapply**. Consulta la ayuda de R acerca de la función `seq`.

- Invocar a esta función sobre el vector `c(17, 21, 23, 25)` tomando siempre `k = 4` y sin usar un bucle sino sapply, y almacenar el resultado en la variable `multk.lista`. Recuerda que los argumentos adicionales a la función que estás pasando a `sapply` debes dárselos, con nombre, a `sapply` justo después de indicarle la función. ¿Qué tipo devuelve? ¿Por qué?

- Incorporar a la función anterior un tercer argumento `n` que indique cuántos múltiplos queremos calcular como máximo. La nueva función debe llamarse `multk.max` y devolverá los `n` primeros múltiplos de `k` que sean menores o iguales que el número, empezando por el 0. El argumento `n` **no debe tener ningún valor por defecto**, es decir, ha de ser obligatorio. Volver a invocarla usando `sapply` sobre el vector `c(17, 21, 23, 25)` con `k = 4` (este valor no varía) y tomando siempre un máximo de `n = 3` múltiplos, y almacenar el resultado en la variable `multk.matriz`. Recuerda que los argumentos adicionales a la función que estás pasando a `sapply` debes dárselos, con nombre, a `sapply` a continuación de la función. ¿Qué tipo devuelve ahora? ¿Por qué es diferente al anterior?
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej2-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej2-respuesta

#' Entrega un vector con los números múltiplos de `k` que existen (empezando en 0) menores o iguales que el primer número.
#' 
#' @param numero Número entero positivo.
#' @param k Número entero positivo.
#' @return Vector con múltiplos de 'k' partiendo de 0, menores o iguales a 'numero'.
multk <- function(numero, k){
    seq(from = 0, to=numero, by=k)
}

#' Entrega un vector con los números múltiplos de `k` que existen (empezando en 0) menores o iguales que el primer número.
#' 
#' @param numero Número entero positivo.
#' @param k Número entero positivo.
#' @param n Número de múltiplos que se quiere calcular.
#' @return Vector con múltiplos de 'k' partiendo de 0, menores o iguales a 'numero'.
multk.max <- function(numero, k, n){
    seq(from = 0, by = k, length.out = n)
}

multk.lista = sapply(c(17, 21, 23, 25), multk, k=4,simplify = FALSE)
multk.matriz = sapply(c(17, 21, 23, 25), multk.max, k=4, n=3)
# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej2-test', 'locked': True, 'points': 2, 'schema_version': 3, 'solution': False, 'task': False}"}
stopifnot(is.list(multk(24, 3)) == FALSE)
stopifnot(all(multk(24, 3) == c(0, 3, 6, 9, 12, 15, 18, 21, 24)))

check.not.command = function(command, f){ stopifnot(!any(sapply(deparse(f), function(x) grepl(command, x)))) }
check.not.command("for", multk)  # no se pueden usar bucles en divisores ni en divisores.max
check.not.command("while", multk)
check.not.command("for", multk.max)
check.not.command("while", multk.max)
                               
stopifnot(is.list(multk.lista)) # debe devolver una lista
stopifnot(length(multk.lista) == 4) # debe devolver una lista
stopifnot(all(sapply(multk.lista, length) == c(5, 6, 6, 7))) # longitudes correctas de cada vector devuelto por multk
stopifnot(all(multk.max(24, 4, 4) == c(0, 4, 8, 12)))
stopifnot(nrow(multk.matriz) == 3 & ncol(multk.matriz) == 4)  # debe ser una matriz 3x20
stopifnot(all(multk.matriz[3, ] == rep(8, 4)))
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-d36fe7d577ef57ff", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
**Ejercicio 3 (2 puntos).** 

* (a) **Sin utilizar bucles ni tampoco sapply/lapply**, crear una función `ponderada` que reciba un solo argumento, que será un vector, y calcule la **media ponderada** de los datos que hay en dicho vector, usando los propios datos también como pesos, tal como indica la siguiente fórmula:

  - Dado un vector n-dimensional $v = (v_1, ..., v_n)$, se define la media ponderada de los datos como 
  
  $$M = \frac{w_1 v_1 + w_2 v_2 + ... + w_n v_n}{w_1 + w_2 + ... + w_n}$$ 
  
  siendo $(w_1, w_2, ..., w_n)$ los pesos asociados a cada dato. En nuestro caso particular tomaremos como pesos los propios datos, de forma que $w_i = v_i$ y por tanto:
  
  $$M = \frac{v_1^2 + v_2^2 + ... + v_n^2}{v_1 + v_2 + ... + v_n}$$
  
  Puedes elevar cada elemento de un vector a cierta potencia con el operador `**` (potencia) que ya está vectorizado. La función de R para sumar los elementos de un vector se denomina `sum`.
* (b) Utilizando `apply`, invocar a la función `ponderada` sobre cada una de las filas de la matriz `m` definida a continuación, y almacenar el resultado en la variable `ponderada.filas`.
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej3-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej3-respuesta

#' calcula la media ponderada de los datos que hay en el vector entregado, usando los propios datos también como pesos.
#' 
#' @param v Vector de números.
#' @return Media ponderada de los datos que hay en el vector entregado.
ponderada <- function(v){
    sum(v**2)/sum(v)
}
m = matrix(data = c(4, -1.2, 46, 78, -2.3, 8, -2.4, 92, 156, -4.6, 12, -3.6, 138, 234, -6.9), ncol = 5)
ponderada.filas = apply(m, MARGIN = 1, ponderada)

# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej3-test', 'locked': True, 'points': 2, 'schema_version': 3, 'solution': False, 'task': False}"}
check.not.command = function(command, f){ stopifnot(!any(sapply(deparse(f), function(x) grepl(command, x)))) }
check.not.command("for", ponderada) # no se puede usar for ni while en la función geometrica
check.not.command("while", ponderada)
check.not.command("apply", ponderada)

stopifnot(ponderada(c(2, 3, 1, 1, 1)) == 2)
stopifnot(all(round(apply(m, MARGIN = 1, FUN = ponderada), 2) == c(118.17, 189.45, 133.22)))
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-be1bb1bb6a445cfc", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
**Ejercicio 4 (3 puntos).** Contestar a las siguentes cuestiones:

- Crear una función `mayusculas` que reciba un vector `v` de cadenas de caracteres y un entero `n`, y devuelva otro vector de la misma longitud que `v` que sea una copia idéntica de `v` excepto en los `n` primeros elementos, los cuales deben haber sido pasados completamente a mayúsculas. Utilizar para ello la función `toupper(cad)` (consulta la ayuda de la función con `?toupper`). Aplicarla al vector `prueba` definido a continuación para comprobar su funcionamiento transformando los `n = 3` primeros elementos, y guardar el resultado en la variable `mayusculas.prueba`.
  - Controlar el caso de que `n > length(v)` para que nunca se intenten pasar a mayúsculas más elementos de los que contiene el propio vector `v`. En dicho caso, simplemente se pasarán a mayúsculas todos los elementos de `v` aunque tenga menos de `n`.
- Crear una función `mayusculas.niveles` que reciba un factor `f` y, utilizando la función `toupper`, renombre todos sus niveles para que se transformen en letras mayúsculas. La función debe devolver el factor con los niveles renombrados, **sin modificar los datos del factor** sino solamente los niveles (y esto automáticamente ya afectará a los datos). Aplicarla al factor `fac` creado a continuación y almacenar el resultado en la variable `fac.renom`.
- Crear una función `mayusculas.columnas` que reciba un data.frame y renombre todas sus columnas, de manera que devuelva otro data.frame en el que todos los nombres de columnas estén ahora en mayúsculas. Utilizar una vez más la función `toupper` aplicada al vector de nombres de columnas, el cual debe ser extraído del dataframe con la función `colnames` de R. Almacenar el resultado devuelto en la variable `dat.renom`.
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej4-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej4-respuesta

#' Devuelva copia idéntica de `v` excepto en los `n` primeros elementos, los cuales seran pasados completamente a mayúsculas
#' 
#' @param v Vector de cadenas.
#' @param n Números de elementos que seran ´pasados a mayúsculas.
#' @return Vector con los primeros 'n' objetos en mayúsculas.
mayusculas <- function(v, n){
    copia <- v  
    mayus <- toupper(copia[1:n])
    copia[c(seq(1,n))] <- mayus
    resultado <- copia[1:length(v)]
    return(resultado)
    }

#' Renombra todos los niveles de un factor para que se transformen en letras mayúsculas.
#' 
#' @param f Vector de cadenas.
#' @return Vector con los primeros 'n' objetos en mayúsculas.
mayusculas.niveles <- function(f){
    levels(f)<-toupper(levels(f))
    return(f)
    }

#' Cambia los nombres de las columnas de un dataframe por mayúsculas.
#' 
#' @param df Dataframe.
#' @return Copia de un dataframe con los nombres de las columnas en mayúsculas.
mayusculas.columnas <- function(df){
    colnames(df)<-toupper(colnames(df))
    return(df)
}

fac = factor(c("Alto","Bajo", "Mediano", "Bajo", "Alto", "Alto", "Mediano"))
prueba = c("Esto", "es", "un", "vector", "de", "cadenas", "de", "caracteres")
dat = data.frame(Nombre = c("Juan", "Antoine", "Guido"), Edad = c(18, 35, 38), 
                 Nacionalidad = c("Esp", "Fra", "Ita"))

fac.renom = mayusculas.niveles(fac)
dat.renom = mayusculas.columnas(dat)
mayusculas.prueba = mayusculas(prueba,3)

# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej4-test', 'locked': True, 'points': 3, 'schema_version': 3, 'solution': False, 'task': False}"}
stopifnot(length(mayusculas(prueba, 3)) == length(prueba))
stopifnot(all(mayusculas(prueba, 3) == c('ESTO', 'ES', 'UN','vector','de','cadenas','de','caracteres')))
renom = mayusculas.niveles(fac)
df.renom = mayusculas.columnas(dat)
stopifnot(all(renom == c("ALTO", "BAJO", "MEDIANO", "BAJO", "ALTO", "ALTO", "MEDIANO")))
stopifnot(all(colnames(df.renom) == c("NOMBRE", "EDAD", "NACIONALIDAD")))
stopifnot(nrow(df.renom) == 3 & ncol(df.renom) == 3)
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-bd0b11511d1e9d9c", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
# Relación de ejercicios 3

En estos ejercicios practicaremos las operaciones para manejar DataFrames. En los primeros ejercicios no se puede utilizar ningún paquete de R adicional, pero en los últimos es obligatorio utilizar `dplyr`, tal como se indica en cada ejercicio.

### Las funciones NUNCA deben hacer print() ni mostrar nada por pantalla, sino devolver el resultado del cálculo utilizando return.
<!-- #endregion -->

<!-- #region nbgrader={"grade": false, "grade_id": "cell-6931830012e6c23e", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
**INSTRUCCIONES**: en cada trozo de código debes responder a la pregunta formulada, asegurándote de que el resultado queda guardado en la(s) variable(s) que por defecto vienen inicializadas a `NULL`. No se necesita usar variables intermedias, pero puedes hacerlo siempre que el resultado final del cálculo quede guardado exactamente en la variable que venía inicializada a NULL (debes reemplazar NULL por el código R necesario, pero nunca cambiar el nombre de esa variable). **El código de tu solución puede ocupar tantas líneas como necesites, pero deben estar situadas entre la línea "NO MODIFICAR ESTA LÍNEA ..." y la línea "FIN SOLUCION". Ninguna de esas dos líneas debe ser modificada bajo ningún concepto.** En caso contrario tu solución no será puntuada.

Después de cada ejercicio verás varias líneas de código ya hechas. Ejecútalas todas (no modifiques su código) y te dirán si tu solución es correcta o no. Si la solución es correcta, no se mostrará nada, pero si es incorrecta, verás un error indicando cuál es el test que tu solución no pasa. Además de esas pruebas, se realizarán algunas más (ocultas) a la hora de puntuar el ejercicio, pero si tu código pasa con éxito las líneas que ves, puedes estar bastante seguro de que tu solución es correcta. Asegúrate de que, al menos, todas las comprobaciones indican que tu solución es correcta antes de subir el ejercicio a la plataforma.

Una vez finalizada la actividad, guarda tu fichero en RStudio, después ciérralo, vuélvelo a abrir y ejecútalo completo, y asegúrate de que no se lanza ningún error. De esta manera comprobarás que no has olvidado nada y que es posible ejecutarlo completo desde 0 y sin errores. **No se corregirá ningún fichero que tenga errores de sintaxis y no se pueda ejecutar completo**. No pasa nada si alguna de las comprobaciones lanza errores por ser incorrecta, pero el código de la solución de cada ejercicio no puede tener errores de sintaxis. Es lo mínimo que se debe exigir.

**RECUERDA SUBIR CADA UNO DE LOS FICHEROS .Rmd TAL CUAL (sueltos), SIN COMPRIMIR Y SIN CAMBIARLES EL NOMBRE. NO SUBAS NADA MÁS QUE LOS FICHEROS .Rmd (no subas ningún HTML, ni ningún fichero ZIP ni similar)**. La plataforma ya los separa automáticamente en carpetas con vuestro nombre completo, por lo que no es necesario que se lo pongas al fichero.
<!-- #endregion -->

<!-- #region nbgrader={"grade": false, "grade_id": "cell-42564346aa5f4ad2", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
### No está permitido usar ningún paquete adicional en este ejercicio
**Ejercicio 1 (1.5 puntos).** Crear el siguiente data.frame y almacenarlo en la variable `personas`, teniendo en cuenta que **la columna `Sex` debe crearse como factor**, y no como columna de caracteres. Recuerda el uso del argumento `stringsAsFactors`, así como asignar nombres a las filas.

|           | Age | Height|Weight|Sex|
|-----------|:---:|:-----:|:----:|:-:|
| Alex      | 25  |   177 |   57 | F |
| Lilly     | 31  |   163 |   69 | F |
| Mark      | 23  |   190 |   83 | M |
| Oliver    | 52  |   179 |   75 | M |
| Martha    | 76  |   163 |   70 | F |
| Lucas     | 49  |   183 |   83 | M |
| Caroline  | 26  |   164 |   53 | F |

- Una vez hecho, reemplazar la columna `Sex` por otra en la que sus valores hayan sido invertidos, renombrando solamente los niveles del factor (sin modificar los datos, que serán modificados automáticamente si renombramos los niveles).

- A continuación, crear el siguiente data.frame en el que `Working` debe ser un factor, almacenarlo en la variable `df.adicional` y finalmente, añadir dicha variable al data.frame `personas` por la derecha, guardando el resultado en una nueva variable `personas.ampliado` de tipo data.frame. Es obligatorio que `df.adicional` sea creada como data.frame; no se admitirá que sea un vector.

|           | Working |
|-----------|:--------|
| Alex      |    Yes  |
| Lilly     |     No  |
| Mark      |     No  |
| Oliver    |    Yes  |
| Martha    |    Yes  |
| Lucas     |     No  |
| Caroline  |    Yes  |
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej1-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej1-respuesta
Age = c(25, 31, 23, 52, 76, 49, 26)
Height = c(177, 163, 190, 179, 163, 183, 164)
Weight = c(57, 69, 83, 75, 70, 83, 53)
Sex = factor(c("F", "F", "M", "M", "F", "M", "F"))
personas = data.frame(Age, Height, Weight, Sex, stringsAsFactors = TRUE)
rownames(personas) =  c("Alex", "Lilly", "Mark", "Oliver", "Martha", "Lucas", "Caroline")
levels(personas$Sex)<-c("M", "F")

Working = factor(c("Yes", "No", "No", "Yes", "Yes", "No", "Yes"))
df.adicional = data.frame(Working)
rownames(df.adicional) = c("Alex", "Lilly", "Mark", "Oliver", "Martha", "Lucas", "Caroline")


personas.ampliado = data.frame(personas, Working)
# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej1-test', 'locked': True, 'points': 1.5, 'schema_version': 3, 'solution': False, 'task': False}"}
stopifnot(is.data.frame(df.adicional))
stopifnot(is.data.frame(personas))
stopifnot(is.data.frame(personas.ampliado))
stopifnot(all(colnames(personas) == c("Age", "Height", "Weight", "Sex")))
stopifnot(all(rownames(personas) == c("Alex", "Lilly", "Mark", "Oliver", "Martha", "Lucas", "Caroline")))
stopifnot(all(colnames(df.adicional) == c("Working")))
stopifnot(all(rownames(df.adicional) == c("Alex", "Lilly", "Mark", "Oliver", "Martha", "Lucas", "Caroline")))
stopifnot(is.factor(personas.ampliado$Sex))
stopifnot(personas.ampliado["Alex", "Sex"] == "M")
stopifnot(is.factor(df.adicional$Working))
stopifnot(all(colnames(personas.ampliado) == c("Age", "Height", "Weight", "Sex", "Working")))
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-9fd328c340860990", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
### No está permitido usar ningún paquete adicional en este ejercicio

**Ejercicio 2 (3 puntos).** Usando la variable `state.x77` que viene definida en R, comprobar si ya es un data.frame con la función `is.data.frame` y, si no lo fuera, convertirlo a un data.frame con la función `as.data.frame` y guardar el resultado en la variable `state.df`. Recuerda que el nombre del estado pasará a ser el nombre de cada fila, no una columna convencional.

- Una vez hecho esto, reemplazar en `state.df` por `NA` **todos los valores de la columna `Illiteracy` para aquellos estados cuyo ingreso (`Income`) supere en más de un 10 % a la media de ingresos de todos los estados** (es decir, el `Income` sea mayor que 1.1 veces `mean.income`). Para esto, primero calcular la media de ingreso de todos los estados y guardarlos en la variable `mean.income`. A partir de ella, crear una máscara booleana sobre las filas como resultado de comparar `mean.income` con la columna `Income`, y guardarla en la variable `mascara.mayor.income` utilizando los nombres de fila extraídos de `state.df`.

- En el propio `state.df` añadir una fila nueva cuyo nombre de fila sea `Medias` que contenga en cada columna la **media** de los valores de todas las filas. Dicha fila será el resultado de invocar a la función `apply` con `MARGIN = 2` y pasándole la función `mean`. La fila debe crearse con ese nombre directamente, en vez de indicar el nombre después. No olvides usar el argumento `na.rm`.

- A continuación, crear una **función** `aniadeDiferencias(df)` que reciba un data.frame cualquiera, acerca del cual podemos asumir que todas sus columnas son numéricas y que ya va a existir una **fila** con nombre `Medias`. La función debe **devolver un nuevo data.frame** que tendrá el **doble de columnas** que el data.frame pasado como argumento: la primera mitad de ellas serán idénticas al data.frame, y la segunda mitad (es decir, añadidas por la derecha) serán el resultado de calcular la *diferencia, medida en porcentaje,* entre los datos de las columnas originales y la media de esa columna (que se encuentra en la fila `Medias`). Si el dato de una columna es `a` y la media es `m`, entonces la diferencia es `100*(a - m)/m`. Diferencia negativa implica estar por debajo de la media, y positiva, por encima. 

- Los nombres de las nuevas columnas deben ser iguales a los de las columnas originales, pero con la terminación `_diff`. Utiliza `paste` con `sep = _` y la cadena `diff` para ir componiendo cada nuevo nombre de columna. El alumno es libre de usar bucles o bien lapply para ir recorriendo el vector de nombres de columna del argumento `df`. *La función no debe estar pensada específicamente para el data.frame `state.df` sino para cualquier data.frame en el que exista una fila llamada Medias*. PISTA: crea una nueva variable dentro de la función llamada `resultado`, que inicialmente sea igual al argumento `df`, y ve añadiéndole las nuevas columnas.

- Como caso particular, invocar la función creada sobre el data.frame `state.df` y guardar el resultado en la variable `state.df.diff`. 
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej2-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej2-respuesta
is.data.frame(state.x77)
state.df = as.data.frame(state.x77)
mean.income = mean(state.df$Income)
mascara.mayor.income = (mean.income * 1.1) < state.df$Income
names(mascara.mayor.income) = rownames(state.df)

Medias =as.list(apply(state.df, MARGIN = 2, mean, na.rm = TRUE ))
Medias = as.list(Medias)
Medias.df = data.frame(Medias, row.names = "Medias")
colnames(Medias.df) = colnames(state.df)
state.df = rbind(state.df, Medias.df)

#' Devuelve un nuevo data.frame  que tendrá el doble de columnas que el data.frame pasado como argumento: la primera mitad de ellas serán idénticas al data.frame, y la segunda mitad (es decir, añadidas por la derecha) serán el resultado de calcular la diferencia, medida en porcentaje, entre los datos de las columnas originales y la media de esa columna.
#' 
#' @param df Dataframe con todas sus columnas con datos numericos.
#' @return Nuevo dataframe con con el doble de columnas.
aniadeDiferencias <- function(df){
lista.medias = as.list(df["Medias",])
nuevo.df = 100*(df-lista.medias)/lista.medias
colnames(nuevo.df) = paste(colnames(df), "diff", sep = "_")
resultado=cbind(df,nuevo.df)
return(resultado)
}

state.df.diff = aniadeDiferencias(state.df)

# FIN SOLUCION

```


```{r nbgrader="{'grade': True, 'grade_id': 'ej2-test', 'locked': True, 'points': 3, 'schema_version': 3, 'solution': False, 'task': False}"}
stopifnot(is.data.frame(state.df))
stopifnot(all(rownames(state.df) == c(rownames(state.x77), "Medias")))
stopifnot(is.logical(mascara.mayor.income))
stopifnot(length(mascara.mayor.income) == nrow(state.x77))
stopifnot(sum(mascara.mayor.income) == 11)                              # hay 9 estados con más de 12 letras
stopifnot(ncol(aniadeDiferencias(state.df)) == 2*ncol(state.df)) # el df resultante debe tener el doble de columnas que el original
stopifnot(all(paste(colnames(state.df), "diff", sep = "_") %in% colnames(state.df.diff))) # comprobamos los nuevos nombres
stopifnot(round(aniadeDiferencias(state.df)["Virginia", "Income_diff"], 2) == 5.98)
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-d36fe7d577ef57ff", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
### No está permitido usar ningún paquete adicional en este ejercicio

**Ejercicio 3 (3 puntos).** Con la variable `state.df` definida anteriormente:

- Almacenar su contenido en una nueva variable `state.df.abb`. Una vez copiada, reemplazar los nombres de filas existentes en `state.df.abb` por los indicados en la variable `state.abb` que ya viene definida en R (abreviaturas de los nombres de estados). Recuerda que la última fila  debe seguir llamándose `Medias` puesto que no es el nombre de ningún estado. Recuerda que la longitud de `state.abb` es uno menos que el número de filas de `state.df`.

- Añadir a `state.df.abb` una nueva columna `Division` (D mayúscula), que sea de tipo **factor** y cuyo contenido sea el contenido de la variable `division` que puedes encontrar creada a continuación. Dicha variable se ha creado añadiendo un NA (que corresponderá a la fila `Medias`) al contenido de la variable `state.division`, que ya viene definida en R y contiene una agrupación por zonas de los estados de EEUU.

- Utilizando la función `tapply` con la variable `Division` como agrupadora y la variable numérica `Income` (ingresos de ese estado) como objetivo, calcular el **ingreso medio en cada zona de EEUU** y almacenar el resultado en la variable `income.zonas`. Tendrás que pasar como argumento para `tapply` la función `mean` además del argumento adicional `na.rm = TRUE`. Tras la operación, `income.zonas` será un vector numérico con nombres, donde el nombre de cada posición coincide con la división (zona) a la que corresponde ese valor. 

- Añadir a `state.df.abb` una nueva columna `Division.mean.income` que tenga, para cada estado, el ingreso medio de la división a la que pertenece ese estado. PISTA: aprovecha que `income.zonas` tiene nombres asignados a las posiciones, y utiliza dichos nombres para indexar sobre él. Puedes obtener el nombre al que pertenece cada estado gracias a la columna `Division`, la cual te servirá para indexar por nombre sobre `income.zonas`.

- **Utilizando una sola llamada a la función `subset`**, seleccionar las filas de `state.df.abb` correspondientes a estados con un ingreso (columna `Income`) *mayor* que el ingreso medio de esa división (columna `Division.mean.income`). Para dichas filas seleccionar solamente las columnas `Population`, `Life Exp`, `Division.mean.income` y `Income`. Recuerda envolver entre \`\` (una tilde grave a cada lado) los nombres de columna que tengan espacios. Guardar el resultado en la variable `state.df.rich`.

La solución a los apartados anteriores también será válida si el data.frame resultante tiene una columna `Life.Exp` en lugar de `Life Exp` ya que ciertas operaciones de R modifican los nombres de columna con espacios. 
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej3-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej3-respuesta
state.df.abb = state.df
rownames(state.df.abb)[1:50] = state.abb
division = state.division
division[51] = NA
Division = division
state.df.abb = cbind(state.df.abb, Division)
income.zonas = tapply(state.df.abb$Income, state.df.abb$Division, FUN = mean, na.rm = TRUE)
Division.mean.income = income.zonas[c(Division)]
state.df.abb = cbind(state.df.abb, Division.mean.income)
state.df.rich = subset(state.df.abb, Income > Division.mean.income, select = c("Population", "Life Exp", "Division.mean.income", "Income"))

# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej3-test', 'locked': True, 'points': 3, 'schema_version': 3, 'solution': False, 'task': False}"}
stopifnot(all(rownames(state.df.abb)[1:50] == state.abb))
stopifnot(all(state.df.abb[["Division"]][1:50] == division[1:50]))
stopifnot(round(mean(income.zonas), 2) == 4422.61)
stopifnot(round(mean(state.df.abb$Division.mean.income - state.df.abb[["Income"]], na.rm = T), 15) == -1.09E-13)
stopifnot(is.data.frame(state.df.rich))
stopifnot(nrow(state.df.rich) == 25 & ncol(state.df.rich) == 4)
stopifnot(round(mean(state.df.rich[["Income"]]), 2) == 4724.56)
life.exp = state.df.rich$`Life Exp`
if(is.null(life.exp)){
  life.exp = state.df.rich$Life.Exp
}
stopifnot(round(mean(life.exp, na.rm = T), 2) == 70.93)
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-be1bb1bb6a445cfc", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
### Este ejercicio completo debe hacerse obligatoriamente con el paquete `dplyr` con el operador %>%.

**Ejercicio 4 (1.5 puntos).** Contestar a las siguentes cuestiones acerca del dataframe `iris`, ya definido en R, guardando el resultado de cada una en la variable correspondiente a cada apartado definida más abajo. Cada cuestión debe responderse en una sola línea de código y sin variables auxiliares. Todos los apartados deben usar funciones de `dplyr` obligatoriamente. Resuelve todo el ejercicio dentro de la función indicada, que es necesaria por motivos logísticos para la corrección.

1. Seleccionar las tres primeras columnas del dataset usando sus nombres de columna uno por uno.
2. Seleccionar todas las columnas del dataset iris excepto “Petal Width”.
3. Seleccionar todas las columnas del datdaset iris que empiecen por “P”.
4. Reemplazar, usando `case_when`, todos los valores de Petal.Width mayores que 2 por NA. **IMPORTANTE**: utiliza `NA_real_` en lugar de `NA`.
5. Quedarse solo con las filas en las que Sepal.Length >= 4.6 y Petal.Width >= 0.5.
6. Ordenar el dataset iris ascendentemente por Sepal.Width y en caso de empate, descendemente por Sepal.Length.
7. Crear una nueva columna llamada `proporcion` que sea el cociente de Sepal.Length entre Sepal.Width.

<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej4-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej4-respuesta
library(dplyr)

# No cambies el nombre de la función. Recuerda usar el operador %>% en TODOS los apartados


ejercicio4 <- function(iris){
    
    resultado.apartado1 = iris %>% select(Sepal.Length, Sepal.Width, Petal.Length)
    resultado.apartado2 = iris %>% select(-Petal.Width)
    resultado.apartado3 = iris %>% select(starts_with("P"))
    resultado.apartado4 = iris %>% mutate(Petal.Width = case_when(Petal.Width > 2 ~ NA_real_, TRUE ~ Petal.Width))
    resultado.apartado5 = iris %>% filter(Sepal.Length >= 4.6 & Petal.Width >= 0.5)
    resultado.apartado6 = iris %>% arrange(Sepal.Width, desc(Sepal.Length))
    resultado.apartado7 = iris %>% mutate(proporcion = Sepal.Length/Sepal.Width)
    
    # No modifiques esta linea
    list(resultado.apartado1, 
         resultado.apartado2, 
         resultado.apartado3, 
         resultado.apartado4,
         resultado.apartado5,
         resultado.apartado6,
         resultado.apartado7)
}

# Para tus pruebas, invocamos a la función y mostramos por pantalla cada resultado con la función head()
lista.resultados = ejercicio4(iris)

resultado1 = lista.resultados[[1]]
resultado2 = lista.resultados[[2]]
resultado3 = lista.resultados[[3]]
resultado4 = lista.resultados[[4]]
resultado5 = lista.resultados[[5]]
resultado6 = lista.resultados[[6]]
resultado7 = lista.resultados[[7]]

# Descomenta estas líneas para visualizar cada resultado
#head(resultado1)
#head(resultado2)
#head(resultado3)
#head(resultado4)
#head(resultado5)
#head(resultado6)
#head(resultado7)

# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej4-test', 'locked': True, 'points': 1.5, 'schema_version': 3, 'solution': False, 'task': False}"}
lista = ejercicio4(iris)
lineas = deparse(ejercicio4)
stopifnot(all(colnames(lista[[1]]) == c("Sepal.Length", "Sepal.Width", "Petal.Length")))
stopifnot(all(colnames(lista[[2]]) == c("Sepal.Length", "Sepal.Width", "Petal.Length", "Species")))
stopifnot(all(colnames(lista[[3]]) == c("Petal.Length", "Petal.Width")))
stopifnot(sum(grepl("resultado.apartado3", lineas) & grepl("\"P\"", lineas)) > 0)
stopifnot(sum(is.na(lista[[4]])) == 23)
stopifnot(sum(grepl("resultado.apartado4", lineas) & grepl("mutate", lineas)) > 0)
stopifnot(nrow(lista[[5]]) == 102)
stopifnot(lista[[6]]$Sepal.Length[1] == 5.0 & lista[[6]]$Sepal.Width[1] == 2.0)
stopifnot(round(mean(lista[[7]]$proporcion), 2) == 1.95)

# Comprobar que todos los apartados se han resuelto utilizando %>%
stopifnot(sum(grepl("resultado.apartado1", lineas) & grepl("%>%", lineas)) > 0)
stopifnot(sum(grepl("resultado.apartado2", lineas) & grepl("%>%", lineas)) > 0)
stopifnot(sum(grepl("resultado.apartado3", lineas) & grepl("%>%", lineas)) > 0)
stopifnot(sum(grepl("resultado.apartado4", lineas) & grepl("%>%", lineas)) > 0)
stopifnot(sum(grepl("resultado.apartado5", lineas) & grepl("%>%", lineas)) > 0)
stopifnot(sum(grepl("resultado.apartado6", lineas) & grepl("%>%", lineas)) > 0)
stopifnot(sum(grepl("resultado.apartado7", lineas) & grepl("%>%", lineas)) > 0)
```

<!-- #region nbgrader={"grade": false, "grade_id": "cell-0fdeacdd87583131", "locked": true, "schema_version": 3, "solution": false, "task": false} -->
### Este ejercicio completo debe hacerse obligatoriamente con el paquete `dplyr` con operador %>%.

**Ejercicio 5 (1 punto).** Repetir el apartado 5 del ejercicio anterior **creando una función `filtrarSepalLengthPetalWidth`** a la que le pasemos como primer argumento un dataframe (que siempre será el de iris, pero dentro de la función **no se puede hacer referencia a la variable iris** sino al df pasado como argumento) y los dos argumentos siguientes serán los umbrales de Sepal.Length y de Petal.Width. Después de crearla, invocarla utilizando el operador pipe tal como se indica en el código de ejemplo, y almacenar el resultado en la variable `df.filtrado`.
<!-- #endregion -->

```{r nbgrader="{'grade': False, 'grade_id': 'ej5-respuesta', 'locked': False, 'schema_version': 3, 'solution': True, 'task': False}"}
# NO MODIFICAR ESTA LINEA ej5-respuesta
filtrarSepalLengthPetalWidth <- function(df, umbralSepalLength, umbralPetalWidth){
    resultado = df %>% filter(Sepal.Length >= umbralSepalLength & Petal.Width >= umbralPetalWidth)
    return(resultado)
}
df.filtrado = iris %>% filtrarSepalLengthPetalWidth(4.6, 0.5)
# FIN SOLUCION
```


```{r nbgrader="{'grade': True, 'grade_id': 'ej5-test', 'locked': True, 'points': 1, 'schema_version': 3, 'solution': False, 'task': False}"}
lineasFiltrar = deparse(filtrarSepalLengthPetalWidth)
df.filtrado = iris %>% filtrarSepalLengthPetalWidth(4.6, 0.5)
stopifnot(!any(grepl("iris", lineasFiltrar))) # no puede aparecer la variable iris en el cuerpo de la función
stopifnot(any(grepl("%>%", lineasFiltrar))) # hay que usar %>% también dentro de la función
stopifnot(nrow(df.filtrado) == 102)
```
