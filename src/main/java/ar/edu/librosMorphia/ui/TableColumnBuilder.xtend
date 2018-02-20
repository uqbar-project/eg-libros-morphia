package ar.edu.librosMorphia.ui

import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table

class TableColumnBuilder {

	/**
	 * Define las columnas de la grilla Cada columna se puede bindear 1) contra una propiedad del model, como
	 * en el caso del número o el nombre 2) contra un transformer que recibe el model y devuelve un tipo
	 * (generalmente String), como en el caso de Recibe Resumen de Cuenta
	 */
	def static void buildColumn(Table _table, String _title, int _fixedSize, String _bindedField) {
		new Column(_table) => [
			title = _title
			fixedSize = _fixedSize
			bindContentsToProperty(_bindedField)
		]
	}

}
