import 'package:flutter/material.dart';
import 'package:futbox_app/src/views/registro.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
  }

  class LoginPageState extends State<LoginPage>{
    //user o correo controllorer 
    final userController = TextEditingController();
    final passwordController = TextEditingController();
    bool isPassWordVisible = false;

    @override
    Widget build(BuildContext context){    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image_login/ENTRADA.gif"),
                //image: AssetImage("assets/ENTRADA.gif"),
                fit: BoxFit.cover,
                ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4)
                  ),
                  ],
                ),
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  
                  children: [
                    Text("Welcome Back",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0)
                    ),
                    ),
                    SizedBox(height: 50),
                    TextField(controller: userController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        )
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      contentPadding: EdgeInsets.all(24),
                      label: Text("Ingrese su correo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      ),
                      hintText: "Ingrese el correo",
                      prefixIcon: Icon(Icons.email_rounded,color: Colors.indigo.shade800,),
                    ),
                    ),
                    SizedBox(height: 50,),
                    TextField(
                      controller: passwordController,
                      maxLength: 12,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: !isPassWordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        contentPadding: EdgeInsets.all(25),
                        label: Text("Ingrese la contraseña",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                        hintText: "Ingrese la contraseña",
                        prefixIcon: Icon(Icons.password_outlined,
                        color: Colors.indigo.shade800),
                        suffixIcon: IconButton(onPressed: (){
                          setState((){
                            isPassWordVisible =! isPassWordVisible;
                          });},
                        icon: isPassWordVisible ? const Icon(
                          Icons.visibility, color: Colors.red): const Icon(Icons.visibility_off,color: Colors.green,)),
                        
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("¿No tienes una cuenta?"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroPage(),
                    ),
                    ) ;
                    /* Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroPage();
                    ),
                    )  falta el registropage*/
                                        }, child: Text("Crea una aqui"))
                                        ],
                                        ),
                    //aqui puede ir iniciio con google o ios

                    SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(16),
                      ),
                      onPressed: (){
                        String correo = userController.text.trim();
                        String contrasenia = passwordController.text.trim();

                        if (correo.isEmpty || contrasenia.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Ooops!"),
                            content: Text("Ningún espacio debe quedar vacío"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Continuar"),
                              ),
                            ],
                          ),
                        );
                        return;
                      }
                        
                        //variables del user y la contraeña
                        //if(correo == userController && contrasenia == passwordController){
                        if(correo == "mj@gmail.com" && contrasenia == "123456789100"){
                         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()),);
                         // Navigator.push(context ,MaterialPageRoute(builder: (context) => HomePage()),);
                        context.go('/');

                        }else{
                          showDialog(
                            context: context, 
                            builder: (_) => AlertDialog(
                              title: Text("Acceso denegado"),
                              content: Text("Contraeña o correo incorrectos"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: Text("Intentar de nuevo"))
                              ],
                            ));
                        }
                        
                        /*
                        GetStorage().write("isLoginIn", true);
                        GetStorage().write("user", userController.text);
                        context.goNamed("home"),
                         */       
                        if(!correo.endsWith("@gmail.com") ){
                          showDialog(
                            context: context, 
                            builder: (context){
                              return AlertDialog(
                                title: Text("Oopps Algo ha salido mal"),
                                content: Text("Debes de usar un correo valido"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: Text("Entendido"))
                                ],
                              );
                            });
                            return;
                        }                 
                        if(contrasenia.length < 12){
                          showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Oopps! Algo fallo"),
                              content: Text("La contraseña debe de tener 12 caracteres"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("Entendido"),)
                              ],
                            );
                          });
                          return;
                        }   
                        // registrar el login del usuario
                          GetStorage().write('isLoggedIn', true);
                          GetStorage().write('user', userController.text);
                          context.go('/');
                      }, 
                      child: const Text("INGRESAR")),
                    ),
                    
                  ],
                ),
              ),
              ),
            ),
          )
        ],
      )
    );
  }
}