import 'package:flutter/material.dart';

class Zoom extends StatelessWidget {
  @override
  final image;
  Zoom({this.image});
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: Center(
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: Center(
            child: InteractiveViewer(
                boundaryMargin: EdgeInsets.all(80),
                panEnabled: false,
                scaleEnabled: true,
                minScale: 1.0,
                maxScale: 2.2,
                child: Image.network("https://pngimg.com/uploads/muffin/muffin_PNG123.png",
                  fit: BoxFit.fitWidth,
                )
            ),
          ),
          /* ... */
        ),
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }
}
