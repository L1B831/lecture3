import 'student.dart';

/// 日志能力基类。
/// 注意：这是刻意保留的"一层继承"写法，步骤三将把它重构成 mixin Logger，
/// 改造理由见进度报告"mixin 改造前后对照"。
abstract class LoggedObject {
  void log(String msg) => print('[$runtimeType] $msg');
}

/// 成绩册：内部持有 `List<Student>`，构造时接收列表。
class GradeBook extends LoggedObject {
  final List<Student> _students;

  /// 防御性拷贝：外部之后对传入列表的增删不影响成绩册内部状态。
  GradeBook(List<Student> students) : _students = List.unmodifiable(students);
}
