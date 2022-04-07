import 'package:flutter/material.dart';
import 'package:virtual_coop/src/utils/colores.dart';

class ExpansionTileVirtualCoop extends StatefulWidget {
  final String title;
  final List<Widget> children;
  ExpansionTileVirtualCoop({@required this.title, this.children});
  @override
  _ExpansionTileVirtualCoopState createState() =>
      _ExpansionTileVirtualCoopState();
}

class _ExpansionTileVirtualCoopState extends State<ExpansionTileVirtualCoop> {
  bool icon = true;

  final colores = Colores();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ExpansionTile(
      leading: Icon(
        icon ? Icons.add_circle : Icons.remove_circle,
        color: Theme.of(context).primaryColor,
      ),
      title: titleExpansionTile(widget.title, screenSize),
      trailing: SizedBox(),
      children: widget.children,
      onExpansionChanged: (value) {
        setState(() {
          icon = !icon;
        });
      },
    );
  }

  Widget titleExpansionTile(String title, Size screenSize) {
    return Text(
      title,
      style: TextStyle(
          color: colores.texto1,
          fontSize: screenSize.height * 0.025,
          fontFamily: 'Helvetica',
          fontWeight: FontWeight.bold),
    );
  }
}
