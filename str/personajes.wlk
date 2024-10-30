class Entidad{
  var vida
  var danio
  var equipo
  var position
  method equipo() = equipo
  method position() = position
  method cumplirObjetivoInicial()
  method recibirDanio(cantDanio){
    vida -= cantDanio
    if(vida<0){
      self.morir()
    }
  }
  method morir(){
    tablero.borrarEntidad(self)
  }
}

class Personaje inherits Entidad{
  override method cumplirObjetivoInicial(){
    self.irATorreMasCercana()
  }
  method irATorreMasCercana(){
    game.onTick(1000, "movete", {self.moveteHacia(tablero.posicionTorreEnemigaMasCercanaA(self))})
  }
  method irA(unaPosicion){
    game.onTick(1000, "movete", {self.moveteHacia(unaPosicion)})
  }
  method moveteHacia(unaPosicion){
    const proximaPosicion =  self.proximaPosicionHacia(unaPosicion)
    if(position != proximaPosicion and tablero.hayAlgoEn(proximaPosicion)){
      const objetivo = tablero.entidadEn(proximaPosicion)
      if(objetivo.equipo() != equipo){
        self.atacar(tablero.entidadEn(proximaPosicion))
      }
    }
    else{
      position = proximaPosicion
    }
  }
  method proximaPosicionHacia(unaPosicion){
    if (position.x() < unaPosicion.x()){
      return position.right(1)
    }
    else if (position.x() > unaPosicion.x()){
      return position.left(1)
    }
    else if (position.y() < unaPosicion.y()){
      return position.up(1)
    }
    else if (position.y() > unaPosicion.y()){
      return position.down(1)
    }
    else{
      return position
    }
  }
  method atacar(unPersonaje){
    unPersonaje.recibirDanio(danio)
  }
}

class Monje inherits Personaje(vida = 5, danio = 10){
  //puede cambiar de bando a otros, sanar alrededor
  // el equipo es "Rojo" o "Azul"
  method tipo() = "Unidad"
  method image() = "monje"+ equipo.name() +".png"
  method nombre() = "monje"
}
class Infanteria inherits Personaje(vida = 5, danio = 10){
  method tipo() = "Unidad"
  method image() = "infanteria"+ equipo.name() +".png"
  method nombre() = "infanteria"
}
class Arquero inherits Personaje(vida = 5, danio = 10){
  method tipo() = "Unidad"
  method image() = "arquero"+ equipo.name() +".png"
  method nombre() = "arquero"
}
object equipoRojo{
  method name()= "Rojo"
  method contrario() = equipoAzul
}
object equipoAzul{
  method name()= "Azul"
  method contrario() = equipoRojo
}

class Torre inherits Entidad(vida = 50, danio = 10){
  method tipo() = "Torre"
  method image() = "castillo.png"
  override method cumplirObjetivoInicial(){}
}
object marco{
  var property position = game.at(0,0)
  method image() = "marco.png"
}
object tablero{
  const property entidadesActivas = []
  method agregarEntidad(unaEntidad){
    game.addVisual(unaEntidad)
    entidadesActivas.add(unaEntidad)
    unaEntidad.cumplirObjetivoInicial()
  }
  method borrarEntidad(unaEntidad){
    entidadesActivas.remove(unaEntidad)
    game.removeVisual(unaEntidad)
  }
  method torres(equipo) = 
    entidadesActivas.filter({entidad => entidad.tipo() == "Torre" and entidad.equipo() == equipo})

  method torreMasCercanaA(unaPosicion,equipo){
    return self.torres(equipo).min({torre => torre.position().distance(unaPosicion)})
  } 

  method hayAlgoEn(unaPosicion)=
    entidadesActivas.any({entidad => entidad.position() == unaPosicion})

  method entidadEn(unaPosicion) =
    entidadesActivas.find({entidad => entidad.position() == unaPosicion})

  method posicionTorreEnemigaMasCercanaA(unaEntidad){
    //aca se pierde o gana(todavia no funciona)
    if (self.torres(unaEntidad.equipo().contrario()).isEmpty()){
      self.error("gano "+ unaEntidad.equipo().name())
      game.stop()
    }
    return self.torreMasCercanaA(unaEntidad.position(),unaEntidad.equipo().contrario()).position()
  }
}
// class PersonajeRango inherits Personaje{

// }
// class PersonajeMele inherits Personaje{

// }
// class Estructura inherits Entidad{

// }
// object monje2{
//   var property position = game.at(3, 15) 
//   var property image = "monjestandingDownBlue0.png"
// }
// object monje{
//   var equipo = equipoAzul
//   method danio() = 10
//   var position = game.at(5, 5) 
//   method position() = position
//   method fotograma(personaje,pose,direccion,color,numero){
//     return personaje+pose+direccion+color+numero+".png"
//   }
//   method image() = self.fotograma('monje','walking','Down','Red','2')
  
//   method irA(unaPosicion){
//     game.onTick(1000, "movete", {self.moveteHacia(unaPosicion)})
//   }
//   method moveteHacia(unaPosicion){
//     const proximaPosicion =  self.proximaPosicionHacia(unaPosicion)
//     if(position != proximaPosicion and tablero.hayAlgoEn(proximaPosicion)){
//       const objetivo = tablero.entidadEn(proximaPosicion)
//       if(objetivo.equipo() != equipo){
//         self.atacar(tablero.entidadEn(proximaPosicion))
//       }
//     }
//     else{
//       position = proximaPosicion
//     }
//   }
//   method proximaPosicionHacia(unaPosicion){
//     if (position.x() < unaPosicion.x()){
//       return position.right(1)
//     }
//     else if (position.x() > unaPosicion.x()){
//       return position.left(1)
//     }
//     else if (position.y() < unaPosicion.y()){
//       return position.up(1)
//     }
//     else if (position.y() > unaPosicion.y()){
//       return position.down(1)
//     }
//     else{
//       return position
//     }
//   }
//   method atacar(unPersonaje){
//     unPersonaje.recibirDanio(self.danio())
//   }
// }
