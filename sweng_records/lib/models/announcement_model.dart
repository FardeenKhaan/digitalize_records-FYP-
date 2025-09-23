class Announcement {
  final int id;
  final String title;
  final String message;
  final String postedBy;
  final String createdAt;

  Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.postedBy,
    required this.createdAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      postedBy: json['posted_by'],
      createdAt: json['created_at'],
    );
  }
}
