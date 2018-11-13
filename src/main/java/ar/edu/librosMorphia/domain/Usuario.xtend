package ar.edu.librosMorphia.domain

import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors

import org.uqbar.commons.model.annotations.Observable
import xyz.morphia.annotations.Entity
import xyz.morphia.annotations.Id

@Observable
@Accessors
@Entity
class Usuario {
	@Id ObjectId id
	
	String nombre
	String password
		
	override toString() {
		nombre
	}
	
}