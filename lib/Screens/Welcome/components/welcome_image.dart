import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Bienvenido",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        // Text(
        //   "Bienvenido",
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        // ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/LOGOAPOYO.png",
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
