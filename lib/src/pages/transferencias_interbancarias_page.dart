import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_coop/src/models/contactos_model.dart';
import 'package:virtual_coop/src/models/cuenta_cliente_model.dart';
import 'package:virtual_coop/src/models/ingresar_transferencia_interbancaria_model.dart';
import 'package:virtual_coop/src/models/tipo_cuenta_model.dart';
import 'package:virtual_coop/src/models/tipo_identificacion_model.dart';
import 'package:virtual_coop/src/models/tipo_institucion_financiera_model.dart';
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

class TransferenciasInterBancariasPage extends StatefulWidget {
  final listadoTipoCuenta = [
    {"codigo": "1", "descri": "TRANSFERENCIA INTERBANCARIAS"}
  ];
  @override
  State<StatefulWidget> createState() {
    return _TransferenciasInterBancariasPage();
  }
}

class _TransferenciasInterBancariasPage
    extends State<TransferenciasInterBancariasPage> {
  Colores colores = new Colores();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();

  String _valueInputCuenta;
  String _valueNombreInstitucion;
  String _valueTipoIdentificacion;
  String _valueTipoCuenta;
  String _valueConcepto;

  bool cargando = true;
  bool cargandoBoton = false;

  TextEditingController montoController = new TextEditingController();
  TextEditingController cedulaIdentificacionController =
      new TextEditingController();
  TextEditingController beneficiarioController = new TextEditingController();
  TextEditingController cuentaAcreditarController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  final keyCuentaOrigen = new GlobalKey<FormFieldState>();
  final keyInstitucionBancaria = new GlobalKey<FormFieldState>();
  final keyTipoIdentificacion = new GlobalKey<FormFieldState>();
  final keyTipoCuenta = new GlobalKey<FormFieldState>();
  final keyConcept = new GlobalKey<FormFieldState>();

  CuentasClienteModel cuentasDisponibleCliente = new CuentasClienteModel();
  TipoIdentificacionModel identificacionModel = new TipoIdentificacionModel();
  TipoCuentaModel cuentaModel = new TipoCuentaModel();
  TipoInstitucionFinancieraModel institucionFinancieraModel =
      new TipoInstitucionFinancieraModel();

  final combosTransaccionesService = new ComboTransaccionesClienteService();
  final transferenciaService = new TransferenciaService();

  cargarCombos() async {
    cuentasDisponibleCliente = await combosTransaccionesService
        .consultarCuentasDisponibleCliente(prefs.cedula);
    identificacionModel =
        await combosTransaccionesService.consultarTiposIdentificacion();
    cuentaModel = await combosTransaccionesService.consultarTiposCuenta();
    institucionFinancieraModel =
        await combosTransaccionesService.consultarTipoInstitucionFinanciera();
    cargando = false;
    setState(() {});
  }

  @override
  void initState() {
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
                  HeaderPage('Transferencias Interbancarias'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Container(
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
                                    _crearInputNombreInstitucion(
                                      sizeBox,
                                      sizeFont,
                                      colorFondoInput,
                                      colorTexto,
                                      buttonStyle,
                                    ),
                                    _crearInputTipoIdentificacion(sizeBox,
                                        sizeFont, colorFondoInput, colorTexto),
                                    _crearInputIdentificacion(sizeBox, sizeFont,
                                        colorFondoInput, colorTexto),
                                    _crearInputBeneficiario(sizeBox, sizeFont,
                                        colorFondoInput, colorTexto),
                                    _crearInputTipoCuenta(sizeBox, sizeFont,
                                        colorFondoInput, colorTexto),
                                    _crearInputCuentaAcreditar(sizeBox,
                                        sizeFont, colorFondoInput, colorTexto),
                                    _crearInputConcepto(sizeBox, sizeFont,
                                        colorFondoInput, colorTexto),
                                    _crearInputTelefono(sizeBox, sizeFont,
                                        colorFondoInput, colorTexto),
                                    _crearInputCorreo(sizeBox, sizeFont,
                                        colorFondoInput, colorTexto),
                                    _crearInputDescripcion(sizeBox, sizeFont,
                                        colorFondoInput, colorTexto),
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
          _valueInputCuenta = value;
        });
      },
    );
  }

  Widget _crearInputNombreInstitucion(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto, ButtonStyle buttonStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DropDownVirtualCoop(
            llave: keyInstitucionBancaria,
            indexResponse: true,
            sizeBox: sizeBox * 1.5,
            sizeFont: sizeFont * 0.75,
            colorTexto: colorTexto,
            colorFondo: colorFondoInput,
            hint: "Nombre de Institución",
            margin: EdgeInsets.only(bottom: sizeBox / 2),
            items: institucionFinancieraModel.listado
                // .map((f) => f.descri)
                .map((f) => f.descri ?? '')
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
                _valueNombreInstitucion =
                    institucionFinancieraModel.listado[value].codigo.toString();
              });
            },
          ),
        ),
        SizedBox(
          width: sizeBox * 0.2,
        ),
        _buscarContactos(context, sizeBox, buttonStyle),
      ],
    );
  }

  Widget _crearInputTipoIdentificacion(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return DropDownVirtualCoop(
      llave: keyTipoIdentificacion,
      indexResponse: true,
      sizeBox: sizeBox,
      sizeFont: sizeFont / 2,
      colorTexto: colorTexto,
      colorFondo: colorFondoInput,
      hint: "Tipo de Identificación",
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      items: identificacionModel.listado.map((f) => f.descri).toList(),
      validator: (value) {
        if (value != null) {
          return true;
        } else {
          return false;
        }
      },
      onChanged: (value) {
        setState(() {
          _valueTipoIdentificacion =
              identificacionModel.listado[value].codigo.toString();
        });
      },
    );
  }

  Widget _crearInputIdentificacion(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
        sizeBox: sizeBox,
        sizeFont: sizeFont,
        colorFondo: colorFondoInput,
        colorTexto: colorTexto,
        controller: cedulaIdentificacionController,
        margin: EdgeInsets.only(bottom: sizeBox / 2),
        hintText: 'Cédula Identificación',
        validator: utils.comprobarCampoNoVacio);
  }

  Widget _crearInputBeneficiario(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
        sizeBox: sizeBox,
        sizeFont: sizeFont,
        colorFondo: colorFondoInput,
        colorTexto: colorTexto,
        controller: beneficiarioController,
        margin: EdgeInsets.only(bottom: sizeBox / 2),
        hintText: 'Beneficiario',
        validator: utils.comprobarSoloLetras);
  }

  Widget _crearInputTipoCuenta(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return DropDownVirtualCoop(
      llave: keyTipoCuenta,
      indexResponse: true,
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorTexto: colorTexto,
      colorFondo: colorFondoInput,
      hint: 'Tipo de Cuenta',
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      items: cuentaModel.listado.map((f) => f.descri).toList(),
      validator: (value) {
        if (value != null) {
          return true;
        } else {
          return false;
        }
      },
      onChanged: (value) {
        setState(() {
          _valueTipoCuenta = cuentaModel.listado[value].codigo;
        });
      },
    );
  }

  Widget _crearInputCuentaAcreditar(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorFondo: colorFondoInput,
      colorTexto: colorTexto,
      controller: cuentaAcreditarController,
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      hintText: 'Cuenta a Acreditar',
      validator: utils.isNumeric,
      keyboardType: TextInputType.number,
    );
  }

  Widget _crearInputConcepto(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return DropDownVirtualCoop(
      llave: keyConcept,
      indexResponse: true,
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorTexto: colorTexto,
      colorFondo: colorFondoInput,
      hint: 'Concepto',
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      items: widget.listadoTipoCuenta.map((f) => f["descri"]).toList(),
      validator: (value) {
        if (value != null) {
          return true;
        } else {
          return false;
        }
      },
      onChanged: (value) {
        setState(() {
          _valueConcepto = widget.listadoTipoCuenta[value]["codigo"];
        });
      },
    );
  }

  Widget _crearInputDescripcion(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorFondo: colorFondoInput,
      colorTexto: colorTexto,
      controller: descripcionController,
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      hintText: 'Descripción',
      validator: utils.comprobarCampoNoVacio,
    );
  }

  Widget _crearInputTelefono(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorFondo: colorFondoInput,
      colorTexto: colorTexto,
      controller: telefonoController,
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      hintText: 'Teléfono',
      keyboardType: TextInputType.number,
    );
  }

  Widget _crearInputCorreo(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorFondo: colorFondoInput,
      colorTexto: colorTexto,
      controller: emailController,
      margin: EdgeInsets.only(bottom: sizeBox / 2),
      hintText: 'Correo Electrónico',
      keyboardType: TextInputType.emailAddress,
    );
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
                onPressed: _submit,
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
                isTransferenciaDirecta: false,
              );
            },
          );

          if (beneficiario != null) {
            this.cedulaIdentificacionController.text = beneficiario.idebnf;
            this.beneficiarioController.text = beneficiario.nombnf;
            this.cuentaAcreditarController.text = beneficiario.codcta;
            this.telefonoController.text = beneficiario.bnfcel;
            this.emailController.text = beneficiario.bnfema;

            try {
              keyInstitucionBancaria.currentState.didChange(
                  institucionFinancieraModel.listado.indexWhere(
                      (element) => element.codigo == beneficiario.codifi));
              keyTipoIdentificacion.currentState.didChange(
                  identificacionModel.listado.indexWhere(
                      (element) => element.codigo == beneficiario.codtid));
              keyTipoCuenta.currentState.didChange(cuentaModel.listado
                  .indexWhere(
                      (element) => element.codigo == beneficiario.codtcu));
              keyConcept.currentState.didChange(0);
            } catch (e) {}
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
        ));
  }

  void limpiarFormulario() async {
    montoController.text = '';
    cedulaIdentificacionController.text = '';
    beneficiarioController.text = '';
    cuentaAcreditarController.text = '';
    descripcionController.text = '';
    emailController.text = '';
    telefonoController.text = '';

    try {
      keyCuentaOrigen.currentState.didChange(null);
      keyInstitucionBancaria.currentState.didChange(null);
      keyTipoIdentificacion.currentState.didChange(null);
      keyTipoCuenta.currentState.didChange(null);
      keyConcept.currentState.didChange(null);
    } catch (e) {}
  }

  void _submit() async {
    setState(() {
      cargandoBoton = true;
    });
    if (!formKey.currentState.validate()) {
      setState(() {
        cargandoBoton = false;
      });
      return;
    } else {
      ValidarSaldoDisponibleModel saldoDisponible =
          new ValidarSaldoDisponibleModel();
      saldoDisponible.idecl = prefs.cedula;
      saldoDisponible.codctad = _valueInputCuenta;
      saldoDisponible.valtrnf = montoController.text;
      saldoDisponible.tiptrnf = "2";

      final tieneSaldoDisponible =
          await transferenciaService.validarSaldoDisponible(saldoDisponible);
      if (tieneSaldoDisponible['estado'] == '000') {
        setState(() {
          cargando = true;
        });
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ModalConfirmationCode(
                prefs.cedula,
                onConfirm: (value) async {
                  IngresarTransferenciaInterbancariaModel ingreso =
                      new IngresarTransferenciaInterbancariaModel();
                  ingreso.idecl = prefs.cedula;
                  ingreso.codctad = _valueInputCuenta;
                  ingreso.valtrnf = montoController.text;
                  ingreso.codifi = _valueNombreInstitucion;
                  ingreso.codtidr = _valueTipoIdentificacion;
                  ingreso.ideclr = cedulaIdentificacionController.text;
                  ingreso.nomclr = beneficiarioController.text;
                  ingreso.codtcur = _valueTipoCuenta;
                  ingreso.codctac = cuentaAcreditarController.text;
                  ingreso.infopi = descripcionController.text;
                  ingreso.bnfcel = telefonoController.text;
                  ingreso.bnfema = emailController.text;
                  ingreso.idemsg = value['idemsg'];
                  ingreso.codseg = value['codseg'];

                  print(ingreso);

                  final res = await transferenciaService
                      .ingresarTransferenciaInterBancaria(ingreso);

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
                    limpiarFormulario();
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
