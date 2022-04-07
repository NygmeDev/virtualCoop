import 'dart:async';

import 'package:flutter/material.dart';
import 'icon_confirm.dart';

class TextFieldVirtualCoop extends StatefulWidget {
  final double sizeBox;
  final double sizeFont;
  final String hintText;
  final TextEditingController controller;
  final Color colorFondo;
  final Color colorTexto;
  final Function(String) validator;
  final Function(String) onSaved;
  final Function(String) onFieldSubmitted;
  final Function onTap;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon suffixIcon;
  final EdgeInsets margin;

  TextFieldVirtualCoop(
      {@required this.sizeBox,
      @required this.sizeFont,
      this.controller,
      this.colorFondo,
      this.colorTexto,
      this.hintText = '',
      this.validator,
      this.onSaved,
      this.onTap,
      this.onFieldSubmitted,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.suffixIcon,
      this.margin = EdgeInsets.zero});

  @override
  _TextFieldVirtualCoopState createState() => _TextFieldVirtualCoopState();
}

class _TextFieldVirtualCoopState extends State<TextFieldVirtualCoop> {
  bool isEmpty = true;
  bool isValidate = false;
  bool _obscureText = false;

  @override
  void initState() {
    setState(() {
      _obscureText = widget.obscureText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            height: widget.sizeBox,
            margin: widget.margin,
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: widget.colorFondo,
            ),
            child: TextFormField(
              expands: false,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textAlign: TextAlign.left,
              obscureText: _obscureText,
              decoration: InputDecoration(
                errorStyle: TextStyle(height: 0),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: widget.sizeFont,
                  fontWeight: FontWeight.w100,
                  color: widget.colorTexto,
                  fontFamily: 'Helvetica',
                ),
                border: InputBorder.none,
                suffixIcon: isEmpty
                    ? SizedBox()
                    : isValidate
                        ? IconConfirm(isConfirm: true)
                        : IconConfirm(isConfirm: false),
              ),
              onTap: widget.onTap,
              onSaved: widget.onSaved,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: (value) {
                if (widget.validator == null) return null;
                if (widget.validator(value)) {
                  setState(() {
                    isEmpty = false;
                    isValidate = true;
                  });
                  return null;
                } else {
                  setState(() {
                    isEmpty = false;
                    isValidate = false;
                  });
                  return '';
                }
              },
            ),
          ),
        ),
        widget.obscureText
            ? IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  setState(() {
                    _obscureText = false;
                  });
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Timer(
                      Duration(milliseconds: 2000),
                      () => setState(() {
                            _obscureText = true;
                          }));
                })
            : SizedBox()
      ],
    );
  }
}
