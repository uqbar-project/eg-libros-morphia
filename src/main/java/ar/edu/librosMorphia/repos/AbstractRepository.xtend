package ar.edu.librosMorphia.repos

interface AbstractRepository<T> {
	
	def void update(T t)
	def void create(T t)
	def void delete(T t)
	
}