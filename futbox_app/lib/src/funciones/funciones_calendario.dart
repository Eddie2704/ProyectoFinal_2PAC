import 'package:cloud_firestore/cloud_firestore.dart';


/// Consulta las reservas por cancha y fecha
Future<List<Map<String, dynamic>>> obtenerReservasPorFechaYCancha({
  required String canchaId,
  required String fecha,
}) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('reservas')
      .where('canchaId', isEqualTo: canchaId)
      .where('fecha', isEqualTo: fecha)
      .get();

  return snapshot.docs.map((doc) => doc.data()).toList();
}

/// Convierte las reservas a rangos de horas ocupadas
List<Map<String, int>> convertirReservasARangos(List<Map<String, dynamic>> reservas) {
  return reservas.map((reserva) {
    final inicio = int.parse(reserva['horaInicio'].split(":")[0]);
    final fin = int.parse(reserva['horaFin'].split(":")[0]);
    return {
      'inicio': inicio,
      'fin': fin,
    };
  }).toList();
}

/// Genera todas las horas posibles en el día (ej. 7am a 11pm)
List<int> generarHorasDelDia({int desde = 7, int hasta = 23}) {
  return List.generate(hasta - desde + 1, (i) => i + desde);
}

/// Filtra las horas libres comparando con las ocupadas
List<int> obtenerHorasLibres({
  required List<int> todasLasHoras,
  required List<Map<String, int>> rangosReservados,
}) {
  List<int> horasOcupadas = [];

  for (var rango in rangosReservados) {
    for (int h = rango['inicio']!; h < rango['fin']!; h++) {
      horasOcupadas.add(h);
    }
  }

  return todasLasHoras.where((h) => !horasOcupadas.contains(h)).toList();
}
