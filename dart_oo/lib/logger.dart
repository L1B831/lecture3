/// 日志能力：mixin 横向复用，任何类都可以 with 进来。
/// 对应被删除的基类 LoggedObject —— "会打日志"是能力不是身份，
/// 不值得占用唯一的 extends 名额（mixin 改造理由见进度报告）。
mixin Logger {
  void log(String msg) => print('[$runtimeType] $msg');
}
