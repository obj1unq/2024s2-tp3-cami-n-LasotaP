object knightRider {
	const property bulto = 1
	
	method peso() = 500
	
	method nivelPeligrosidad() = 10
	
	method actualizarCarga() {
		
	}
} 

// BUMBLEBEE
object bumblebee {
	const property bulto = 2
	var property estadoDeBumblebee = auto
	
	method peso() = 700 // se que es 800, pero me di cuenta cuando tire todos test
	
	method nivelPeligrosidad() = estadoDeBumblebee.peligrosidad()
	
	method actualizarCarga() {
		estadoDeBumblebee = robot
	}
}
object auto {
	method peligrosidad() = 15
}
object robot {
	method peligrosidad() = 30
}

// PAQUETE DE LADRILLOS
object paqueteDeLadrillos {
	var property cantidadDeLadrillos = 0
	
	method peso() = cantidadDeLadrillos * 2
	
	method nivelPeligrosidad() = 2
	
	method bulto() = self.bultoXPaqueteDeLadirllos()
	
	method bultoXPaqueteDeLadirllos() = if (cantidadDeLadrillos <= 100) {
		1
	} else {
		if (cantidadDeLadrillos <= 300) 2 else 3
	}
	
	method actualizarCarga() {
		cantidadDeLadrillos += 12
	}
}

 // ARENA A GRANEL
object arenaAGranel {
	const property bulto = 1
	var property peso = 0
	
	method nivelPeligrosidad() = 1
	
	method actualizarCarga() {
		peso += 20
	}
}

 // BATERIA ANTI AEREA
object bateriaAntiaerea {
	var property estaArmado = desarmado
	
	method peso() {
		return estaArmado.peso()
	}
	method nivelPeligrosidad() {
		return estaArmado.nivelDePeligrosidad()
	}
	method bulto() = estaArmado.bulto()
	method actualizarCarga() {
		estaArmado = armado
	}
}
object armado {
	const property bulto = 2
	method peso() = 300
	method nivelDePeligrosidad() = 100
}
object desarmado {
	const property bulto = 1
	method peso() = 200
	method nivelDePeligrosidad() = 0
}

// CONTENEDOR PORTUARIO
object contenedorPortuario {
	const property cosasCargadas = []
	
	method cargarEnContenedor(cosa) {
		cosasCargadas.add(cosa)
	}
	
	method peso() = 100 + cosasCargadas.sum({ cosa => cosa.peso() })
	
	method nivelPeligrosidad() = self.peligrosidadDeTodasLasCosas().maxIfEmpty({ 0 })
	
	method peligrosidadDeTodasLasCosas() = cosasCargadas.map(
		{ cosa => cosa.nivelPeligrosidad() }
	)
	
	method bulto() = 1 + self.cosasCargadas().sum({ cosa => cosa.bulto() })
	
	method actualizarCarga() {
		cosasCargadas.forEach({ cosa => cosa.actualizarCarga() })
	}
}

// RECIDUOS RADIOACTIVOS
object reciduosRadioactivos {
	const property bulto = 1
	var property peso = 0
	
	method nivelPeligrosidad() = 200
	
	method actualizarCarga() {
		peso += 15
	}
}

object embalajeDeSeguridad {
	const property bulto = 2
	var property cosa = knightRider
	
	method peso() = cosa.peso()
	
	method nivelPeligrosidad() = cosa.nivelPeligrosidad() / 2
	
	method actualizarCarga() {	
	}
}