package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.domain.Usuario
import com.mongodb.MongoClient
import java.lang.reflect.Modifier
import java.util.ArrayList
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.UpdateOperations

abstract class AbstractRepository<T> {

	static protected Datastore ds
	static Morphia morphia

	new() {
		if (ds == null) {
			val mongo = new MongoClient("localhost", 27017)
			morphia = new Morphia => [
				map(typeof(Usuario)).map(typeof(Libro)).map(typeof(Prestamo))
				ds = createDatastore(mongo, "local")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
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
		if (entidadAModificar != null) {
			return entidadAModificar
		}
		create(t)
		t
	}

	def void update(T t) {
		val result = ds.update(t, this.defineUpdateOperations(t))
		println("Actualizamos " + t + "? " + result.updatedExisting)
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)

	def void create(T t) {
		val obj = despejarCampos(t)
		ds.save(obj)
	}

	def T despejarCampos(Object t) {
		val fields = new ArrayList(t.class.getDeclaredFields)
		val camposAModificar = fields.filter[!Modifier.isTransient(it.modifiers)]
		val T result = t.class.newInstance as T
		camposAModificar.forEach [
			it.accessible = true
			var valor = it.get(t)
			if (valor != null) {
				try {
					valor.class.getDeclaredField("changeSupport")
					valor = despejarCampos(valor)
				} catch (NoSuchFieldException e) {
					// todo ok, no es un valor que tenga changeSupport
				}
			}
			it.set(result, valor)
		]
		result
	}

	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}
