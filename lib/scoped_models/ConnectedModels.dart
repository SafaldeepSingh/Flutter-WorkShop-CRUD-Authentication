import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';
import '../models/user.dart';

class ConnectedModels extends Model{
  List<Course> _courses = [];
  late User _authUser;
  bool _isLoading = false;
}
class CoursesModel extends ConnectedModels {
  // bool _isLoading = false;
  // List<Course> _courses = [];

  List<Course> get courses {
    return List.from(_courses);
  }

  Future<bool> addCourse(String title, String description) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> courseData = {
      "title": title,
      "description": description,
      "teacher_id": _authUser.id //TODO add for auth user
    };

    return http.post(
        Uri.parse('http://localhost:3001/api/course'),
        headers: {
          "Content-type": "application/json"
        },
        body: json.encode(courseData)
    ).then<bool>((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      if(responseData["status"] == "Success"){
        final Course newCourse = Course(
            id: responseData["course_id"],
            title: title,
            description: description
        );
        _courses.add(newCourse);
        _isLoading = false;
        notifyListeners();
        return true;
      }else{
        _isLoading = false;
        notifyListeners();
        return false;
      }


    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });

    // } catch (error) {
    //   _isLoading = false;
    //   notifyListeners();
    //   print("Error");
    //   print(error);
    //   return false;
    // }
  }

  Future<Null> fetchCourses() {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
      Uri.parse('http://localhost:3001/api/course'),)
        .then<Null>((http.Response response) {
      final List<Course> fetchedCourseList = [];
      final List<dynamic> courseListData = json.decode(response.body)["results"];
      if (courseListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      courseListData.forEach((dynamic courseData) {
        final Course course = Course(
          id: courseData["id"],
          title: courseData["title"],
          description: courseData["description"],
        );
        fetchedCourseList.add(course);
      });
      _courses = fetchedCourseList.toList();
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      print("Error fetch Courses");
      print(error);
      return;
    });
  }

  Future<bool> updateCourse(int id, String title, String description) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> courseData = {
      "title": title,
      "description": description,
    };

    return http.put(
        Uri.parse('http://localhost:3001/api/course/${id}'),
        headers: {
          "Content-type": "application/json"
        },
        body: json.encode(courseData)
    ).then<bool>((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      if(responseData["status"] == "Success"){
        final Course updatedCourse = Course(
            id: id,
            title: title,
            description: description
        );
        _courses.forEach((element) {
          if(element.id == id){
            element = updatedCourse;
          }
        });
        _isLoading = false;
        notifyListeners();
        return true;
      }else{
        _isLoading = false;
        notifyListeners();
        return false;
      }


    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });

    // } catch (error) {
    //   _isLoading = false;
    //   notifyListeners();
    //   print("Error");
    //   print(error);
    //   return false;
    // }
  }

  Future<bool> deleteCourse(int id) async {
    _isLoading = true;
    notifyListeners();
    return http.delete(
      Uri.parse('http://localhost:3001/api/course/${id}'),
    ).then<bool>((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      if(responseData["status"] == "Success"){
        _courses.remove(_courses.firstWhere((element) => element.id == id)) ;
        _isLoading = false;
        notifyListeners();
        return true;
      }else{
        _isLoading = false;
        notifyListeners();
        return false;
      }


    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });

    // } catch (error) {
    //   _isLoading = false;
    //   notifyListeners();
    //   print("Error");
    //   print(error);
    //   return false;
    // }
  }

}

class UsersModel extends ConnectedModels{

  User get authUser {
    return _authUser;
  }

  Future<bool> authenticate(String email, String password){
    bool _isLoading = true;
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    return http.post(
        Uri.parse('http://localhost:3001/api/login'),
        body: authData
    ).then<bool>((http.Response response) {
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      if(responseData["status"] == "Success"){
        User user = User(
          id: responseData["id"],
          name: responseData["name"],
          type: responseData["type"],
          email: responseData["email"],
        );
        _authUser = user;
        bool _isLoading = false;
        return true;
      }else{
        bool _isLoading = false;
        return false;
      }
    });
  }
}
