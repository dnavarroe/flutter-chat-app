import 'package:flutter/material.dart';

class Forma extends StatelessWidget {
  final List<Color> colors;
  final CustomClipper<Path> clipper;
  const Forma({
    Key? key,
    required this.colors,
    required this.clipper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ClipPath(
        clipper: clipper,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
      ),
    );
  }
}

class TopForm extends StatelessWidget {
  const TopForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Forma(
            clipper: _MyClipperTop1(),
            colors: const [Color(0xff7DB5FA), Color(0xff43CCF0)]),
        Expanded(flex: 2, child: Container()),
        Forma(
            clipper: _MyClipperTop2(),
            colors: const [Color(0xff7DB5FA), Color(0xff43CCF0)]),
      ],
    );
  }
}

class BotForm extends StatelessWidget {
  const BotForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Forma(
          clipper: _MyClipperTop1(),
          colors: const [Color(0xff5361E0), Color(0xff7F56F5)],
        ),
        Expanded(
          flex: 3,
          child: Container(),
        ),
        Forma(
          clipper: _MyClipperTop2(),
          colors: const [Color(0xff5361E0), Color(0xff7F56F5)],
        ),
      ],
    );
  }
}

class _MyClipperTop1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.45,
        size.width * 0.25, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.25,
        size.width * 0.5, size.height * 0.35);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.55, size.width, size.height * 0.35);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _MyClipperTop2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.45,
        size.width * 0.25, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.75,
        size.width * 0.50, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.35, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}