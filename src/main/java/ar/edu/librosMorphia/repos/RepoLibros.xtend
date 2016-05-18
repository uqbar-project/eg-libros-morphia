package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Usuario
import org.apache.commons.collections15.Predicate
import org.apache.commons.collections15.functors.AndPredicate
import org.uqbar.commons.model.CollectionBasedRepo

class RepoLibros extends AbstractRepository<Libro> {

	override protected getCriterio(Libro example) {
		var result = criterioPendientes
		if (example.titulo != null) {
			result = new AndPredicate(result, getCriterioPorTitulo(example.titulo))
		}
		result
	}

	def getCriterioPendientes() {
		[Libro libro| libro.estaDisponible ] as Predicate<Libro>
	}

	def getCriterioPorTitulo(String titulo) {
		[Libro libro| libro.titulo.contains(titulo)] as Predicate<Libro>
	}
	
	override createExample() {
		new Libro
	}

	override getEntityType() {
		typeof(Libro)
	}

}
