// Definición de la clase Producto con propiedades nombre, precio y stock
class Producto {
    var nombre: String
    var precio: Int
    var stock: Int

    init(nombre: String, precio: Int, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

// Hacer que Producto cumpla con el protocolo Hashable
extension Producto: Hashable {
    static func == (lhs: Producto, rhs: Producto) -> Bool {
        return lhs.nombre == rhs.nombre && lhs.precio == rhs.precio && lhs.stock == rhs.stock
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(nombre)
        hasher.combine(precio)
        hasher.combine(stock)
    }
}

// Función para mostrar los detalles de un producto
func mostrarDetallesProducto(producto: Producto) {
    print("\(producto.nombre) - Precio: $\(producto.precio) - Stock: \(producto.stock)")
}

// Función para mostrar la lista de productos disponibles
func mostrarProductos(productos: [Producto]) {
    print("Artículos disponibles:")
    for (index, producto) in productos.enumerated() {
        print("\(index + 1). ", terminator: "")
        mostrarDetallesProducto(producto: producto)
    }
}

// Función para mostrar el contenido del carrito
func mostrarCarrito(carrito: [Producto]) {
    print("\nCarrito:")
    print("Artículo | Cantidad | Total ")
    let conjuntoCarrito = Set(carrito)
    for producto in conjuntoCarrito {
        let cantidad = carrito.filter { $0.nombre == producto.nombre }.count
        let total = cantidad * producto.precio
        print("\(producto.nombre) |    \(cantidad)     | $\(total)")
    }
}

// Función principal del programa
func main() {
    // Creación de instancias de la clase Producto con nombre, precio y stock
    let pantalon = Producto(nombre: "Pantalón", precio: 500, stock: 10)
    let playera = Producto(nombre: "Playera", precio: 250, stock: 8)
    let zapatos = Producto(nombre: "Zapatos", precio: 400, stock: 5)
    let sombrero = Producto(nombre: "Sombrero", precio: 150, stock: 12)

    // Inicialización de un carrito vacío
    var carrito: [Producto] = []

    // Creación de una lista de productos
    let productos = [pantalon, playera, zapatos, sombrero]

    // Bucle principal del programa
    while true {
        // Mostrar la lista de productos
        mostrarProductos(productos: productos)

        // Mostrar el menú
        print("\nMenú:")
        print("1. Comprar un artículo")
        print("2. Ver carrito")
        print("3. Terminar compra")

        // Leer la opción seleccionada por el usuario
        if let opcion = readLine(), let eleccion = Int(opcion) {
            switch eleccion {
            case 1:
                // Opción para comprar un artículo
                print("Ingrese el número del artículo que desea comprar:")
                if let indiceProducto = readLine(), let indice = Int(indiceProducto), indice > 0, indice <= productos.count {
                    let productoSeleccionado = productos[indice - 1]

                    // Mostrar detalles del producto seleccionado
                    mostrarDetallesProducto(producto: productoSeleccionado)

                    // Preguntar por la cantidad de artículos a comprar
                    print("¿Cuántos artículos desea comprar?")
                    if let cantidadEntrada = readLine(), let cantidad = Int(cantidadEntrada), cantidad > 0, cantidad <= productoSeleccionado.stock {
                        // Agregar productos al carrito y actualizar el stock
                        for _ in 1...cantidad {
                            carrito.append(productoSeleccionado)
                            productoSeleccionado.stock -= 1
                        }
                        print("\(cantidad) \(productoSeleccionado.nombre)(s) agregado(s) al carrito.")
                    } else {
                        print("¡Cantidad no válida!")
                    }
                } else {
                    print("¡Opción no válida!")
                }
            case 2:
                // Opción para ver el carrito
                if !carrito.isEmpty {
                    mostrarCarrito(carrito: carrito)
                } else {
                    print("El carrito está vacío.")
                }
            case 3:
                // Opción para terminar la compra
                if !carrito.isEmpty {
                    var total = 0
                    for producto in carrito {
                        total += producto.precio
                    }

                    // Mostrar el total a pagar
                    print("\nTotal a pagar: $\(total)")

                    // Pago en efectivo
                    print("Ingrese la cantidad en efectivo:")
                    if let efectivoEntrada = readLine(), let efectivo = Int(efectivoEntrada) {
                        if efectivo < total {
                            print("¡Fondos insuficientes! Pago no realizado.")
                        } else {
                            let cambio = efectivo - total
                            print("¡Muchas gracias por tu compra! Tu cambio es de: $\(cambio)")
                            return
                        }
                    } else {
                        print("¡Cantidad no válida!")
                    }
                } else {
                    print("¡El carrito está vacío! No hay nada que comprar.")
                }
            default:
                print("¡Opción no válida!")
            }
            print()  // Añadir un salto de línea al final de cada caso
        } else {
            print("¡Opción no válida!")
        }
    }
}

// Llamar a la función principal para ejecutar el programa
main()