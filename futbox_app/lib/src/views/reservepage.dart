import 'package:flutter/material.dart';
import 'package:futbox_app/src/funciones/validar_reserva.dart';
import 'package:futbox_app/src/widgets/textfields.dart';


class ReservePage extends StatefulWidget {
  final String nombrecancha;

  const ReservePage({super.key, required this.nombrecancha});

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {
  String? canchaSeleccionadaId;
  TimeOfDay? horaInicio;
  TimeOfDay? horaFin;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String imagen = 'assets/image/${widget.nombrecancha}.jpg';

    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      appBar: AppBar(backgroundColor: Color(0xFF1565C0) ,
        title: Text("Nueva Reserva",style: TextStyle(color: Colors.white),),),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            
            SizedBox(height: 30),
            Image.asset(imagen),
            SizedBox(height: 30),
            CustomTextField(
              label: "Persona que reserva",
              controller: nameController,
              prefixIcon: Icon(Icons.person, color: Color(0xFF00BFA5)),
            ),
            SizedBox(height: 30),
            CustomTextField(
              label: "Teléfono",
              controller: phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(Icons.smartphone, color:  Color(0xFF00BFA5)),
            ),
            SizedBox(height: 30),
            CustomTextField(
              label: "Seleccionar Fecha",
              controller: dateController,
              keyboardType: TextInputType.datetime,
              prefixIcon: Icon(Icons.calendar_month, color:  Color(0xFF00BFA5)),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Column(
                  children: [
                    Text("Inicio", style: TextStyle(fontSize: 20, color:   Color(0xFF1565C0))),
                    SizedBox(
                      width: 170,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.access_time,color: Color(0xFF00BFA5),),
                        label: Text(
                          horaInicio != null ? horaInicio!.format(context) : 'Inicio',
                        ),
                        onPressed: () async {
                          final hora = await ValidarReserva.seleccionarHora(context);
                          if (hora != null) {
                            setState(() {
                              horaInicio = hora;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text("Fin", style: TextStyle(fontSize: 20, color: Colors.redAccent)),
                    SizedBox(
                      width: 170,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.access_time,color: Color(0xFF00BFA5),),
                        label: Text(
                          horaFin != null ? horaFin!.format(context) : 'Final',
                        ),
                        onPressed: () async {
                          final hora = await ValidarReserva.seleccionarHora(context);
                          if (hora != null) {
                            setState(() {
                              horaFin = hora;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                onPressed: () async {
                  bool camposValidos = ValidarReserva().validarNombre(nameController.text, context) &&
                      ValidarReserva().validarTelefono(phoneController.text, context) &&
                      ValidarReserva().validarFechaNoPasada(dateController.text, context) &&
                      ValidarReserva().validarHoras(horaInicio, horaFin, context);
      
                  if (camposValidos) {
                    final horaInicioStr = ValidarReserva.formatearHora24(horaInicio!);
                    final horaFinStr = ValidarReserva.formatearHora24(horaFin!);
      
                    await ValidarReserva.mostrarResumenReserva(
                      context: context,
                      canchaId: widget.nombrecancha,
                      canchaNombre: widget.nombrecancha,
                      fecha: dateController.text,
                      horaInicio: horaInicioStr,
                      horaFin: horaFinStr,
                      nombre: nameController.text,
                      telefono: phoneController.text,
                      onSuccess: () {
                        nameController.clear();
                        phoneController.clear();
                        dateController.clear();
                        setState(() {
                          horaInicio = null;
                          horaFin = null;
                        });
                      },
                    );
                  }
                },
                backgroundColor: Color(0xFF1565C0),
                child: Text(
                  "Validar Reserva",
                  style: TextStyle(color: Colors.white),
                  
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
