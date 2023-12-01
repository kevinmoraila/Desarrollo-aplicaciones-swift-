class Banco {
  var saldo: Double = 0

  func depositar() {
      print("Ingrese la cantidad a depositar:")
      if let cantidadString = readLine(), let cantidad = Double(cantidadString) {
          saldo += cantidad
          print("Depósito exitoso. Saldo actual: $\(saldo)")

          // Preguntar si desea realizar otro depósito
          print("¿Desea realizar otro depósito? (Sí/No)")
          if let respuesta = readLine(), respuesta.lowercased() == "no" {
              realizarOtraOperacion()
          } else {
              depositar()
          }
      } else {
          print("Cantidad inválida. Por favor, ingrese un número.")
          depositar()
      }
  }

  func retirar() {
      if saldo == 0 {
          print("Lo siento, no cuenta con saldo para realizar un retiro.")
      } else {
          print("Ingrese la cantidad a retirar:")
          if let cantidadString = readLine(), let cantidad = Double(cantidadString) {
              if cantidad <= saldo {
                  saldo -= cantidad
                  print("Retiro exitoso. Saldo actual: $\(saldo)")
              } else {
                  print("No cuenta con el saldo suficiente para realizar este retiro.")
              }

              // Preguntar si desea realizar otro retiro
              print("¿Desea realizar otro retiro? (Sí/No)")
              if let respuesta = readLine(), respuesta.lowercased() == "no" {
                  realizarOtraOperacion()
              } else {
                  retirar()
              }
          } else {
              print("Cantidad inválida. Por favor, ingrese un número.")
              retirar()
          }
      }
  }

  func mostrarSaldo() {
      print("Su saldo actual es: $\(saldo)")
  }

  func realizarOtraOperacion() {
      // Preguntar si desea realizar otra operación
      print("¿Desea realizar otra operación? (Sí/No)")
      if let respuesta = readLine(), respuesta.lowercased() == "si" {
          mostrarMenu()
      } else {
          print("Gracias por utilizar nuestros servicios. ¡Hasta luego!")
          return
      }
  }

  func mostrarMenu() {
      print("!Bienvenido al Banco UMI!")
      print("Menú:")
      print("1. Depósito")
      print("2. Retiro")
      print("3. Saldo")
      print("4. Salir")
      print("")

      // Leer la opción seleccionada por el usuario
      if let opcionString = readLine(), let opcion = Int(opcionString) {
          switch opcion {
          case 1:
              depositar()
          case 2:
              retirar()
          case 3:
              mostrarSaldo()
              realizarOtraOperacion()
          case 4:
              print("Gracias por utilizar nuestros servicios. ¡Hasta luego!")
              return
          default:
              print("Opción no válida. Por favor, seleccione una opción válida.")
              mostrarMenu()
          }
      } else {
          print("Opción inválida. Por favor, ingrese un número.")
          mostrarMenu()
      }
  }
}

// Iniciar la aplicación
let banco = Banco()
banco.mostrarMenu()