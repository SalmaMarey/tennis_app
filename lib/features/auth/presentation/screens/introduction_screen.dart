import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';



class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 0, 87, 166),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(200.0),
              bottomRight: Radius.circular(200.0),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://img.freepik.com/free-photo/people-activity-lifestyle-standing-slim_1368-1941.jpg?t=st=1727201695~exp=1727205295~hmac=5fdd791bf10a7ac49fc9ac6309ca096b1046e6e3062e800462ec5c4f5e8d2e1c&w=2000',
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
           Navigator.of(context).pushNamed('/signup');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 8, 36, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: const Size(285, 50),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: const Size(285, 50),
            ),
            child: const Text(
              'Log In',
              style: TextStyle(
                  color: Color.fromARGB(255, 8, 36, 59),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
