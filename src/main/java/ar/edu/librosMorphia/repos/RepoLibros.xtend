package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Libro

class RepoLibros extends AbstractRepository<Libro> {
	
	override searchByExample(Libro example) {
		ds.createQuery(entityType)
			.field("titulo").contains(example.titulo ?: "")
			.field("activo").equal(true)
			.field("estado").equal(example.estado ?: Libro.DISPONIBLE)
			.asList
	}
	
	override getEntityType() {
		Libro
	}
	
	override defineUpdateOperations(Libro libro) {
		ds.createUpdateOperations(entityType)
			.set("titulo", libro.titulo)
			.set("autor", libro.autor)
			.set("activo", libro.activo)
			.set("estado", libro.estado)
	}

}
