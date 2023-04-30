import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/ThemeDark.dart';
import 'package:themes/ThemeLight.dart';
import 'package:themes/bloc/theme_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(RegistrationFormApp());
}

final themeBloc = ThemeBloc(IsLight: false);

class RegistrationFormApp extends StatelessWidget {
  RegistrationFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: themeBloc,
      builder: (BuildContext context, ThemeState state) {
        return MaterialApp(
          theme: state.IsLight ? ThemeLight : ThemeDark,
          debugShowCheckedModeBanner: false,
          home: const RegistrationForm(),
        );
      },
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedCountry;
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: const Text('Change Theme Click'),
        onPressed: () {
          themeBloc.add(ChangeTheme());
        },
      ),
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add additional email validation logic here
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _selectedCountry,
                items: ['USA', 'Canada', 'Mexico']
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Country'),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('I accept the terms and conditions'),
                value: _termsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _termsAccepted) {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    // Perform registration logic here
                    print('Name: $name');
                    print('Email: $email');
                    print('Country: $_selectedCountry');
                    print('Terms accepted: $_termsAccepted');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please accept the terms and conditions'),
                    ));
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
