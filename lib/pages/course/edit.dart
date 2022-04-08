import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:workshop1/scoped_models/main-model.dart';

import '../../models/course.dart';
import '../../scoped_models/courses.dart';

class EditCoursePage extends StatefulWidget{
  final Course course;
  EditCoursePage(this.course);
  @override
  State createState() => _EditCourseState();
}
class _EditCourseState extends State<EditCoursePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
  };

  @override
  void initState() {
    print(widget.course);
    _formData['title'] = widget.course.title;
    _formData['description'] = widget.course.description;
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Title', border: OutlineInputBorder(),filled: true, fillColor: Colors.white,),
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if(value == null)
          return null;
        if (value.isEmpty) {
          return 'Please enter a title';
        }
      },
      initialValue: _formData['title'],
      onSaved: (String? value) {
        _formData['title'] = value;
      },
    );
  }
  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Description', border: OutlineInputBorder(), filled: true, fillColor: Colors.white,
          hintMaxLines: 1
      ),
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: 15,
      initialValue: _formData['description'],
      onSaved: (String? value) {
        _formData['description'] = value;
      },
    );
  }
  Widget _buildSubmitButton(MainModel model){
    return ElevatedButton(
        onPressed: () {
          FormState? currentState = _formKey.currentState;
          if(currentState !=  null){
            if (!currentState.validate()) {
              return;
            }
            currentState.save();
            // print(_formData);
            model.updateCourse(widget.course.id,_formData['title'], _formData['description']).then((value) =>
            {
              if(value){
                Navigator.pop(context, {'updated': true})
              }else{
                // show snackbar
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(
                      content:Text("Course couldn't be updated"),
                      duration: Duration(seconds: 5),
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: (){},
                      ),
                    ))
              }
            });
          }
        },
        child: Text("Update")
    );
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Course"),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTitleTextField(),
                SizedBox(height: 10),
                _buildDescriptionTextField(),
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