import 'package:flutter/material.dart';

class FormularioPage extends StatefulWidget {
  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp telefonoRegex = RegExp(r'^[0-9]{10}$');
  final RegExp curpRegex = RegExp(
    r'^[A-Z]{4}[0-9]{6}[HM][A-Z]{5}[A-Z0-9]{1}[0-9]{1}$',
  );
  final TextEditingController _fechaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro de Pacientes")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nombre completo"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Correo"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }

                  if (!emailRegex.hasMatch(value)) {
                    return 'El correo no es valido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Teléfono"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un número de teléfono';
                  } //codigo obtenido al hacer la investigación
                  if (!telefonoRegex.hasMatch(value)) {
                    return 'El teléfono debe tener exactamente 10 dígitos numéricos';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "CURP"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una CURP';
                  }
                  if (value.length != 18) {
                    return 'La CURP debe tener exactamente 18 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Fecha de nacimiento",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Contraseña"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una contraseña';
                  }
                  if (value.length != 6) {
                    return 'La contraseña debe tener exactamente 6 caracteres';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Formulario correcto");
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Registro exitoso")));
                  }
                },

                child: Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //función conseguida cuando se hizo la investigación para validar la fecha
  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        // Formato simple: Día/Mes/Año
        _fechaController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
