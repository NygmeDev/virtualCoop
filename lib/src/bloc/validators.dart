import 'dart:async';
import 'package:virtual_coop/src/utils/utils.dart';

class Validators {
  final validarCedula = StreamTransformer<String, String>.fromHandlers(
      handleData: (cedula, sink) {
    if (cedula.length == 10) {
      if (comprobarCedula(cedula)) {
        sink.add("La cédula es válida");
      } else {
        sink.addError("La cédula es incorrecta");
      }
    } else {
      sink.addError('La cédula debe tener 10 dígitos');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (comprobarContrasenia(password)) {
      sink.add(password);
    } else {
      sink.addError("Contraseña no válida");
    }
  });

  final validarUserName =
      StreamTransformer<String, String>.fromHandlers(handleData: (user, sink) {
    if (comprobarLetrasNumeros(user)) {
      sink.add(user);
    } else {
      sink.addError("Usuario no válido");
    }
  });

  final validarRepeatPassword =
      StreamTransformer<Map<String, String>, String>.fromHandlers(
          handleData: (map, sink) {
    if (map['newPassword'] == map['repeatPassword']) {
      sink.add("Las contraseñas son iguales");
    } else {
      sink.addError("La contraseña no coincide");
    }
  });
}
