import 'package:flutter/material.dart';
import 'package:futbox_app/src/Funciones/validar_reserva.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Nueva Reserva",
                    style: TextStyle(fontSize: 30, color: Colors.blueGrey),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Image.asset(imagen),
              const SizedBox(height: 30),
              CustomTextField(
                label: "Persona que reserva",
                controller: nameController,
                prefixIcon: Icon(Icons.person, color: Colors.cyanAccent),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                label: "Teléfono",
                controller: phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: Icon(Icons.smartphone, color: Colors.cyanAccent),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                label: "Seleccionar Fecha",
                controller: dateController,
                keyboardType: TextInputType.datetime,
                prefixIcon: Icon(Icons.calendar_month, color: Colors.cyanAccent),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Column(
                    children: [
                      const Text("Inicio", style: TextStyle(fontSize: 20, color: Colors.green)),
                      SizedBox(
                        width: 170,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.access_time),
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
                  const Spacer(),
                  Column(
                    children: [
                      const Text("Fin", style: TextStyle(fontSize: 20, color: Colors.red)),
                      SizedBox(
                        width: 170,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.access_time),
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
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 30),
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
                  backgroundColor: Colors.blue,
                  child: const Text(
                    "Validar Reserva",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
