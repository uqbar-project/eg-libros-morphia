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

		var elAlephASantos = new Prestamo(elAleph, santos)
		elAleph.prestar(elAlephASantos)
		repoLibros.update(elAleph)
		var noHabraAMedina = new Prestamo(noHabraMasPenas, medina)
		noHabraMasPenas.prestar(noHabraAMedina)
		repoLibros.update(noHabraMasPenas)
		
		var novelaASantos = new Prestamo(novelaPeron, santos)
		novelaPeron.prestar(novelaASantos)
		repoLibros.update(novelaPeron)

		repoPrestamos.createWhenNew(elAlephASantos)
		repoPrestamos.createWhenNew(noHabraAMedina)
		repoPrestamos.createWhenNew(novelaASantos)
	}

}
