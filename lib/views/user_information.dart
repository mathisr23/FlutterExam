import 'package:flutter/material.dart';
import 'package:eval_flutter/data_base/db_connexion.dart';


class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  late String _username = '';
  late String _password = '';
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  get databaseConnection => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _username = args['username'];
      _password = args['password'];
    }
  }

  void _saveChanges() async {
    final DatabaseConnection databaseConnection = DatabaseConnection.instance;
    await databaseConnection.saveUser(_username, _password);

    setState(() {
      _isEditing = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations sur l\'utilisateur'),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;

                if (!_isEditing) {
                  _saveChanges();
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bonjour $_username',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom d\'utilisateur',
                    enabled: _isEditing,
                  ),
                  initialValue: _username,
                  validator: (value) {
                    if (_isEditing && value!.isEmpty) {
                      return 'Veuillez saisir un nom d\'utilisateur';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_isEditing) {
                      setState(() {
                        _username = value;
                      });
                    }
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    enabled: _isEditing,
                  ),
                  initialValue: _password,
                  obscureText: true,
                  validator: (value) {
                    if (_isEditing && value!.isEmpty) {
                      return 'Veuillez saisir un mot de passe';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_isEditing) {
                      setState(() {
                        _password = value;
                      });
                    }
                  },
                ),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          databaseConnection.saveUser(_username, _password);

                        }
                      },
                      child: Text('Enregistrer'),
                    ),

                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                      child: Text('Modifier'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
