extension DateManager on int {
  String msToDisplayDuration() {
    int totalSeconds = (this / 1000).floor();
    int hours = (totalSeconds / 3600).floor();
    int remainingSeconds = totalSeconds % 3600;
    int minutes = (remainingSeconds / 60).floor();
    int seconds = remainingSeconds % 60;

    // Format hours, minutes, and seconds with leading zeros where needed
    String formattedTime;
    if (hours > 0) {
      formattedTime =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      formattedTime =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    return formattedTime;
  }
}
