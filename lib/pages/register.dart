import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jmp_application/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _namaControl = TextEditingController();
  final TextEditingController _notelpControl = TextEditingController();

// WHEN BUTTON REGISTER CLICKED
  registerSubmit() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _usernameControl.text,
        password: _passwordControl.text,
      );
      // Show registarsi sukses
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Registarsi Berhasil")));
      // Redirect to login
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      });
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
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
                const Text("Silakan Registrasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _namaControl,
                  decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      hintText: "Ketikkan Nama Lengkap",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide())),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harap masukkan nama lengkap";
                    }
                    return null;
                  },
                ),
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
                      return "Harap masukkan username";
                    }
                    return null;
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
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _notelpControl,
                  decoration: InputDecoration(
                      labelText: "No Telepon",
                      hintText: "Ketikkan No Telepon",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide())),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harap masukkan nomor telepon";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerSubmit();
                    }
                  },
                  child: const Text('REGISTER'),
                ),
                const SizedBox(height: 15),
                TextButton(
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          )
                        },
                    child: const Text("Login"))
              ],
            )),
          )),
    ));
  }
}
