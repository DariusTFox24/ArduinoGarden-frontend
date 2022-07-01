import 'package:arduino_garden/config/config.dart';
import 'package:arduino_garden/config/state_handler.dart';
import 'package:arduino_garden/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static const String path = '/register';
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _validateConfPass = false;
  bool _validateMatching = false;
  bool _validateName = false;
  bool _validatePass = false;
  bool _validateEmail = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pink.shade600,
            Colors.amber.shade900,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
                child: const Text(
                  'ArduinoGarden',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ),
              ),
              const Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0, top: 16.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFF8E1),
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                    errorText: _validateName ? 'Value Can\'t Be Empty' : null,
                    errorStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFF8E1),
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    errorText: _validateEmail ? 'Value Can\'t Be Empty' : null,
                    errorStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFF8E1),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    errorText: _validatePass ? 'Value Can\'t Be Empty' : null,
                    errorStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFFF8E1),
                      border: OutlineInputBorder(),
                      hintText: 'Confirm Password',
                      errorText: _validateConfPass
                          ? 'Value Can\'t Be Empty'
                          : _validateMatching
                              ? 'Passwords Must Match'
                              : null,
                      errorStyle: TextStyle(color: Colors.white)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: MaterialButton(
                      padding: EdgeInsets.only(
                          bottom: 12.0, top: 12.0, left: 34, right: 34),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      color: Colors.pink,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        setState(() {
                          _validateName = nameController.text.isEmpty;
                          _validateEmail = emailController.text.isEmpty;
                          _validatePass = passwordController.text.isEmpty;
                          _validateConfPass =
                              confirmPasswordController.text.isEmpty;
                          _validateMatching = !(passwordController.text ==
                              confirmPasswordController.text);
                        });

                        if ((!_validateName &&
                            !_validateEmail &&
                            !_validatePass &&
                            !_validateConfPass &&
                            !_validateMatching)) {
                          try {
                            final token = await api.register(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                            );
                            await Provider.of<StateHandler>(context,
                                    listen: false)
                                .updateToken(token);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.path, (route) => false);
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: MaterialButton(
                      padding: EdgeInsets.only(
                          bottom: 12.0, top: 12.0, left: 34, right: 34),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      color: Colors.pink,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
