import 'package:dam_u2_ejercicio8/main.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static bool login = false;
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controladores de login
  final usuario = TextEditingController();
  final contrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    if (usuario.text == "angel" && contrasena.text == "1234"){
                      setState(() {
                        Login.login = true;
                      });
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Autenticación Incorrecta. Prueba otra vez.")));
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
}
