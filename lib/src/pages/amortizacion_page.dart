import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_coop/src/images/logoHorizontal.dart';
import 'package:virtual_coop/src/models/amortizacion_model.dart';
import 'package:virtual_coop/src/providers/amortizacion_service.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';
import 'package:virtual_coop/src/utils/colores.dart';
import 'package:virtual_coop/src/utils/utilsFecha.dart';
import 'package:virtual_coop/src/widgets/rich_text_descripcion.dart';
import 'package:virtual_coop/src/widgets/header_page.dart';

import '../../app_config.dart';

class AmortizacionPage extends StatefulWidget {
  final String codcrd;

  AmortizacionPage(this.codcrd);

  @override
  _AmortizacionPageState createState() => _AmortizacionPageState();
}

class _AmortizacionPageState extends State<AmortizacionPage> {
  AmortizacionModel amortizacionModel = new AmortizacionModel();
  final amortizacionService = new AmortizacionService();
  final prefs = PreferenciasUsuario();
  final colores = new Colores();

  bool cargando = true;

  cargarAmortizaciones() async {
    amortizacionModel = await amortizacionService.consultarAmortizacionXCredito(
        prefs.cedula, widget.codcrd);
    cargando = false;
    setState(() {});
  }

  @override
  void initState() {
    cargarAmortizaciones();
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
        title: Row(
          children: <Widget>[
            Container(
                width: screenSize.width * 0.4,
                child: LogoHorizontal(
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ),
      ),
      body: cargando
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  HeaderPage('Tabla Amortización'),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        _CreditoInformacion(amortizacionModel.credito),
                        _TablaAmortizacion(amortizacionModel.cuotas),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _TablaAmortizacion extends StatelessWidget {
  final List<Cuota> cuotas;
  final colores = new Colores();
  _TablaAmortizacion(this.cuotas);

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    final screenSize = MediaQuery.of(context).size;

    if (cuotas != null) {
      rows.addAll(cuotas
          .map((e) => DataRow(cells: [
                DataCell(Container(
                  child: Text(e.numcuo.trim()),
                )),
                DataCell(Container(
                    child: Text(
                        '${e.fecvnc.year}-${e.fecvnc.month}-${e.fecvnc.day}'))),
                DataCell(
                    Text(double.parse(e.valcap.trim()).toStringAsFixed(2))),
                DataCell(
                    Text(double.parse(e.valint.trim()).toStringAsFixed(2))),
                DataCell(
                    Text(double.parse(e.valotr.trim()).toStringAsFixed(2))),
                DataCell(
                    Text(double.parse(e.valcuo.trim()).toStringAsFixed(2))),
                DataCell(
                    Text(double.parse(e.salcuo.trim()).toStringAsFixed(2))),
                DataCell(Text(e.estcuo.trim())),
              ]))
          .toList());

      double totalCapital = 0;
      double totalInteres = 0;
      double totalOtros = 0;
      double totalCuota = 0;
      double totalSaldoCuota = 0;

      cuotas.forEach((element) => totalCapital += double.parse(element.valcap));
      cuotas.forEach((element) => totalInteres += double.parse(element.valint));
      cuotas.forEach((element) => totalOtros += double.parse(element.valotr));
      cuotas.forEach((element) => totalCuota += double.parse(element.valcuo));
      cuotas.forEach(
          (element) => totalSaldoCuota += double.parse(element.salcuo));

      rows.add(DataRow(cells: [
        DataCell(Container(child: Text('Total'))),
        DataCell(Container()),
        DataCell(Text(totalCapital.toStringAsFixed(2))),
        DataCell(Text(totalInteres.toStringAsFixed(2))),
        DataCell(Text(totalOtros.toStringAsFixed(2))),
        DataCell(Text(totalCuota.toStringAsFixed(2))),
        DataCell(Text(totalSaldoCuota.toStringAsFixed(2))),
        DataCell(Container())
      ]));
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
              DataColumn(label: Text('DVD.', style: styleHeader)),
              DataColumn(label: Text('Fec. Vencm', style: styleHeader)),
              DataColumn(label: Text('Capital', style: styleHeader)),
              DataColumn(label: Text('Interes', style: styleHeader)),
              DataColumn(label: Text('Otros', style: styleHeader)),
              DataColumn(label: Text('Cuota', style: styleHeader)),
              DataColumn(label: Text('Saldo Cuota', style: styleHeader)),
              DataColumn(label: Text('Estado', style: styleHeader)),
            ],
            rows: rows));
  }
}

class _CreditoInformacion extends StatelessWidget {
  final Credito credito;

  const _CreditoInformacion(this.credito);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.03,
          vertical: screenSize.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: screenSize.width * 0.45,
                  child: RichTextDescripcion(
                      titulo: 'Crédito', subtitulo: credito.codcrd)),
              RichTextDescripcion(titulo: 'Estado', subtitulo: credito.desecr)
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          Row(
            children: <Widget>[
              Container(
                  width: screenSize.width * 0.45,
                  child: RichTextDescripcion(
                      titulo: 'Fecha Inicio',
                      subtitulo:
                          '${credito.fecini.year}-${credito.fecini.month < 10 ? '0' + credito.fecini.month.toString() : credito.fecini.month}-${credito.fecini.day < 10 ? '0' + credito.fecini.day.toString() : credito.fecini.day}')),
              RichTextDescripcion(
                  titulo: 'Fecha Vencmt',
                  subtitulo:
                      '${credito.fecvnc.year}-${credito.fecvnc.month < 10 ? '0' + credito.fecvnc.month.toString() : credito.fecvnc.month}-${credito.fecvnc.day < 10 ? '0' + credito.fecvnc.day.toString() : credito.fecvnc.day}')
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          Row(
            children: <Widget>[
              Container(
                  width: screenSize.width * 0.45,
                  child: RichTextDescripcion(
                      titulo: 'Monto', subtitulo: credito.mntcap)),
              RichTextDescripcion(
                  titulo: 'Tasa Nominal', subtitulo: credito.tascrd)
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          RichTextDescripcion(
              titulo: 'Plazo',
              subtitulo:
                  '${daysToYear(credito.fecvnc.difference(credito.fecini).inDays)} años ${daysToMonth(credito.fecvnc.difference(credito.fecini).inDays)} meses ${diasRestantes(credito.fecvnc.difference(credito.fecini).inDays)} dias'),
        ],
      ),
    );
  }
}
