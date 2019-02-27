package ar.edu.librosMorphia.repos

import java.util.List

abstract class AbstractRepository<T> {

//	static protected Datastore ds
//	static Morphia morphia

	new() {
//		if (ds === null) {
//			val mongo = new MongoClient("localhost", 27017)
//			morphia = new Morphia => [
//				map(typeof(Usuario)).map(typeof(Libro)).map(typeof(Prestamo))
//				ds = createDatastore(mongo, "test")
//				ds.ensureIndexes
//			]
//			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
//		}
	}

	def T getByExample(T example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		}
	}

	def List<T> searchByExample(T t)

	def T createIfNotExists(T t) {
		val entidadAModificar = getByExample(t)
		if (entidadAModificar !== null) {
			return entidadAModificar
		}
		create(t)
	}

	def void update(T t) {
		//ds.update(t, this.defineUpdateOperations(t))
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)

	def T create(T t) {
//		ds.save(t)
		t
	}

	def void delete(T t) {
	//	ds.delete(t)
	}

	def List<T> allInstances() {
		//ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}
