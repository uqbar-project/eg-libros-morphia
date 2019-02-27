package ar.edu.librosMorphia.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors

class Usuario {
	//@Id ObjectId id
	
	String nombre
	String password
		
	override toString() {
		nombre
	}
	
}