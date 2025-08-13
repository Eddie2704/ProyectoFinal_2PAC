import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MaterialApp(home: RegistroPage()));
}

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  RegistroPageState createState() => RegistroPageState();
}

class RegistroPageState extends State<RegistroPage> {
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();
  final contrasenaController = TextEditingController();
  bool isPasswordVisible = false;
  bool caracterpecial(String texto) {
    return texto.contains(RegExp(r'[!@#/^\<>*%$&]'));
  }

//assets/ave.jpg
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Registro')),
      body: 
      Stack(
        children: [
          Container(
          height: MediaQuery.of(context).size.height*0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image_login/ENTRADA.gif"),
              fit: BoxFit.cover,
            ),
          
          ),
        ),

        
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height*0.7,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 140, 208, 142),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -6),
              )
            ]
          ),
           child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              TextField(
                controller: nombreController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: EdgeInsets.all(22),

                  label: Text('Ingrese su nombre',
                  style: TextStyle(
                    color: Colors.black,
                  )
                  ,),
                  hintText: 'Ingrese su nombre',
                  prefixIcon: Icon(Icons.account_circle_rounded, 
                  color: Colors.black,),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: correoController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: EdgeInsets.all(22),
                  label: Text('Ingrese su correo',
                  style: TextStyle(
                    color: Colors.black,
                  ),),
                  hintText: 'Ingrese su correo',
                  prefixIcon: Icon(Icons.email_outlined,
                  color: Colors.black),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: telefonoController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: EdgeInsets.all(22),

                  label: Text('Ingrese su telefono', 
                  style: TextStyle(
                    color: Colors.black,
                  ),),
                  hintText: 'Ingrese su telefono',
                  prefixIcon: Icon(Icons.phone, color: Colors.black, ),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: contrasenaController,
                maxLength: 12,
                obscureText: !isPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: EdgeInsets.all(22),
                  label: Text('Ingrese su contraseña',
                  style: TextStyle(
                    color:Colors.black,
                  ),),
                  hintText: 'Ingrese su contraseña',
                  prefixIcon: Icon(Icons.password_rounded,
                  color: Colors.black,),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon:
                        isPasswordVisible
                            ? const Icon(Icons.visibility, color: Colors.black)
                            : const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    String correo = correoController.text.trim();
                    String contra = contrasenaController.text.trim();
                    //String tele= telefonoController.text.trim();
                    // String nombre= nombreController.text.trim();

                    if (nombreController.text.isEmpty ||
                        telefonoController.text.isEmpty ||
                        correoController.text.isEmpty ||
                        contrasenaController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Oops! Se encontro un error'),
                            content: Text('Ningun espacio debe quedar vacio'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Entiendo'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                     
                    if (!correo.endsWith('@gmail.com') ) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Oops!'),
                            content: Text(
                              'correo no valido',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Entiendo'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    if (contra.length < 12) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Oops!'),
                            content: Text(
                              'la contraseña debe tener 12 o mas digitos',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Entiendo'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (!caracterpecial(contra)) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Oops!'),
                            content: Text(
                              'su contraseña debe tener al menos un caracter especial',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Entiendo'),
                              ),
                            ],
                          );
                        },
                      );
                      return ;
                      
                    }
                    // registrar el login del usuario
                          GetStorage().write('isLoggedIn', true);
                          GetStorage().write('user', nombreController.text);
                          context.go('/');
                   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()),);
                     
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('¡Cuenta creada correctamente!'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                  },
                  child: const Text(
                    'Crear cuenta',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
            
          ),
        ),

        ),
      ),


      
      ],
      )
    );
  }
}