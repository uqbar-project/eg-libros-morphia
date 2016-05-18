package ar.edu.librosMorphia.domain

import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable
import org.mongodb.morphia.annotations.Entity

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