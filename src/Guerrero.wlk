import Traje.*

class Guerrero {
	var potencialOfensivo
	var experiencia
	const energiaOriginal
	var energia = energiaOriginal
	var traje
	
	method atacarA(unGuerrero) {
		unGuerrero.recibirAtaque(self.potencialOfensivo())
	}
	
	method recibirAtaque(unPotencialOfensivo) {
		self.disminuirEnergia(self.potencialEfectivo(unPotencialOfensivo))
		self.validarEstado()
		self.ganarExperiencia(1)
	}
	
	method validarEstado() {
		if(energia <= 0){
			self.error("El guerrero ha muerto")
		}
	}
	
	method disminuirEnergia(unValor) {
		energia -= unValor
	}
	
	method potencialEfectivo(unPotencialOfensivo) = 0.max(unPotencialOfensivo * 0.1 - traje.amortiguacion(unPotencialOfensivo))
	
	method ganarExperiencia(unValor) {
		experiencia += traje.experienciaBonificada(unValor)
	}
	
	method comerSemilla(){
		energia = energiaOriginal
	}
	
	method elegirTraje(unTraje) {
		traje = unTraje
	}
	
	method potencialOfensivo() = potencialOfensivo
	
	method tirada() = (1..100).anyOne()
	
	method cantidadDePiezas() = traje.cantidadDePiezas()
	
}

class Saiyan inherits Guerrero {
	
	var bonusSuperSaiyan = 0
	var property nivel = new Base()
	var bonusSemilla = 0
	
	method convertirse() {
		bonusSuperSaiyan = 50
		nivel.subir(self)
	}
	
	override method potencialOfensivo() = potencialOfensivo * (1 + bonusSuperSaiyan + bonusSemilla)
	
	override method potencialEfectivo(unPotencialOfensivo) = 0.max(unPotencialOfensivo * 0.1 - traje.amortiguacion(unPotencialOfensivo) - nivel.amortiguacion(unPotencialOfensivo))

	override method validarEstado() {
		super()
		if( self.estaMuyDebilitado() ) {
			nivel = new Base()
		}
	}
	
	override method comerSemilla() {
		super()
		bonusSemilla = 5
	}
	
	method estaMuyDebilitado() = energia < energiaOriginal * 0.01
	
}

class Base {
	
	method subir(unSaiyan) {
		unSaiyan.nivel(nivel1)
	}
	
	method aumentoResistencia() = 0
	
	method amortiguacion(unPotencialOfensivo) = unPotencialOfensivo * self.aumentoResistencia() / 100

}

object nivel1 inherits Base {
	
	override method subir(unSaiyan) {
		unSaiyan.nivel(nivel2)
	}
	
	override method aumentoResistencia() = 5
}

object nivel2 inherits Base {
	
	override method subir(unSaiyan) {
		unSaiyan.nivel(nivel3)
	}
	
	override method aumentoResistencia() = 7
	
}

object nivel3 inherits Base {
	
	override method subir(unSaiyan) {
		// nada
	}
	
	override method aumentoResistencia() = 15
	
}

