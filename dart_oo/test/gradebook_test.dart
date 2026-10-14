import 'package:dart_oo/gradebook.dart';
import 'package:dart_oo/student.dart';
import 'package:test/test.dart';

void main() {
  test('正常数据统计正确', () {
    final book = GradeBook([
      Student('01', '李华', 92),
      Student('02', '王芳', 55),
      Student('03', '张伟', 78),
    ]);
    expect(book.average, closeTo((92 + 55 + 78) / 3, 1e-9));
    expect(book.maxBy().name, '李华');
    expect(book.countPassed, 2);
    final g = book.groupByGrade();
    expect(g['优']!.map((s) => s.name), ['李华']);
    expect(g['不及格']!.map((s) => s.name), ['王芳']);
  });

  test('越界分数抛异常', () {
    final s = Student('01', '李华', 60);
    expect(() => s.score = 101, throwsArgumentError);
    expect(() => s.score = -1, throwsArgumentError);
  });
}
