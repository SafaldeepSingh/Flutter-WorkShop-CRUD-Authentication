class User {
  final int id;
  final String name;
  final String email;
  final int type;
  final String profilePicture;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    this.profilePicture = '',

  });

}
