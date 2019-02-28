package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Libro

class RepoLibros extends AbstractRepository<Libro> {
	
	override generateWhere(Libro example) {
		"{ $and: [ { titulo : /" + example.titulo + "/ }, { activo :true },{ estado : '" + example.estado ?: Libro.DISPONIBLE + "' } ] }"
	}
	override getEntityType() {
		typeof(Libro)
	}
	
	override getName() {
		"Libro"
	}

}
