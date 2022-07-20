import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabajo/Gestion/MenuG.dart';
import 'package:flutter/material.dart';
import 'package:trabajo/main.dart';
import 'package:trabajo/providers/firebase_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  //GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Bienvenido Usuario:',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${FirebaseAuth.instance.currentUser!.displayName}",
                style: TextStyle(fontSize: 20),
              ),
              Image.network(
                FirebaseAuth.instance.currentUser!.photoURL!,
                width: 150,
                height: 150,
              ),
              Text(
                'Correo Electronico:',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${FirebaseAuth.instance.currentUser!.email}",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseServices().googleSignOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
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
                            "Desloguear",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
