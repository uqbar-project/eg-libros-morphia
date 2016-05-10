package ar.edu.librosMorphia.ui

import ar.edu.librosMorphia.appModel.BuscarPrestamos
import ar.edu.librosMorphia.appModel.NuevoPrestamo
import ar.edu.librosMorphia.domain.Prestamo
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BuscarPrestamosWindow extends SimpleWindow<BuscarPrestamos> {
	
	new(WindowOwner parent, BuscarPrestamos model) {
		super(parent, model)
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Préstamo de libros"
		taskDescription = "Estos son los préstamos pendientes"

		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		this.createGridActions(mainPanel)
	}
		
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Agregar un préstamo"
			onClick [ | this.crearPrestamo ]
			setAsDefault
		]
	}
	
	override protected createFormPanel(Panel mainPanel) {
	}

	// *************************************************************************
	// ** RESULTADOS DE LA BUSQUEDA
	// *************************************************************************
	/**
	 * Se crea la grilla en el panel de abajo El binding es: el contenido de la grilla en base a los
	 * resultados de la búsqueda Cuando el usuario presiona Buscar, se actualiza el model, y éste a su vez
	 * dispara la notificación a la grilla que funciona como Observer
	 */
	def protected createResultsGrid(Panel mainPanel) {
		var table = new Table<Prestamo>(mainPanel, typeof(Prestamo)) => [
			numberVisibleRows = 10
			width = 650
			items <=> "prestamos"
			value <=> "prestamoSeleccionado"
		]
		this.describeResultsGrid(table)
	}

	/**
	 * Define las columnas de la grilla Cada columna se puede bindear 1) contra una propiedad del model, como
	 * en el caso del número o el nombre 2) contra un transformer que recibe el model y devuelve un tipo
	 * (generalmente String), como en el caso de Recibe Resumen de Cuenta
	 *
	 * @param table
	 */
	def void describeResultsGrid(Table<Prestamo> table) {
		new Column<Prestamo>(table) => [
			title = "Libro"
			fixedSize = 150
			bindContentsToProperty("libro")
		]

		new Column<Prestamo>(table) => [
			title = "Usuario"
			fixedSize = 200
			bindContentsToProperty("usuario")
		]
	}

	def void createGridActions(Panel mainPanel) {
		val actionsPanel = new Panel(mainPanel)
		actionsPanel.setLayout(new HorizontalLayout)
		val elementSelected = new NotNullObservable("prestamoSeleccionado")
		
		new Button(actionsPanel) => [
			caption = "Devolver"
			onClick [ | modelObject.devolver ]
			bindEnabled(elementSelected)
		]
	}
	
	def void crearPrestamo() {
		this.openDialog(new NuevoPrestamoDialog(this, new NuevoPrestamo))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|
			modelObject.buscar
		]
		dialog.open
	}
		
}