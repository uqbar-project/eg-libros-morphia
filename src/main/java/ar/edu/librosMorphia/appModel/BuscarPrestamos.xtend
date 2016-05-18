package ar.edu.librosMorphia.appModel

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.repos.AbstractRepository
import ar.edu.librosMorphia.repos.RepoLibros
import ar.edu.librosMorphia.repos.RepoPrestamos
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class BuscarPrestamos {

	// Busqueda
	List<Prestamo> prestamos
	Prestamo prestamoSeleccionado

	AbstractRepository<Prestamo> repoPrestamos = ApplicationContext.instance.getSingleton(typeof(RepoPrestamos))
	AbstractRepository<Libro> repoLibros = ApplicationContext.instance.getSingleton(typeof(RepoLibros))

	new() {
		buscar()
	}

	def buscar() {
		prestamos = repoPrestamos.searchByExample(new Prestamo)
	}

	def devolver() {
		prestamoSeleccionado.devolver

		// al estar en memoria esto es al cuete
		var libroAModificar = new Libro => [
			titulo = prestamoSeleccionado.libro.titulo
		]
		libroAModificar = repoLibros.getByExample(libroAModificar)
		libroAModificar.devolver
		repoLibros.update(libroAModificar)
		repoPrestamos.update(prestamoSeleccionado)

		//
		buscar()
	}

}
