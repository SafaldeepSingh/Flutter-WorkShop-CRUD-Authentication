import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:workshop1/widget/courses.dart';

import '../../models/course.dart';
import '../../scoped_models/courses.dart';
import '../../scoped_models/main-model.dart';

class CoursesPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget? child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Courses"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic results = await Navigator.pushNamed(context, "/courses/add");
            if(results!= null){
              if(results['added']){
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    SnackBar(
                      content:Text("Course was added successfully"),
                      duration: Duration(seconds: 5),
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: (){},
                      ),
                    ));

              }
            }
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: CoursesWidget(model),
        ),
      );
    });

  }

}