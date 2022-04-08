class Course {
  final int id;
  final String title;
  final String description;
  // final int teacherId;

  Course({
    required this.id,
    required this.title,
    required this.description,
    // this.teacherId = 1//TODO link to auth user id,
  });

  @override
  String toString() {
    return "id= ${id} title=${title}";
  }
}
