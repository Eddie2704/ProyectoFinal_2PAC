import 'package:flutter/material.dart';
import 'package:futbox_app/controllers/calendariocontroller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarioPage extends StatelessWidget {
  final String index;

  const CalendarioPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final CalendarioController controller = Get.put(CalendarioController());

    final Rx<DateTime> fechaSeleccionada = DateTime.now().obs;

    controller.cargarReservas(
      index,
      DateFormat('dd/MM/yyyy').format(fechaSeleccionada.value),
    );

    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF1565C0),
        title: Text(
          'Reservas - Cancha $index',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Selector de fecha
            Obx(() {
              final fecha = fechaSeleccionada.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      fechaSeleccionada.value = fecha.subtract(
                        Duration(days: 1),
                      );
                      controller.cargarReservas(
                        index,
                        DateFormat(
                          'dd/MM/yyyy',
                        ).format(fechaSeleccionada.value),
                      );
                    },
                  ),
                  Text(
                    DateFormat('EEEE dd/MM/yyyy', 'es_ES').format(fecha),
                    style: TextStyle(fontSize: 18, color: Color(0xFF1565C0)),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      fechaSeleccionada.value = fecha.add(Duration(days: 1));
                      controller.cargarReservas(
                        index,
                        DateFormat(
                          'dd/MM/yyyy',
                        ).format(fechaSeleccionada.value),
                      );
                    },
                  ),
                ],
              );
            }),

            SizedBox(height: 20),

            // Card de horas libres
            Obx(() {
              final libres = controller.horasLibres;
              return SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  color: Color(0xFFE8F5E9),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Horas libres:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        if (libres.isEmpty)
                          Text("No hay horas libres disponibles.")
                        else
                          Wrap(
                            spacing: 8,
                            children:
                                libres
                                    .map(
                                      (h) => Chip(
                                        label: Text("$h:00"),
                                        avatar: Icon(
                                          Icons.check_circle,
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Card de horas ocupadas
            Obx(() {
              final ocupadas = controller.horasOcupadas;
              return Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 3,
                    color: Color(0xFFFFEBEE),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Horas ocupadas:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red.shade700,
                            ),
                          ),
                          SizedBox(height: 8),
                          if (ocupadas.isEmpty)
                            Text("No hay reservas para este día.")
                          else
                            Wrap(
                              spacing: 8,
                              children:
                                  ocupadas
                                      .map(
                                        (h) => Chip(
                                          label: Text("$h:00"),
                                          avatar: Icon(
                                            Icons.cancel,
                                            color: Colors.red.shade600,
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}