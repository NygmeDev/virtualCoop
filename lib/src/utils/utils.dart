RegExp expresionCorreos = new RegExp(
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
RegExp expresionPass = new RegExp(r"^[0-9a-zA-Z]{4,10}$");
RegExp expressionSoloLetras = new RegExp(r"^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+");
RegExp expressionLetrasNumeros = new RegExp(r"^[0-9a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+");
RegExp expressionSoloNumeros = new RegExp(r"^([0-9]+(?:[0-9]*)?|[0-9]+)$");

bool comprobarCorreo(String email) {
  return expresionCorreos.hasMatch(email);
}

bool comprobarContrasenia(String pass) {
  return expresionPass.hasMatch(pass);
}

bool comprobarSoloLetras(String value) {
  return expressionSoloLetras.hasMatch(value);
}

bool comprobarSoloNumeros(String value) {
  for (int i = 0; i < value.length; i++) {
    if (!expressionSoloNumeros.hasMatch(value[i])) return false;
  }
  return true;
}

bool comprobarLetrasNumeros(String value) {
  return expressionLetrasNumeros.hasMatch(value);
}

bool comprobarCampoNoVacio(String value) {
  return value.length != 0 ? true : false;
}

bool comprobarCedula(String cedula) {
  if (cedula.length == 0) return false;
  List<int> multiplicadores = [2, 1, 2, 1, 2, 1, 2, 1, 2];
  int valor = 0;
  try {
    for (int i = 0; i < cedula.length - 1; i++) {
      valor += multiplicadores[i] * int.parse(cedula[i]) >= 10
          ? (multiplicadores[i] * int.parse(cedula[i])) - 9
          : (multiplicadores[i] * int.parse(cedula[i]));
    }
  } catch (e) {
    return false;
  }

  var valorVerificador =
      (valor % 10 == 0 ? valor : valor + 10 - valor % 10) - valor;

  return valorVerificador == int.parse(cedula[9]) ? true : false;
}

List<String> shuffleAbecedario() {
  List<String> abecedario;
  abecedario = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  abecedario.shuffle();
  return abecedario;
}

List<String> shuffleNumeros() {
  List<String> numeros;
  numeros = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  numeros.shuffle();
  return numeros;
}

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}
