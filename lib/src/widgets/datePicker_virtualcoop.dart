import 'package:flutter/material.dart';

class FloatingDatePickerStayHome extends StatelessWidget {

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onPressed;
  
  FloatingDatePickerStayHome({
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Color(0xffffc529),
        textSelectionColor: Colors.pink,        
          colorScheme: ColorScheme(
            background: Colors.red, 
            brightness: Brightness.light, 
            error: Colors.red, 
            onBackground: Color(0xffffc529),
            onError: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            primary: Color(0xffffc529),
            primaryVariant: Colors.white,
            secondary: Color(0xffffc529),
            secondaryVariant: Color(0xffffc529),
            surface: Color(0xffffc529),                                    
          )
        ),
      child: new Builder(
        builder: (context) => new FloatingActionButton(
          child: new Icon(Icons.date_range),
          onPressed: () async {
            DateTime dateTime = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate,
              locale: Locale('es', 'ES'),                   
            );
            onPressed(dateTime);
          }
        ),
      ),
    );
  }
}