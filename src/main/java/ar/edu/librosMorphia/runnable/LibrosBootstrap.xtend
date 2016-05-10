package ar.edu.librosMorphia.runnable

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.domain.Usuario
import ar.edu.librosMorphia.repos.RepoLibros
import ar.edu.librosMorphia.repos.RepoPrestamos
import ar.edu.librosMorphia.repos.RepoUsuarios
import org.uqbar.arena.bootstrap.Bootstrap
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.utils.ApplicationContext

import static extension ar.edu.librosMorphia.repos.RepoHelper.*

class LibrosBootstrap implements Bootstrap {
	CollectionBasedRepo<Usuario> repoUsuarios = ApplicationContext.instance.getSingleton(typeof(RepoUsuarios))
	CollectionBasedRepo<Libro> repoLibros = ApplicationContext.instance.getSingleton(typeof(RepoLibros))
	RepoPrestamos repoPrestamos = ApplicationContext.instance.getSingleton(typeof(RepoPrestamos)) as RepoPrestamos

	override isPending() {
		true
	}

	override run() {
		repoUsuarios.createIfNotExists(
			new Usuario => [
				nombre = "Lampone"
				password = "Betun"
			])
		val medina = new Usuario => [
			nombre = "Medina"
			password = "Piquito"
		]
		repoUsuarios.createIfNotExists(medina)
		val santos = new Usuario => [
			nombre = "Santos"
			password = "Milazzo"
		]
		repoUsuarios.createIfNotExists(santos)
		val elAleph = new Libro => [
			titulo = "El Aleph"
			autor = "Jorge Luis Borges"
		]
		repoLibros.createIfNotExists(elAleph)
		val noHabraMasPenas = new Libro => [
			titulo = "No habrá más penas ni olvido"
			autor = "Osvaldo Soriano"
		]
		repoLibros.createIfNotExists(noHabraMasPenas)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "100 años de soledad"
				autor = "Gabriel García Márquez"
			])
		val novelaPeron = new Libro => [
			titulo = "La novela de Perón"
			autor = "Tomás Eloy Martínez"
		]
		repoLibros.createIfNotExists(novelaPeron)
		repoLibros.createIfNotExists(
			new Libro => [
				titulo = "¿Por quién doblan las campanas?"
				autor = "Ernest Hemingway"
			])

		val elAlephASantos = elAleph.prestar(santos)
		repoPrestamos.createWhenNew(elAlephASantos)
		val noHabraAMedina = noHabraMasPenas.prestar(medina)
		repoPrestamos.createWhenNew(noHabraAMedina)
		val novelaASantos = novelaPeron.prestar(santos) 
		repoPrestamos.createWhenNew(novelaASantos)
	}

}
