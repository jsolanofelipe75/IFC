import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruebas/theme/colors.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Quiero pertenecer a la ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                    child: Image(
                  image: AssetImage('assets/logo_negro_solo.png'),
                  width: 100,
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15,),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(Icons.email, color: LightColors.kgrey),
                        ),
                        border: InputBorder.none,
                        labelText: "Correo electrónico",
                        hintText: 'Escribe tu correo',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(Icons.lock, color: LightColors.kgrey),
                        ),
                        border: InputBorder.none,
                        labelText: "Contraseña",
                        hintText: 'Escribe tu contraseña',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                _register();
                              },
                              child: Text('Registrarse',
                                  style: TextStyle(color: Colors.white)),
                              color: LightColors.kgrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: LightColors.kgrey)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    FirebaseFirestore _db = FirebaseFirestore.instance;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final User _user = result.user;

        if (_user != null) {
          _db.collection('usuarios').doc(_user.uid).set({
            'name': '',
            'email': _user.email,
            'photoUrl': '',
            'createdAt': DateTime.now().millisecondsSinceEpoch,
            'celular': ''
          });
          showCupertinoDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Hecho'),
                content: Text(
                    'Registro exitoso ahora puedes ingresar como  ${_user.email}'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _emailController.text = '';
                      _passwordController.text = '';
                      Navigator.of(ctx).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        showCupertinoDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(e.toString().trimLeft()),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        _emailController.text = '';
                        _passwordController.text = '';
                        Navigator.of(ctx).pop();
                      },
                      child: Text('OK')),
                ],
              );
            });
      }
    } else {
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Por favor ingresa tu Email y una contraseña'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      _emailController.text = '';
                      _passwordController.text = '';
                      Navigator.of(ctx).pop();
                    },
                    child: Text('OK')),
              ],
            );
          });
    }
  }
}
