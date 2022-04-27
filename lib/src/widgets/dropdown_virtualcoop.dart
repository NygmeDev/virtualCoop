import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDownVirtualCoop extends StatefulWidget {
  final double sizeBox;
  final double sizeFont;
  final Color colorFondo;
  final Color colorTexto;
  final EdgeInsets margin;
  final List items;
  final String hint;
  final Function(dynamic) onChanged;
  final Function(dynamic) validator;
  final bool indexResponse;
  final GlobalKey<FormFieldState> llave;

  DropDownVirtualCoop(
      {this.sizeBox,
      this.sizeFont,
      this.items,
      this.indexResponse,
      this.llave,
      this.colorFondo,
      this.colorTexto,
      this.margin = EdgeInsets.zero,
      this.hint = '',
      this.onChanged,
      this.validator});
  @override
  _DropDownVirtualCoopState createState() => _DropDownVirtualCoopState();
}

class _DropDownVirtualCoopState extends State<DropDownVirtualCoop> {
  bool isEmpty = true;
  bool isValidate = false;
  dynamic _currentValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.sizeBox,
        margin: widget.margin,
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: isEmpty
              ? null
              : isValidate
                  ? null
                  : Border.all(color: Colors.red),
          color: widget.colorFondo,
        ),
        child: DropdownButtonFormField<dynamic>(
          key: widget.llave,
          isExpanded: true,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          isDense: true,
          hint: Text(widget.hint),
          value: _currentValue,
          icon: AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              child: SvgPicture.asset(
                'assets/img/selected.svg',
              ),
            ),
          ),
          items: widget.items.map((item) {
            return DropdownMenuItem(
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: widget.sizeFont,
                ),
              ),
              value: widget.indexResponse ? widget.items.indexOf(item) : item,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(widget.indexResponse ? value ?? 0 : value ?? '');
            }
          },
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
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
              return null;
            }
          },
        ));
  }
}
