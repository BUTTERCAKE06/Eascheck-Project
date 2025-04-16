import 'package:flutter/material.dart';
import 'exercise_question.dart';//import หน้าแบบสอบถาม

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});
 //ประกาศตัวแปร
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final Color primaryColor = const Color(0xFF25AAAC);

  DateTime? selectedDate;
  String? selectedGender;
  String? isPregnant;
  String? selectedWeightUnit;
  String? selectedHeightUnit;

  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    birthDateController.text = '${selectedDate!.day.toString().padLeft(2, '0')}/'
        '${selectedDate!.month.toString().padLeft(2, '0')}/'
        '${selectedDate!.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text = '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  void _handleSubmit() {
    if (selectedDate == null ||
        selectedGender == null ||
        (selectedGender == 'หญิง' && isPregnant == null) ||
        weightController.text.isEmpty ||
        selectedWeightUnit == null ||
        heightController.text.isEmpty ||
        selectedHeightUnit == null) {
      _showErrorDialog();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExerciseQuestionScreen()),
      );
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('กรอกข้อมูลไม่ครบ'),
        content: Text('กรุณากรอกข้อมูลให้ครบทุกช่องที่มี *'),
        actions: [
          TextButton(
            child: Text('ตกลง'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลส่วนตัว'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // วันเกิด
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: birthDateController,
                  decoration: InputDecoration(
                    labelText: 'วัน/เดือน/ปี*',
                    suffixIcon: Icon(Icons.calendar_today, color: primaryColor),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  readOnly: true,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // เพศ
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                labelText: 'เพศ*',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              items: ['ชาย', 'หญิง', 'อื่นๆ']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                  if (selectedGender != 'หญิง') {
                    isPregnant = null;
                  }
                });
              },
            ),

            if (selectedGender == 'หญิง') ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: isPregnant,
                decoration: InputDecoration(
                  labelText: 'คุณกำลังตั้งครรภ์หรือไม่*',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
                items: ['ใช่', 'ไม่ใช่']
                    .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
                    .toList(),
                onChanged: (value) => setState(() => isPregnant = value),
              ),
            ],
            const SizedBox(height: 12),

            // น้ำหนัก
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'น้ำหนัก*',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedWeightUnit,
                  hint: Text('kg/lbs'),
                  items: ['kg', 'lbs']
                      .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedWeightUnit = value),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ส่วนสูง
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ส่วนสูง*',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedHeightUnit,
                  hint: Text('cm/inches'),
                  items: ['cm', 'inches']
                      .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedHeightUnit = value),
                ),
              ],
            ),
            const Spacer(),

            // ปุ่ม"ถัดไป"
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: primaryColor,
              ),
              child: const Text('ถัดไป'),
            ),
          ],
        ),
      ),
    );
  }
}
