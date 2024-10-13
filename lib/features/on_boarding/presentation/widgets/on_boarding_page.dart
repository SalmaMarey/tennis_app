import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnBoardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: image,
            height: 500,
            // fit: BoxFit.fitHeight,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(200, 0, 87, 166),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(200, 0, 87, 166), fontSize: 16)),
        ],
      ),
    );
  }
}
