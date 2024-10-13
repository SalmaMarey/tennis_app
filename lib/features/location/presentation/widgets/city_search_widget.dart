import 'package:flutter/material.dart';

class CitySearchWidget extends StatefulWidget {
  final TextEditingController cityController;

  const CitySearchWidget({super.key, required this.cityController});

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: widget.cityController,
                decoration: InputDecoration(
                  hintText: 'Location',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 0, 33, 60),
                    fontSize:
                        isPortrait ? size.width * 0.04 : size.height * 0.04,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color.fromARGB(255, 0, 33, 60),
                    size: isPortrait ? size.width * 0.06 : size.height * 0.06,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.03,
                  ),
                ),
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 33, 60),
                  fontSize:
                      isPortrait ? size.width * 0.045 : size.height * 0.045,
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.02),
          ElevatedButton(
            onPressed: () {
              final cityName = widget.cityController.text.trim();
              if (cityName.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: {
                    'cityName': cityName,
                  },
                );
                widget.cityController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.015,
              ),
              backgroundColor: Colors.grey.withOpacity(0.7),
              textStyle: TextStyle(
                fontSize: isPortrait ? size.width * 0.035 : size.height * 0.035,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Get Weather',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 33, 60),
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
