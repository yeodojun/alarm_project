import 'package:flutter/material.dart';
import 'main_screen.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Option(),
    );
  }
}

class Option extends StatelessWidget {
  const Option({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1000, // 전체 높이를 main_screen.dart와 동일하게 줄입니다.
              color: const Color(0xFFD9D9D9),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 900, // Adjusted top position
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80, // Adjusted height
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: 300,
                              height: 80,
                              child: const Center(
                                child: Text(
                                  '알람',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30, // Adjusted font size
                                    fontFamily: 'Inconsolata',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 80,
                            decoration: const BoxDecoration(color: Color(0xFFFFE500)),
                            child: const Center(
                              child: Text(
                                '설정',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30, // Adjusted font size
                                  fontFamily: 'Inconsolata',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    top: 0,
                    child: SizedBox(
                      width: 150, // Adjusted size
                      height: 60, // Adjusted size
                      child: Text(
                        '앱 정보',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFF5656),
                          fontSize: 30, // Adjusted font size
                          fontFamily: 'Imprima',
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 16,
                    top: 70, // Adjusted top position
                    child: SizedBox(
                      width: 350, // Adjusted size
                      height: 300, // Adjusted size
                      child: Text(
                        '모두들 좋은 아침, 점심, 저녁, 새벽되세요\nb__b\n\n불편하신 점 꼭 편하시게 연락해주세요\n얼른 고치겠습니다~!\n      ㅇ\n     /ㅣ\\n      ㅅ\n     /    \\n\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20, // Adjusted font size
                          fontFamily: 'Imprima',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 400, // Adjusted top position
                    child: Container(
                      width: 350, // Adjusted size
                      height: 100, // Adjusted size
                      decoration: ShapeDecoration(
                        color: Color(0xFF957F7F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'kjr0118@naver.com',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20, // Adjusted font size
                            fontFamily: 'Inconsolata',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
