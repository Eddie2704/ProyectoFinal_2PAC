import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed:(){
                  GoRouter.of(context).push('/reservepage');
                },
                label: Text("Navegar a reserva")),
              ],
            ),
             Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(onPressed:(){
              GoRouter.of(context).push('/calendariopage');
            },
            label: Text("Navegar a Calendario")),
          ],
        )
          ],
        ),
        
      ),
    );
  }
}