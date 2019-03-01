package ar.edu.librosMorphia.repos

import java.util.List
import javax.persistence.EntityManager
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException

abstract class AbstractRepository<T> {

//	static protected Datastore ds
//	static Morphia morphia
	private static final EntityManagerFactory entityManagerFactory = Persistence.
		createEntityManagerFactory("ogm-mongodb")
	protected static EntityManager entityManager = entityManagerFactory.createEntityManager

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
	def Long count() {	
	println("db." + name +".count({})")
	 entityManager.createNativeQuery( "db." + name +".count({})" ).getSingleResult() as Long
	}
	
	def String getName(){
		entityType.simpleName
	}
	
	def List<T> searchByExample(T t){
		entityManager.createNativeQuery(generateWhere(t), entityType ).resultList
	}
	
	def String generateWhere(T t)

	def T createIfNotExists(T t) {
		val entidadAModificar = getByExample(t)
		if (entidadAModificar !== null) {
			return entidadAModificar
		}
		create(t)
	}

	def void update(T t) {
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ha ocurrido un error. La operación no puede completarse.", e)
		}
	}

	// abstract def UpdateOperations<T> defineUpdateOperations(T t)
	def T create(T t) {
			entityManager.getTransaction().begin()
			entityManager.persist(t)
			entityManager.transaction.commit()
	t
	}

	def void delete(T t) {
		try {
			entityManager => [
				transaction.begin
				delete(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ha ocurrido un error. La operación no puede completarse.", e)
		}
	}

	def List<T> allInstances() {
//		val criteria = entityManager.criteriaBuilder
//		val query = criteria.createQuery as CriteriaQuery<T>
//		val from = query.from(entityType)
//		query.select(from)
		entityManager.createNativeQuery("{}",entityType).resultList
	}

	abstract def Class<T> getEntityType()

}
