import 'package:flutter/material.dart';
import 'custom_google_map.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Expanded(child: CustomGoogleMap()),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
