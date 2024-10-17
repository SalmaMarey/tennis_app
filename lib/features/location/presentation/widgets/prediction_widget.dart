import 'package:flutter/material.dart';

class PredictionWidget extends StatelessWidget {
  final double tempC;
  final double humidity;
  final double cloud;
  final Function(String) showPredictionDialog;

  const PredictionWidget({
    super.key,
    required this.tempC,
    required this.humidity,
    required this.cloud,
    required this.showPredictionDialog,
  });

  bool _shouldGoOut() {
    const double tempThreshold = 30.0;
    const double humidityThreshold = 60.0;
    const double cloudThreshold = 50.0;

    bool isTempGood = tempC < tempThreshold;
    bool isHumidityGood = humidity < humidityThreshold;
    bool isCloudGood = cloud < cloudThreshold;

    return isTempGood && isHumidityGood && isCloudGood;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.sports_tennis,
        color: Colors.white,
      ),
      onPressed: () {
        bool isGoodToGoOut = _shouldGoOut();
        showPredictionDialog(isGoodToGoOut
            ? 'The weather is good for exercise'
            : 'The weather is not suitable for exercise');
      },
    );
  }
}
