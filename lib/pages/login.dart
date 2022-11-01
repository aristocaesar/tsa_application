import 'package:flutter/material.dart';
import 'package:jmp_application/pages/register.dart';
import 'package:jmp_application/pages/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jmp_application/pages/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('jmp');

  setSession(int id, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", id);
    prefs.setString("nama", name);
  }

  // WHEN BUTTON LOGIN CLICKED
  loginSubmit() async {
    try {
      // GET DATABASE
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameControl.text,
        password: _passwordControl.text,
      );
      // On loign success create session
      setSession(1, _usernameControl.text.toString());
      // On login success push to dahsboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardUser()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email atau Password salah!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
                child: ListView(
              children: <Widget>[
                const FlutterLogo(
                  size: 300,
                  textColor: Colors.blue,
                  style: FlutterLogoStyle.stacked,
                ),
                const SizedBox(height: 25),
                const Text("Selamat Datang, Silakan Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _usernameControl,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Ketikkan Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide())),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harap masukkan Email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _passwordControl,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Ketikkan Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harap masukkan password";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginSubmit();
                    }
                  },
                  child: const Text('LOGIN'),
                ),
                const SizedBox(height: 10),
                TextButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40)),
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          )
                        },
                    child: const Text("Register"))
              ],
            )),
          )),
    ));
  }
}
