package ar.edu.librosMorphia.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Usuario extends Entity {
	
	String nombre
	String password
	
	override toString() {
		nombre
	}
	
}