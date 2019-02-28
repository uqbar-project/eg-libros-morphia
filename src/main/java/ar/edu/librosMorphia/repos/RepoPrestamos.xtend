package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Prestamo

class RepoPrestamos extends AbstractRepository<Prestamo> {
	
	override getEntityType() {
		typeof(Prestamo)
	}
	
	
	override generateWhere(Prestamo example) {
		"{ $and: [ { libro.titulo : '" + example.libro.titulo + "' }, { usuario.nombre : '" + example.usuario.nombre + "' } ] }"
	}
	
	override getName() {
		"Prestamos"
	}
	

}
