import 'package:dart_oo/student.dart';

void main() {
  // 命名构造：从 Map/JSON 造对象
  final s = Student.fromJson({'id': '01', 'name': '李华', 'score': 92});
  print('从 JSON 构建: $s');

  // 走带校验的 setter 改分
  s.score = 95;
  print('setter 改分后: $s（及格=${s.passed}）');
}
