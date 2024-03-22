import 'package:dam_u2_ejercicio8/camionero.dart';
import 'package:dam_u2_ejercicio8/listaCamioneros.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: App0208(),
    debugShowCheckedModeBanner: false,
  ));
}

class App0208 extends StatefulWidget {
  const App0208({super.key});

  @override
  State<App0208> createState() => _App0208State();
}

class _App0208State extends State<App0208> {
  bool login = false;

  // Índice de pantallas
  int _index = 0;

  // Controladores
  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final curp = TextEditingController();
  final licencia = TextEditingController();

  // Lista de camioneros
  ListaCamioneros lista = ListaCamioneros();

  // Controladores de login
  final usuario = TextEditingController();
  final contrasena = TextEditingController();

  @override
  void initState() {
    lista.cargarDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return inicio(context);
  }

  Widget inicio(BuildContext context) {
    return (!login) ? loginGUI() : principalGUI(context);
  }

  Scaffold loginGUI() {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.directions_bus),
        centerTitle: true,
      ),
        body: Center(
      child: SizedBox(
        width: 256,
        height: 512,
        child: Column(children: [
          Icon(Icons.person, size: 128, color: Colors.lightBlue.shade900),
          SizedBox(
            height: 32,
          ),
          TextField(
              controller: usuario,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  labelText: "Usuario",
                  suffixIcon: Icon(Icons.account_circle))),
          SizedBox(
            height: 32,
          ),
          TextField(
              obscureText: true,
              controller: contrasena,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  labelText: "Contraseña", suffixIcon: Icon(Icons.lock))),
          SizedBox(
            height: 32,
          ),
          FilledButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.lightBlue.shade900)),
              onPressed: () {
                if (usuario.text == "angel" && contrasena.text == "1234") {
                  setState(() {
                    login = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Inicio de sesión correcto. Bienvenido"),
                    backgroundColor: Colors.green,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Autenticación Incorrecta. Prueba otra vez."),
                    backgroundColor: Colors.deepOrange,
                  ));
                }
              },
              child: Text(
                "Iniciar Sesión",
                style: TextStyle(fontSize: 24),
              ))
        ]),
      ),
    ));
  }

  Scaffold principalGUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camioneros"),
        centerTitle: true,
      ),
      body: dinamico(),
      drawer: Drawer(
        width: 256,
        backgroundColor: Colors.green.shade200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade400),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  child: Text("AG"),
                  radius: 32,
                ),
                Text(
                  "Angel González",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )
              ],
            )),
            itemDrawer(0, Icons.directions_bus_rounded, "CAPTURAR"),
            itemDrawer(1, Icons.list, "MOSTRAR"),
            itemDrawer(2, Icons.delete_outline, "ELIMINAR"),
            itemDrawer(3, Icons.edit, "ACTUALIZAR"),
            itemDrawerWithFunction(() {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text("Cerrar Sesión"),
                    content: Text("Seguro que deseas cerrar la sesión?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              login = false;
                            });
                          },
                          child: Text("Sí")),
                    ]),
              );
            }, Icons.logout, "CERRAR SESION"),
            SizedBox(
              height: 240,
            ),
            itemDrawerWithFunction(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("Borrar"),
                        content: Text(
                            "!Quieres borrar los datos. Esta acción no se puede deshacer"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancelar")),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  lista.borrarAlmacen();
                                  lista.cargarDatos();
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Aceptar")),
                        ],
                      ));
            }, Icons.delete_forever, "BORRAR DATOS"),
            opcionEliminarTodoDrawer(context)
          ],
        ),
      ),
    );
  }

  ListTile opcionEliminarTodoDrawer(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Icon(Icons.delete_forever)),
          Expanded(
            child: Text("Borrar Datos"),
            flex: 4,
          )
        ],
      ),
      onTap: () {},
    );
  }

  Widget dinamico() {
    switch (_index) {
      case 0:
        return capturarGUI();
      case 1:
        return listadoCamioneros();
      case 4:
    }
    return ListView();
  }

  ListView capturarGUI() {
    return ListView(
      padding: EdgeInsets.all(32),
      children: [
        TextField(
          controller: nombres,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.abc), labelText: "Nombres"),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: apellidos,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.abc), labelText: "Apellidos"),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: curp,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.perm_identity), labelText: "CURP"),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: licencia,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.insert_drive_file),
              labelText: "Tipo de licencia"),
        ),
        SizedBox(
          height: 16,
        ),
        FilledButton(
            onPressed: () {
              lista.nuevo(Camionero(
                  nombres: nombres.text,
                  apellidos: apellidos.text,
                  curp: curp.text,
                  licencia: licencia.text));
              lista.guardarDatos();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 750),
                backgroundColor: Colors.lightGreen,
                  content: Text(
                "Insertado con éxito",
              )));
              limpiar();
            },
            child: Text("Registrar"))
      ],
    );
  }

  ListTile itemDrawer(int i, IconData icono, String mensaje) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Icon(icono)),
          Expanded(
            child: Text(mensaje),
            flex: 4,
          )
        ],
      ),
      onTap: () {
        setState(() => _index = i);
        Navigator.pop(context);
      },
    );
  }

  ListTile itemDrawerWithFunction(
      void Function() funcion, IconData icono, String mensaje) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Icon(icono)),
          Expanded(
            child: Text(mensaje),
            flex: 4,
          )
        ],
      ),
      onTap: () {
        Navigator.pop(context);
        funcion();
      },
    );
  }

  void limpiar() {
    var campos = [nombres, apellidos, curp, licencia];
    campos.forEach((element) => element.clear());
  }

  ListView listadoCamioneros() {
    final camioneros = lista.data;
    return ListView.builder(
      itemCount: camioneros.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key(camioneros[index].curp),
        onDismissed: (direction) => setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${camioneros[index].nombres} ha sido eliminado")));
          lista.eliminar(index);
        }),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text("$index"),
            ),
            title: Text(
                "${camioneros[index].curp} ${camioneros[index].apellidos}"),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("CURP: ${camioneros[index].curp}",
                    textAlign: TextAlign.left),
                Text("LICENCIA: ${camioneros[index].licencia}",
                    textAlign: TextAlign.left)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
