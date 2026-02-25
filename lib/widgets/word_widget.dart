import 'package:flutter/material.dart';
import 'package:readease/services/tts_service.dart';
import 'package:readease/services/analytics_service.dart';

class WordWidget extends StatefulWidget {
  final String word;
  final TTSService ttsService;
  final AnalyticsService analytics;
  final Function() onAdaptationTriggered;
  final double textSize; // <-- ADDED THIS

  const WordWidget({
    Key? key,
    required this.word,
    required this.ttsService,
    required this.analytics,
    required this.onAdaptationTriggered,
    required this.textSize, // <-- ADDED THIS
  }) : super(key: key);

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  int localTapCount = 0;

  void _handleTap() {
    widget.ttsService.speak(widget.word);
    widget.analytics.recordTap(widget.word);

    setState(() {
      localTapCount++;
    });

    if (localTapCount >= 2) {
      widget.onAdaptationTriggered();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isStruggling = localTapCount >= 2;

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
        padding: isStruggling ? const EdgeInsets.symmetric(horizontal: 4.0) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isStruggling ? const Color(0xFFFDE047).withOpacity(0.4) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          "${widget.word} ",
          style: TextStyle(
            fontSize: widget.textSize, // <-- NOW USES THE DYNAMIC SIZE
            height: 1.8,
            letterSpacing: 1.5,
            color: const Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}