import 'package:develop/background.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

///An instance of [FirebaseAuth] for authentication.
final _firebase = FirebaseAuth
    .instance;

///A [StatefulWidget] for the authentication screen.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

///Creates the mutable state for this widget.
///
///Returns a state class for [AuthScreen], managing the state of the widget.
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

/// A state class for [AuthScreen], managing the state of the widget.
class _AuthScreenState extends State<AuthScreen> {
  ///[GlobalKey] used to identify the [Form] widget and manage its state.
  final _form = GlobalKey<
      FormState>();
  ///Whether the login or signup mode is active.
  var _isLogin =
      true;
  ///A string of entered email.
  var _enteredEmail = '';
  ///A string of entered password.
  var _enteredPassword = '';

  ///Submits the login data for authentication.
  ///
  ///If invalid, returns false.
  ///The function [_firebase.signInWithEmailAndPassword] validates login.
  ///The function [_firebase.createUserWithEmailAndPassword] validates signing up.
  ///If failed, show an error [SnackBar] using the [showErrorSnackBar] function, 
  //displaying the 'Authentication failed' text.
  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    try {
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      }
    } on FirebaseAuthException catch (error) {
      _showErrorSnackBar(error.message ?? 'Authentication failed.');
    }
  }

  ///Creates a [SnackBar] displaying a string of text in the app.
  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            errorMessage),
      ),
    );
  }

  ///Creates a [Scaffold] widget, providing a layout for the authentication screen.
  ///
  ///* [EdgeInsets] objects are used to describe the padding in all directions.
  ///* [Padding] widgets add space around their child widgets.
  ///* [Form] widgets are used for user input and validation.
  ///* [Column] widgets arrange their children vertically.
  ///* [Text] widgets display a string of text in the app.
  ///* [ElevatedButton] widgets are buttons with an elevation.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffold(
        childBody: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  width: 200,
                  child: Image.asset('assets/images/camera.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(
                      20),
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(
                        16),
                    child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              key: const Key('login_textfield'),
                              decoration: const InputDecoration(
                                labelText:
                                    'Email Address',
                              ),
                              keyboardType: TextInputType
                                  .emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization
                                  .none,
                              validator: (value) {
                                if (!EmailValidator.validate(value!)) {
                                  return 'Please enter a valid email address.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            TextFormField(
                              key: const Key('password_textfield'),
                              decoration: const InputDecoration(
                                labelText:
                                    'Passsword',
                              ),
                              obscureText:
                                  true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password must be at least 6 characters long.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              key: const Key('loginButton'),
                              onPressed: _submit,
                              child: Text(_isLogin
                                  ? 'Login'
                                  : 'Signup'),
                            ),
                            TextButton(
                              key: const Key('createButton'),
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                  _isLogin
                                      ? 'Create an account'
                                      : 'I already have an account.'),
                            ),
                          ],
                        )),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
