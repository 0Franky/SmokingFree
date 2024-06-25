
import 'package:smoke_free/models/store_data/DailyRecord.dart';
import 'package:smoke_free/models/store_data/MainInformation.dart';
import 'package:smoke_free/repos/UserStorage.dart';

String MAIN_INFORMATION_ENTRY = "mainInformation";
String PREFERENCES_ENTRY = "preferences";
String DAILY_RECORD_ENTRY = "dailyRecord";

Future<DailyRecord> getDailyRecord() async {
  DailyRecord? daily =
      await UserStorage.loadUserData(DAILY_RECORD_ENTRY, DailyRecord.fromJson);

  MainInformation mainInfo = (await UserStorage.loadUserData(
      MAIN_INFORMATION_ENTRY, MainInformation.fromJson))!;

  if (daily == null) {
    daily = DailyRecord(
      maxAllowedCigarettes: mainInfo.currentMaxCigarettesPerDay,
    );

    await UserStorage.save(DAILY_RECORD_ENTRY, daily);
  }

  return daily;
}