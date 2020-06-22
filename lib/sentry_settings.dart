
import 'package:sentry/sentry.dart';

const String dsn = 'https://0ae4a6d4a217482ca1ac11ee9b4f4638@o401399.ingest.sentry.io/5284716';
final SentryClient _sentry = new SentryClient(dsn: dsn);

Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  print('Reporting error to Sentry...');

  final SentryResponse response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Error reported. Event id: ${response.eventId}');
  } else {
    print('Failed to report to Sentry: ${response.error}');
  }
}