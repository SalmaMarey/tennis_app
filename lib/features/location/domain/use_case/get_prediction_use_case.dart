import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

class GetPredictionUseCase {
  final LocationWeatherRepository repository;

  GetPredictionUseCase(this.repository);

  Future<int> execute(List<int> features) async {
    return await repository.getPrediction(features);
  }
}