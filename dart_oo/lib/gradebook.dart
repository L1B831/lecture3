import 'logger.dart';
import 'student.dart';

/// 成绩册：内部持有 `List<Student>`，构造时接收列表。
/// 日志能力来自 mixin Logger（横向混入），不再占用唯一的 extends 名额。
class GradeBook with Logger {
  final List<Student> _students;

  /// 防御性拷贝：外部之后对传入列表的增删不影响成绩册内部状态。
  GradeBook(List<Student> students) : _students = List.unmodifiable(students);

  /// 平均分：fold 聚合。
  /// 种子必须写 `fold<double>(0, ...)`：写成 fold(0, ...) 会被推断成 int，
  /// 累加 double 时编译报错（本课报告第六节记录的真实错误）。
  double get average {
    log('average: 共 ${_students.length} 名学生');
    return _students.fold<double>(0, (sum, s) => sum + s.score) /
        _students.length;
  }

  /// 最高分学生：reduce 归约，两两比较留下分数较高者。
  Student maxBy() => _students.reduce((a, b) => a.score >= b.score ? a : b);

  /// 及格人数：where 筛选后取长度。
  int get countPassed => _students.where((s) => s.passed).length;

  /// 按优良中分档：优>=90、良>=80、中>=60、不及格<60。
  Map<String, List<Student>> groupByGrade() => {
        '优': _students.where((s) => s.score >= 90).toList(),
        '良': _students.where((s) => s.score >= 80 && s.score < 90).toList(),
        '中': _students.where((s) => s.score >= 60 && s.score < 80).toList(),
        '不及格': _students.where((s) => s.score < 60).toList(),
      };
}
