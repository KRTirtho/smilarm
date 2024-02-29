extension DurationExtensions on Duration {
  String formatHHmm() {
    final hours = inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
