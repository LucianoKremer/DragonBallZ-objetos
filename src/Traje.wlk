
class Traje {
	var desgaste = 0
	
	method validarUso() {
		desgaste += 5
		if(desgaste >= 100)
		{
			self.trajeEstaDesgastado()
		}		
	}
	
	method trajeEstaDesgastado(){
		self.error("Traje no apto para su uso, desgaste total")
	}
	
	method amortiguacion(unPotencialOfensivo){
		self.validarUso()
		return 0
	}
	
	method experienciaBonificada(unValor) =  unValor
	
}

class Comun inherits Traje {
	var resistencia
	
	override method amortiguacion(unPotencialOfensivo){
		super(unPotencialOfensivo)
		return unPotencialOfensivo * resistencia / 100
	}
	
}

class Entrenamiento inherits Traje {
	var bonusExperiencia = 100
	
	override method experienciaBonificada(unValor) = unValor * ( 1 + bonusExperiencia / 100 )
	
}

class Modularizado inherits Traje {
	
	const piezas = []
	
	override method amortiguacion(unPotencialOfensivo){
		super(unPotencialOfensivo)
		return self.resistencia()
	}
	
	method resistencia() = piezas.sum{ pieza => pieza.resistenciaEfectiva()}
	
	override method validarUso(){
		piezas.forEach { pieza => pieza.usarse()}
		if(self.todasLasPiezasEstanDesgastadas()){
			self.trajeEstaDesgastado()
		}
	}
	
	method todasLasPiezasEstanDesgastadas() = piezas.all { pieza => pieza.estaGastada() }
	
	override method experienciaBonificada(unValor) = unValor * ( 1 + self.tasaUtilizable() )
	
	method tasaUtilizable() = self.cantidadDePiezasUsables() / self.cantidadDePiezas()
	
	method cantidadDePiezasUsables() = piezas.count { pieza => not pieza.estaGastada()}
	
	method cantidadDePiezas() = piezas.size()
	
}

class Pieza {
	var resistencia
	var desgaste = 0
	
	method estaGastada() = desgaste >= 20
	
	method usarse() {
		desgaste += 5
	}
	
	method resistenciaEfectiva(){
		if(not self.estaGastada()){
			return resistencia
		}else{
			return 0
		}
	}
	
}