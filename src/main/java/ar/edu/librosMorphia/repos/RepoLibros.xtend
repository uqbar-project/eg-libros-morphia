package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Libro

class RepoLibros extends AbstractRepository<Libro> {
	
	override generateWhere(Libro example) {
		var String titulo = ""
		if (example.titulo !== null)
			titulo = ",{ 'titulo' : {$regex : '.*" + example.titulo + ".*'} }"
		"{ $and: [ { 'activo' :true },{ 'estado' : '" + (example.estado ?: Libro.DISPONIBLE) + "' }" + titulo + " ] }"
	}
	override getEntityType() {
		typeof(Libro)
	}

}
