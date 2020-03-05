package ar.edu.librosMorphia.domain

import java.util.Date
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Property
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
@Entity(value="Prestamos", noClassnameStored=true)
class Prestamo {
	@Id ObjectId id

	@Embedded	
	Usuario usuario
	
	@Embedded
	Libro libro
	
	@Property("fechaRetorno")
	Date fechaDevolucion

	def devolver() {
		fechaDevolucion = new Date
		libro.devolver
	}
	
	def estaPendiente() {
		fechaDevolucion === null
	}
	
	def void validar() {
		if (libro === null) {
			throw new UserException("Debe seleccionar el libro a prestar")
		}
		if (usuario === null) {
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