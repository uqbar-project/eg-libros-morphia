package ar.edu.librosMorphia.runnable

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.domain.Usuario
import ar.edu.librosMorphia.repos.AbstractRepository
import ar.edu.librosMorphia.repos.RepoLibros
import ar.edu.librosMorphia.repos.RepoPrestamos
import ar.edu.librosMorphia.repos.RepoUsuarios
import org.uqbar.arena.bootstrap.Bootstrap
import org.uqbar.commons.applicationContext.ApplicationContext

class LibrosBootstrap implements Bootstrap {
	AbstractRepository<Usuario> repoUsuarios = ApplicationContext.instance.getSingleton(RepoUsuarios)
	AbstractRepository<Libro> repoLibros = ApplicationContext.instance.getSingleton(RepoLibros)
	RepoPrestamos repoPrestamos = ApplicationContext.instance.getSingleton(RepoPrestamos) as RepoPrestamos

	override isPending() {
		true
	}

	override run() {
		if (!repoUsuarios.allInstances.isEmpty) {
			return
		}
		
		var medina = new Usuario => [
			nombre = "Medina"
			password = "Piquito"
		]
		var santos = new Usuario => [
			nombre = "Santos"
			password = "Milazzo"
		]

		var elAleph = new Libro => [
			titulo = "El Aleph"
			autor = "Jorge Luis Borges"
		]
		var noHabraMasPenas = new Libro => [
			titulo = "No habrá más penas ni olvido"
			autor = "Osvaldo Soriano"
		]
		var novelaPeron = new Libro => [
			titulo = "La novela de Perón"
			autor = "Tomás Eloy Martínez"
		]

		repoUsuarios.createIfNotExists(
			new Usuario => [
				nombre = "Lampone"
				password = "Betun"
			])
		medina = repoUsuarios.createIfNotExists(medina)
		santos = repoUsuarios.createIfNotExists(santos)

		elAleph = repoLibros.createIfNotExists(elAleph)
		noHabraMasPenas = repoLibros.createIfNotExists(noHabraMasPenas)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "100 años de soledad"
				autor = "Gabriel García Márquez"
			])
		novelaPeron = repoLibros.createIfNotExists(novelaPeron)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "¿Por quién doblan las campanas?"
				autor = "Ernest Hemingway"
			])

		val elAlephASantos = crearPrestamo(elAleph, santos)
		elAleph.prestar(elAlephASantos)
		repoLibros.update(elAleph)
		repoPrestamos.createWhenNew(elAlephASantos)
		
		val noHabraAMedina = crearPrestamo(noHabraMasPenas, medina)
		noHabraMasPenas.prestar(noHabraAMedina)
		repoLibros.update(noHabraMasPenas)
		repoPrestamos.createWhenNew(noHabraAMedina)
		
		val novelaASantos = crearPrestamo(novelaPeron, santos)
		novelaPeron.prestar(novelaASantos)
		repoLibros.update(novelaPeron)
		repoPrestamos.createWhenNew(novelaASantos)
	}
	
	def crearPrestamo(Libro _libro, Usuario _usuario) {
		return new Prestamo => [
			libro = _libro
			usuario = _usuario
		]
	}

}
