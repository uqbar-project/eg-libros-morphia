package ar.edu.librosMorphia.domain

import java.util.Date
import javax.persistence.CascadeType
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.GenericGenerator
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
@Entity()
class Prestamo {
	@Id 
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")	
	private String id

	@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.REFRESH)
	Usuario usuario
	
	@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.REFRESH)
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