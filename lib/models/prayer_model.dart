// To parse this JSON data, do
//
//     final prayerResponse = prayerResponseFromJson(jsonString);

import 'dart:convert';

PrayerResponse prayerResponseFromJson(String str) =>
    PrayerResponse.fromJson(json.decode(str));

String prayerResponseToJson(PrayerResponse data) => json.encode(data.toJson());

class PrayerResponse {
  final Timings timings;
  final Date date;

  PrayerResponse({required this.timings, required this.date});

  factory PrayerResponse.fromJson(Map<String, dynamic> json) => PrayerResponse(
    timings: Timings.fromJson(json['timings']),
    date: Date.fromJson(json['date']),
  );

  Map<String, dynamic> toJson() => {
    'timings': timings.toJson(),
    'date': date.toJson(),
  };
}

class Date {
  final String readable;
  final String timestamp;
  final Hijri hijri;
  final Gregorian gregorian;

  Date({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    readable: json['readable'],
    timestamp: json['timestamp'],
    hijri: Hijri.fromJson(json['hijri']),
    gregorian: Gregorian.fromJson(json['gregorian']),
  );

  Map<String, dynamic> toJson() => {
    'readable': readable,
    'timestamp': timestamp,
    'hijri': hijri.toJson(),
    'gregorian': gregorian.toJson(),
  };
}

class Gregorian {
  final String date;
  final String format;
  final String day;
  final GregorianWeekday weekday;
  final GregorianMonth month;
  final String year;
  final Designation designation;
  final bool lunarSighting;

  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
    date: json['date'],
    format: json['format'],
    day: json['day'],
    weekday: GregorianWeekday.fromJson(json['weekday']),
    month: GregorianMonth.fromJson(json['month']),
    year: json['year'],
    designation: Designation.fromJson(json['designation']),
    lunarSighting: json['lunarSighting'],
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'format': format,
    'day': day,
    'weekday': weekday.toJson(),
    'month': month.toJson(),
    'year': year,
    'designation': designation.toJson(),
    'lunarSighting': lunarSighting,
  };
}

class Designation {
  final String abbreviated;
  final String expanded;

  Designation({required this.abbreviated, required this.expanded});

  factory Designation.fromJson(Map<String, dynamic> json) =>
      Designation(abbreviated: json['abbreviated'], expanded: json['expanded']);

  Map<String, dynamic> toJson() => {
    'abbreviated': abbreviated,
    'expanded': expanded,
  };
}

class GregorianMonth {
  final int number;
  final String en;

  GregorianMonth({required this.number, required this.en});

  factory GregorianMonth.fromJson(Map<String, dynamic> json) =>
      GregorianMonth(number: json['number'], en: json['en']);

  Map<String, dynamic> toJson() => {'number': number, 'en': en};
}

class GregorianWeekday {
  final String en;

  GregorianWeekday({required this.en});

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      GregorianWeekday(en: json['en']);

  Map<String, dynamic> toJson() => {'en': en};
}

class Hijri {
  final String date;
  final String format;
  final String day;
  final HijriWeekday weekday;
  final HijriMonth month;
  final String year;
  final Designation designation;
  final List<dynamic> holidays;
  final List<dynamic> adjustedHolidays;
  final String method;

  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
    required this.adjustedHolidays,
    required this.method,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
    date: json['date'],
    format: json['format'],
    day: json['day'],
    weekday: HijriWeekday.fromJson(json['weekday']),
    month: HijriMonth.fromJson(json['month']),
    year: json['year'],
    designation: Designation.fromJson(json['designation']),
    holidays: List<dynamic>.from(json['holidays'].map((x) => x)),
    adjustedHolidays: List<dynamic>.from(
      json['adjustedHolidays'].map((x) => x),
    ),
    method: json['method'],
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'format': format,
    'day': day,
    'weekday': weekday.toJson(),
    'month': month.toJson(),
    'year': year,
    'designation': designation.toJson(),
    'holidays': List<dynamic>.from(holidays.map((x) => x)),
    'adjustedHolidays': List<dynamic>.from(adjustedHolidays.map((x) => x)),
    'method': method,
  };
}

class HijriMonth {
  final int number;
  final String en;
  final String ar;
  final int days;

  HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
    required this.days,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
    number: json['number'],
    en: json['en'],
    ar: json['ar'],
    days: json['days'],
  );

  Map<String, dynamic> toJson() => {
    'number': number,
    'en': en,
    'ar': ar,
    'days': days,
  };
}

class HijriWeekday {
  final String en;
  final String ar;

  HijriWeekday({required this.en, required this.ar});

  factory HijriWeekday.fromJson(Map<String, dynamic> json) =>
      HijriWeekday(en: json['en'], ar: json['ar']);

  Map<String, dynamic> toJson() => {'en': en, 'ar': ar};
}

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
    fajr: json['Fajr'],
    sunrise: json['Sunrise'],
    dhuhr: json['Dhuhr'],
    asr: json['Asr'],
    sunset: json['Sunset'],
    maghrib: json['Maghrib'],
    isha: json['Isha'],
    imsak: json['Imsak'],
    midnight: json['Midnight'],
    firstthird: json['Firstthird'],
    lastthird: json['Lastthird'],
  );

  Map<String, dynamic> toJson() => {
    'Fajr': fajr,
    'Sunrise': sunrise,
    'Dhuhr': dhuhr,
    'Asr': asr,
    'Sunset': sunset,
    'Maghrib': maghrib,
    'Isha': isha,
    'Imsak': imsak,
    'Midnight': midnight,
    'Firstthird': firstthird,
    'Lastthird': lastthird,
  };
}

class NextPrayer {
  final String name;
  final String time;
  final String beginsIn;

  NextPrayer({required this.name, required this.time, required this.beginsIn});
}
