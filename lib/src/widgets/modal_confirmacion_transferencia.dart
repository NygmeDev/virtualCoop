import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:virtual_coop/src/images/iconLogin.dart';
import 'package:virtual_coop/src/providers/codigo_seguridad_service.dart';
import 'package:virtual_coop/src/utils/colores.dart';

import '../../app_config.dart';

class ModalConfirmationTransferencia extends StatefulWidget {
  final dynamic confirmacion;
  ModalConfirmationTransferencia(this.confirmacion);

  @override
  _ModalConfirmationTransferenciaState createState() =>
      _ModalConfirmationTransferenciaState();
}

class _ModalConfirmationTransferenciaState
    extends State<ModalConfirmationTransferencia> {
  String idemsg = '';
  final codigoSeguridadService = CodigoSeguridadService();
  final colores = Colores();
  TextEditingController codigoController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final config = AppConfig.of(context);
    final ButtonStyle elevatedButtonStyle = TextButton.styleFrom(
      primary: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.01,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      fixedSize: Size(screenSize.width * 0.5, screenSize.width * 0.1),
      textStyle: TextStyle(
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        fontSize: screenSize.height * 0.02,
        color: Theme.of(context).primaryColor,
      ),
    );
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
        height: screenSize.height * 0.7,
        width: screenSize.width * 0.9,
        child: Column(
          children: [
            InfoTransferencia(
              screenSize: screenSize,
              valorTransferencia: widget.confirmacion['valtrnf'],
              ctaOrigen: widget.confirmacion['ctaorige'],
              ctaDestino: widget.confirmacion['ctadesti'],
              beneficiario: widget.confirmacion['nombenef'],
              comprobante: widget.confirmacion['numcompr'],
              fechaTransferencia: widget.confirmacion['fectrans'],
              institucionFinanciera: widget.confirmacion['insfinan'],
              comentario: widget.confirmacion['dettrnf'],
              flavor: config.flavorName,
            ),
            Spacer(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.share),
                      onPressed: () async {
                        final controller = ScreenshotController();
                        final bytes = await controller.captureFromWidget(
                          Material(
                            child: InfoTransferencia(
                              screenSize: screenSize,
                              valorTransferencia:
                                  widget.confirmacion['valtrnf'],
                              ctaOrigen: widget.confirmacion['ctaorige'],
                              ctaDestino: widget.confirmacion['ctadesti'],
                              beneficiario: widget.confirmacion['nombenef'],
                              comprobante: widget.confirmacion['numcompr'],
                              fechaTransferencia:
                                  widget.confirmacion['fectrans'],
                              institucionFinanciera:
                                  widget.confirmacion['insfinan'],
                              comentario: widget.confirmacion['dettrnf'],
                              flavor: config.flavorName,
                            ),
                          ),
                        );

                        Share.file(
                            "Transferencia Exitosa",
                            "${widget.confirmacion['numcompr']}.png",
                            bytes,
                            "images/png");
                      },
                      label: Text(
                        'Compartir',
                        style: TextStyle(fontSize: screenSize.width * 0.03),
                      ),
                      style: elevatedButtonStyle,
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.05,
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      label: Text(
                        'Salir',
                        style: TextStyle(fontSize: screenSize.width * 0.03),
                      ),
                      style: elevatedButtonStyle,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0),
    );
  }
}

class InfoTransferencia extends StatelessWidget {
  const InfoTransferencia(
      {Key key,
      @required this.screenSize,
      this.valorTransferencia,
      this.ctaOrigen,
      this.ctaDestino,
      this.beneficiario,
      this.institucionFinanciera,
      this.fechaTransferencia,
      this.comprobante,
      this.comentario,
      this.flavor})
      : super(key: key);

  final Size screenSize;
  final String valorTransferencia;
  final String ctaOrigen;
  final String ctaDestino;
  final String beneficiario;
  final String institucionFinanciera;
  final String fechaTransferencia;
  final String comprobante;
  final String comentario;
  final String flavor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.045),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
              aspectRatio: 8 / 2,
              child: IconLogin(
                flavor: this.flavor,
              )),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Transferencia Exitosa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: screenSize.height * 0.022,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          DetalleTransferencia(
            screenSize: screenSize,
            subtitle: 'Has transferido',
            contenido: '\$$valorTransferencia',
          ),
          Divider(),
          DetalleTransferencia(
            screenSize: screenSize,
            subtitle: 'De la cuenta:',
            contenido: '$ctaOrigen',
          ),
          DetalleTransferencia(
            screenSize: screenSize,
            subtitle: 'A la cuenta:',
            contenido: '$ctaDestino',
          ),
          DetalleTransferencia(
            screenSize: screenSize,
            subtitle: 'Beneficiario:',
            contenido: '$beneficiario',
          ),
          DetalleTransferencia(
            screenSize: screenSize,
            subtitle: 'Banco destino:',
            contenido: '$institucionFinanciera',
          ),
          Divider(),
          DetalleTransferencia(
            screenSize: screenSize,
            subtitle: 'Cuando:',
            contenido: '$fechaTransferencia',
          ),
          DetalleTransferencia(
            screenSize: screenSize,
            subtitle: 'Nro. comprobante:',
            contenido: '$comprobante',
          ),
          Divider(),
          Text(
            '$comentario',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: screenSize.height * 0.02,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class DetalleTransferencia extends StatelessWidget {
  const DetalleTransferencia({
    Key key,
    @required this.screenSize,
    @required this.subtitle,
    @required this.contenido,
  }) : super(key: key);

  final Size screenSize;
  final String subtitle;
  final String contenido;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subtitle,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: screenSize.height * 0.018,
              color: Colors.black54,
            ),
          ),
          Container(
            width: screenSize.width * 0.35,
            child: Text(
              contenido,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: screenSize.height * 0.016,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
