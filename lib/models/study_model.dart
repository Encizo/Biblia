import 'package:cloud_firestore/cloud_firestore.dart';

class Study {
  final String verse;
  final String studyText;
  final DateTime createdAt;
  final String? externalUrl;

  Study({
    required this.verse,
    required this.studyText,
    required this.createdAt,
    this.externalUrl,
  });

  Map<String, dynamic> toMap() => {
        'verse': verse,
        'studyText': studyText,
        'createdAt': Timestamp.fromDate(createdAt),
        'externalUrl': externalUrl,
      };

  factory Study.fromMap(Map<String, dynamic> map) => Study(
        verse: map['verse'],
        studyText: map['studyText'],
        createdAt: (map['createdAt'] as Timestamp).toDate(),
        externalUrl: map['externalUrl'],
      );
}
