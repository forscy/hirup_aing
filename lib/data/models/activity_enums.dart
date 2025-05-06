enum Frequency { DAILY, WEEKLY, MONTHLY }

enum Days { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }

enum ActivityStatus { PENDING, COMPLETED, POSTPONED, CANCELLED }

// Ekstensi untuk konversi ke string yang lebih mudah dibaca
extension FrequencyExtension on Frequency {
  String get displayName {
    switch (this) {
      case Frequency.DAILY:
        return 'Harian';
      case Frequency.WEEKLY:
        return 'Mingguan';
      case Frequency.MONTHLY:
        return 'Bulanan';
    }
  }
}

extension DaysExtension on Days {
  String get displayName {
    switch (this) {
      case Days.MONDAY:
        return 'Senin';
      case Days.TUESDAY:
        return 'Selasa';
      case Days.WEDNESDAY:
        return 'Rabu';
      case Days.THURSDAY:
        return 'Kamis';
      case Days.FRIDAY:
        return 'Jumat';
      case Days.SATURDAY:
        return 'Sabtu';
      case Days.SUNDAY:
        return 'Minggu';
    }
  }
}

extension ActivityStatusExtension on ActivityStatus {
  String get displayName {
    switch (this) {
      case ActivityStatus.PENDING:
        return 'Belum';
      case ActivityStatus.COMPLETED:
        return 'Selesai';
      case ActivityStatus.POSTPONED:
        return 'Ditunda';
      case ActivityStatus.CANCELLED:
        return 'Batalkan';
    }
  }
}
