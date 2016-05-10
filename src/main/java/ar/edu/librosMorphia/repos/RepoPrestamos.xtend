package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedRepo
import ar.edu.librosMorphia.domain.Usuario

class RepoPrestamos extends CollectionBasedRepo<Prestamo> implements AbstractRepository<Prestamo> {
	
	override protected getCriterio(Prestamo example) {
		var result = criterioPendientes
		result
	}

	def getCriterioPendientes() {
		[Prestamo prestamo | prestamo.estaPendiente ] as Predicate<Prestamo>
	}

	override createExample() {
		new Prestamo
	}

	override getEntityType() {
		typeof(Prestamo)
	}

	def createWhenNew(Prestamo prestamo) {
		if (search(prestamo.libro, prestamo.usuario).isEmpty) {
			this.create(prestamo)
		}
	}
	
	def search(Libro libro, Usuario usuario) {
		allInstances.filter [ 
			prestamo | (prestamo.libro.equals(libro) || libro == null)
				&& (prestamo.usuario.equals(usuario) || usuario == null)
		]
	}
	
}