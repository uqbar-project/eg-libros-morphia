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
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class NuevoPrestamo {

	List<Usuario> usuarios
	Usuario usuarioSeleccionado
	String libroBusqueda
	List<Libro> libros
	Libro libroSeleccionado
	
	AbstractRepository<Usuario> repoUsuarios = ApplicationContext.instance.getSingleton(typeof(RepoUsuarios))
	AbstractRepository<Libro> repoLibros = ApplicationContext.instance.getSingleton(typeof(RepoLibros))
	AbstractRepository<Prestamo> repoPrestamos = ApplicationContext.instance.getSingleton(typeof(RepoPrestamos))

	new() {
		usuarios = repoUsuarios.allInstances
	}

	def void prestar() {
		val prestamo = new Prestamo => [
			usuario = usuarioSeleccionado
			libro = libroSeleccionado
			validar
		]
		// al estar en memoria solo tengo que agregarlo a la colección
		libroSeleccionado.prestar(prestamo)
		//
		repoPrestamos.create(prestamo)
	}

	def buscarLibros() {
		libros = repoLibros.searchByExample(new Libro => [
			titulo = libroBusqueda
		])
	}	
}
