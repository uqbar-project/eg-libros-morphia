package ar.edu.librosMorphia.runnable

import ar.edu.librosMorphia.appModel.BuscarPrestamos
import ar.edu.librosMorphia.repos.RepoLibros
import ar.edu.librosMorphia.repos.RepoPrestamos
import ar.edu.librosMorphia.repos.RepoUsuarios
import ar.edu.librosMorphia.ui.BuscarPrestamosWindow
import org.uqbar.arena.Application
import org.uqbar.arena.bootstrap.Bootstrap
import org.uqbar.commons.utils.ApplicationContext

class LibrosApplication extends Application {
	
	new(Bootstrap bootstrap) {
		super(bootstrap)
	}
	
	static def void main(String[] args) {
		ApplicationContext.instance.configureSingleton(typeof(RepoUsuarios), new RepoUsuarios)
		ApplicationContext.instance.configureSingleton(typeof(RepoLibros), new RepoLibros) 
		ApplicationContext.instance.configureSingleton(typeof(RepoPrestamos), new RepoPrestamos)
		new LibrosApplication(new LibrosBootstrap).start()
	}

	override createMainWindow() {
		new BuscarPrestamosWindow(this, new BuscarPrestamos())
	}
	
}