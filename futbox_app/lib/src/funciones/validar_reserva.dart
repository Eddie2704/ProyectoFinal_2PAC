// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ValidarReserva {
  // Validación de nombre
  bool validarNombre(String nombre, BuildContext context) {
    if (nombre.trim().isEmpty) {
      _mostrarError(context, "El nombre no puede estar vacío.");
      return false;
    }
    return true;
  }

  // Validación de teléfono
  bool validarTelefono(String telefono, BuildContext context) {
    if (telefono.length != 8 || !RegExp(r'^\d{8}$').hasMatch(telefono)) {
      _mostrarError(context, "El teléfono debe tener 8 dígitos numéricos.");
      return false;
    }
    return true;
  }

  // Selección de hora
  static Future<TimeOfDay?> seleccionarHora(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }

  //Validar las horas
  bool validarHoras(
    TimeOfDay? horaInicio,
    TimeOfDay? horaFin,
    BuildContext context,
  ) {
    if (horaInicio == null || horaFin == null) {
      _mostrarError(context, "Debes seleccionar hora de inicio y fin.");
      return false;
    }

    final inicioMinutos = horaInicio.hour * 60 + horaInicio.minute;
    final finMinutos = horaFin.hour * 60 + horaFin.minute;

    if (inicioMinutos >= finMinutos) {
      _mostrarError(
        context,
        "La hora de inicio debe ser menor que la hora de fin.",
      );
      return false;
    }

    // Validar que la hora de inicio no sea antes  de las 8:00 am
    final limiteInicioMin = 8 * 60;
    if (inicioMinutos < limiteInicioMin) {
      _mostrarError(
        context,
        "La reserva no puede comenzar antes de las 8:00 am.",
      );
      return false;
    }
    // Validar que la hora de fin no sea después de las 11:00 pm
    final limiteFin = 23 * 60;
    if (finMinutos > limiteFin) {
      _mostrarError(
        context,
        "La reserva debe finalizar antes de las 11:00 pm.",
      );
      return false;
    }

    return true;
  }

  //Validar Fechas
  bool validarFechaNoPasada(String fecha, BuildContext context) {
    try {
      final formato = DateFormat('dd/MM/yyyy');
      final fechaSeleccionada = formato.parse(fecha);
      final hoy = DateTime.now();

      if (fechaSeleccionada.isBefore(DateTime(hoy.year, hoy.month, hoy.day))) {
        _mostrarError(context, "La fecha no puede ser anterior a hoy.");
        return false;
      }
      return true;
    } catch (e) {
      _mostrarError(context, "Formato de fecha inválido.");
      return false;
    }
  }

  // Mostrar errores
  void _mostrarError(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  // Mostrar resumen y confirmar reserva
  static Future<void> mostrarResumenReserva({
    required BuildContext context,
    required String canchaId,
    required String canchaNombre,
    required String fecha,
    required String horaInicio,
    required String horaFin,
    required String nombre,
    required String telefono,
    required VoidCallback onSuccess,
  }) async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Confirmar Reserva"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cancha: $canchaNombre"),
                Text("Fecha: $fecha"),
                Text("Hora: $horaInicio - $horaFin"),
                Text("Nombre: $nombre"),
                Text("Teléfono: $telefono"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final reservas =
                      await FirebaseFirestore.instance
                          .collection('reservas')
                          .where('canchaId', isEqualTo: canchaId)
                          .where('fecha', isEqualTo: fecha)
                          .get();
                  bool disponible = true;
                  for (var doc in reservas.docs) {
                    final inicio = doc['horaInicio'];
                    final fin = doc['horaFin'];
                    if (!(horaFin.compareTo(inicio) <= 0 ||
                        horaInicio.compareTo(fin) >= 0)) {
                      disponible = false;
                      break;
                    }
                  }
                  if (!disponible) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Ya existe una reserva en ese horario."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  await FirebaseFirestore.instance.collection('reservas').add({
                    'canchaId': canchaId,
                    'fecha': fecha,
                    'horaInicio': horaInicio,
                    'horaFin': horaFin,
                    'nombre': nombre,
                    'telefono': int.parse(telefono),
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Reserva creada exitosamente 🎉"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                  onSuccess();
                },
                child: Text("Confirmar"),
              ),
            ],
          ),
    );
  }

  //Funcion para formatear la hora
  static String formatearHora24(TimeOfDay hora) {
    final horaStr = hora.hour.toString().padLeft(2, '0');
    final minutoStr = hora.minute.toString().padLeft(2, '0');
    return "$horaStr:$minutoStr";
  }
}
