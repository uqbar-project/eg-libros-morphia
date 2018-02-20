package ar.edu.librosMorphia.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Libro extends Entity {
	String titulo
	String autor
	boolean activo
	List<Prestamo> prestamos
	
	new() {
		activo = true
		prestamos = newArrayList
	}
	
	def void devolver() {
		ultimoPrestamo?.devolver
	}
	
	def getEstaDisponible() {
		if (!activo) {
			return false
		}
		if (prestamos.isEmpty) {
			return true
		}
		ultimoPrestamo.estaDisponible
	}
	
	def getUltimoPrestamo() {
		prestamos.last
	}
	
	def estaPrestado() {
		!estaDisponible
	}
	
	def void prestar(Prestamo prestamo) {
		prestamos.add(prestamo)
	}
	
	override toString() {
		titulo
	}
	
}

