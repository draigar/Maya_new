import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white, // Change the color as needed
          ),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              // You can customize each swiper item
              return Center(
                child: Text('Page $index'),
              );
            },
            itemCount: 3, // Adjust the number of onboarding pages
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
          ),
        ),
      ],
    );
  }
}
