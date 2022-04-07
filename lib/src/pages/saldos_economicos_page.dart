import 'package:flutter/material.dart';
import 'package:virtual_coop/src/models/estado_economico_model.dart';
import 'package:virtual_coop/src/pages/amortizacion_page.dart';
import 'package:virtual_coop/src/pages/cuenta_ahorros_page.dart';
import 'package:virtual_coop/src/providers/estado_economico_service.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

import 'package:virtual_coop/src/utils/colores.dart';
import 'package:virtual_coop/src/widgets/expansion_tile_virtualcoop.dart';
import 'package:virtual_coop/src/widgets/header_page.dart';

class SaldosEconomicosPage extends StatefulWidget {
  @override
  _SaldosEconomicosPageState createState() => _SaldosEconomicosPageState();
}

class _SaldosEconomicosPageState extends State<SaldosEconomicosPage> {
  final Colores colores = new Colores();

  final prefs = PreferenciasUsuario();

  final estadoEconomicoService = new EstadoEconomicoService();

  EstadoEconomicoModel estadoEconomicoModel = EstadoEconomicoModel();

  void cargarEstadoEconomicoModel() async {
    final estadoEconomicoModelAux =
        await estadoEconomicoService.consultarEstadoEconomico(prefs.cedula);
    setState(() {
      estadoEconomicoModel = estadoEconomicoModelAux;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarEstadoEconomicoModel();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: Column(
        children: <Widget>[
          HeaderPage('Saldos Económicos'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                ExpansionTileVirtualCoop(
                  title: 'Captaciones',
                  children: <Widget>[
                    _TableEstadoEconomicoCuentas(estadoEconomicoModel.cuentas)
                  ],
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 4,
                  height: 0,
                ),
                ExpansionTileVirtualCoop(
                  title: 'Inversiones',
                  children: <Widget>[
                    _TableEstadoEconomicoInversiones(
                        estadoEconomicoModel.inversiones)
                  ],
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 4,
                  height: 0,
                ),
                ExpansionTileVirtualCoop(
                  title: 'Créditos',
                  children: <Widget>[
                    _TableEstadoEconomicoCreditos(
                        estadoEconomicoModel.creditos),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableEstadoEconomicoCuentas extends StatelessWidget {
  final List<Cuenta> estadoEconomico;
  final colores = Colores();

  _TableEstadoEconomicoCuentas(this.estadoEconomico);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final styleHeader = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: screenSize.height * 0.02,
      color: colores.texto1,
    );
    List<DataRow> rows = [];
    if (estadoEconomico != null) {
      rows.addAll(estadoEconomico
          .map((e) => DataRow(
                cells: [
                  DataCell(Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text(e.desdep), Text(e.codcta)],
                  )),
                  DataCell(
                      Text(double.parse(e.salcnt.trim()).toStringAsFixed(2))),
                  DataCell(
                      Text(double.parse(e.saldis.trim()).toStringAsFixed(2))),
                  DataCell(Text(
                      '${(double.parse(e.saldis) * 100 / double.parse(e.salcnt)).toStringAsFixed(2)}')),
                  DataCell(IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CuentaAhorroPage(e.codcta)));
                      },
                      icon: Icon(Icons.event_note))),
                ],
              ))
          .toList());

      double totalCaptacionesMonto = 0;
      double totalCaptacionesDisponible = 0;
      estadoEconomico.forEach(
          (element) => totalCaptacionesMonto += double.parse(element.salcnt));
      estadoEconomico.forEach((element) =>
          totalCaptacionesDisponible += double.parse(element.saldis));

      rows.add(DataRow(cells: [
        DataCell(Container(
          child: Text('SubTotal', style: styleHeader),
          alignment: Alignment.center,
        )),
        DataCell(Text('${totalCaptacionesMonto.toStringAsFixed(2)}',
            style: styleHeader)),
        DataCell(Text('${totalCaptacionesDisponible.toStringAsFixed(2)}',
            style: styleHeader)),
        DataCell(Text(
            '${(totalCaptacionesDisponible * 100 / totalCaptacionesMonto).isNaN ? 0 : (totalCaptacionesDisponible * 100 / totalCaptacionesMonto).toStringAsFixed(2)}%',
            style: styleHeader)),
        DataCell(Container())
      ]));
    }

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: screenSize.height * 0.03,
          columnSpacing: 15,
          columns: [
            DataColumn(label: Text('', style: styleHeader)),
            DataColumn(label: Text('Valor', style: styleHeader)),
            DataColumn(label: Text('Disponible', style: styleHeader)),
            DataColumn(label: Text('%', style: styleHeader)),
            DataColumn(
                label: Text('Ver Movimiento',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: rows,
        ));
  }
}

class _TableEstadoEconomicoInversiones extends StatelessWidget {
  final List<Inversione> estadoEconomico;
  final colores = new Colores();

  _TableEstadoEconomicoInversiones(this.estadoEconomico);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final styleHeader = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: screenSize.height * 0.02,
      color: colores.texto1,
    );

    List<DataRow> rows = [];

    if (estadoEconomico != null) {
      rows.addAll(estadoEconomico
          .map((e) => DataRow(cells: [
                DataCell(Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text(e.destin), Text(e.codinv)],
                )),
                DataCell(
                  Container(
                    child: Text(
                        double.parse(e.salcnt.trim()).toStringAsFixed(2),
                        textAlign: TextAlign.right),
                    alignment: Alignment.centerRight,
                  ),
                ),
                DataCell(Text(double.parse(e.saldis.trim()).toStringAsFixed(2),
                    textAlign: TextAlign.right)),
                DataCell(Text(
                    '${(double.parse(e.saldis) * 100 / double.parse(e.salcnt)).toStringAsFixed(2)}',
                    textAlign: TextAlign.right)),
              ]))
          .toList());

      double totalInversionesMonto = 0;
      double totalInversionesDisponible = 0;
      estadoEconomico.forEach(
          (element) => totalInversionesMonto += double.parse(element.salcnt));
      estadoEconomico.forEach((element) =>
          totalInversionesDisponible += double.parse(element.saldis));

      rows.add(DataRow(cells: [
        DataCell(Container(
          child: Text('SubTotal', style: styleHeader),
          alignment: Alignment.center,
        )),
        DataCell(Text('${totalInversionesMonto.toStringAsFixed(2)}',
            style: styleHeader)),
        DataCell(Text('${totalInversionesDisponible.toStringAsFixed(2)}',
            style: styleHeader)),
        DataCell(Text(
            '${(totalInversionesDisponible * 100 / totalInversionesMonto).isNaN ? 0 : (totalInversionesDisponible * 100 / totalInversionesMonto).toStringAsFixed(2)}%',
            style: styleHeader)),
      ]));
    }

    return Container(
      child: DataTable(
          horizontalMargin: 0,
          columns: [
            DataColumn(
                label: Text(
              '',
              style: styleHeader,
            )),
            DataColumn(label: Text('Valor', style: styleHeader)),
            DataColumn(label: Text('Saldo', style: styleHeader)),
            DataColumn(label: Text('%', style: styleHeader)),
          ],
          rows: rows),
    );
  }
}

class _TableEstadoEconomicoCreditos extends StatelessWidget {
  final List<Credito> estadoEconomico;
  final colores = new Colores();

  _TableEstadoEconomicoCreditos(this.estadoEconomico);

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    final screenSize = MediaQuery.of(context).size;
    final styleHeader = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: screenSize.height * 0.02,
        color: colores.texto1);

    if (estadoEconomico != null) {
      rows.addAll(estadoEconomico
          .map((e) => DataRow(cells: [
                DataCell(Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text(e.destcr), Text(e.codcrd)],
                )),
                DataCell(Text(
                  double.parse(e.mntcap.trim()).toStringAsFixed(2),
                  textAlign: TextAlign.right,
                )),
                DataCell(Text(double.parse(e.salcap.trim()).toStringAsFixed(2),
                    textAlign: TextAlign.right)),
                DataCell(Text(
                    '${(double.parse(e.mntcap) * 100 / double.parse(e.salcap)).toStringAsFixed(2)}',
                    textAlign: TextAlign.right)),
                DataCell(IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AmortizacionPage(e.codcrd)));
                    },
                    icon: Icon(Icons.event_note))),
              ]))
          .toList());

      double totalCreditosMonto = 0;
      double totalCreditosDisponible = 0;
      estadoEconomico.forEach(
          (element) => totalCreditosMonto += double.parse(element.mntcap));
      estadoEconomico.forEach(
          (element) => totalCreditosDisponible += double.parse(element.salcap));

      rows.add(DataRow(cells: [
        DataCell(Container(
          child: Text('SubTotal', style: styleHeader),
          alignment: Alignment.center,
        )),
        DataCell(Text('${totalCreditosMonto.toStringAsFixed(2)}',
            style: styleHeader)),
        DataCell(Text('${totalCreditosDisponible.toStringAsFixed(2)}',
            style: styleHeader)),
        DataCell(Text(
            '${(totalCreditosDisponible * 100 / totalCreditosMonto).isNaN ? 0 : (totalCreditosDisponible * 100 / totalCreditosMonto).toStringAsFixed(2)}%',
            style: styleHeader)),
        DataCell(Container()),
      ]));
    }

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columnSpacing: 20,
            columns: [
              DataColumn(label: Text('', style: styleHeader)),
              DataColumn(label: Text('Valor', style: styleHeader)),
              DataColumn(label: Text('Saldo', style: styleHeader)),
              DataColumn(label: Text('%', style: styleHeader)),
              DataColumn(label: Text('Ver Movimiento', style: styleHeader)),
            ],
            rows: rows));
  }
}
