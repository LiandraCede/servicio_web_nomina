import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  NominaFormScreen(),
    );
  }
}

class NominaFormScreen extends StatefulWidget {
  @override
  _NominaFormScreenState createState() => _NominaFormScreenState();
}

class _NominaFormScreenState extends State<NominaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final empresaController = TextEditingController();
  final fechaCreacionController = TextEditingController();
  final fechaPagoController = TextEditingController();
  final cedulaController = TextEditingController();
  final tipoCuentaController = TextEditingController();
  final cuentaDestinoController = TextEditingController();
  final monedaController = TextEditingController();
  final montoController = TextEditingController();

  Future<void> enviarNomina() async {
    final data = {
      "encabezado": {
        "tipoRegistro": "E",
        "empresa": empresaController.text,
        "tipoTransaccion": "N",
        "fechaCreacion": fechaCreacionController.text,
        "fechaPago": fechaPagoController.text
      },
      "detalle": [
        {
          "tipoRegistro": "D",
          "cedula": cedulaController.text,
          "tipoCuenta": tipoCuentaController.text,
          "cuentaDestino": cuentaDestinoController.text,
          "moneda": monedaController.text,
          "monto": montoController.text
        }
      ],
      "sumario": {
        "tipoRegistro": "S",
        "cantidadRegistros": "1"
      }
    };

    final url = Uri.parse('https://api.apap.com.do/api/nomina'); // endpoint

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        _mostrarDialogo("Éxito", "Nómina enviada correctamente.\nRespuesta: ${response.body}");
      } else {
        _mostrarDialogo("Error", "Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      _mostrarDialogo("Excepción", "Error al enviar: $e");
    }
  }

  void _mostrarDialogo(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    empresaController.dispose();
    fechaCreacionController.dispose();
    fechaPagoController.dispose();
    cedulaController.dispose();
    tipoCuentaController.dispose();
    cuentaDestinoController.dispose();
    monedaController.dispose();
    montoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario Nómina")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: empresaController, decoration: const InputDecoration(labelText: "Empresa (RNC)"), validator: _requerido),
              TextFormField(controller: fechaCreacionController, decoration: const InputDecoration(labelText: "Fecha Creación (DDMMAAAA)"), validator: _requerido),
              TextFormField(controller: fechaPagoController, decoration: const InputDecoration(labelText: "Fecha Pago (DDMMAAAA)"), validator: _requerido),
              const Divider(height: 32),
              TextFormField(controller: cedulaController, decoration: const InputDecoration(labelText: "Cédula"), validator: _requerido),
              TextFormField(controller: tipoCuentaController, decoration: const InputDecoration(labelText: "Tipo de Cuenta (C/A)"), validator: _requerido),
              TextFormField(controller: cuentaDestinoController, decoration: const InputDecoration(labelText: "Cuenta Destino"), validator: _requerido),
              TextFormField(controller: monedaController, decoration: const InputDecoration(labelText: "Moneda (DOP/USD)"), validator: _requerido),
              TextFormField(controller: montoController, decoration: const InputDecoration(labelText: "Monto (00000000004500.50)"), validator: _requerido),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    enviarNomina();
                  }
                },
                child: const Text("Enviar Nómina"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _requerido(String? value) {
    if (value == null || value.isEmpty) return "Este campo es obligatorio";
    return null;
  }
}