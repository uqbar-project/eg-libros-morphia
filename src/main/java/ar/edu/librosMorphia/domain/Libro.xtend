package ar.edu.librosMorphia.domain

import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class Libro {
	public static String PRESTADO = "P"
	public static String DISPONIBLE = "D"
	
	@Id ObjectId id
	
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
