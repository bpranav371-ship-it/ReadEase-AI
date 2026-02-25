class AnalyticsService {
  final DateTime sessionStart = DateTime.now();
  final Map<String, int> wordTaps = {};

  void recordTap(String word) {
    String cleanWord = word.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
    wordTaps[cleanWord] = (wordTaps[cleanWord] ?? 0) + 1;
    print("Analytics: $cleanWord tapped ${wordTaps[cleanWord]} times.");
  }

  List<String> getStruggleWords() {
    return wordTaps.entries
        .where((entry) => entry.value >= 2) // Rule Engine Trigger
        .map((entry) => entry.key)
        .toList();
  }

  int calculateSessionDurationMinutes() {
    return DateTime.now().difference(sessionStart).inMinutes;
  }
}