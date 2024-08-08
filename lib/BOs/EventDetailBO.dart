class EventDetail {
  DateTime createdAt;
  String title;
  String description;
  String status;
  DateTime startAt;
  int duration;
  String id;
  List<String> images;

  EventDetail({
    required this.createdAt,
    required this.title,
    required this.description,
    required this.status,
    required this.startAt,
    required this.duration,
    required this.id,
    required this.images,
  });

  // Convert JSON map to EventDetail object
  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      startAt: DateTime.parse(json['createdAt'] ?? ''),
      duration: json['duration'] ?? 0,
      id: json['id'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  // Convert EventDetail object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'status': status,
      'startAt': startAt.toIso8601String(),
      'duration': duration,
      'id': id,
      'images': images,
    };
  }

  // Convert Map to EventDetail object
  factory EventDetail.fromMap(Map<String, dynamic> map) {
    return EventDetail(
      createdAt: DateTime.parse(map['createdAt']),
      title: map['title'],
      description: map['description'],
      status: map['status'],
      startAt: DateTime.parse(map['startAt']),
      duration: map['duration'],
      id: map['id'],
      images: (map['images'] as String).split(','),
    );
  }

  // Convert EventDetail object to Map
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'status': status,
      'startAt': startAt.toIso8601String(),
      'duration': duration,
      'id': id,
      'images': images.join(','), // Convert list to comma-separated string
    };
  }
}
