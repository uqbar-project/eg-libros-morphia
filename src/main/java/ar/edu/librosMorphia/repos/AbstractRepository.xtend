package ar.edu.librosMorphia.repos

import java.util.List
import javax.persistence.EntityManager
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException

abstract class AbstractRepository<T> {
	static final EntityManagerFactory entityManagerFactory = Persistence.
		createEntityManagerFactory("ogm-mongodb")
	protected static EntityManager entityManager = entityManagerFactory.createEntityManager

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
		entityManager.createNativeQuery("{}",entityType).resultList
	}

	abstract def Class<T> getEntityType()

}
