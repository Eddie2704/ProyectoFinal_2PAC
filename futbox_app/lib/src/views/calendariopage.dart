import 'package:flutter/material.dart';
import 'package:futbox_app/controllers/calendariocontroller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarioPage extends StatelessWidget {
  final String canchaId;

  const CalendarioPage({super.key, required this.canchaId});

  @override
  Widget build(BuildContext context) {
    final CalendarioController controller = Get.put(CalendarioController());

    final Rx<DateTime> fechaSeleccionada = DateTime.now().obs;

    controller.cargarReservas(
      canchaId,
      DateFormat('dd/MM/yyyy').format(fechaSeleccionada.value),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas - $canchaId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: [
            // 📅 Selector de fecha
            Obx(() {
              final fecha = fechaSeleccionada.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      fechaSeleccionada.value = fecha.subtract(const Duration(days: 1));
                      controller.cargarReservas(
                        canchaId,
                        DateFormat('dd/MM/yyyy').format(fechaSeleccionada.value),
                      );
                    },
                  ),
                  Text(
                    DateFormat('EEEE dd/MM/yyyy', 'es_ES').format(fecha),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      fechaSeleccionada.value = fecha.add(const Duration(days: 1));
                      controller.cargarReservas(
                        canchaId,
                        DateFormat('dd/MM/yyyy').format(fechaSeleccionada.value),
                      );
                    },
                  ),
                ],
              );
            }),

            const SizedBox(height: 20),

            // 🟩 Card de horas libres
            Obx(() {
              final libres = controller.horasLibres;
              return Card(
                elevation: 3,
                color: Colors.green[50],
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Horas libres:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      if (libres.isEmpty)
                        const Text("No hay horas libres disponibles.")
                      else
                        Wrap(
                          spacing: 8,
                          children: libres.map((h) => Chip(
                            label: Text("$h:00"),
                            avatar: const Icon(Icons.check_circle, color: Colors.green),
                          )).toList(),
                        ),
                    ],
                  ),
                ),
              );
            }),

            // 🟥 Card de horas ocupadas
            Obx(() {
              final ocupadas = controller.horasOcupadas;
              return Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 3,
                    color: Colors.red[50],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Horas ocupadas:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          if (ocupadas.isEmpty)
                            const Text("No hay reservas para este día.")
                          else
                            Wrap(
                              spacing: 8,
                              children: ocupadas.map((h) => Chip(
                                label: Text("$h:00"),
                                avatar: const Icon(Icons.cancel, color: Colors.red),
                                
                              )).toList(),
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
