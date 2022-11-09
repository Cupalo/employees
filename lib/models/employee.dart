class Employee {
  Employee({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
      };
}
