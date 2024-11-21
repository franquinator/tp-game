import config.*
import interfazJuego.*
import enemigo.*
object configInterfaz {
  var dificultadSeleccionada = false
  method reiniciar(){
    dificultadSeleccionada = false
  }
  method seleccionarDificultad(){
      keyboard.d().onPressDo({
        self.ponerDificultad(7,5)
      })
      keyboard.f().onPressDo({
        self.ponerDificultad(5,5)
      })
  }
  
  method ponerDificultad(cantEnemigos,cantAliados){
    if(!dificultadSeleccionada){
      dificultadSeleccionada = true
      config.maximoTropas(cantAliados)
      enemigo.maximoTropasEnemigo(cantEnemigos)
      interfaz.cerrarInterfaz()
      juego.iniciarJuego()
      juego.desPausar()
    }
  }
}