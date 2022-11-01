import 'package:flutter/material.dart';
import 'package:jmp_application/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({super.key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  int idUser = 0;
  String namaUser = "";

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getInt("id")!;
      namaUser = prefs.getString("nama")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      getSession();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: <Widget>[
              Text(
                "Selamat Datang $namaUser",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserEdit()),
                  )
                },
                child: const Text('Edit User'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 132, 130, 130)),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  )
                },
                child: const Text('Get My Coordinate'),
              ),
            ],
          ),
        ));
  }
}

class UserEdit extends StatefulWidget {
  const UserEdit({super.key});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _namaControl = TextEditingController();
  final TextEditingController _notelpControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit User"),
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Center(
                    child: ListView(
                  children: <Widget>[
                    const Text("Update User",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                          labelText: "Username",
                          hintText: "Ketikkan Username",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // registerSubmit();
                            }
                          },
                          child: const Text('Simpan Perubahan'),
                        )
                      ],
                    )
                  ],
                )),
              )),
        ));
  }
}
