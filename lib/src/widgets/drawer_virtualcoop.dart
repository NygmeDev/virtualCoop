import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:virtual_coop/src/images/drawerLogo.dart';
import 'package:virtual_coop/src/images/logoHorizontal.dart';
import 'package:virtual_coop/src/models/menu_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';
import 'package:virtual_coop/src/utils/colores.dart';

class DrawerVirtualCoop extends StatelessWidget {
  final Function(int) onTapItem;

  final prefs = PreferenciasUsuario();
  final colores = Colores();

  DrawerVirtualCoop({@required this.onTapItem});
  @override
  Widget build(BuildContext context) {
    final itemsMenu = menuModelFromJson(prefs.menu);
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05),
                    child: AspectRatio(
                      aspectRatio: 6 / 2,
                      child: DrawerLogo(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01),
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        prefs.nombre,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: screenSize.height * 0.03),
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.only(top: screenSize.height * 0.005),
              children: _listaItems(itemsMenu, context, screenSize),
            )),
            cerrarSesion(screenSize),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            footer(screenSize)
          ],
        ),
      ),
    );
  }

  List<Widget> _listaItems(
      List<MenuModel> data, BuildContext context, Size screenSize) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      if (opt.id >= 0) {
        final widgetTemp = opt.id == 0
            ? title(opt.texto, opt.dev, screenSize)
            : itemMenu(opt.texto, opt.id, screenSize);
        opciones.add(widgetTemp);
      }
    });
    return opciones;
  }

  Widget title(String texto, bool dev, Size screenSize) {
    return Container(
      margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
      padding: EdgeInsets.only(
          left: screenSize.width * 0.04, right: screenSize.width * 0.01),
      color: colores.fondo,
      height: screenSize.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            texto,
            style: TextStyle(
                fontSize: screenSize.height * 0.028,
                color: colores.texto1,
                fontFamily: 'Helvetica'),
          ),
          Spacer(
            flex: 5,
          ),
          Container(
            child: dev
                ? Text(
                    'Próximamente',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.width * 0.03),
                  )
                : SizedBox(),
            padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.005,
                horizontal: screenSize.width * 0.01),
            decoration: BoxDecoration(
                color: dev ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
          ),
        ],
      ),
    );
  }

  Widget itemMenu(String texto, int id, Size screenSize) {
    return InkWell(
      onTap: () {
        onTapItem(id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
        padding: EdgeInsets.only(left: screenSize.width * 0.06),
        child: Text(
          texto,
          style: TextStyle(
              fontSize: screenSize.height * 0.028,
              color: colores.texto2,
              fontFamily: 'Helvetica'),
        ),
      ),
    );
  }

  Widget cerrarSesion(Size screenSize) {
    return Builder(builder: (context) {
      return RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
        onPressed: () {
          if (prefs.puedeUsarHuella && !prefs.huella) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Acceso con Huella'),
                      content: Text('¿Quieres ingresar con tu huella?'),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              prefs.huella = true;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'login', (Route<dynamic> route) => false);
                            },
                            child: Text("Si")),
                        FlatButton(
                            onPressed: () {
                              prefs.username = '';
                              prefs.huella = false;
                              prefs.cedula = '';
                              prefs.nombre = '';
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'login', (Route<dynamic> route) => false);
                            },
                            child: Text("No")),
                      ],
                    ));
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'login', (Route<dynamic> route) => false);
          }
        },
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          'CERRAR SESIÓN',
          style: TextStyle(
            fontSize: screenSize.height * 0.025,
            color: Colors.white,
            letterSpacing: 1,
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }

  Widget footer(Size screenSize) {
    return FutureBuilder(
      //future: menuProvider.cargarContacto(),
      initialData: '',
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
          child: Column(
            children: <Widget>[
              AspectRatio(aspectRatio: 9 / 2, child: LogoHorizontal()),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Contacto: ',
                  style: TextStyle(
                      fontSize: screenSize.height * 0.02,
                      color: colores.texto2,
                      fontFamily: 'Helvetica'),
                ),
                TextSpan(
                  text: snapshot.data,
                  style: TextStyle(
                      fontSize: screenSize.height * 0.02,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica'),
                )
              ]))
            ],
          ),
        );
      },
    );
  }
}
