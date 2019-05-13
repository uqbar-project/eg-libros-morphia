package ar.edu.librosMorphia.appModel

import ar.edu.librosMorphia.domain.Libro
import ar.edu.librosMorphia.domain.Prestamo
import ar.edu.librosMorphia.domain.Usuario
import ar.edu.librosMorphia.repos.AbstractRepository
import ar.edu.librosMorphia.repos.RepoLibros
import ar.edu.librosMorphia.repos.RepoPrestamos
import ar.edu.librosMorphia.repos.RepoUsuarios
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class NuevoPrestamo {

	List<Usuario> usuarios
	Usuario usuarioSeleccionado
	String libroBusqueda
	List<Libro> libros
	Libro libroSeleccionado
	
	AbstractRepository<Usuario> repoUsuarios = ApplicationContext.instance.getSingleton(RepoUsuarios)
	AbstractRepository<Libro> repoLibros = ApplicationContext.instance.getSingleton(RepoLibros)
	AbstractRepository<Prestamo> repoPrestamos = ApplicationContext.instance.getSingleton(RepoPrestamos)

	new() {
		usuarios = repoUsuarios.allInstances
	}

	def void prestar() {
		val prestamo = new Prestamo => [
			usuario = usuarioSeleccionado
			libro = libroSeleccionado
			validar
		]
		libroSeleccionado.prestar(prestamo)
		// al estar en memoria solo tengo que agregarlo a la colección
		repoPrestamos.create(prestamo)
		repoLibros.update(libroSeleccionado) // esto ahora es necesario para que quede sincronizado
		//		
	}

	def buscarLibros() {
		libros = repoLibros.searchByExample(new Libro => [
			titulo = libroBusqueda
		])
	}	
}
