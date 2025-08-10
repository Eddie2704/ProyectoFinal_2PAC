import 'package:futbox_app/src/funciones/funciones_calendario.dart';
import 'package:get/get.dart';

class CalendarioController extends GetxController {

  final horasLibres = <int>[].obs;
  final horasOcupadas = <int>[].obs;
  final reservas = <Map<String, dynamic>>[].obs;

  // Cargar reservas y calcular disponibilidad
  Future<void> cargarReservas(String canchaId, String fecha) async {
    try {
      // 1. Obtener reservas
      final datos = await obtenerReservasPorFechaYCancha(
        canchaId: canchaId,
        fecha: fecha,
      );
      reservas.value = datos;

      // 2. Convertir a rangos
      final rangos = convertirReservasARangos(datos);

      // 3. Generar todas las horas del día
      final todasLasHoras = generarHorasDelDia();

      // 4. Calcular horas ocupadas
      final ocupadas = <int>[];
      for (var rango in rangos) {
        for (int h = rango['inicio']!; h < rango['fin']!; h++) {
          ocupadas.add(h);
        }
      }
      horasOcupadas.value = ocupadas;

      // 5. Calcular horas libres
      horasLibres.value = todasLasHoras.where((h) => !ocupadas.contains(h)).toList();
    } catch (e) {
      print("Error al cargar reservas: $e");
    }
  }

  // Limpiar estado si cambias de fecha o cancha
  void limpiar() {
    horasLibres.clear();
    horasOcupadas.clear();
    reservas.clear();
  }
}
