// import 'dart:convert';
//
// import 'package:scoped_model/scoped_model.dart';
// import 'package:http/http.dart' as http;
//
// import '../models/course.dart';
// import 'ConnectedModels.dart';
//
// class CoursesModel extends Model {
//   bool _isLoading = false;
//   List<Course> _courses = [];
//
//   List<Course> get courses {
//     return List.from(_courses);
//   }
//
//   Future<bool> addCourse(String title, String description) async {
//     _isLoading = true;
//     notifyListeners();
//     final Map<String, dynamic> courseData = {
//       "title": title,
//       "description": description,
//       "teacher_id": 1 //TODO add for auth user
//     };
//
//       return http.post(
//           'http://localhost:3001/api/course',
//           headers: {
//             "Content-type": "application/json"
//           },
//           body: json.encode(courseData)
//       ).then<bool>((http.Response response) {
//         if (response.statusCode != 200 && response.statusCode != 201) {
//           _isLoading = false;
//           notifyListeners();
//           return false;
//         }
//         print(response.body);
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         if(responseData["status"] == "Success"){
//           final Course newCourse = Course(
//               id: responseData["course_id"],
//               title: title,
//               description: description
//           );
//           _courses.add(newCourse);
//           _isLoading = false;
//           notifyListeners();
//           return true;
//         }else{
//           _isLoading = false;
//           notifyListeners();
//           return false;
//         }
//
//
//       }).catchError((error) {
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       });
//
//     // } catch (error) {
//     //   _isLoading = false;
//     //   notifyListeners();
//     //   print("Error");
//     //   print(error);
//     //   return false;
//     // }
//   }
//
//   Future<Null> fetchCourses() {
//     _isLoading = true;
//     notifyListeners();
//     return http
//         .get(
//             'http://localhost:3001/api/course',)
//         .then<Null>((http.Response response) {
//       final List<Course> fetchedCourseList = [];
//       final List<dynamic> courseListData = json.decode(response.body)["results"];
//       if (courseListData == null) {
//         _isLoading = false;
//         notifyListeners();
//         return;
//       }
//       courseListData.forEach((dynamic courseData) {
//         final Course course = Course(
//             id: courseData["id"],
//             title: courseData["title"],
//             description: courseData["description"],
//             );
//         fetchedCourseList.add(course);
//       });
//       _courses = fetchedCourseList.toList();
//       _isLoading = false;
//       notifyListeners();
//     }).catchError((error) {
//       _isLoading = false;
//       notifyListeners();
//       print("Error fetch Courses");
//       print(error);
//       return;
//     });
//   }
//
//   Future<bool> updateCourse(int id, String title, String description) async {
//     _isLoading = true;
//     notifyListeners();
//     final Map<String, dynamic> courseData = {
//       "title": title,
//       "description": description,
//       "teacher_id": 1 //TODO add for auth user
//     };
//
//     return http.put(
//         'http://localhost:3001/api/course/${id}',
//         headers: {
//           "Content-type": "application/json"
//         },
//         body: json.encode(courseData)
//     ).then<bool>((http.Response response) {
//       if (response.statusCode != 200 && response.statusCode != 201) {
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//       print(response.body);
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       if(responseData["status"] == "Success"){
//         final Course updatedCourse = Course(
//             id: id,
//             title: title,
//             description: description
//         );
//         _courses.forEach((element) {
//           if(element.id == id){
//             element = updatedCourse;
//           }
//         });
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       }else{
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//
//
//     }).catchError((error) {
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     });
//
//     // } catch (error) {
//     //   _isLoading = false;
//     //   notifyListeners();
//     //   print("Error");
//     //   print(error);
//     //   return false;
//     // }
//   }
//
//   Future<bool> deleteCourse(int id) async {
//     _isLoading = true;
//     notifyListeners();
//     return http.delete(
//         'http://localhost:3001/api/course/${id}',
//     ).then<bool>((http.Response response) {
//       if (response.statusCode != 200 && response.statusCode != 201) {
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//       print(response.body);
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       if(responseData["status"] == "Success"){
//         _courses.remove(_courses.firstWhere((element) => element.id == id)) ;
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       }else{
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//
//
//     }).catchError((error) {
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     });
//
//     // } catch (error) {
//     //   _isLoading = false;
//     //   notifyListeners();
//     //   print("Error");
//     //   print(error);
//     //   return false;
//     // }
//   }
//
// }
