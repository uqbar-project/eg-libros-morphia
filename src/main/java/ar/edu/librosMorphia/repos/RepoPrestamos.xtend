package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Prestamo

class RepoPrestamos extends AbstractRepository<Prestamo> {
	
	override getEntityType() {
		typeof(Prestamo)
	}
	
	def createWhenNew(Prestamo prestamo) {
		if (searchByExample(prestamo).isEmpty) {
			this.create(prestamo)
		}
	}
	
	override searchByExample(Prestamo example) {
		val query = ds.createQuery(entityType)
		if (example.libro !== null) {
			query.field("libro.titulo").equal(example.libro.titulo)
		}
		if (example.usuario !== null) {
			query.field("usuario.nombre").equal(example.usuario.nombre)
		}
		query.field("fechaRetorno").doesNotExist
		query.asList
	}
	
	override defineUpdateOperations(Prestamo prestamo) {
		val operations = ds.createUpdateOperations(entityType)
		if (prestamo.fechaDevolucion === null) {
			operations.unset("fechaRetorno")
		} else {
			// No tiene sentido modificar el libro o el usuario
			//.set("libro", prestamo.libro) 
			//.set("usuario", prestamo.usuario)
			// solo la fecha de devolucion cuando lo devuelve
			operations.set("fechaRetorno", prestamo.fechaDevolucion)
		}
	}

}
