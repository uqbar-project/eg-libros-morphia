package ar.edu.librosMorphia.runnable

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.domain.Usuario
import ar.edu.librosMorphia.repos.AbstractRepository
import ar.edu.librosMorphia.repos.RepoLibros
import ar.edu.librosMorphia.repos.RepoPrestamos
import ar.edu.librosMorphia.repos.RepoUsuarios
import org.uqbar.arena.bootstrap.Bootstrap
import org.uqbar.commons.utils.ApplicationContext

class LibrosBootstrap implements Bootstrap {
	AbstractRepository<Usuario> repoUsuarios = ApplicationContext.instance.getSingleton(typeof(RepoUsuarios))
	AbstractRepository<Libro> repoLibros = ApplicationContext.instance.getSingleton(typeof(RepoLibros))
	RepoPrestamos repoPrestamos = ApplicationContext.instance.getSingleton(typeof(RepoPrestamos)) as RepoPrestamos

	override isPending() {
		true
	}

	override run() {
		if (!repoUsuarios.allInstances.isEmpty) {
			return
		}
		
		val medina = new Usuario => [
			nombre = "Medina"
			password = "Piquito"
		]
		val santos = new Usuario => [
			nombre = "Santos"
			password = "Milazzo"
		]

		val elAleph = new Libro => [
			titulo = "El Aleph"
			autor = "Jorge Luis Borges"
		]
		val noHabraMasPenas = new Libro => [
			titulo = "No habrá más penas ni olvido"
			autor = "Osvaldo Soriano"
		]
		val novelaPeron = new Libro => [
			titulo = "La novela de Perón"
			autor = "Tomás Eloy Martínez"
		]

		val elAlephASantos = new Prestamo => [
			libro = elAleph
			usuario = santos
		]
		elAleph.prestar(elAlephASantos)
		val noHabraAMedina = new Prestamo => [
			libro = noHabraMasPenas
			usuario = medina
		]
		noHabraMasPenas.prestar(noHabraAMedina)
		
		val novelaASantos = new Prestamo => [
			libro = novelaPeron
			usuario = santos
		]
		novelaPeron.prestar(novelaASantos)
		
		repoUsuarios.createIfNotExists(
			new Usuario => [
				nombre = "Lampone"
				password = "Betun"
			])
		repoUsuarios.createIfNotExists(medina)
		repoUsuarios.createIfNotExists(santos)

		repoLibros.createIfNotExists(elAleph)
		repoLibros.createIfNotExists(noHabraMasPenas)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "100 años de soledad"
				autor = "Gabriel García Márquez"
			])
		repoLibros.createIfNotExists(novelaPeron)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "¿Por quién doblan las campanas?"
				autor = "Ernest Hemingway"
			])

		repoPrestamos.createWhenNew(elAlephASantos)
		repoPrestamos.createWhenNew(noHabraAMedina)
		repoPrestamos.createWhenNew(novelaASantos)
	}

}
