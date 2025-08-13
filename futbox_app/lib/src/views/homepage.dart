import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:futbox_app/providers/canchas.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Canchas Disponibles",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1565C0),
      ),
      body: ListView.builder(
        itemCount: canchasDisponibles.length,
        itemBuilder: (context, index) {
          final cancha = canchasDisponibles[index];

          return Card(
            color: Color(0xFFE3F2FD),
            margin: const EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Imagen de la cancha
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.asset(
                    cancha.imagen,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                // Nombre y ubicación
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cancha.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        cancha.ubicacion,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          //context.push("/reservepage/${index + 1}");
                          //GoRouter.of(context).push('/reservepage');
                          final visualIndex = index + 1; // Sumamos 1
                          final visualIndexStr = visualIndex.toString();
                          context.push('/reservepage/$visualIndexStr');
                        },
                        icon: const Icon(
                          Icons.event_available,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Reservar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          //context.push("/calendariopage/${index + 1}");
                          //GoRouter.of(context).push('/calendariopage');
                          final visualIndex = index + 1; // Sumamos 1
                          final visualIndexStr = visualIndex.toString();
                          context.push('/calendariopage/$visualIndexStr');
                        },
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Calendario",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
