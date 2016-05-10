package ar.edu.librosMorphia.appModel

import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.repos.RepoPrestamos
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class BuscarPrestamos {
	
	// Busqueda
	List<Prestamo> prestamos
	Prestamo prestamoSeleccionado
	
	CollectionBasedRepo<Prestamo> repoPrestamos = ApplicationContext.instance.getSingleton(typeof(RepoPrestamos))
	
	new() {
		buscar()
	}
	
	def buscar() {
		prestamos = repoPrestamos.searchByExample(repoPrestamos.createExample)
	}
	
	def devolver() {
		prestamoSeleccionado.devolver
		// al estar en memoria esto es al cuete
		repoPrestamos.update(prestamoSeleccionado)
		//
		buscar()
	}
	
}