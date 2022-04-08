
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/courses.dart';
import '../scoped_models/main-model.dart';

class CoursesWidget extends StatefulWidget{
  final MainModel model;
  CoursesWidget(this.model);
  @override
  State createState() => _CoursesWidgetState();
}
class _CoursesWidgetState extends State<CoursesWidget> {

  Widget _buildCourseItem(BuildContext context, int index, MainModel model) {
    return Card(
      child: Container(
        child: Row(
          children: [
            Text(model.courses[index].title),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () async {
                      dynamic results = await Navigator.pushNamed(context, "/courses/${model.courses[index].id}/edit");
                      if(results!= null){
                        print(results);
                        if(results['updated']){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                          SnackBar(
                            content:Text("Course was updated successfully"),
                            duration: Duration(seconds: 5),
                            action: SnackBarAction(
                              label: "OK",
                              onPressed: (){},
                            ),
                          ));

                    }
                  }

                }, child: Text("Edit")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: () {
                  model.deleteCourse(model.courses[index].id).then((value) =>
                  {
                    print(value)
                  });
                }, child: Text("Delete"),),
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
    );
  }
  @override
  void initState() {
    widget.model.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget? child, MainModel model) {
      return model.courses.length == 0?
          Text("Loading...")
          :ListView.builder(
          itemBuilder: (BuildContext context, int index)=>  _buildCourseItem(context,index,model),
          itemCount: model.courses.length
      );
    });
  }

}