const contents = [
    {
        content: "C:\\Users\\mknei\\Documents\\master big data\\modulo2-BaseDeDatosNoSQL\\desarrolloTarea\\movies.json",
        collection: "dataset",
        idPolicy: "drop_collection_first", //overwrite_with_same_id|always_insert_with_new_id|insert_with_new_id_if_id_exists|skip_documents_with_existing_id|abort_if_id_already_exists|drop_collection_first|log_errors
        //Use the transformer to customize the import result
        //transformer: (doc)=>{ //async (doc)=>{
        //   doc["importDate"]= new Date()
        //   return doc; //return null skips this doc
        //}
    }
];

mb.importContent({
    connection: "localhost",
    database: "Tarea_NoSQL",
    fromType: "file",
    batchSize: 2000,
    contents
})

// 1.Analizar con find() la coleccion
db.dataset.find()

// 2.Contar cuántos documentos (películas) tiene cargado
db.dataset.count()

// 3.Insertar una película
var nueva_pelicula = { "title": "Dune", "year": 2021, "cast": "Thimothee Chalamet", "genres": "Adventure" }
db.dataset.insert(nueva_pelicula)

// 4.Borrar la película insertada en el punto anterior
var nueva_pelicula = { "title": "Dune", "year": 2021, "cast": "Thimothee Chalamet", "genres": "Adventure" }
db.dataset.deleteOne(nueva_pelicula)

// 5.Contar cuantas películas tienen actores (cast) que se llaman "and"
var query = { "cast": "and" }
db.dataset.find(query).count()

// 6.Actualizar los documentos cuyo actor (cast) tenga por error el valor “and” como si realmente fuera un actor. Para 
//   ello, se debe sacar únicamente ese valor del array cast. Por lo tanto, no se debe eliminar ni el documento (película) ni 
//   su array cast con el resto de actores.
var query = { "cast": "and" }
var operacion = { $unset: { "cast": "and" } }
db.dataset.updateMany(query, operacion)

// 7.Contar cuantos documentos (películas) no tienen actores (array cast)
var query = { "cast": [] }
db.dataset.find(query).count()

// 8.Actualizar TODOS los documentos (películas) que no tengan actores (array cast), añadiendo un nuevo elemento 
//   dentro del array con valor Undefined. Cuidado! El tipo de cast debe seguir siendo un array. El array debe ser así 
//   -> ["Undefined" ]
var query = { "cast": [] }
var operacion = { $set: { "cast": ["Undefined"] } }
db.dataset.updateMany(query, operacion)

// 9.Contar cuantos documentos (películas) no tienen Género (array genres)
var query = { "genres": [] }
db.dataset.find(query).count()

// 10.Actualizar TODOS los documentos (películas) que no tengan géneros (array genres), añadiendo un nuevo elemento 
// dentro del array con valor Undefined. Cuidado! El tipo de genres debe seguir siendo un array. El array debe ser así 
// -> ["Undefined" ]
var query = { "genres": [] }
var operacion = { $set: { "genres": ["Undefined"] } }
db.dataset.updateMany(query, operacion)

// 11.Mostrar el año más reciente / actual que tenemos sobre todas las películas
var query = {}
var projection = { "_id": 0, "year": 1 }
db.dataset.find(query, projection).sort({ "year": -1 }).limit(1)

// 12.Contar cuántas películas han salido en los últimos 20 años. Debe hacerse desde el último año que se tienen 
//    registradas películas en la colección, mostrando el resultado total de esos años. Se debe hacer con el Framework de 
//    Agregación
var query1 = { "year": { $lte: 2018 }, "year": { $gt: 1998 } }
var fase1 = { $match: query1 }
var query2 = { _id: null, total: { $sum: 1 } }
var fase2 = { $group: query2 }
var etapas = [fase1, fase2]
db.dataset.aggregate(etapas)

// 13.Contar cuántas películas han salido en la década de los 60 (del 60 al 69 incluidos). Se debe hacer con el Framework 
//    de Agregación
var query1 = { "year": { $lte: 1969 }, "year": { $gte: 1960 } }
var fase1 = { $match: query1 }
var query2 = { _id: null, total: { $sum: 1 } }
var fase2 = { $group: query2 }
var etapas = [fase1, fase2]
db.dataset.aggregate(etapas)

// 14.Mostrar el año u años con más películas mostrando el número de películas de ese año. Revisar si varios años 
//    pueden compartir tener el mayor número de películas
var query1 = { "_id":"$year", "pelis": {$sum:1}}
var fase1 = { $group: query1}
var query2 = {"_id":{"pelis":"$pelis"}, "years":{$push: "$_id"}}
var fase2 = {$group: query2}
var query3 = {"_id": -1}
var fase3 = {$sort: query3}
var etapas = [fase1, fase2, fase3]
db.dataset.aggregate(etapas).limit(1)

// 15.Mostrar el año u años con menos películas mostrando el número de películas de ese año. Revisar si varios años 
//    puede compartir tener el menor número de películas
var query1 = { "_id":"$year", "pelis": {$sum:1}}
var fase1 = { $group: query1}
var query2 = {"_id":{"pelis":"$pelis"}, "years":{$push: "$_id"}}
var fase2 = {$group: query2}
var query3 = {"_id": 1}
var fase3 = {$sort: query3}
var etapas = [fase1, fase2, fase3]
db.dataset.aggregate(etapas).limit(1)

// 16.Guardar en nueva colección llamada “actors” realizando la fase $unwind por actor. Después, contar cuantos 
//    documentos existen en la nueva colección
var fase1 = {$unwind: "$cast"}
var fase2 = {$project: {"_id": 0}}
var fase3 = {$out: "actors"}
var etapas = [fase1, fase2, fase3]
db.dataset.aggregate(etapas)

db.actors.find().count()

// 17.Sobre actors (nueva colección), mostrar la lista con los 5 actores que han participado en más películas mostrando el 
//número de películas en las que ha participado. Importante! Se necesita previamente filtrar para descartar aquellos 
//actores llamados "Undefined". Aclarar que no se eliminan de la colección, sólo que filtramos para que no aparezcan.
var query1 = {"cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"_id": "$cast", "peliculas": {$sum: 1}}
var fase2 = {$group: query2}
var query3 = {"peliculas": -1}
var fase3 = {$sort: query3}
var etapas = [fase1, fase2, fase3]
db.actors.aggregate(etapas).limit(5)

// 18.Sobre actors (nueva colección), agrupar por película y año mostrando las 5 en las que más actores hayan 
//    participado, mostrando el número total de actores
var query1 = {"cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"_id": {"title": "$title", "year": "$year"}, "cuenta": {$sum: 1}}
var fase2 = {$group: query2}
var query3 = {"cuenta": -1}
var fase3 = {$sort: query3}
var etapas = [fase1, fase2, fase3]
db.actors.aggregate(etapas).limit(5)

// 19.Sobre actors (nueva colección), mostrar los 5 actores cuya carrera haya sido la más larga. Para ello, se debe 
//    mostrar cuándo comenzó su carrera, cuándo finalizó y cuántos años han pasado. Importante! Se necesita previamente 
//    filtrar para descartar aquellos actores llamados "Undefined"
var query1 = {"genres":{$ne: "Undefined"}, "cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"cast":1, "year":2}
var fase2 = {$project: query2}
var query3 = {"_id": "$cast", "year":{$addToSet: "$year"}}
var fase3 = {$group: query3}
var query4 = {"comienza":{$min:"$year"}, "termina":{$max: "$year"},"year": 1}
var fase4 = {$project: query4}
var query5 = {"años":{$subtract: ["$termina","$comienza"]}}
var fase5 = {$addFields: query5} 
var fase6 = {$unset: "year"}
var query7 = {"años": -1}
var fase7 = {$sort: query7}
var etapas = [fase1, fase2, fase3, fase4, fase5, fase6, fase7]
db.actors.aggregate(etapas).limit(5)

// 20.Sobre actors (nueva colección), Guardar en nueva colección llamada “genres” realizando la fase $unwind por 
//    genres. Después, contar cuantos documentos existen en la nueva colección
var fase1 = {$unwind: "$genres"}
var fase2 = {$project: {"_id": 0}}
var fase3 = {$out: "genres"}
var etapas = [fase1, fase2, fase3]
db.actors.aggregate(etapas)

db.genres.find().count()

// 21.Sobre genres (nueva colección), mostrar los 5 documentos agrupados por “Año y Género” que más número de 
//    películas diferentes tienen mostrando el número total de películas
var query1 = {"genres":{$ne: "Undefined"}, "cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"_id": {"year": "$year", "genre": "$genres"}, "pelis": {$sum: 1}}
var fase2 = {$group: query2}
var query3 = {"pelis": -1}
var fase3 = {$sort: query3}
var etapas = [fase1, fase2, fase3]
db.genres.aggregate(etapas).limit(5)

// 22.Sobre genres (nueva colección), mostrar los 5 actores y los géneros en los que han participado con más número de 
//    géneros diferentes, se debe mostrar el número de géneros diferentes que ha interpretado. Importante! Se necesita 
//    previamente filtrar para descartar aquellos actores llamados "Undefined". Aclarar que no se eliminan de la colección, 
//    sólo que filtramos para que no aparezcan
var query1 = {"genres":{$ne: "Undefined"}, "cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"cast":1, "genres":1}
var fase2 = {$project: query2} 
var query3 = {"_id":"$cast", "generos": {$addToSet: "$genres"}}
var fase3 = {$group: query3}
var query4 = {"numgeneros": {$size:"$generos"}}
var fase4 = {$addFields: query4}
var query5 = {"numgeneros": -1}
var fase5 = {$sort: query5}
var etapas = [fase1, fase2, fase3, fase4, fase5]
db.genres.aggregate(etapas).limit(5) 

// 23.Sobre genres (nueva colección), mostrar las 5 películas y su año correspondiente en los que más géneros diferentes
//    han sido catalogados, mostrando esos géneros y el número de géneros que contiene. Se muestra una salida de //
//    ejemplo, el resultado es erróneo
var query1 = {"genres":{$ne: "Undefined"}, "cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"_id": {"title":"$title","year": "$year"}, "cast":{$push:"$cast"}, "genres": {$addToSet: "$genres"} }
var fase2 = {$group: query2}
var fase3 = {$unset: "cast"} 
var query4 = {"numgeneros": {$size:"$genres"}}
var fase4 = {$addFields: query4}
var query5 = {"numgeneros": -1}
var fase5 = {$sort: query5}
var etapas = [fase1, fase2, fase3,fase4, fase5]
db.genres.aggregate(etapas).limit(5)

// 24.Genero con mayor cantidad de peliculas
var query1 = {"genres":{$ne: "Undefined"}, "cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"_id": "$genres", "peliculas": {$addToSet: "$title"} }
var fase2 = {$group: query2}
var query3 = {"numpeliculas": {$size:"$peliculas"}}
var fase3 = {$addFields: query3}
var fase4 = {$unset:"peliculas"}
var query5 = {"numpeliculas": -1}
var fase5 = {$sort: query5}
var etapas = [fase1, fase2, fase3, fase4, fase5]
db.genres.aggregate(etapas).limit(1)

// 25. Los 3 actores que han trabajado en mas peliculas de comedia
var query1 = {"genres":{$ne: "Undefined"}, "cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"genres": "Comedy"}
var fase2 = {$match: query2}
var query3= {"_id": "$cast", "genres":{$push: "$genres"}}
var fase3 = {$group: query3}
var query4 = {"numpeliculas": {$size:"$genres"}}
var fase4 = {$addFields: query4}
var fase5 = {$unset:"genres"}
var query6 = {"numpeliculas": -1}
var fase6 = {$sort: query6}
var etapas = [fase1, fase2, fase3, fase4, fase5, fase6]
db.genres.aggregate(etapas).limit(3)

// 26. Duracion media de la carrera de una actor en años
var query1 = {"genres":{$ne: "Undefined"}, "cast":{$ne: "Undefined"}}
var fase1 = {$match: query1}
var query2 = {"cast":1, "year":2}
var fase2 = {$project: query2}
var query3 = {"_id": "$cast", "year":{$addToSet: "$year"}}
var fase3 = {$group: query3}
var query4 = {"comienza":{$min:"$year"}, "termina":{$max: "$year"},"year": 1}
var fase4 = {$project: query4}
var query5 = {"años":{$subtract: ["$termina","$comienza"]}}
var fase5 = {$addFields: query5} 
var fase6 = {$unset: ["_id","year", "comienza", "termina"}
var query7 = {"_id": "$_id" , "numAños": {$avg: "$años"} }
var fase7 = {$group: query7}
var query8 = {"años": -1}
var fase8 = {$sort: query8}
var etapas = [fase1, fase2, fase3, fase4, fase5, fase6, fase7]
db.actors.aggregate(etapas)