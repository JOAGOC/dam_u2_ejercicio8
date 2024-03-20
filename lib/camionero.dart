class Camionero {
  String nombres;
  String apellidos;
  String curp;
  String licencia;

  Camionero({
    required this.nombres,
    required this.apellidos,
    required this.curp,
    required this.licencia,
  });

  String toString() {
    return "$curp|$nombres|$apellidos|$licencia";
  }
}
