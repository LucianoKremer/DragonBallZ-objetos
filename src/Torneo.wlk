
class Torneo {
	const potencialesPeleadores = #{}
	
	method peleadoresSegun(unParametro) = potencialesPeleadores.sortedBy (unParametro)
	
	method seleccionDeJugadores() = self.peleadoresSegun(self.closure()).take(16)
	
	method closure()
}

object powerIsBest inherits Torneo{
	override method closure() = { peleadorA, peleadorB => peleadorA.potencialOfensivo() > peleadorB.potencialOfensivo() }
}

object funny inherits Torneo{	
	override method closure() = { peleadorA, peleadorB => peleadorA.cantidadDePiezas() > peleadorB.cantidadDePiezas() }
}

object surprise inherits Torneo{	
	override method closure() = { peleadorA, peleadorB => peleadorA.tirada() > peleadorB.tirada() }
}