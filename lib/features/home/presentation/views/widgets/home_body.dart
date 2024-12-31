import 'package:flutter/material.dart';
import '../../../../../utils/widget/custom_text_form_field.dart';
import 'custom_google_map.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Stack(
            // clipBehavior: Clip.none,
            children: [
              CustomGoogleMap(),
              Padding(
                padding: EdgeInsets.all(16),
                child: CustomTextFormField(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
