# Préstamos de libros - Persistencia en MongoDB con Morphia

## Objetivo
Testea el mapeo de una aplicación de préstamos de libros con MongoDB y Morphia. 
Está estructurado con el formato de un [taller iterativo](https://docs.google.com/document/d/1kLAsruPYKZBNB0zi40_ORYavt_daQzEpaz2tf6pB6zw/edit#) cuyo link te dejamos. 

## Modelo
La base de datos se estructura en un documento jerárquico:

* préstamo
 * libro (embebido)
 * usuario (embebido)

Y además tenemos dos colecciones: los libros y los usuarios

## Proyecto
El proyecto base de Xtend está usando el framework [Morphia](http://mongodb.github.io/morphia/) que es un OD/M (Object Document Mapper) contra MongoDB.

**IMPORTANTE:** Usar la versión 1.2.1 o superior de Morphia ya que la anterior no se integra correctamente con Arena.



