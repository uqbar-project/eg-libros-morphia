package ar.edu.librosMorphia.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import org.hibernate.annotations.GenericGenerator
import javax.persistence.Embeddable

@Observable
@Accessors
@Entity
@Embeddable
class Libro {
	public static String PRESTADO = "P"
	public static String DISPONIBLE = "D"

	@Id
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid2")
	String id

	String titulo
	String autor
	boolean activo
	String estado // "P" prestado / "D" disponible

	new() {
		activo = true
		estado = DISPONIBLE
	}

	def void prestar(Prestamo prestamo) {
		estado = PRESTADO
	}

	def void devolver() {
		estado = DISPONIBLE
	}

	def getEstaDisponible() {
		activo && estado.equalsIgnoreCase(DISPONIBLE)
	}

	def estaPrestado() {
		activo && estado.equalsIgnoreCase(PRESTADO)
	}

	override toString() {
		titulo
	}

}
