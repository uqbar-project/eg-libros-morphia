package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.domain.Usuario
import com.mongodb.MongoClient
import java.lang.reflect.Array
import java.lang.reflect.Field
import java.lang.reflect.Modifier
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.annotations.Transient
import org.mongodb.morphia.query.UpdateOperations

abstract class AbstractRepository<T> {

	static String CHANGE_SUPPORT = "changeSupport"
	static String COLLECTION_METHOD = "size"
	
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
	}

	def void update(T t) {
		val result = ds.update(t, this.defineUpdateOperations(t))
		println("Actualizamos " + t + "? " + result.updatedExisting)
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)

	def T create(T t) {
		val obj = despejarCampos(t)
		ds.save(obj)
		obj
	}

	def T despejarCampos(Object t) {
		if (t == null) {
			return null
		}
		if (claseNoPersistida(t.class.name)) {
			return null
		}
		val camposAModificar = filtrarCamposAPersistir(t.class.getDeclaredFields)
		val T result = t.class.newInstance as T
		blanquearPropiedad(result, CHANGE_SUPPORT)
		camposAModificar.forEach [
			it.accessible = true
			val valor = getValor(it, t)
			it.set(result, valor)
		]
		result
	}
	
	def getValor(Field field, Object value) {
		val valor = field.get(value)
		
		if (valor == null) {
			return null
		}
		
		// Los arrays no tienen variables, buuu
		if (field.getType().isArray) {
			val length = Array.getLength(valor)
			for (var i = 0; i < length; i++) {
				Array.set(valor, i, despejarCampos(Array.get(valor, i)))
			}
			return valor
		} 
		
		try {
			valor.class.getDeclaredField(CHANGE_SUPPORT)
			return despejarCampos(valor)
		} catch (NoSuchFieldException e) {
			// todo ok, no es un valor que tenga changeSupport
			// pero por ahi­ es un list, set o lo que fuera
			// entonces hay que despejarle los campos
			try {
				valor.class.getDeclaredMethod(COLLECTION_METHOD)
				return despejarCampos(valor)
			} catch (NoSuchMethodException nsfe) {
			}
		}
		return valor		
	}

	def boolean esTransient(Field f) {
		val tieneAnnotation = f.getAnnotation(Transient)
		return (tieneAnnotation != null)
	}

	def boolean claseNoPersistida(String className) {
		#["PersistentSet"].contains(className)
	}

	def filtrarCamposAPersistir(List<Field> fields) {
		fields.filter [
			//!Modifier.isTransient(it.modifiers) &&
			// elementData[] de ArrayList es transient!!! 
			!Modifier.isFinal(it.modifiers) && !it.name.contains(CHANGE_SUPPORT) && !esTransient(it)
		]
	}

	def blanquearPropiedad(T result, String property) {
		try {
			val fieldModified = result.class.getDeclaredField(property)
			fieldModified.accessible = true
			fieldModified.set(result, null)
		} catch (NoSuchFieldException e) {
		}
	}

	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}
