package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Usuario
import org.apache.commons.collections15.Predicate

class RepoUsuarios extends AbstractRepository<Usuario> {
	
	override protected getCriterio(Usuario example) {
		return [ Usuario usuario | example.nombre.equalsIgnoreCase(usuario.nombre)] as Predicate<Usuario>
	}
	
	override createExample() {
		new Usuario
	}
	
	override getEntityType() {
		typeof(Usuario)
	}
	
}