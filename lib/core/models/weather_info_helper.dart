class WeatherInfo {
  final String imagePath;
  final String description;

  WeatherInfo(this.imagePath, this.description);
}

WeatherInfo getWeatherInfo(double temp) {
  if (temp >= 10 && temp < 15) {
    return WeatherInfo('assets/weather/storm.png', 'Rainy');
  } else if (temp >= 15 && temp < 20) {
    return WeatherInfo('assets/weather/cloud3.png', 'Mostly Cloudy');
  } else if (temp >= 20 && temp < 25) {
    return WeatherInfo('assets/weather/cloud1.png', 'Partly Cloudy');
  } else if (temp >= 25 && temp < 30) {
    return WeatherInfo('assets/weather/cloud2.png', 'Mostly Sunny');
  } else if (temp >= 30 && temp < 40) {
    return WeatherInfo('assets/weather/sun.png', 'Sunny');
  }
  return WeatherInfo('assets/weather/cloud1.png', 'Partly Cloudy');
}
