abstract class TodayApodEvent {}

class LoadApodEvent extends TodayApodEvent {}

class LoadApodByDateEvent extends TodayApodEvent {
  final String date;

  LoadApodByDateEvent({required this.date});
}
