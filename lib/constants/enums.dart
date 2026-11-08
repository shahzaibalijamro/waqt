enum AsrSchool {
  shafi(
    id: 0,
    displayName: 'Shafi (Standard)',
    description: 'Standard shadow-length rule (one mithl).',
  ),
  hanafi(
    id: 1,
    displayName: 'Hanafi',
    description: 'Longer shadow-length rule (two mithl).',
  );

  const AsrSchool({
    required this.id,
    required this.displayName,
    required this.description,
  });

  final int id;
  final String displayName;
  final String description;
}

enum TimeFormat {
  twelveHour(name: '12-hour', description: 'Example: 05:30 PM'),
  twentyFourHour(name: '24-hour', description: 'Example: 17:30 PM');

  TimeFormat({required this.name, required this.description});

  final String name;
  final String description;
}

enum Screen { home, calendar, settings, search }
