class UploadedImage {
  final int id;
  final String filePath;
  final String fileType;
  final DateTime timestamp;
  final double? confidenceScore;
  final String? description;

  UploadedImage({
    required this.id,
    required this.filePath,
    required this.fileType,
    required this.timestamp,
    this.confidenceScore,
    this.description,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) {
    return UploadedImage(
      id: json['id'],
      filePath: json['file_path'],
      fileType: json['file_type'],
      timestamp: DateTime.parse(json['timestamp']),
      confidenceScore: json['confidence_score'] != null
          ? (json['confidence_score'] as num).toDouble()
          : null,
      description: json['model_output'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_path': filePath,
      'file_type': fileType,
      'timestamp': timestamp.toIso8601String(),
      'confidence_score': confidenceScore,
      'model_output': description,
    };
  }
}
