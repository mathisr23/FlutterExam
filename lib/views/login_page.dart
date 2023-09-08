import 'package:flutter/material.dart';
import 'package:eval_flutter/model/user_id_generator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String predefinedUsername = 'test';
  String predefinedPassword = 'test';

  late UserIDGenerator userIDGenerator;

  late String _username;
  late String _password;



  @override
  void initState() {
    super.initState();
    userIDGenerator = UserIDGenerator();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  '../assets/man.jpg',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir un nom d\'utilisateur';
                  }
                  if (value != predefinedUsername) {
                    return 'Nom d\'utilisateur incorrect';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir un mot de passe';
                  }
                  if (value != predefinedPassword) {
                    return 'Mot de passe incorrect';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (_username == predefinedUsername && _password == predefinedPassword) {
                      final int userID = userIDGenerator.generateUserID();

                      Navigator.pushNamed(
                        context,
                        '/user_information',
                        arguments: {
                          'username': _username,
                          'password': _password,
                          'userID': userID,
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nom d\'utilisateur ou mot de passe incorrect.'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Connexion'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
