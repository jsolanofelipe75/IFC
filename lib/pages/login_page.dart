import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:pruebas/provider/login_state.dart';
import 'package:pruebas/theme/colors.dart';
import 'package:pruebas/utils/responsive.dart';
import '../pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: Consumer<LoginState>(
        builder: (BuildContext context, LoginState state, Widget child) {
          if (state.isLoading()) {
            return Center(child: CupertinoActivityIndicator());
          } else {
            return child;
          }
        },
        child: SingleChildScrollView(
          child: Container(
            width: responsive.width,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            LightColors.kLightYellow,
                            LightColors.kLightYellow
                          ]),
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 290,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              LightColors.kLightYellow2,
                              LightColors.kLightYellow2
                            ],
                          ),
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipperOne(),
                      child: Container(
                        child: Column(),
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            LightColors.kDarkYellow,
                            LightColors.kDarkYellow
                          ]),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 50,
                      left: 50,
                      child: Image(
                        image: AssetImage('assets/image_2020.png'),
                        height: 200,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: responsive.wp(18),
                      child: Image(
                        image: AssetImage('assets/logo_negro_solo.png'),
                        width: responsive.wp(15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                              String email = _emailController.text.trim();
                              String password = _passwordController.text;
                              if (email.isNotEmpty && password.isNotEmpty) {
                                final provider = Provider.of<LoginState>(
                                    context,
                                    listen: false);
                                provider.signInWithEmailAndPassword(
                                    email, password);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: Text(
                                            'Por favor ingresa tu correo y contraseña'),
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
                            },
                            child: Text(
                              'Ingresar',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: LightColors.kgrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: LightColors.kgrey)),
                          ),
                        )),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
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
                ),
                SizedBox(height: 10),
                Text('O inicia sesión con:'),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () {
                    Provider.of<LoginState>(context, listen: false)
                        .loginGoogle();
                  },
                  child: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.red[800],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
