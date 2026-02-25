import 'package:flutter/material.dart';
import 'package:readease/utils/constants.dart';
import 'package:readease/widgets/word_widget.dart';
import 'package:readease/services/tts_service.dart';
import 'package:readease/services/analytics_service.dart';
import 'package:readease/services/llm_service.dart';
import 'package:readease/services/database_service.dart';

class ReadingScreen extends StatefulWidget {
  final String initialText;

  const ReadingScreen({Key? key, required this.initialText}) : super(key: key);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late List<String> words;
  final TTSService _tts = TTSService();
  final AnalyticsService _analytics = AnalyticsService();
  final LLMService _llmService = LLMService();

  double _currentTextSize = 24.0;
  Color _currentBgColor = AppColors.bgCream;
  bool _isSimplifying = false;

  @override
  void initState() {
    super.initState();
    _updateWords(widget.initialText);
  }

  void _updateWords(String text) {
    String cleanText = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    setState(() {
      words = cleanText.split(' ');
    });
  }

  void _triggerRuleEngine() {
    setState(() {});
  }

  // --- NEW: SAVE WITH CUSTOM NAME DIALOG ---
  void _saveCurrentSession() {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("Name your note", style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "e.g., Science Chapter 1",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                String currentText = words.join(" ");
                DatabaseService.addNote(currentText, title: nameController.text);

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Saved as '${nameController.text}'! 📚"),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // --- MAGIC AI POP-UP FUNCTION ---
  Future<void> _simplifyCurrentText() async {
    if (_isSimplifying) return;

    setState(() => _isSimplifying = true);
    String currentParagraph = words.join(" ");
    String simplifiedParagraph = await _llmService.simplifyText(currentParagraph);
    setState(() => _isSimplifying = false);

    if (mounted) {
      List<String> simplifiedWords = simplifiedParagraph.split(' ');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: _currentBgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: const Row(
              children: [
                Icon(Icons.auto_awesome, color: AppColors.primary, size: 28),
                SizedBox(width: 12),
                Text("Magic Teacher",
                    style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: simplifiedWords.map((word) {
                    return WordWidget(
                      word: word,
                      ttsService: _tts,
                      analytics: _analytics,
                      textSize: _currentTextSize * 0.8,
                      onAdaptationTriggered: () => setState(() {}),
                    );
                  }).toList(),
                ),
              ),
            ),
            actions: [
              TextButton.icon(
                onPressed: () {
                  // Prompt for name when saving AI notes too
                  Navigator.pop(context); // Close AI dialog
                  _saveAIResult(simplifiedParagraph);
                },
                icon: const Icon(Icons.bookmark_add_outlined, color: AppColors.primary),
                label: const Text("Save Note", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  _tts.stop();
                  Navigator.of(context).pop();
                },
                child: const Text("Got it!",
                    style: TextStyle(color: AppColors.textMuted, fontSize: 16)
                ),
              ),
            ],
          );
        },
      );
    }
  }

  // Helper to save AI result with a name
  void _saveAIResult(String content) {
    TextEditingController nameController = TextEditingController(text: "Magic Explanation");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Name your AI note"),
        content: TextField(controller: nameController),
        actions: [
          ElevatedButton(
            onPressed: () {
              DatabaseService.addNote(content, title: nameController.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Magic Note Saved! ✨")));
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  // Settings menu code remains same...
  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceLight,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Reading Settings",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain)
                  ),
                  const SizedBox(height: 24),
                  const Text("Text Size",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMuted)
                  ),
                  Slider(
                    value: _currentTextSize,
                    min: 16.0,
                    max: 42.0,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.borderLight,
                    onChanged: (val) {
                      setModalState(() => _currentTextSize = val);
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text("Page Color",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMuted)
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildColorOption(AppColors.bgCream, "Cream", setModalState),
                        _buildColorOption(AppColors.bgSoftBlue, "Blue", setModalState),
                        _buildColorOption(AppColors.bgMint, "Mint", setModalState),
                        _buildColorOption(AppColors.bgPeach, "Peach", setModalState),
                        _buildColorOption(AppColors.bgSoftYellow, "Yellow", setModalState),
                        _buildColorOption(AppColors.bgSoftGray, "Gray", setModalState),
                        _buildColorOption(AppColors.bgSoftPink, "Pink", setModalState),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildColorOption(Color color, String name, StateSetter setModalState) {
    bool isSelected = _currentBgColor == color;
    return GestureDetector(
      onTap: () {
        setModalState(() => _currentBgColor = color);
        setState(() {});
      },
      child: Column(
        children: [
          Container(
            width: 45, height: 45,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.borderLight,
                    width: isSelected ? 3 : 1
                ),
                boxShadow: [
                  if (isSelected) BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8)
                ]
            ),
          ),
          const SizedBox(height: 8),
          Text(name,
              style: TextStyle(color: isSelected ? AppColors.primary : AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold)
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentBgColor,
      appBar: AppBar(
        title: const Text("Reading Session", style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Wrap(
          children: words.map((word) {
            return WordWidget(
              word: word,
              ttsService: _tts,
              analytics: _analytics,
              textSize: _currentTextSize,
              onAdaptationTriggered: _triggerRuleEngine,
            );
          }).toList(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: "settings_btn",
            backgroundColor: AppColors.surfaceLight,
            onPressed: _openSettings,
            child: const Icon(Icons.palette_rounded, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            mini: true,
            heroTag: "save_btn",
            backgroundColor: AppColors.surfaceLight,
            onPressed: _saveCurrentSession,
            child: const Icon(Icons.bookmark_add_rounded, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "ai_btn",
            backgroundColor: AppColors.primary,
            onPressed: _simplifyCurrentText,
            child: _isSimplifying
                ? const Padding(
              padding: EdgeInsets.all(12.0),
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            )
                : const Icon(Icons.auto_awesome, color: Colors.white),
          ),
        ],
      ),
    );
  }
}