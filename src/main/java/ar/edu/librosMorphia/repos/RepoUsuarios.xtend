package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Usuario

class RepoUsuarios extends AbstractRepository<Usuario> {

	override getEntityType() {
		typeof(Usuario)
	}

	override searchByExample(Usuario usuario) {
//		ds.createQuery(entityType)
//			.field("nombre").equal(usuario.nombre)
//			.asList
	}

	override defineUpdateOperations(Usuario usuario) {
//		ds.createUpdateOperations(entityType)
//			.set("nombre", usuario.nombre)
//			.set("password", usuario.password)
	}

}
