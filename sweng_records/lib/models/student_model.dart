class Student {
  final int id;
  final String name;
  final String fatherName;
  final String rollNumber;
  final String section;
  final String createdAt;

  Student({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.rollNumber,
    required this.section,
    required this.createdAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      fatherName: json['father_name'],
      rollNumber: json['roll_number'],
      section: json['section'],
      createdAt: json['created_at'],
    );
  }
}
