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
	AbstractRepository<Usuario> repoUsuarios = ApplicationContext.instance.getSingleton(typeof(RepoUsuarios))
	AbstractRepository<Libro> repoLibros = ApplicationContext.instance.getSingleton(typeof(RepoLibros))
	AbstractRepository<Prestamo> repoPrestamos = ApplicationContext.instance.getSingleton(typeof(RepoPrestamos)) 

	override isPending() {
		true
	}

	override run() {
		if (repoPrestamos.count !=0) {
			return
		}
		println("Creando juego de datos")
		
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

		repoUsuarios.create(
			new Usuario => [
				nombre = "Lampone"
				password = "Betun"
			])
		medina = repoUsuarios.createIfNotExists(medina)
		santos = repoUsuarios.create(santos)

		elAleph = repoLibros.create(elAleph)
		noHabraMasPenas = repoLibros.create(noHabraMasPenas)
		repoLibros.create(
			new Libro => [
				titulo = "100 años de soledad"
				autor = "Gabriel García Márquez"
			])
		novelaPeron = repoLibros.create(novelaPeron)
		repoLibros.create(
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

		repoPrestamos.create(elAlephASantos)
		repoPrestamos.create(noHabraAMedina)
		repoPrestamos.create(novelaASantos)
	}

}
