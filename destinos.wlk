object almacen {
	var property stock = []
	var property bultoMaximo = 0
	method llegarADestino(cosas) {
		stock.addAll(cosas)
	}
	method bultoTotal() {
		return stock.sum({cosa => cosa.bulto()})
	}
	method bultoDisponible() {
		return bultoMaximo - self.bultoTotal()
	}
}