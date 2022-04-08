import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main-model.dart';

class LoginPage extends StatefulWidget{

  @override
  State createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailTextFieldWidget(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if(value == null)
          return null;
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String? value) {
        _formData['email'] = value;
      },
    );

  }
  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String? value) {
        if(value == null)
          return null;
        if (value.isEmpty || value.length < 3) {
          return 'Password invalid';
        }
      },
      onSaved: (String? value) {
        _formData['password'] = value;
      },
    );
  }
  Widget _buildSubmitButton(MainModel model) {
    return ElevatedButton(onPressed: () {_submitForm(model);}, child: Text("Login"));
  }
  _submitForm(MainModel model) {
    FormState? currentState = _formKey.currentState;
    if(currentState !=  null){
      if (!currentState.validate()) {
        return;
      }
      currentState.save();
      model.authenticate(_formData['email'], _formData['password']).then((value) =>
      {
        if(value){
          Navigator.pushReplacementNamed(context, "/courses")
        }else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Invalid Credentials'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          )
        }

      });


    }

  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        body: Container(
          width: deviceWidth,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildEmailTextFieldWidget(),
                SizedBox(height: 10,),
                _buildPasswordTextField(),
                SizedBox(height: 10,),
                _buildSubmitButton(model)

              ],
            ),
          ),

        ),
      );
    });
  }
}