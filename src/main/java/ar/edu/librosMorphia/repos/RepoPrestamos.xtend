package ar.edu.librosMorphia.repos

import ar.edu.librosMorphia.domain.Prestamo

class RepoPrestamos extends AbstractRepository<Prestamo> {
	
	override getEntityType() {
		typeof(Prestamo)
	}
	
	override generateWhere(Prestamo example) {
		var filtros = ""
		if (example.libro !== null)
			filtros = filtros + ",{ 'libro.titulo' : '" + example.libro.titulo + "' } "
		if (example.usuario !==null)
			filtros = filtros + ", { 'usuario.nombre' : '" + example.usuario.nombre + "' }"
		"{ $and: [{ 'fechaDevolucion': { $exists: false }}"+ filtros +"  ] }"
	}
	

}
