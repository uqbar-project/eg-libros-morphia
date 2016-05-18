package ar.edu.librosMorphia.repos

import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.Entity

abstract class AbstractRepository<T extends Entity> extends CollectionBasedRepo<T> {
	
	def createIfNotExists(T example) {
		val entidadAModificar = getByExample(example)
		if (entidadAModificar != null) {
			return entidadAModificar
		}
		this.create(example)
		return example
	}
	
	def getByExample(T example) {
		val result = this.searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		} 
	}
	
}