import 'package:flutter/material.dart';

class RichTextDescripcion extends StatelessWidget {
  
  final titulo;
  final subtitulo;

  RichTextDescripcion({ @required this.titulo, @required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: '$titulo :', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: subtitulo)
        ]
      )
    );
  }
}