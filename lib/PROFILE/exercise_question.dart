import 'package:flutter/material.dart';
import '../HOME/home_page.dart';

void main() {
  runApp(MaterialApp(home: ExerciseQuestionScreen()));
}

const primaryColor = Color(0xFF25AAAC);
const selectedBorderColor = Color(0xFF00C8B7); // สีเขียวมิ้นต์
const defaultBorderColor = Color(0xFFD3D3D3); // สีเทาอ่อนกว่าก่อนหน้านี้

class QuestionScreenTemplate extends StatefulWidget {
  final String questionText;
  final List<String> choices;
  final VoidCallback onNext;
  final int questionNumber;
  final int totalQuestions;
  final IconData icon;

  const QuestionScreenTemplate({
    required this.questionText,
    required this.choices,
    required this.onNext,
    required this.questionNumber,
    required this.totalQuestions,
    required this.icon,
    super.key,
  });

  @override
  State<QuestionScreenTemplate> createState() => _QuestionScreenTemplateState();
}

class _QuestionScreenTemplateState extends State<QuestionScreenTemplate> {
  String? selectedAnswer;

  void _submit() {
    if (selectedAnswer == null) {
      _showErrorDialog();
    } else {
      widget.onNext();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ยังไม่ได้เลือกคำตอบ'),
        content: const Text('กรุณาเลือกตัวเลือกก่อนดำเนินการต่อ'),
        actions: [
          TextButton(
            child: const Text('ตกลง'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // ความกว้างของหน้าจอ

    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบสอบถาม'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: widget.questionNumber / widget.totalQuestions,
              color: primaryColor,
              backgroundColor: primaryColor.withOpacity(0.2),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(widget.icon, color: primaryColor, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.questionText,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...widget.choices.map(
                  (choice) => GestureDetector(
                onTap: () => setState(() {
                  selectedAnswer = choice;
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: screenWidth - 32, // ทำให้กรอบเต็มความกว้างของหน้าจอ (ลบ padding ขอบขวาและซ้าย)
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: selectedAnswer == choice
                          ? selectedBorderColor
                          : defaultBorderColor, // กรอบที่ยังไม่ได้เลือกจะใช้สีเทาอ่อนกว่า
                      width: 2,
                    ),
                    color: selectedAnswer == choice
                        ? selectedBorderColor.withOpacity(0.2) // กรอบที่เลือกแล้วจะมีสีอ่อนของเขียวมิ้นต์
                        : Colors.white, // ตัวเลือกที่ยังไม่ได้เลือกมีพื้นหลังเป็นสีขาว
                  ),
                  child: Text(
                    choice,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('ถัดไป', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseQuestionScreen extends StatelessWidget {
  const ExerciseQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreenTemplate(
      questionText: 'คุณออกกำลังกายบ่อยแค่ไหน? 🏃‍♂️',
      choices: ['ทุกวัน', '3-5 ครั้งต่อสัปดาห์', '1-2 ครั้งต่อสัปดาห์', 'ไม่เคยเลย'],
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SleepQuestionScreen())),
      questionNumber: 1,
      totalQuestions: 7,
      icon: Icons.fitness_center,
    );
  }
}

class SleepQuestionScreen extends StatelessWidget {
  const SleepQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreenTemplate(
      questionText: 'คุณนอนวันละกี่ชั่วโมง? 😴',
      choices: ['มากกว่า 8 ชั่วโมง', '6-8 ชั่วโมง', '4-6 ชั่วโมง', 'น้อยกว่า 4 ชั่วโมง'],
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WorkShiftQuestionScreen())),
      questionNumber: 2,
      totalQuestions: 7,
      icon: Icons.bedtime,
    );
  }
}

class WorkShiftQuestionScreen extends StatelessWidget {
  const WorkShiftQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreenTemplate(
      questionText: 'ช่วงเวลาที่ท่านปฏิบัติงานส่วนใหญ่อยู่ในช่วงใด? 🕒',
      choices: [
        'กะเช้า (06:00 – 14:00 น.)',
        'กะบ่าย (14:00 – 22:00 น.)',
        'กะดึก (22:00 – 06:00 น.)',
        'เวลาทำงานไม่แน่นอน/เปลี่ยนแปลงอยู่เสมอ',
        'อื่น ๆ',
      ],
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MealFrequencyQuestionScreen())),
      questionNumber: 3,
      totalQuestions: 7,
      icon: Icons.work_history,
    );
  }
}

class MealFrequencyQuestionScreen extends StatelessWidget {
  const MealFrequencyQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreenTemplate(
      questionText: 'โดยปกติในหนึ่งวัน ท่านรับประทานอาหารวันละกี่มื้อ? 🍽️',
      choices: ['1 มื้อ', '2 มื้อ', '3 มื้อ', 'มากกว่า 3 มื้อ', 'ไม่แน่นอน', 'ไม่รับประทานอาหารเลย'],
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FoodAllergyQuestionScreen())),
      questionNumber: 4,
      totalQuestions: 7,
      icon: Icons.restaurant,
    );
  }
}

class FoodAllergyQuestionScreen extends StatelessWidget {
  const FoodAllergyQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreenTemplate(
      questionText: 'ท่านมีอาการแพ้อาหารหรือไม่? 🤧',
      choices: ['ไม่มีอาการแพ้อาหาร', 'แพ้อาหารทะเล', 'แพ้อาหารจากนม', 'แพ้อาหารจากแป้ง', 'อื่น ๆ'],
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EatingStyleQuestionScreen())),
      questionNumber: 5,
      totalQuestions: 7,
      icon: Icons.warning_amber,
    );
  }
}

class EatingStyleQuestionScreen extends StatelessWidget {
  const EatingStyleQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionScreenTemplate(
      questionText: 'ท่านทานอาหารในรูปแบบใด? 🥗',
      choices: ['Keto', 'Intermittent Fasting (IF)', 'Low Carb', 'ไม่จำกัด'],
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SmartwatchQuestionScreen())),
      questionNumber: 6,
      totalQuestions: 7,
      icon: Icons.fastfood,
    );
  }
}

class SmartwatchQuestionScreen extends StatelessWidget {
  const SmartwatchQuestionScreen({super.key});

  void _finish(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('เสร็จสิ้น'),
        content: const Text('ขอบคุณที่ทำแบบสอบถาม'),
        actions: [
          TextButton(
            child: const Text('ตกลง'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuestionScreenTemplate(
      questionText: 'ท่านใช้นาฬิกาอัจฉริยะในการติดตามสุขภาพหรือไม่? ⌚',
      choices: ['ใช่, ใช้ตลอดเวลา', 'ใช่, ใช้เป็นบางเวลา', 'ไม่เคยใช้'],
      onNext: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      ),
      questionNumber: 7,
      totalQuestions: 7,
      icon: Icons.watch,
    );
  }
}
