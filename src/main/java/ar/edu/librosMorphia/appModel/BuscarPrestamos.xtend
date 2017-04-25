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
		val libroSeleccionado = prestamoSeleccionado.libro
		libroSeleccionado.devolver

		// al estar en memoria esto es al cuete
		repoLibros.update(libroSeleccionado)
		repoPrestamos.update(prestamoSeleccionado)
		//
		buscar()
	}

}
