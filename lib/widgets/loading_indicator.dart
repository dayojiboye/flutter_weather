import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/utils/theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 96,
              width: 96,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(
                    animating: true,
                    color: kWhite,
                    radius: 10,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please wait...",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
