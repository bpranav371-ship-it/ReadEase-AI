import 'package:flutter/material.dart';
import '../services/theme_service.dart';

class ReadingScreen extends StatefulWidget {
  final String text;
  const ReadingScreen({super.key, this.text = "No text provided. Go back and scan something!"});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  double _fontSize = 20.0;

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Readability Settings", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text("Text Size"),
              Slider(
                value: _fontSize,
                min: 14.0, max: 40.0,
                onChanged: (val) {
                  setState(() => _fontSize = val);
                  (context as Element).markNeedsBuild();
                },
              ),
              const SizedBox(height: 20),
              const Text("Color Themes"),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dyslexiaOptions.length,
                  itemBuilder: (context, index) {
                    final palette = dyslexiaOptions[index];
                    return GestureDetector(
                      onTap: () {
                        ThemeService.changeTheme(index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 90,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: palette.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Aa", style: TextStyle(color: palette.text, fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(palette.name, style: TextStyle(color: palette.text, fontSize: 10)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DyslexiaPalette>(
      valueListenable: ThemeService.currentTheme,
      builder: (context, palette, _) {
        return Scaffold(
          backgroundColor: palette.background,
          appBar: AppBar(
            backgroundColor: palette.background,
            elevation: 0,
            iconTheme: IconThemeData(color: palette.text),
            title: Text("Reading Mode", style: TextStyle(color: palette.text)),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showSettings,
            backgroundColor: Colors.cyanAccent,
            child: const Icon(Icons.settings, color: Colors.black),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              widget.text,
              style: TextStyle(
                color: palette.text,
                fontSize: _fontSize,
                height: 1.8,
                letterSpacing: 1.1,
              ),
            ),
          ),
        );
      },
    );
  }
}