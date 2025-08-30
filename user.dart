class AppUser {
  final String role; // 'Student', 'Teacher', 'Admin'
  final String region; // e.g., 'Punjab / Ludhiana'

  AppUser({required this.role, required this.region});

  Map<String, dynamic> toJson() => {'role': role, 'region': region};

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      AppUser(role: json['role'] as String, region: json['region'] as String);
}
