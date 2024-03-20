import 'package:shared_preferences/shared_preferences.dart';
import 'camionero.dart';

class ListaCamioneros {
  List<Camionero> data = [];

  Camionero toCamionero(String cod) {
    List res = cod.split("|");
    Camionero c = Camionero(
        nombres: res[0], apellidos: res[1], curp: res[2], licencia: res[3]);
    return c;
  }

  Future<bool> guardarDatos() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    data.forEach((element) {
      buffer.add(element.toString());
    });
    almacen.setStringList("buffer", buffer);
    return true;
  }

  Future cargarDatos() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    buffer = almacen.getStringList("buffer") ?? [];
    data.clear();
    buffer.forEach((element) {
      data.add(toCamionero(element));
    });
  }

  Future<bool> borrarAlmacen() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    almacen.remove("buffer");
    data.clear();
    return true;
  }

  void nuevo(Camionero camionero){
    data.add(camionero);
  }

  void actualizar(Camionero ca,int pos){
    data[pos] = ca;
  }

  void eliminar(int pos){
    data.removeAt(pos);
  }
}