package ar.edu.librosMorphia.ui

import ar.edu.librosMorphia.appModel.NuevoPrestamo
import ar.edu.librosMorphia.domain.Libro
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class NuevoPrestamoDialog extends Dialog<NuevoPrestamo> {

	new(WindowOwner owner, NuevoPrestamo model) {
		super(owner, model)
		title = "Nuevo préstamo"
	}

	override protected createFormPanel(Panel mainPanel) {
		val panelRoles = new Panel(mainPanel) => [
			layout = new ColumnLayout(1)
		]
		new Label(panelRoles) => [
			text = "Usuario"
		]
		new Selector(panelRoles) => [
			width = 300
			items <=> "usuarios"
			value <=> "usuarioSeleccionado"
		]
		
		val panelLibro = new GroupPanel(mainPanel, this.modelObject) => [
			title = "Libro"
		] 
		val panelValoresBusqueda = new Panel(panelLibro)
		panelValoresBusqueda.layout = new HorizontalLayout
		new TextBox(panelValoresBusqueda) => [
			value <=> "libroBusqueda"
			width = 300
		]
		new Button(panelValoresBusqueda) => [
			caption = "Buscar"
			onClick [ | modelObject.buscarLibros ]
		]
		
		val table = new Table<Libro>(panelLibro, typeof(Libro)) => [
			numberVisibleRows = 10
			width = 650
			items <=> "libros"
			value <=> "libroSeleccionado"
		]
		TableColumnBuilder.buildColumn(table, "Titulo", 450, "titulo")
		TableColumnBuilder.buildColumn(table, "Autor", 200, "autor")
		
		val filaAgregar = new Panel(mainPanel)
		new Button(filaAgregar) => [
			caption = "Prestar libro"
			onClick [|
				modelObject.prestar
				this.accept
			]
		]
	}

}
