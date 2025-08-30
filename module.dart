class ModuleItem {
  final String id;
  final String title;
  final String summary;
  final String content;
  final int estimatedMinutes;

  ModuleItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.estimatedMinutes,
  });

  factory ModuleItem.fromJson(Map<String, dynamic> json) => ModuleItem(
        id: json['id'],
        title: json['title'],
        summary: json['summary'],
        content: json['content'],
        estimatedMinutes: json['estimated_minutes'],
      );
}
