import 'package:flutter/material.dart';
import 'dark_alarm_setting.dart';
import 'dark_option.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class MainDarkScreen extends StatefulWidget {
  final List<Map<String, dynamic>> alarms;

  const MainDarkScreen({super.key, required this.alarms});

  @override
  _MainDarkScreenState createState() => _MainDarkScreenState();
}

class _MainDarkScreenState extends State<MainDarkScreen> {
  List<Map<String, dynamic>> alarms = [];
  late Timer _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache(prefix: 'assets/');

  @override
  void initState() {
    super.initState();
    alarms = widget.alarms;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkAlarms();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _calculateTimeRemaining(String alarmTime) {
    final now = DateTime.now();
    final alarm = DateTime(now.year, now.month, now.day, int.parse(alarmTime.split(':')[0]), int.parse(alarmTime.split(':')[1]));

    Duration difference = alarm.difference(now);
    if (difference.isNegative) {
      difference += const Duration(days: 1);
    }
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return '$hours시간 $minutes분 남음';
  }

  String _getNextAlarmTime() {
    if (alarms.isEmpty) {
      return '예정된 알람 없음';
    }
    alarms.sort((a, b) {
      DateTime alarmA = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(a['time'].split(':')[0]), int.parse(a['time'].split(':')[1]));
      DateTime alarmB = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(b['time'].split(':')[0]), int.parse(b['time'].split(':')[1]));
      return alarmA.compareTo(alarmB);
    });
    return _calculateTimeRemaining(alarms.first['time']);
  }

  void _setAlarmTime(Map<String, dynamic> time) {
    final String alarmTime = '${time['hour']}:${time['minute']}';
    setState(() {
      alarms.add({
        'time': alarmTime,
        'remaining': _calculateTimeRemaining(alarmTime),
        'volume': time['volume'],
      });
    });
  }

  void _deleteAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
    });
  }

  void _checkAlarms() {
    final now = DateTime.now();
    for (var alarm in alarms) {
      final alarmTime = DateTime(now.year, now.month, now.day, int.parse(alarm['time'].split(':')[0]), int.parse(alarm['time'].split(':')[1]));
      if (now.isAfter(alarmTime) && now.isBefore(alarmTime.add(const Duration(seconds: 1)))) {
        _playAlarm(alarm['volume']);
      }
    }
  }

  Future<void> _playAlarm(double volume) async {
    await _audioPlayer.setVolume(volume / 100);
    await _audioCache.play('alarm.mp3', volume: volume / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 1000,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1000,
                      decoration: const BoxDecoration(color: Color(0xFF2C2C2C)),
                    ),
                  ),
                  Positioned(
                    left: 500,
                    top: 800,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DarkAlarmSetting()),
                        );
                        if (result != null) {
                          _setAlarmTime(result);
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFF000AFF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 300,
                    top: 900,
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 90,
                            top: 20,
                            child: SizedBox(
                              width: 130,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const DarkOption()),
                                  );
                                },
                                child: const Text(
                                  '설정',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'Inconsolata',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 900,
                    child: SizedBox(
                      width: 300,
                      height: 80,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 300,
                              height: 80,
                              decoration: const BoxDecoration(color: Color(0xFF000AFF)),
                            ),
                          ),
                          const Positioned(
                            left: 90,
                            top: 20,
                            child: SizedBox(
                              width: 130,
                              height: 40,
                              child: Text(
                                '알람',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'Inconsolata',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    top: 30,
                    child: SizedBox(
                      width: 220,
                      height: 50,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 220,
                              height: 50,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF8A93B2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 45,
                            top: 10,
                            child: SizedBox(
                              width: 130,
                              height: 30,
                              child: Text(
                                '다음 알람',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF965555),
                                  fontSize: 20,
                                  fontFamily: 'Inconsolata',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    top: 80,
                    child: SizedBox(
                      width: 220,
                      height: 40,
                      child: Text(
                        _getNextAlarmTime(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Imprima',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  if (alarms.isEmpty)
                    Positioned(
                      left: 30,
                      top: 250,
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DarkAlarmSetting()),
                          );
                          if (result != null) {
                            _setAlarmTime(result);
                          }
                        },
                        child: SizedBox(
                          width: 570,
                          height: 130,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 570,
                                  height: 130,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF664949),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(70),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 30,
                                top: 40,
                                child: SizedBox(
                                  width: 500,
                                  height: 45,
                                  child: Text(
                                    '알람을 설정하세요',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFB96F6F),
                                      fontSize: 30,
                                      fontFamily: 'Imprima',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 30,
                    top: 150,
                    child: SizedBox(
                      width: 570,
                      height: 90,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context, alarms);
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 570,
                                height: 90,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 270,
                              top: 23,
                              child: SizedBox(
                                width: 30,
                                height: 40,
                                child: Stack(),
                              ),
                            ),
                            Positioned(
                              left: 250,
                              top: 5,
                              child: SizedBox(
                                width: 220,
                                height: 220,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 20,
                                      top: 1,
                                      child: Container(
                                        width: 40,
                                        height: 80,
                                        child: CustomPaint(
                                          painter: SunRaysPainter(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...alarms.asMap().entries.map((entry) {
                    int index = entry.key;
                    String alarmTime = entry.value['time']!;
                    String remainingTime = _calculateTimeRemaining(alarmTime);
                    double volume = entry.value['volume'];
                    return Positioned(
                      left: 30,
                      top: 250 + (index * 150),
                      child: GestureDetector(
                        onLongPress: () => _deleteAlarm(index),
                        child: SizedBox(
                          width: 570,
                          height: 130,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 570,
                                  height: 130,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF664949),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(70),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 30,
                                top: 40,
                                child: SizedBox(
                                  width: 500,
                                  height: 45,
                                  child: Text(
                                    '알람 시간: $alarmTime',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFFB96F6F),
                                      fontSize: 30,
                                      fontFamily: 'Imprima',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 30,
                                top: 80,
                                child: SizedBox(
                                  width: 500,
                                  height: 45,
                                  child: Text(
                                    remainingTime,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFFB96F6F),
                                      fontSize: 20,
                                      fontFamily: 'Imprima',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 30,
                                top: 100,
                                child: SizedBox(
                                  width: 500,
                                  height: 45,
                                  child: Text(
                                    '음량: ${volume.round()}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFFB96F6F),
                                      fontSize: 20,
                                      fontFamily: 'Imprima',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SunRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawLine(center, Offset(center.dx + 55, center.dy), paint);
    canvas.drawLine(center, Offset(center.dx - 55, center.dy), paint);
    canvas.drawLine(center, Offset(center.dx, center.dy + 55), paint);
    canvas.drawLine(center, Offset(center.dx, center.dy - 55), paint);
    canvas.drawLine(center, Offset(center.dx + 40, center.dy + 40), paint);
    canvas.drawLine(center, Offset(center.dx - 40, center.dy - 40), paint);
    canvas.drawLine(center, Offset(center.dx + 40, center.dy - 40), paint);
    canvas.drawLine(center, Offset(center.dx - 40, center.dy + 40), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
