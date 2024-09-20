import cosas.*
import caminos.*
import destinos.*

object camion {
	const property pesoCamion = 1000 
	const pesoMaximo = 2500 
	const property cosas = #{}

	method cargar(unaCosa) {
		cosas.add(unaCosa)
		unaCosa.actualizarCarga()
	}

	method descargar(unaCosa) {
		cosas.remove(unaCosa)
	}

	method todoPesoPar() {
		return cosas.all({cosa => cosa.peso().even()})
	}

	method hayAlgunoQuePesa(peso) {
		return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel) {
		return cosas.filter({cosa => cosa.nivelPeligrosidad() == nivel}).asList().first()
	}

	method pesoTotal() {
		return pesoCamion + self.cargaDelCamion()
	}

	method cargaDelCamion() {
		return cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso() {
		return self.pesoTotal() >= pesoMaximo
	}

	method objetosQueSuperanPeligrosidad(nivel) {
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosaMenosPeligrosa) {
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > cosaMenosPeligrosa.nivelPeligrosidad()})
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		return not self.excedidoDePeso() and self.objetosQueSuperanPeligrosidad(nivelMaximoPeligrosidad).isEmpty()
 	}

	method tieneAlgoQuePesaEntre(min, max) {
		return  cosas.any({cosa => cosa.peso() > min and cosa.peso() < max})
	}

	method cosaMasPesada() {
		return cosas.maxIfEmpty({cosa => cosa.peso()}, {})
	}

	method pesos() {
		return cosas.map({cosa => cosa.peso()})
	}

	method totalBultos() {
		return cosas.sum({cosa => cosa.bulto()})
	}

	method vaciarCamion() {
		cosas.clear()
	}

	method transportar(destino, camino) {
		self.validarPeso()
		self.validarDestino(destino)
		self.validarCamino(camino)
		destino.llegarADestino(cosas)
		self.vaciarCamion()
	}

	method validarPeso() {
		if(self.pesoTotal() > pesoMaximo){
			self.error("El camion esta excedido de peso por " + (self.pesoTotal() - pesoMaximo) + "Kg")
		}
	}

	method validarDestino(destino) {
		if(self.totalBultos() > destino.bultoDisponible()){
			self.error("El transporte nose puede realizar porque no hay suficiente espacio en el almacen")
		}
	}

	method validarCamino(camino) {
		if(not self.puedeCircularEnRuta(camino.nivelDePeligrosidad())){
			self.error("El transporte no se puede realizar porque lo que transporta es demasiado peligroso")
		} else if (self.pesoTotal() > camino.pesoTolerado()){
			self.error("El transporte no se puede realizar porque es demasiado para pasar hacer el camino vecinal")
		}
	}
}

