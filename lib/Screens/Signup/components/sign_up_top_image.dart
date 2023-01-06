import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Center(
          child: Text(
            "Registro".toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/LOGOAPOYO.png",
                height: 120,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
