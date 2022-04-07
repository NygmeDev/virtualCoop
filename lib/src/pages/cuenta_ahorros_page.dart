import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_coop/src/images/logoHorizontal.dart';
import 'package:virtual_coop/src/models/estado_cuenta_ahorro_model.dart';
import 'package:virtual_coop/src/providers/estado_cuenta_ahorro_service.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';
import 'package:virtual_coop/src/utils/colores.dart';
import 'package:virtual_coop/src/widgets/rich_text_descripcion.dart';
import 'package:virtual_coop/src/widgets/header_page.dart';

class CuentaAhorroPage extends StatefulWidget {
  final String codcrd;

  CuentaAhorroPage(this.codcrd);
  @override
  _CuentaAhorroPageState createState() => _CuentaAhorroPageState();
}

class _CuentaAhorroPageState extends State<CuentaAhorroPage> {
  final estadoCuentaAhorroService = new EstadoCuentaAhorrosService();
  final prefs = PreferenciasUsuario();
  final colores = new Colores();
  EstadoCuentaAhorroModel estadoCuentaAhorroModel =
      new EstadoCuentaAhorroModel();
  bool cargando = true;

  cargarEstadoCuentaAhorroModel() async {
    estadoCuentaAhorroModel = await estadoCuentaAhorroService
        .consultarEstadoCuentaAhorro(prefs.cedula, widget.codcrd);
    cargando = false;
    setState(() {});
  }

  @override
  void initState() {
    cargarEstadoCuentaAhorroModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: colores.fondo,
        appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: new IconThemeData(color: Theme.of(context).primaryColor),
            elevation: 0,
            title: Row(children: <Widget>[
              Container(
                  width: screenSize.width * 0.4,
                  child: LogoHorizontal(
                    color: Theme.of(context).primaryColor,
                  )),
            ])),
        body: cargando
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  HeaderPage('Estado de Cuenta Ahorros'),
                  Expanded(
                    child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          _DescripcionAhorro(estadoCuentaAhorroModel.cuenta),
                          _TablaCuentaAhorros(estadoCuentaAhorroModel.detalle)
                        ]),
                  )
                ],
              ));
  }
}

class _TablaCuentaAhorros extends StatelessWidget {
  final List<Detalle> detalles;
  final colores = new Colores();
  _TablaCuentaAhorros(this.detalles);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    List<DataRow> rows = [];

    if (detalles != null) {
      rows.addAll(detalles
          .map((e) => DataRow(cells: [
                DataCell(Container(
                    child: Text(
                        '${e.fectrn.year}-${e.fectrn.month}-${e.fectrn.day}'))),
                DataCell(Text(e.codcaj.trim())),
                DataCell(Text(e.docnum.trim())),
                DataCell(Text(e.valdeb.trim())),
                DataCell(Text(e.valcre.trim())),
                DataCell(Text(e.saldos.trim())),
              ]))
          .toList());
    }

    final styleHeader = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: screenSize.height * 0.02,
        color: colores.texto1);

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columnSpacing: 30,
            columns: [
              DataColumn(label: Text('Fecha', style: styleHeader)),
              DataColumn(label: Text('Caja', style: styleHeader)),
              DataColumn(label: Text('Detalle', style: styleHeader)),
              DataColumn(label: Text('Retiro', style: styleHeader)),
              DataColumn(label: Text('Deposito', style: styleHeader)),
              DataColumn(label: Text('Saldo', style: styleHeader)),
            ],
            rows: rows));
  }
}

class _DescripcionAhorro extends StatelessWidget {
  final Cuenta cuenta;
  _DescripcionAhorro(this.cuenta);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.03,
          vertical: screenSize.height * 0.02),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: screenSize.width * 0.45,
                  child: RichTextDescripcion(
                      titulo: 'Cuenta', subtitulo: cuenta.codcta)),
              Text(cuenta.desdep)
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: screenSize.width * 0.45,
                  child: RichTextDescripcion(
                      titulo: 'Saldo Cuenta', subtitulo: cuenta.salcnt)),
            ],
          ),
        ],
      ),
    );
  }
}
