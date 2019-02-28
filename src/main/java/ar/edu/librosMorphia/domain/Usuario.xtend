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
class Usuario {
	@Id
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid2")
	private String id

	String nombre
	String password

	override toString() {
		nombre
	}

}
