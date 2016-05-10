package ar.edu.librosMorphia.repos

import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.Entity

class RepoHelper {

	static def createIfNotExists(CollectionBasedRepo repo, Entity example) {
		val entidadAModificar = getByExample(repo, example)
		if (entidadAModificar != null) {
			return entidadAModificar
		}
		repo.create(example)
		return example
	}
	
	static def getByExample(CollectionBasedRepo repo, Entity example) {
		val result = repo.searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		} 
	}
	
}