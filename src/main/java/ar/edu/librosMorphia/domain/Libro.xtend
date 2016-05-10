package ar.edu.librosMorphia.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable

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
	
	def Prestamo prestar(Usuario _usuario) {
		val nuevoPrestamo = new Prestamo => [
					usuario = _usuario
					libro = this
				]
		prestamos.add(nuevoPrestamo)
		nuevoPrestamo
	}
	
	def void devolver() {
		ultimoPrestamo?.devolver
	}
	
	def getEstaDisponible() {
		if (prestamos.isEmpty) {
			return true
		}
		ultimoPrestamo?.estaDisponible
	}
	
	def getUltimoPrestamo() {
		prestamos.last
	}
	
	def quienLoTiene() {
		ultimoPrestamo?.usuario
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

