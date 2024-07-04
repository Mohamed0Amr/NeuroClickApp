import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vibration/vibration.dart';
import '../../../../controller/tips_controller.dart';

class TipWidget extends StatefulWidget {
  final String tip;
  final String tipId;
  final TipController tipController;

  const TipWidget({
    Key? key,
    required this.tip,
    required this.tipId,
    required this.tipController,
  }) : super(key: key);

  @override
  _TipWidgetState createState() => _TipWidgetState();
}

class _TipWidgetState extends State<TipWidget> {
  bool _isSelected = false;
  bool _showOverlay = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final Color bgColor = Color.fromRGBO(2, 190, 203, 1);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
              _handleCheckBoxClick();
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 22, right: 22, bottom: 14),
            child: Container(
              width: screenWidth,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.tip,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Checkbox(
                      value: _isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _isSelected = value ?? false;
                          _handleCheckBoxClick();
                        });
                      },
                      checkColor: Colors.black,
                      fillColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isSelected && _showOverlay) _buildFullScreenOverlay(),
      ],
    );
  }

  Future<void> _handleCheckBoxClick() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 100);
    }

    setState(() {
      _showOverlay = _isSelected;
    });

    if (_isSelected) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _showOverlay = false;
      });

      // Call the delete method from TipController
      try {
        await widget.tipController.delete(widget.tipId);
        // Optionally, you can also remove the tip from the UI
        // This callback can be passed to the parent to handle the UI update
      } catch (e) {
        print("Failed to delete tip: $e");
      }
    }
  }

  Widget _buildFullScreenOverlay() {
    return Positioned.fill(
      child: Center(
        child: Transform.scale(
          scale: 2.0,
          child: Lottie.asset("assets/animations/Anm-1.json"),
        ),
      ),
    );
  }

  Color _generateRandomColor() {
    return Color((DateTime.now().millisecondsSinceEpoch / 950).toInt() << 0)
        .withOpacity(1.0);
  }
}
