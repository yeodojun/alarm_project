import 'package:flutter/material.dart';
import 'main_screen.dart';

class AlarmSettingScreen extends StatefulWidget {
  @override
  _AlarmSettingScreenState createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
  String _selectedHour = '1'; // 선택된 시간을 저장할 변수
  String _selectedMinute = '0'; // 선택된 분을 저장할 변수
  double _volume = 50.0; // 음량을 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              left: -3,
              top: 0,
              child: Container(
                width: 392,
                height: 693,
                decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
              ),
            ),
            Positioned(
              left: 48,
              top: 40,
              child: Container(
                width: 100,
                height: 44.75,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 100,
                        height: 44.75,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFCDE4FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 13.5,
                      top: 9.24,
                      child: SizedBox(
                        width: 72.5,
                        height: 26.19,
                        child: DropdownButton<String>(
                          value: _selectedHour, // 현재 선택된 시간
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedHour = newValue!;
                            });
                          },
                          items: List.generate(24, (index) {
                            // 1시부터 24시까지의 시간 목록을 생성
                            int hour = index + 1;
                            return DropdownMenuItem<String>(
                              value: hour.toString(),
                              child: Text(
                                hour.toString() + '시',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Inconsolata',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 48,
              top: 100,
              child: Container(
                width: 100,
                height: 44.75,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 100,
                        height: 44.75,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFCDE4FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 13.5,
                      top: 9.25,
                      child: SizedBox(
                        width: 72.5,
                        height: 26.19,
                        child: DropdownButton<String>(
                          value: _selectedMinute, // 현재 선택된 분
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedMinute = newValue!;
                            });
                          },
                          items: List.generate(60, (index) {
                            // 0분부터 59분까지의 분 목록을 생성
                            return DropdownMenuItem<String>(
                              value: index.toString(),
                              child: Text(
                                index.toString().padLeft(2, '0') + '분',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Inconsolata',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 50.5,
              top: 200,
              child: Column(
                children: [
                  const Text(
                    '음량',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inconsolata',
                    ),
                  ),
                  Slider(
                    value: _volume,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _volume.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _volume = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              left: 50.5,
              top: 545.94,
              child: SizedBox(
                width: 291,
                height: 44.75,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4747),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  child: const Text(
                    '취소',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inconsolata',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 50.5,
              top: 612.47,
              child: SizedBox(
                width: 291,
                height: 44.75,
                child: ElevatedButton(
                  onPressed: () {
                    int hour = int.parse(_selectedHour);
                    int minute = int.parse(_selectedMinute);
                    Navigator.pop(context, {'hour': hour, 'minute': minute, 'volume': _volume});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8075FF),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
    );
  }
}
