import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/Gestion/Curso/Curso_page.dart';
import 'package:trabajo/Gestion/MenuG.dart';
import 'package:trabajo/Gestion/Noticias/Noticias_unlog.dart';
import 'package:trabajo/Listar/MenuL.dart';
import 'package:trabajo/google_login.dart';
import 'package:trabajo/providers/firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class Jardin extends StatefulWidget {
  const Jardin({Key? key}) : super(key: key);

  @override
  State<Jardin> createState() => _JardinState();
}

class _JardinState extends State<Jardin> {
  int _paginaactual = 0;

  List<Widget> _paginas = [MenuG(), MenuL(), GoogleSignIn()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jardin "Los cachorros"'),
          backgroundColor: Color.fromARGB(255, 255, 132, 24),
        ),
        body: _paginas[_paginaactual],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 187, 89, 3),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          iconSize: 30,
          selectedFontSize: 20,
          showUnselectedLabels: false,
          onTap: (valor) {
            setState(() {
              _paginaactual = valor;
            });
          },
          currentIndex: _paginaactual,
          items: [
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.pencilPlus), label: 'Gestion'),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.clipboardList), label: 'Listado'),
            BottomNavigationBarItem(icon: Icon(MdiIcons.google), label: 'Login')
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //iniciar
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //login

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Jardin Infantil',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold)),
          const Text('Los Cachorros',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 44.0,
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseServices().signInWithGoogle();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Jardin()));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Color.fromARGB(66, 255, 242, 5);
              }
              return Color.fromARGB(255, 255, 181, 84);
            })),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(
                  //  width: 10,
                  //),
                  Text(
                    "Ingresar con Gmail",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                return NoticiasUnlogPage();
              });

              Navigator.push(context, route).then((value) {
                print('ACTUALIZAR PAGINA');
                setState(() {});
              });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Color.fromARGB(76, 255, 63, 5);
              }
              return Color.fromARGB(181, 237, 87, 5);
            })),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(
                  //  width: 10,
                  //),
                  Text(
                    "Ingresar a seccion noticias",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
