import 'package:flutter/material.dart';
import 'package:virtual_coop/src/models/contactos_model.dart';
import 'package:virtual_coop/src/providers/contactos_service.dart';

class ModalContactos extends StatefulWidget {
  final String codcli;
  final bool isTransferenciaDirecta;

  const ModalContactos({
    Key key,
    this.codcli,
    this.isTransferenciaDirecta = false,
  }) : super(key: key);

  @override
  State<ModalContactos> createState() => _ModalContactosState();
}

class _ModalContactosState extends State<ModalContactos> {
  final contactoService = new ContactoService();
  var contacto;
  ContactosModel contactos;

  cargarContactos() async {
    contactos = await contactoService.consultarContactos(
      widget.codcli,
      widget.isTransferenciaDirecta,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargarContactos();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      contentPadding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.0025,
          vertical: screenSize.height * 0.025),
      title: Text(
        'Lista de Contactos',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Helvetica',
          fontSize: screenSize.height * 0.025,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Container(
        height: screenSize.height * 0.7,
        width: screenSize.width * 1,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Theme.of(context).primaryColor,
          ),
          physics: BouncingScrollPhysics(),
          itemCount: contactos == null ? 0 : contactos.beneficiario.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
              ),
              child: Contacto(
                screenSize: screenSize,
                beneficiario: contactos.beneficiario[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Contacto extends StatelessWidget {
  const Contacto({
    Key key,
    @required this.screenSize,
    @required this.beneficiario,
  }) : super(key: key);

  final Size screenSize;
  final Beneficiario beneficiario;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, beneficiario);
      },
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.00,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.02,
                    vertical: screenSize.width * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenSize.width * 0.6,
                        margin:
                            EdgeInsets.only(bottom: screenSize.height * 0.01),
                        child: Text(
                          beneficiario.nombnf,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: screenSize.height * 0.018,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width * 0.6,
                        margin:
                            EdgeInsets.only(bottom: screenSize.height * 0.01),
                        child: Text(
                          beneficiario.nomifi,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: screenSize.height * 0.016,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width * 0.6,
                        child: Text(
                          "${beneficiario.codcta} - ${beneficiario.destcu}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: screenSize.height * 0.016,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Icon(
              Icons.chevron_right,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
