import 'package:flutter/material.dart';

class CitySearchWidget extends StatelessWidget {
  final TextEditingController cityController;
  final VoidCallback onGetWeather; 

  const CitySearchWidget({
    super.key,
    required this.cityController,
    required this.onGetWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  hintText: 'Location',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 0, 33, 60)),
                  prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 0, 33, 60)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                style: const TextStyle(color: Color.fromARGB(255, 0, 33, 60)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onGetWeather, // Now correctly typed
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              backgroundColor: Colors.grey.withOpacity(0.7),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Get Weather',
              style: TextStyle(color: Color.fromARGB(255, 0, 33, 60)),
            ),
          ),
        ],
      ),
    );
  }
}
