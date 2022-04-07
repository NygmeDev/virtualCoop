import 'package:flutter/material.dart';  
  
void mostrarSnackbar(String mensaje, Color colorAlert, GlobalKey<ScaffoldState> scaffoldKey){
  final snackbar = SnackBar(
    content: Text(mensaje, style: TextStyle(color: Colors.white),),
    duration: Duration(milliseconds: 2000),
    backgroundColor: colorAlert
    
  );

  scaffoldKey.currentState.showSnackBar(snackbar);
}