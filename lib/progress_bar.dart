import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaticProgressBar extends StatefulWidget {
  final double percent;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final Text centerText;
  final bool animation;
  final int animationDuration;

  StaticProgressBar({
    @required this.percent,
    @required this.width,
    @required this.height,
    @required this.backgroundColor,
    @required this.progressColor,
    this.centerText,
    this.animation = false,
    this.animationDuration = 500,
  });

  @override
  _StaticProgressBarState createState() => _StaticProgressBarState();
}

class _StaticProgressBarState extends State<StaticProgressBar> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  double _percent = 0.0;
  Curve _curve = Curves.easeIn;

  void _updatePercent() {
    setState(() {
      _percent = widget.percent;
    });
  }

  @override
  void initState() {
    if (widget.animation) {
      _animationController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.animationDuration));
      _animation = Tween(begin: 0.0, end: widget.percent)
          .animate(CurvedAnimation(parent: _animationController, curve: _curve))
            ..addListener(() {
              setState(() {
                _percent = _animation.value;
              });
            });
      _animationController.forward();
    } else {
      _updatePercent();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: RRectProgressBarPainter(
              progress: _percent,
              rectWidth: widget.width,
              rectHeight: widget.height,
              progressColor: widget.progressColor,
              backgroundColor: widget.backgroundColor,
            ),
          ),
          Container(alignment: Alignment.center, child: widget.centerText)
        ],
      ),
    );
  }
}

class RRectProgressBarPainter extends CustomPainter {
  final Paint _paintBackground = new Paint();
  final Paint _paintLine = new Paint();
  final double rectWidth;
  final double rectHeight;
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  RRectProgressBarPainter({
    this.rectWidth,
    this.rectHeight,
    this.progress,
    this.progressColor,
    this.backgroundColor,
  }) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.fill;

    _paintLine.color = progressColor;
    _paintLine.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double progressWidth = rectWidth * progress;
    final RRect _backgrounRect =
        RRect.fromLTRBR(0, 0, rectWidth, rectHeight, Radius.circular(10));
    final RRect _lineRect =
        RRect.fromLTRBR(0, 0, progressWidth, rectHeight, Radius.circular(10));

    canvas.drawRRect(_backgrounRect, _paintBackground);
    canvas.drawRRect(_lineRect, _paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
