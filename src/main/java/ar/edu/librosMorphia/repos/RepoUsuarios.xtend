package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Usuario

class RepoUsuarios extends AbstractRepository<Usuario> {

	override getEntityType() {
		typeof(Usuario)
	}

	override generateWhere(Usuario example) {
		"{'nombre' : '" + example.nombre + "'}"
	}

}
