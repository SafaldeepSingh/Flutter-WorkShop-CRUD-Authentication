// import 'dart:convert';
//
// import 'package:scoped_model/scoped_model.dart';
// import 'package:http/http.dart' as http;
//
// import '../models/user.dart';
//
// class UsersModel extends Model{
//   bool _isLoading = false;
//   late User _authUser;
//
//   User get authUser {
//     return _authUser;
//   }
//
//   Future<bool> authenticate(String email, String password){
//     bool _isLoading = true;
//     final Map<String, dynamic> authData = {
//       'email': email,
//       'password': password,
//     };
//     return http.post(
//         'http://localhost:3001/api/login',
//         body: authData
//     ).then<bool>((http.Response response) {
//         print(response.body);
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         if(responseData["status"] == "Success"){
//           User user = User(
//             id: responseData["id"],
//             name: responseData["name"],
//             type: responseData["type"],
//             email: responseData["email"],
//           );
//           _authUser = user;
//           bool _isLoading = false;
//           return true;
//         }else{
//           bool _isLoading = false;
//           return false;
//         }
//     });
//   }
// }