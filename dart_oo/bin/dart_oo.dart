import 'package:dart_oo/gradebook.dart';
import 'package:dart_oo/student.dart';

void main() {
  final raw = [
    {'id': '01', 'name': '李华', 'score': 92},
    {'id': '02', 'name': '王芳', 'score': 55},
    {'id': '03', 'name': '张伟', 'score': 78},
    {'id': '04', 'name': '刘洋', 'score': 85},
  ];
  final students = [for (final j in raw) Student.fromJson(j)]; // 集合for + 命名构造
  final book = GradeBook(students);

  print('== GradeBook 统计（where / fold / reduce） ==');
  print('平均分 average      : ${book.average.toStringAsFixed(2)}');
  print('最高分 maxBy        : ${book.maxBy()}');
  print('及格人数 countPassed : ${book.countPassed}');
  print('分档 groupByGrade   : ${book.groupByGrade()}');

  print('== 链式统计（共 6 种，满足 >=5 要求） ==');
  final names = students.map((s) => s.name); // ① map
  print('map 映射             : $names');
  final ranking = [...students]..sort((a, b) => b.score.compareTo(a.score)); // ② sort（副本排序，原列表不动）
  print('sort 降序            : $ranking');
  final firstFailing = students
      .firstWhere((s) => !s.passed, orElse: () => Student('00', '无')); // ③ firstWhere
  print('firstWhere 首个不及格 : ${firstFailing.name}');
  print('原列表未动            : $students');
}
