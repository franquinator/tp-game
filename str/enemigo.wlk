import personajes.*
import config.*
import tablero.*
object enemigo{
    const property personajes = ["infanteria","arquero","monje"]
    var property maximoTropasEnemigo = 0
    method iniciar(){
        game.onTick(2500, "comportamiento", {self.ponerEnemigoAleatorio()})
    }
    method ponerEnemigoAleatorio(){
        const personaje = personajes.anyOne()
        if(tablero.tropas(equipoRojo).size() < maximoTropasEnemigo){
            if(personaje == "infanteria")
                tablero.agregarEntidad(new Infanteria(position = self.posicionAleatoriaEnemiga() ,equipo = equipoRojo))
            else if(personaje == "arquero")
                tablero.agregarEntidad(new Arquero(position = self.posicionAleatoriaEnemiga() ,equipo = equipoRojo))
            else if(personaje == "monje")
                tablero.agregarEntidad(new Monje(position = self.posicionAleatoriaEnemiga() ,equipo = equipoRojo))
        }   
    }
    method posicionAleatoriaEnemiga(){
        return 	game.at( 
					(12 .. game.width() - 1 ).anyOne(),
					(7..  game.height() - 1).anyOne()
		) 
    }
}