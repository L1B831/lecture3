/// 学生模型：演示字段封装、命名构造、getter 与校验 setter。
class Student {
  final String id;
  final String name;
  double _score; // 私有：下划线前缀（库级私有，文件外不可直接访问）

  Student(this.id, this.name, [this._score = 0]);

  /// 命名构造：从 Map/JSON 造对象（网络数据解析的标准入口）。
  /// 初始化列表在构造体执行前运行，是给 final 字段赋值的地方。
  Student.fromJson(Map<String, dynamic> json) // 命名构造
      : id = json['id'],
        name = json['name'],
        _score = (json['score'] as num).toDouble();

  double get score => _score; // getter

  set score(double v) { // setter 带校验
    if (v < 0 || v > 100) throw ArgumentError('分数越界');
    _score = v;
  }

  bool get passed => _score >= 60;

  @override
  String toString() => 'Student($id, $name, $_score)';
}
