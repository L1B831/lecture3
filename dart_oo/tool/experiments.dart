// 6.3 独立研究任务：三个实验的记录与复现。
// 运行方式：dart run tool/experiments.dart
import 'package:dart_oo/student.dart';

// ── 实验 1：mixin 线性化 ──────────────────────────────────────────
// 两个含同名方法的 mixin，改变 with 顺序，观察调用的是哪一个。
mixin LogA {
  void log(String msg) => print('A.log: $msg');
}

mixin LogB {
  void log(String msg) => print('B.log: $msg');
}

class WithAthenB with LogA, LogB {}

class WithBthenA with LogB, LogA {}

// ── 实验 3：重写 == 与 hashCode 后的 contains 与 Set 去重 ──────────
class Point {
  final int x, y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point($x,$y)';
}

class RawPoint { // 对照组：不重写 ==
  final int x, y;

  RawPoint(this.x, this.y);

  @override
  String toString() => 'RawPoint($x,$y)';
}

void main() {
  print('── 实验 1：mixin 线性化（同名方法，后混入者胜） ──');
  WithAthenB().log('with LogA, LogB'); // 预期 B 胜出
  WithBthenA().log('with LogB, LogA'); // 预期 A 胜出

  print('── 实验 2：const 列表不可变 ──');
  const fixed = [1, 2, 3];
  try {
    fixed.add(4);
  } catch (e) {
    print('const 列表 add 抛出: $e');
  }

  print('── 实验 3：== 与 hashCode 对 contains / Set 去重的影响 ──');
  final rawList = [RawPoint(1, 1), RawPoint(1, 1)];
  print('未重写==: List.contains(RawPoint(1,1)) → '
      '${rawList.contains(RawPoint(1, 1))}');
  final rawSet = <RawPoint>{}..addAll(rawList);
  print('未重写==: Set 去重后长度 → ${rawSet.length}');

  final pts = [Point(1, 1), Point(1, 1)];
  print('重写==后: List.contains(Point(1,1)) → ${pts.contains(Point(1, 1))}');
  final ptSet = <Point>{}..addAll(pts);
  print('重写==后: Set 去重后长度 → ${ptSet.length}');

  // 附：fromJson 缺 key 时的 null 类型转换错误复现（报告第六节引用）。
  print('── 附：null 类型转换错误复现 ──');
  try {
    Student.fromJson({'id': '9', 'name': '赵敏'}); // 缺 score 键
  } catch (e) {
    print('缺 score 键抛出: $e');
  }
}
