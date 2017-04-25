package ar.edu.librosMorphia.domain

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Prestamo extends Entity {
	Usuario usuario
	Libro libro
	Date fechaDevolucion
	
	new() {
		
	}
	
	new(Libro _libro, Usuario _usuario) {
		libro = _libro
		usuario = _usuario
	}
	
	def devolver() {
		fechaDevolucion = new Date
		libro.devolver
	}
	
	def estaPendiente() {
		fechaDevolucion == null
	}
	
	def void validar() {
		if (libro == null) {
			throw new UserException("Debe seleccionar el libro a prestar")
		}
		if (usuario == null) {
			throw new UserException("Debe seleccionar a quién prestarle el libro")
		}
		if (!libro.estaDisponible) {
			throw new UserException("El libro no está disponible")
		}
	}
	
	def estaDisponible() {
		!estaPendiente
	}

	override toString() {
		"" + super.hashCode() + "- " + libro.toString() + " a " + usuario.toString
	}
	
}