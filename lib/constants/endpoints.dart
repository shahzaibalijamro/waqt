class AppEndpoints {
  static const String _baseUrl = 'https://api.aladhan.com/v1';

  static final Uri methods = Uri.parse('$_baseUrl/methods');
  static const String locations =
      'https://geocoding-api.open-meteo.com/v1/search';
  static const String prayerData = 'https://api.aladhan.com/v1/timings';
  static const String calendarData = 'https://api.aladhan.com/v1/calendar';
}
