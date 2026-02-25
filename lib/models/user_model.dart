class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final int totalWordsRead;
  final int currentStreak;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.totalWordsRead = 0,
    this.currentStreak = 0,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'totalWordsRead': totalWordsRead,
      'currentStreak': currentStreak,
    };
  }

  // Create from Firestore Document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'],
      totalWordsRead: map['totalWordsRead']?.toInt() ?? 0,
      currentStreak: map['currentStreak']?.toInt() ?? 0,
    );
  }
}