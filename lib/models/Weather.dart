class Weather {
  final double temp;
  final double faren;

  final double feelslike;
  final double low;
  final double high;
  final String pressure;
  final String humidity;
  final String speed;
  final String description;

  Weather({
    required this.temp,
    required this.faren,
    required this.feelslike,
    required this.low,
    required this.high,
    required this.description,
    required this.humidity,
    required this.pressure,
    required this.speed
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      faren: double.parse((json['main']['temp']*(9/5)+32).toStringAsFixed(2)),
      feelslike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'].toString(),
      pressure: json['main']['pressure'].toString(),
      speed: json['wind']['speed'].toString(),
      description: json['weather'][0]['description'].toString(),

    );
  }
}
