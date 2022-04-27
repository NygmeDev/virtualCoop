import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_coop/src/models/contactos_model.dart';
import 'package:virtual_coop/src/models/cuenta_cliente_model.dart';
import 'package:virtual_coop/src/models/ingresar_transferencia_directa.dart';
import 'package:virtual_coop/src/models/validar_saldo_disponible_model.dart';
import 'package:virtual_coop/src/providers/combo_transferencias_service.dart';
import 'package:virtual_coop/src/providers/transferencia_service.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

import 'package:virtual_coop/src/utils/colores.dart';

import 'package:virtual_coop/src/utils/utils.dart' as utils;
import 'package:virtual_coop/src/widgets/dropdown_virtualcoop.dart';
import 'package:virtual_coop/src/widgets/header_page.dart';
import 'package:virtual_coop/src/widgets/modal_confirmacion_transferencia.dart';
import 'package:virtual_coop/src/widgets/modal_confirmation_code.dart';
import 'package:virtual_coop/src/widgets/modal_contactos.dart';
import 'package:virtual_coop/src/widgets/mostrar_snackbar.dart';
import 'package:virtual_coop/src/widgets/text_field_virtual_coop.dart';

class TransferenciasInternasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransferenciasInternasPage();
  }
}

class _TransferenciasInternasPage extends State<TransferenciasInternasPage> {
  Colores colores = new Colores();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final combosTransaccionesService = new ComboTransaccionesClienteService();
  final transferenciaService = new TransferenciaService();
  final prefs = PreferenciasUsuario();

  TextEditingController montoController = new TextEditingController();
  TextEditingController cedulaController = new TextEditingController();
  TextEditingController conceptoController = new TextEditingController();

  GlobalKey<FormFieldState> keyCuentaOrigen = new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> keyCuentaDestinoPropia =
      new GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> keyCuentaDestinoTerceros =
      new GlobalKey<FormFieldState>();

  int _pickedDestino = 0;
  String valueCuenta = "";
  String valueCuentaPropia = "";
  String valueCuentaTerceros = "";
  String nombreContacto = "";

  bool validado = true;
  bool cargando = true;
  bool cargandoBoton = false;
  bool bloquearBoton = false;

  IngresoTransferenciaDirectaModel ingreso =
      new IngresoTransferenciaDirectaModel();

  CuentasClienteModel cuentasDisponibleCliente = new CuentasClienteModel();
  CuentasClienteModel cuentasDisponiblesTerceros = new CuentasClienteModel();

  cargarCombos() async {
    cuentasDisponibleCliente = await combosTransaccionesService
        .consultarCuentasDisponibleCliente(prefs.cedula);
    cargando = false;
    setState(() {});
  }

  cargarComboCuentaTerceros(String cedula) async {
    cuentasDisponiblesTerceros = await combosTransaccionesService
        .consultarCuentasDisponibleTerceros(cedula);
    if (cuentasDisponiblesTerceros.estado != '000') {
      //mostrarSnackbar('La cédula no tiene cuentas', Colors.red, scaffoldKey);
    }
    setState(() {});
  }

  inicializarComboCuentasTerceros() {
    cuentasDisponiblesTerceros.cliente = new Cliente();
    cuentasDisponiblesTerceros.cliente.cuentas = [];
  }

  @override
  void initState() {
    inicializarComboCuentasTerceros();
    cargarCombos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sizeBox = screenSize.height * 0.06;
    final sizeFont = screenSize.height * 0.022;
    final colorFondoInput = Colors.white;
    final colorTexto = colores.texto3;

    final titleStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: screenSize.height * 0.03,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.w600);

    final textStyle = TextStyle(
      color: colores.texto2,
      fontSize: screenSize.height * 0.025,
      fontFamily: 'Helvetica',
    );

    final ButtonStyle buttonStyle = TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: colores.fondo,
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  HeaderPage('Transferencias Directas'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.1),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Origen',
                                    style: titleStyle,
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  nameInput(screenSize, textStyle, 'Monto'),
                                  _crearInputMonto(sizeBox, sizeFont,
                                      colorFondoInput, colorTexto),
                                  nameInput(screenSize, textStyle, 'Cuenta'),
                                  _crearInputCuenta(sizeBox, sizeFont,
                                      colorFondoInput, colorTexto)
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 4,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenSize.height * 0.02),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.1),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Destino',
                                    style: titleStyle,
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.02,
                                  ),
                                  _radioButtonsDestino(screenSize),
                                  _pickedDestino == 0
                                      ? _crearOpcionCuentaPropia(sizeBox,
                                          sizeFont, colorFondoInput, colorTexto)
                                      : _crearOpcionCuentaTerceros(
                                          sizeBox,
                                          sizeFont,
                                          colorFondoInput,
                                          colorTexto,
                                          textStyle,
                                          screenSize,
                                          buttonStyle,
                                        )
                                ],
                              ),
                            ),
                            _crearBoton(context, screenSize),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _crearInputMonto(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
        sizeBox: sizeBox,
        sizeFont: sizeFont,
        colorFondo: colorFondoInput,
        colorTexto: colorTexto,
        controller: montoController,
        margin: EdgeInsets.only(bottom: sizeBox / 2),
        hintText: 'Ej: 99.99',
        keyboardType: TextInputType.number,
        validator: utils.isNumeric);
  }

  Widget _crearInputCuenta(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return DropDownVirtualCoop(
      llave: keyCuentaOrigen,
      indexResponse: false,
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorTexto: colorTexto,
      colorFondo: colorFondoInput,
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      items: cuentasDisponibleCliente.cliente.cuentas
          .map((f) => f.codcta)
          .toList(),
      validator: (value) {
        if (value != null) {
          return true;
        } else {
          return false;
        }
      },
      onChanged: (value) {
        setState(() {
          ingreso.codctad = value;
          valueCuentaPropia = value;
        });
      },
    );
  }

  Widget _radioButtonsDestino(Size screenSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RadioListTile(
          activeColor: Theme.of(context).primaryColor,
          value: 0,
          title: Text('Cuenta Propia'),
          groupValue: _pickedDestino,
          onChanged: (value) {
            setState(() {
              _pickedDestino = value;
              bloquearBoton = false;
            });
          },
        ),
        RadioListTile(
          activeColor: Theme.of(context).primaryColor,
          value: 1,
          title: Text('Cuenta de Terceros'),
          groupValue: _pickedDestino,
          onChanged: (value) {
            setState(() {
              _pickedDestino = value;
              bloquearBoton = false;
            });
          },
        ),
      ],
    );
  }

  Widget _crearOpcionCuentaPropia(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return DropDownVirtualCoop(
      llave: keyCuentaDestinoPropia,
      indexResponse: false,
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorTexto: colorTexto,
      colorFondo: colorFondoInput,
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      items: cuentasDisponibleCliente.cliente.cuentas
          .map((f) => f.codcta)
          .toList(),
      validator: (value) {
        if (value != null) {
          return true;
        } else {
          return false;
        }
      },
      onChanged: (value) {
        print(value);
        if (value == ingreso.codctad) {
          //mostrarSnackbar('No puede seleccionar la misma cuenta dos veces',
          //Colors.red, scaffoldKey);
          setState(() {
            bloquearBoton = true;
          });
        } else {
          setState(() {
            valueCuentaPropia = value;
            bloquearBoton = false;
          });
        }
      },
    );
  }

  Widget _crearOpcionCuentaTerceros(
    double sizeBox,
    double sizeFont,
    Color colorFondoInput,
    Color colorTexto,
    TextStyle textStyle,
    Size screenSize,
    ButtonStyle buttonStyle,
  ) {
    return Column(
      children: <Widget>[
        nombreContacto == ""
            ? SizedBox()
            : nameInput(screenSize, textStyle, nombreContacto),
        _crearInputCedula(
            sizeBox, sizeFont, colorFondoInput, colorTexto, buttonStyle),
        _crearInputCuentas(sizeBox, sizeFont, colorFondoInput, colorTexto),
        nameInput(screenSize, textStyle, 'Por Concepto de:'),
        _crearInputConcepto(sizeBox, sizeFont, colorFondoInput, colorTexto),
      ],
    );
  }

  Widget _crearInputCedula(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto, ButtonStyle buttonStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFieldVirtualCoop(
            sizeBox: sizeBox,
            sizeFont: sizeFont,
            colorFondo: colorFondoInput,
            colorTexto: colorTexto,
            controller: cedulaController,
            margin: EdgeInsets.only(bottom: sizeBox / 2),
            hintText: 'Cédula Identificación',
            keyboardType: TextInputType.number,
            validator: utils.comprobarCedula,
            onFieldSubmitted: cargarComboCuentaTerceros,
          ),
        ),
        SizedBox(
          width: sizeBox * 0.2,
        ),
        _buscarContactos(context, sizeBox, buttonStyle),
      ],
    );
  }

  Widget _crearInputCuentas(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return DropDownVirtualCoop(
      llave: keyCuentaDestinoTerceros,
      indexResponse: false,
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorTexto: colorTexto,
      colorFondo: colorFondoInput,
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      items: cuentasDisponiblesTerceros.cliente.cuentas
          .map((f) => f.codcta)
          .toList(),
      validator: (value) {
        if (value != null) {
          return true;
        } else {
          return false;
        }
      },
      onChanged: (value) {
        print(value);
        setState(() {
          valueCuentaTerceros = value;
        });
      },
    );
  }

  Widget _crearInputConcepto(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
        sizeBox: sizeBox,
        sizeFont: sizeFont,
        colorFondo: colorFondoInput,
        colorTexto: colorTexto,
        controller: conceptoController,
        margin: EdgeInsets.only(bottom: sizeBox / 2),
        validator: utils.comprobarLetrasNumeros);
  }

  Widget _crearBoton(BuildContext context, Size screenSize) {
    return cargandoBoton
        ? CircularProgressIndicator()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2),
            child: ButtonTheme(
              minWidth: double.infinity,
              height: screenSize.height * 0.06,
              child: RaisedButton.icon(
                onPressed: bloquearBoton ? null : _submit,
                elevation: 10.0,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                icon: Icon(Icons.save),
                label: Text(
                  'Guardar',
                  style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w600),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          );
  }

  Widget _buscarContactos(
      BuildContext context, double sizeBox, ButtonStyle buttonStyle) {
    return CircleAvatar(
      radius: sizeBox / 2,
      backgroundColor: Theme.of(context).primaryColor,
      child: IconButton(
        icon: Icon(
          Icons.people_alt,
          color: Colors.white,
        ),
        onPressed: () async {
          Beneficiario beneficiario = await showDialog(
            context: scaffoldKey.currentContext,
            barrierDismissible: true,
            builder: (context) {
              return ModalContactos(
                codcli: prefs.cedula,
                isTransferenciaDirecta: true,
              );
            },
          );

          if (beneficiario != null) {
            this.cedulaController.text = beneficiario.idebnf;
            cargarComboCuentaTerceros(beneficiario.idebnf);
            setState(() {
              nombreContacto = beneficiario.nombnf;
            });
          }
        },
      ),
    );
  }

  Widget nameInput(Size screenSize, TextStyle textStyle, String texto) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: screenSize.width * 0.02),
      margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
      child: Text(
        texto,
        textAlign: TextAlign.left,
        style: textStyle,
      ),
    );
  }

  void limpiarFormulario() async {
    montoController.text = '';
    cedulaController.text = '';
    conceptoController.text = '';
    nombreContacto = '';

    try {
      keyCuentaOrigen.currentState.didChange(null);
      if (_pickedDestino == 0) {
        keyCuentaDestinoPropia.currentState.didChange(null);
      } else {
        keyCuentaDestinoTerceros.currentState.didChange(null);
      }
    } catch (e) {}
  }

  void _submit() async {
    setState(() {
      cargandoBoton = true;
    });
    if (!formKey.currentState.validate() ||
        (ingreso.codctad == null ||
            (valueCuentaPropia == null || valueCuentaTerceros == null))) {
      setState(() {
        cargandoBoton = false;
      });
      return;
    } else {
      ValidarSaldoDisponibleModel saldoDisponible =
          new ValidarSaldoDisponibleModel();
      saldoDisponible.idecl = prefs.cedula;
      saldoDisponible.codctad = ingreso.codctad;
      saldoDisponible.valtrnf = montoController.text;
      saldoDisponible.tiptrnf = "1";

      final tieneSaldoDisponible =
          await transferenciaService.validarSaldoDisponible(saldoDisponible);
      if (tieneSaldoDisponible['estado'] == '000') {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ModalConfirmationCode(
                prefs.cedula,
                onConfirm: (value) async {
                  ingreso.idecl = prefs.cedula;
                  ingreso.codctad = ingreso.codctad;
                  ingreso.valtrnf = montoController.text;
                  ingreso.codctac = _pickedDestino == 0
                      ? valueCuentaPropia
                      : valueCuentaTerceros;
                  ingreso.idemsg = value['idemsg'];
                  ingreso.codseg = value['codseg'];

                  setState(() {
                    cargando = true;
                  });

                  final res = await transferenciaService
                      .ingresarTransferenciaDirecta(ingreso);

                  if (res['estado'] == '000') {
                    Timer(Duration(seconds: 2), () {
                      setState(() {
                        cargando = false;
                      });
                      showDialog(
                          context: scaffoldKey.currentContext,
                          barrierDismissible: false,
                          builder: (context) {
                            return ModalConfirmationTransferencia(
                              res['comprobante'],
                            );
                          });
                    });
                    limpiarFormulario();
                  } else {
                    setState(() {
                      cargando = false;
                    });
                    mostrarSnackbar(res['msg'], Colors.red, scaffoldKey);
                  }
                },
              );
            });
      } else {
        mostrarSnackbar(tieneSaldoDisponible['msg'], Colors.red, scaffoldKey);
      }
    }
    setState(() {
      cargandoBoton = false;
    });
  }
}
