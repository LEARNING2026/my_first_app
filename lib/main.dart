import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طريقي للنجاح',
      debugShowCheckedModeBanner: false,
      // دعم اللغة العربية والاتجاه من اليمين لليسار
      locale: const Locale('ar', 'SA'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B9080),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Arial', // يمكن استبدالها بخط عربي أفضل
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // قائمة المهام مع حالة الإنجاز
  final List<Map<String, dynamic>> tasks = [
    {'title': 'قراءة', 'completed': false},
    {'title': 'تأمل', 'completed': false},
    {'title': 'رياضة', 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // تفعيل الاتجاه من اليمين لليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: const Text(
            'طريقي للنجاح',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF6B9080),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // قسم الاقتباس التحفيزي
                _buildQuoteCard(),
                const SizedBox(height: 24),

                // قائمة المهام
                _buildTaskList(),
                const SizedBox(height: 24),

                // زر إضافة هدف جديد
                _buildAddGoalButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // بطاقة الاقتباس التحفيزي
  Widget _buildQuoteCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFA4C3B2), Color(0xFFCCE3DE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.format_quote, size: 32, color: Color(0xFF2D5F4F)),
          const SizedBox(height: 12),
          const Text(
            'النجاح ليس نهاية الطريق، والفشل ليس قاتلاً، بل الشجاعة للاستمرار هي ما يهم',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D5F4F),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '- ونستون تشرشل',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // قائمة المهام
  Widget _buildTaskList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'مهام اليوم',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D5F4F),
            ),
          ),
          const SizedBox(height: 16),
          ...tasks.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> task = entry.value;
            return _buildTaskItem(task['title'], task['completed'], (value) {
              setState(() {
                tasks[index]['completed'] = value;
              });
            });
          }).toList(),
        ],
      ),
    );
  }

  // عنصر مهمة واحدة
  Widget _buildTaskItem(
    String title,
    bool completed,
    Function(bool?) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: completed ? const Color(0xFFE8F5E9) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            decoration: completed ? TextDecoration.lineThrough : null,
            color: completed ? Colors.grey[600] : Colors.black87,
          ),
        ),
        value: completed,
        onChanged: onChanged,
        activeColor: const Color(0xFF6B9080),
        checkColor: Colors.white,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  // زر إضافة هدف جديد
  Widget _buildAddGoalButton() {
    return ElevatedButton(
      onPressed: () {
        // يمكن إضافة وظيفة لإضافة هدف جديد هنا
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('سيتم إضافة هدف جديد قريباً'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6B9080),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, size: 24),
          SizedBox(width: 8),
          Text(
            'إضافة هدف جديد',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
