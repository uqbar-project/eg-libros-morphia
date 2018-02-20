# Préstamos de libros - Persistencia en MongoDB con Morphia

[![Build Status](https://travis-ci.org/uqbar-project/eg-libros-morphia.svg?branch=master)](https://travis-ci.org/uqbar-project/eg-libros-morphia)

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
Antes de levantar la aplicación, tenés que instalar una base de datos [MongoDB Community Edition](https://www.mongodb.com/) y levantar el server. En Windows, [levantan el servicio mongod](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/), en Linux desde una línea de comandos hacen

```bash
$ sudo service mongod start
```

El proyecto base de Xtend está usando el framework [Morphia](http://mongodb.github.io/morphia/) que es un OD/M (Object Document Mapper) contra MongoDB.

**IMPORTANTE:** Usar la versión 1.2.1 o superior de Morphia ya que la anterior no se integra correctamente con Arena.



