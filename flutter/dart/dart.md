# dart

## 关键字

## 一、变量

### 1.1 初始化及默认值

- 初始化

```dart
var name = 'Bob';       // 变量仅存储对象的引用

dynamic name = 'Bob';   // 一个对象的引用不局限于单一的类型，可以根据设计指南将其指定为 Object 或 dynamic 类型。

String name = 'Bob';    // 指定类型
```

- 默认值

在 Dart 中，未初始化的变量拥有一个默认的初始化值：null。即便数字也是如此，因为在 Dart 中一切皆为对象，数字也不例外。

```dart
int lineCount;
assert(lineCount == null);
```

### 1.2 Final 和 Const

如果不想更改一个变量，可以使用关键字 final 或者 const 修饰变量，这两个关键字可以替代 var 关键字或者加在一个具体的类型前。一个 final 变量只可以被赋值一次；一个 const 变量是一个编译时常量（const 变量同时也是 final 的）。顶层的 final 变量或者类的 final 变量在其第一次使用的时候被初始化。

- 创建并初始化

如果使用 const 修饰类中的变量，则必须加上 static 关键字，即 static const（注意：顺序不能颠倒）。在声明 const 变量时可以直接为其赋值，也可以使用其它的 const 变量为其赋值

```dart
final name = 'Bob';     // 不能被修改
final String nickname = 'Bobby';

const bar = 1000000; // 直接赋值
const double atm = 1.01325 * bar; // 利用其它 const 变量赋值；
```

- 常量值

const 关键字不仅仅可以用来定义常量，还可以用来创建 常量值，该常量值可以赋予给任何变量。你也可以将构造函数声明为 const 的，这种类型的构造函数创建的对象是不可改变的。

```dart
var foo = const [];
final bar = const [];
const baz = []; // 相当于 `const []`；如果使用初始化表达式为常量赋值可以省略掉关键字 const

foo = [1, 2, 3]; // foo 的值之前为 const []；没有使用 final 或 const 修饰的变量的值是可以被更改的
```

- 类型转换

```dart
// Valid compile-time constants as of Dart 2.5.
const Object i = 3; // Where i is a const Object with an int value...
const list = [i as int]; // Use a typecast.
const map = {if (i is int) i: "int"}; // Use is and collection if.
const set = {if (list is List<int>) ...list}; // ...and a spread.
```

## 二、内置类型

- Dart 语言支持下列的类型：
    - numbers
    - strings
    - booleans
    - lists (也被称为 arrays)
    - sets
    - maps
    - runes (用于在字符串中表示 Unicode 字符)
    - symbols

可以直接使用字面量来初始化上述类型。例如 'This is a string' 是一个字符串字面量，true 是一个布尔字面量。

由于 Dart 中每个变量引用都指向一个对象（一个 类 的实例），你通常也可以使用 构造器 来初始化变量。一些内置的类型有它们自己的构造器。例如你可以使用 Map() 来创建一个 map 对象。

### 2.1 Numbers

int 和 double 都是 num 的子类。 num 中定义了一些基本的运算符比如 +、-、\*、/ 等，还定义了 abs()、ceil() 和 floor() 等方法（位运算符，比如 \>\> 定义在 int 中）。

- int
    - 整数值；长度不超过 64位，具体取值范围依赖于不同的平台。
- double
    - 64位的双精度浮点数字，且符合 IEEE 754 标准。

- 字符串和数字之间的类型转换

```dart
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');
```

- 位运算

```dart
assert((3 << 1) == 6);      // 0011 << 1 == 0110
assert((3 >> 1) == 1);      // 0011 >> 1 == 0001
assert((3 | 4) == 7);       // 0011 | 0100 == 0111
```

### 2.2 Strings

Dart 字符串是 UTF-16 编码的字符序列。可以使用单引号或者双引号来创建字符串：

```dart
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
```

- 可以在字符串中以 ${表达式} 的形式使用表达式，如果表达式是一个标识符，可以省略掉 {}。如果表达式的结果为一个对象，则 Dart 会调用该对象的 toString 方法来获取一个字符串：

```dart
var s = 'string interpolation';

assert('Dart has $s, which is very handy.' ==
    'Dart has string interpolation, ' +
        'which is very handy.');

assert('That deserves all caps. ' +
        '${s.toUpperCase()} is very handy!' ==
    'That deserves all caps. ' +
        'STRING INTERPOLATION is very handy!');
```

- 可以使用 + 运算符将两个字符串连接为一个，也可以将多个字符串挨着放一起变为一个：

```dart
var s1 = 'String '
    'concatenation'
    " works even over line breaks.";
assert(s1 ==
    'String concatenation works even over '
        'line breaks.');

var s2 = 'The + operator ' + 'works, as well.';
assert(s2 == 'The + operator works, as well.');
```

- 可以使用三个单引号或者三个双引号创建多行字符串：

```dart
var s1 = '''
你可以像这样创建多行字符串。
''';

var s2 = """这也是一个多行字符串。""";
```

- 在字符串前加上 r 作为前缀创建 “raw” 字符串（即不会被做任何处理（比如转义）的字符串）：

```dart
var s = r'In a raw string, not even \n gets special treatment.';
```

### 2.3 Booleans

Dart 使用 bool 关键字表示布尔类型，布尔类型只有两个对象 true 和 false，两者都是编译时常量。

Dart 的类型安全不允许你使用类似 if (nonbooleanValue) 或者 assert (nonbooleanValue) 这样的代码检查布尔值。相反，你应该总是显示地检查布尔值，比如像下面的代码这样：

```dart
// 检查是否为空字符串 (Check for an empty string).
var fullName = '';
assert(fullName.isEmpty);

// 检查是否小于等于零。
var hitPoints = 0;
assert(hitPoints <= 0);

// 检查是否为 null。
var unicorn;
assert(unicorn == null);

// 检查是否为 NaN。
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
```

### 2.4 Lists

```dart
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);

list[1] = 1;
assert(list[1] == 1);
```

```dart
var constantList = const [1, 2, 3];
// constantList[1] = 1; // 取消注释将导致出错 (Uncommenting this causes an error.)
// constantList = 1;    // Error: A value of type 'int' can't be assigned to a variable of type 'List<int>'.
constantList = [1];
```

- 可以使用扩展操作符（...）将一个 List 中的所有元素插入到另一个 List 中：

```dart
var list = [1, 2, 3];
var list2 = [0, ...list];
assert(list2.length == 4);
```

- 如果扩展操作符右边可能为 null ，你可以使用 null-aware 扩展操作符（...?）来避免产生异常：

```dart
var list;
var list2 = [0, ...?list];
assert(list2.length == 1);
```

- Collection If 和 Collection For，在构建集合时，可以使用条件判断（if）和循环（for）

```dart
var nav = [
  'Home',
  'Furniture',
  'Plants',
  if (promoActive) 'Outlet'
];

var listOfInts = [1, 2, 3];
var listOfStrings = [
  '#0',
  for (var i in listOfInts) '#$i'
];
assert(listOfStrings[1] == '#1');
```

### 2.5 Sets

在 Dart 中，set 是一组特定元素的无序集合。 Dart 所支持的 set 由 set literals 和 Set 类所提供。尽管 Set 类型(type) 一直都是 Dart 的一项核心功能，但是 Set 字面量(literals) 却是在 Dart2.2 中才加入的。

```dart
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
var names = <String>{};     // 类型 + {} 的形式创建 Set
Set<String> names = {};     // 声明类型变量的形式创建 Set
// var names = {};          // 这样的形式将创建一个 Map 而不是 Set
```

- 向一个已存在的 Set 中添加项目可以使用 add() 方法或 addAll() 方法
- 使用 .length 可以获取 Set 中元素的数量
- 可以在 Set 字面量前添加 const 关键字创建一个 Set 编译时常量
- Set 可以像 List 一样支持使用扩展操作符（... 和 ...?）以及 Collection If 和 Collection For 操作

```dart
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);

assert(elements.length == 5);

final constantSet = const {
  'fluorine',
  'chlorine',
  'bromine',
  'iodine',
  'astatine',
};
```

### 2.6 Maps

通常来说， Map 是用来关联 keys 和 values 的对象。 keys 和 values 可以是任何类型的对象。在一个 Map 对象中一个 key 只能出现一次。但是 value 可以出现多次。 Dart 中 Map 通过 Map 字面量和 Map 类型来实现。

- 示例

```dart
var gifts = {
  // 键:    值
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

var gifts = Map();                  // 不是使用 new Map() 构造 Map 对象。因为从 Dart2 开始，构造对象的 new 关键字可以被省略掉
gifts['first'] = 'partridge';       // 向现有的 Map 中添加键值对
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';

assert(gifts['first'] == 'partridge');  // 从一个 Map 中获取一个值的操作
assert(gifts['third'] == null);         // 如果检索的 Key 不存在于 Map 中则会返回一个 null
assert(gifts.length == 3);              // 使用 .length 可以获取 Map 中键值对的数量

final constantMap = const {             // 创建一个 Map 编译时常量
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
```

Map 可以像 List 一样支持使用扩展操作符（... 和 ...?）以及 Collection If 和 Collection For 操作

### 2.7 Runes 与 grapheme clusters

在 Dart 中，runes 公开了字符串的 Unicode 码位。从 Dart 2.6 开始，使用 characters 包来访问或者操作用户感知的字符，也被称为 Unicode (扩展) grapheme clusters。

Unicode 编码为每一个字母、数字和符号都定义了一个唯一的数值。因为 Dart 中的字符串是一个 UTF-16 的字符序列，所以如果想要表示 32 位的 Unicode 数值则需要一种特殊的语法。

通常使用 \uXXXX 来表示 Unicode 字符，XXXX 是一个四位数的 16 进制数字。例如心形字符（♥）的 Unicode 为 \u2665。对于不是四位数的 16 进制数字，需要使用大括号将其括起来。例如大笑的 emoji 表情（😆）的 Unicode 为 \u{1f600}。

如果你需要读写单个 Unicode 字符，可以使用 characters 包中定义的 characters getter。它将返回 Characters 作为一系列 grapheme clusters 的字符串。下面是使用 characters API 的样例：

```dart
import 'package:characters/characters.dart';
...
var hi = 'Hi 🇩🇰';
print(hi);
print('The end of the string: ${hi.substring(hi.length - 1)}');
print('The last character: ${hi.characters.last}\n');
```

输出取决于你的环境，看上去会像这样：

```shell
$ dart bin/main.dart
Hi 🇩🇰
The end of the string: ???
The last character: 🇩🇰
```

### 2.8 Symbols

Symbol 表示 Dart 中声明的操作符或者标识符，该类型的对象几乎不会被使用到，但是如果需要按名称引用它们的 API 时就非常有用。因为代码压缩后会改变这些符号的名称但不会改变具体的符号。

可以使用在标识符前加 # 前缀来获取 Symbol：

```dart
#radix
#bar
```

## 三、Functions

Dart 是一种真正面向对象的语言，所以即便函数也是对象并且类型为 Function，这意味着函数**可以被赋值给变量或者作为其它函数的参数**。你也可以像调用函数一样调用 Dart 类的实例。

### 3.1 函数定义

```dart
bool isNoble(int atomicNumber) {    // 定义返回类型效率高
    return _nobleGases[atomicNumber] != null;
}

isNoble(int atomicNumber) {         // 不定义返回类型也正确
    return _nobleGases[atomicNumber] != null;
}
// 语法 => 表达式 是 { return 表达式; } 的简写， => 有时也称之为胖箭头语法。
// 在 => 与 ; 之间的只能是 表达式 而非 语句
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

### 3.2 必要参数与可选参数

函数可以有两种形式的参数：必要参数 和 可选参数。必要参数定义在参数列表前面，可选参数则定义在必要参数后面。可选参数可以是 命名的 或 位置的。

- 可选参数

可选参数分为命名参数和位置参数，可在参数列表中任选其一使用，但两者不能同时出现在参数列表中。

```dart
// *命名参数

// 使用 参数名: 参数值 的形式来指定命名参数
enableFlags(bold: true, hidden: false);
// 使用 {param1, param2, …} 来指定命名参数
void enableFlags({bool bold, bool hidden}) {...}
// 使用 @required 注解来标识一个命名参数是必须的参数，调用者则必须为该参数提供一个值
const Scrollbar({Key key, @required Widget child})

// *位置参数

// 使用 [] 将一系列参数包裹起来作为位置参数
String say(String from, String msg, [String device]) {...}

// *默认参数值

void enableFlags({bool bold = false, bool hidden = false}) {...}
String say(String from, String msg,[String device = 'carrier pigeon']) {...}

// *List 或 Map 同样也可以作为默认值
void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
  print('list:  $list');
  print('gifts: $gifts');
}
```

### 3.3 main() 函数

每个 Dart 程序都必须有一个 main() 顶级函数作为程序的入口，main() 函数返回值为 void 并且有一个 List\<String\> 类型的可选参数。

```dart
void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'    // .. 语法称之为 级联调用。使用级联访问可以在一个对象上执行多个操作
    ..onClick.listen(reverseText);
}
```

- 使用命令行访问带参数的 main() 函数示例：

```dart
// 使用命令 dart args.dart 1 test 运行该应用
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```

### 3.4 函数作为一级对象

```dart
// *将函数作为参数传递给另一个函数
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];
list.forEach(printElement);

// *将函数赋值给一个变量
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```

### 3.5 匿名函数

可以创建一个没有名字的方法，称之为 匿名函数，或 Lambda表达式 或 Closure闭包。你可以将匿名方法赋值给一个变量然后使用它，比如将该变量添加到集合或从中删除。

- 语法：

```dart
([[类型] 参数[, …]]) {
  函数体;
};
```

- 示例：

```dart
var list = ['apples', 'bananas', 'oranges'];
list.forEach((item) {
  print('${list.indexOf(item)}: $item');
});
```

### 3.5 词法作用域

Dart 是词法有作用域语言，变量的作用域在写代码的时候就确定了，大括号内定义的变量只能在大括号内访问，与 Java 类似。

```dart
bool topLevel = true;

void main() {
  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}
```

### 3.6 函数闭包

闭包 即一个函数对象，即使函数对象的调用在它原始作用域之外，依然能够访问在它词法作用域内的变量。函数可以**封闭定义到它作用域内的变量**。

```dart
/// 返回一个将 [addBy] 添加到该函数参数的函数。
Function makeAdder(num addBy) { // addBy 变量只有下面函数才能看到
  return (num i) => addBy + i;
}

void main() {
  // 生成加 2 的函数。
  var add2 = makeAdder(2);
  // 生成加 4 的函数。
  var add4 = makeAdder(4);
  assert(add2(3) == 5);
  assert(add4(3) == 7);
}
```

### 3.7 测试函数是否相等

```dart
void foo() {}           // 定义顶层函数 (A top-level function)

class A {
  static void bar() {}  // 定义静态方法
  void baz() {}         // 定义实例方法
}

void main() {
  var x;

  // 比较顶层函数是否相等。
  x = foo;
  assert(foo == x);

  // 比较静态方法是否相等。
  x = A.bar;
  assert(A.bar == x);

  // 比较实例方法是否相等。
  var v = A(); // A 的实例 #1
  var w = A(); // A 的实例 #2
  var y = w;
  x = w.baz;

  // 这两个闭包引用了相同的实例对象，因此它们相等。
  assert(y.baz == x);

  // 这两个闭包引用了不同的实例对象，因此它们不相等。
  assert(v.baz != w.baz);
}
```

### 3.8 返回值

所有的函数都有返回值。没有显示返回语句的函数最后一行默认为执行 return null;。

## 四、运算符

### 4.1 算术运算符

|运算符|描述|
|:---|:---|
|+   |加|
|–   |减|
|-表达式    |一元负, 也可以作为反转（反转表达式的符号）|
|*   |乘|
|/   |除|
|~/  |除并取整|
|%   |取模|

- Dart 还支持自增自减操作。

```dart
i++;
i--;
++i;
--i;
```

### 4.2 关系运算符

|运算符|描述|
|:---|:---|
|==  |相等|
|!=  |不等|
|>   |大于|
|<   |小于|
|>=  |大于等于|
|<=  |小于等于|

### 4.3 类型判断运算符

|运算符|描述|
|:---|:---|
|as  |类型转换（也用作指定类前缀)）|
|is  |如果对象是指定类型则返回 true|
|is! |如果对象是指定类型则返回 false|

```dart
if (emp is Person) {    
  // 类型检查
  emp.firstName = 'Bob';
}

(emp as Person).firstName = 'Bob';  // 当且仅当 obj 实现了 T 的接口，obj is T 才是 true
```

### 4.4 赋值运算符

可以使用 = 来赋值，同时也可以使用 ??= 来为值为 null 的变量赋值。

```dart
b ??= value;    // 当且仅当 b 为 null 时才赋值
```

### 4.5 逻辑运算符

|运算符|描述|
|:---|:---|
|!表达式     |对表达式结果取反（即将 true 变为 false，false 变为 true）|
|\|\|         |逻辑或|
|&&         |逻辑与|

### 4.6 按位和移位运算符

|运算符|描述|
|:---|:---|
|&   |按位与|
|\|   |按位或|
|^   |按位异或|
|~表达式|    按位取反（即将 “0” 变为 “1”，“1” 变为 “0”）|
|<<  |位左移|
|>>  |位右移|

### 4.7 条件表达式

```dart
condition ? expr1 : expr2

var visibility = isPublic ? 'public' : 'private';
```

### 4.8 级联运算符（..）

级联运算符（..）可以让你在同一个对象上连续调用多个对象的变量或方法。

```dart
querySelector('#confirm')   // 获取对象 (Get an object).
  ..text = 'Confirm'        // 使用对象的成员 (Use its members).
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));

// 等价于
var button = querySelector('#confirm');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));

// 级联运算符嵌套
final addressBook = (AddressBookBuilder()
      ..name = 'jenny'
      ..email = 'jenny@example.com'
      ..phone = (PhoneNumberBuilder()
            ..number = '415-555-0100'
            ..label = 'home')
          .build())
    .build();

// 级联运算符的上级第一级必须是对象
var sb = StringBuffer();
sb.write('foo')     // 返回 void
  ..write('bar');   // 出错：void 对象中没有方法 write (Error: method 'write' isn't defined for 'void').
```

### 4.9 其他运算符

|运算符|名称|描述|
|:---|:---|:---|
|()  |使用方法    |代表调用一个方法|
|[]  |访问 List |访问 List 中特定位置的元素|
|.   |访问成员    |成员访问符|
|?.  |条件访问成员  |与上述成员访问符类似，但是左边的操作对象不能为 null，例如 foo?.bar，如果 foo 为 null 则返回 null ，否则返回 bar|

## 五、流程控制语句

- 你可以使用下面的语句来控制 Dart 代码的执行流程：
    - if 和 else
    - for 循环
    - while 和 do-while 循环
    - break 和 continue
    - switch 和 case
    - assert

### 5.1 循环

```dart
// *if - else

// Dart 的 if 语句中的条件必须是一个布尔值，不能是其它类型
if (isRaining()) {
    you.bringRainCoat();
} else if (isSnowing()) {
    you.wearJacket();
} else {
    car.putTopDown();
}

// *For 循环

var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++) {   // 标准 for
    message.write('!');
}

// for 循环中的闭包会自动捕获循环的 索引值
var callbacks = [];
for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));    // 数组中添加匿名函数
}
callbacks.forEach((c) => c());

// 如果要遍历的对象实现了 Iterable 接口，则可以使用 forEach() 方法
candidates.forEach((candidate) => candidate.interview());

//  List 和 Set 等实现了 Iterable 接口的类还支持 for-in 形式的 迭代
var collection = [0, 1, 2];
for (var x in collection) {
    print(x); // 0 1 2
}

// *While 和 Do-While

while (!isDone()) {
  doSomething();
}
do {
  printLine();
} while (!atEndOfPage());
```

### 5.2 switch

Switch 语句在 Dart 中使用 == 来比较整数、字符串或编译时常量，比较的两个对象必须是同一个类型且不能是子类并且没有重写 == 操作符

每一个非空的 case 子句都必须有一个 break 语句，也可以通过 continue、throw 或者 return 来结束非空 case 语句。

```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':
    executeClosed();
    continue nowClosed;     // continue 用法
  // 继续执行标签为 nowClosed 的 case 子句。

  nowClosed:
  case 'NOW_CLOSED':
    // case 条件值为 CLOSED 和 NOW_CLOSED 时均会执行该语句。
    executeNowClosed();
    break;
}
```

### 5.3 断言 Assert

在开发过程中，可以在条件表达式为 false 时使用 - assert(条件, 可选信息); - 语句来打断代码的执行

```dart
// assert 的第二个参数可以为其添加一个字符串消息
assert(urlString.startsWith('https'), 'URL ($urlString) should start with "https".');
```

- assert 是否生效依赖开发工具和使用的框架：
    - Flutter 在调试模式时生效。
    - 一些开发工具比如 dartdevc 通常情况下是默认生效的。
    - 其他一些工具，比如 dart 以及 dart2js 通过在运行 Dart 程序时添加命令行参数 --enable-asserts 使 assert 生效。

在生产环境代码中，断言会被忽略，与此同时传入 assert 的参数不被判断。

## 六、异常

Dart 代码可以抛出和捕获异常。异常表示一些未知的错误情况，如果异常没有捕获则会被抛出从而导致抛出异常的代码终止执行。

与 Java 不同的是，Dart 的所有异常都是非必检异常，方法不一定会声明其所抛出的异常并且你也不会被要求捕获任何异常。

Dart 提供了 Exception 和 Error 两种类型的异常以及它们一系列的子类，你也可以定义自己的异常类型。但是在 Dart 中可以将任何非 null 对象作为异常抛出而不局限于 Exception 或 Error 类型。

### 6.1 抛出异常

```dart
throw FormatException('Expected at least 1 section');   // 抛出 或者 引发 异常
throw 'Out of llamas!';     // 抛出任意的对象
```

### 6.2 捕获异常

捕获异常可以避免异常继续传递（重新抛出异常除外）。捕获一个异常可以给你处理它的机会：

```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // 指定异常
  buyMoreLlamas();
} on Exception catch (e) {
  // 其它类型的异常
  print('Unknown exception: $e');
} catch (e) {
  // // 不指定类型，处理其它全部
  print('Something really unknown: $e');
}

try {
  // ···
} on Exception catch (e) {
  print('Exception details:\n $e');
} catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}

void misbehave() {  // catch 和 on 可以同时使用
  try {
    dynamic foo = true;
    print(foo++); // 运行时错误
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // 允许调用者查看异常。
  }
}
```

### 6.3 Finally

可以使用 finally 语句来包裹确保不管有没有异常都执行代码，如果没有指定 catch 语句来捕获异常，则在执行完 finally 语句后再抛出异常

```dart
try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // 先处理异常。
} finally {
  cleanLlamaStalls(); // 然后清理。
}
```

## 七、类

Dart 是支持基于 mixin 继承机制的面向对象语言，所有对象都是一个类的实例，而所有的类都继承自 Object 类。基于 mixin 的继承 意味着每个除 Object 类之外的类都只有一个超类，一个类的代码可以在其它多个类继承中重复使用。 Extension 方法是一种在不更改类或创建子类的情况下向类添加功能的方式。

### 7.1 使用类的成员

```dart
// 使用（.）来访问对象的实例变量或方法
var p = Point(2, 2);
// 为实例变量 y 赋值。
p.y = 3;
// 获取 y 的值。
assert(p.y == 3);
// 调用变量 p 的 distanceTo() 方法。
num distance = p.distanceTo(Point(4, 4));

p?.y = 4;   // 使用 ?. 代替 . 可以避免因为左边表达式为 null 而导致的问题
```

### 7.2 使用构造函数

可以使用 构造函数 来创建一个对象。构造函数的命名方式可以为 类名 或 类名.标识符 的形式。例如下述代码分别使用 Point() 和 Point.fromJson() 两种构造器创建了 Point 对象：

```dart
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});

var p1 = new Point(2, 2);       // new 可选；与上面等价
var p2 = new Point.fromJson({'x': 1, 'y': 2});
```

一些类提供了常量构造函数。使用常量构造函数，在构造函数名之前加 const 关键字，来创建编译时常量时：

```dart
var p = const ImmutablePoint(2, 2);

// 两个使用相同构造函数相同参数值构造的编译时常量是同一个对象：
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // 它们是同一个实例 (They are the same instance!)
```

创建常量 map：

```dart
// 这里有很多 const 关键字
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};

// 只需要一个 const 关键字，其它的则会隐式地根据上下文进行关联。
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

### 7.3 获取对象的类型

可以使用 Object 对象的 runtimeType 属性在运行时获取一个对象的类型，该对象类型是 Type 的实例。

```dart
print('The type of a is ${a.runtimeType}');
```

### 7.4 实例变量

- 下面是声明实例变量的示例：

```dart
class Point {
    double x;     // 声明 double 变量 x 并初始化为 null。
    double y;     // 声明 double 变量 y 并初始化为 null
    double z = 0; // 声明 double 变量 z 并初始化为 0。
}
```

- 所有未初始化的实例变量其值均为 null。
- 所有实例变量均会隐式地声明一个 Getter 方法，非 final 类型的实例变量还会隐式地声明一个 Setter 方法。
- 如果你在声明一个实例变量的时候就将其初始化（而不是在构造函数或其它方法中），那么该实例变量的值就会在对象实例创建的时候被设置，该过程会在构造函数以及它的初始化器列表执行前。

### 7.5 构造函数

#### 声明构造函数

- 声明一个与类名一样的函数即可声明一个构造函数（对于命名式构造函数 还可以添加额外的标识符）

```dart
class Point {
  double x, y;

  Point(double x, double y) {
    this.x = x;         // 使用 this 关键字引用当前实例。
    this.y = y;
  }
}

class Point {
  double x, y;

  Point(this.x, this.y);    // 更简介的构造函数
}
```

#### 默认构造函数

- 如果你没有声明构造函数，那么 Dart 会自动生成一个无参数的构造函数并且该构造函数会调用其父类的无参数构造方法。

#### 构造函数不被继承

- 子类不会继承父类的构造函数，如果子类没有声明构造函数，那么只会有一个默认无参数的构造函数。

#### 命名式构造函数

- 可以为一个类声明多个命名式构造函数来表达更明确的意图：

```dart
class Point {
  double x, y;
  Point(this.x, this.y);
  // 命名式构造函数
  Point.origin() {
    x = 0;
    y = 0;
  }
}
```

记住构造函数是不能被继承的，这将意味着子类不能继承父类的命名式构造函数，如果你想在子类中提供一个与父类命名构造函数名字一样的命名构造函数，则需要在子类中显式地声明。

#### 调用父类非默认构造函数

- 默认情况下，子类的构造函数会调用父类的匿名无参数构造方法，并且该调用会在子类构造函数的函数体代码执行前，如果子类构造函数还有一个 初始化列表，那么该初始化列表会在调用父类的该构造函数之前被执行，总的来说，这三者的调用顺序如下：
    - 初始化列表
    - 父类的无参数构造函数
    - 当前类的构造函数

- 如果父类没有匿名无参数构造函数，那么子类必须调用父类的其中一个构造函数，为子类的构造函数指定一个父类的构造函数只需在构造函数体前使用（:）指定。

```dart
class Person {
  String firstName;
  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  Employee.fromJson(Map data) : super.fromJson(data) {  // 调用父类构造函数的方式
    print('in Employee');
  }
}

main() {
  var emp = new Employee.fromJson({});

  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }
  (emp as Person).firstName = 'Bob';
}
```

#### 初始化列表

```dart
Point.fromJson(Map<String, double> json)
    : x = json['x'],
      y = json['y'] {
  print('In Point.fromJson(): ($x, $y)');
}
// 在开发模式下，你可以在初始化列表中使用 assert 来验证输入数据
Point.withAssert(this.x, this.y) : assert(x >= 0) {
  print('In Point.withAssert(): ($x, $y)');
}
```

#### 重定向构造函数

```dart
class Point {
  double x, y;
  // 该类的主构造函数。
  Point(this.x, this.y);
  // 委托实现给主构造函数。
  Point.alongXAxis(double x) : this(x, 0);
}
```

#### 常量构造函数

如果类生成的对象都是不会变的，那么可以在生成这些对象时就将其变为编译时常量。你可以在类的构造函数前加上 const 关键字并确保所有实例变量均为 final 来实现该功能。

```dart
class ImmutablePoint {
  static final ImmutablePoint origin =
      const ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
```

#### 工厂构造函数

使用 factory 关键字标识类的构造函数将会令该构造函数变为工厂构造函数，这将意味着使用该构造函数构造类的实例时并非总是会返回新的实例对象。例如，工厂构造函数可能会从缓存中返回一个实例，或者返回一个子类型的实例。

```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache 变量是库私有的，因为在其名字前面有下划线。
  static final Map<String, Logger> _cache =
      <String, Logger>{};

  factory Logger(String name) {     // 在工厂构造函数中无法访问 this。
    return _cache.putIfAbsent(
        name, () => Logger._internal(name));
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```

### 7.6 方法

#### 实例方法

对象的实例方法可以访问实例变量和 this

```dart
import 'dart:math';

class Point {
  double x, y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```

#### Getter 和 Setter

Getter 和 Setter 是一对用来读写对象属性的特殊方法，上面说过实例对象的每一个属性都有一个隐式的 Getter 方法，如果为非 final 属性的话还会有一个 Setter 方法，你可以使用 get 和 set 关键字为额外的属性添加 Getter 和 Setter 方法：

```dart
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // 定义两个计算产生的属性：right 和 bottom。
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```

使用 Getter 和 Setter 的好处是，你可以先使用你的实例变量，过一段时间过再将它们包裹成方法且不需要改动任何代码，即先定义后更改且不影响原有逻辑。

#### 抽象方法

实例方法、Getter 方法以及 Setter 方法都可以是抽象的，定义一个接口方法而不去做具体的实现让其他的类去实现该方法，抽象方法只能存在于 抽象类中。

直接使用分号（;）替代方法体即可声明一个抽象方法：

```dart
abstract class Doer {
  // 定义实例变量和方法等等……
  void doSomething(); // 定义一个抽象方法。
}

class EffectiveDoer extends Doer {  // 子类必须定义父类的抽象方法
  void doSomething() {
    // 提供一个实现，所以在这里该方法不再是抽象的……
  }
}
```

#### 抽象类

使用关键字 abstract 标识类可以让该类成为 抽象类，抽象类将无法被实例化。抽象类常用于声明接口方法、有时也会有具体的方法实现。如果想让抽象类同时可被实例化，可以为其定义 工厂构造函数。

#### 隐式接口

每一个类都隐式地定义了一个接口并实现了该接口，这个接口包含所有这个类的实例成员以及这个类所实现的其它接口。如果想要创建一个 A 类支持调用 B 类的 API 且不想继承 B 类，则可以实现 B 类的接口。

一个类可以通过关键字 implements 来实现一个或多个接口并实现每个接口定义的 API：

```dart
// A person. The implicit interface contains greet().
// Person 类的隐式接口中包含 greet() 方法。
class Person {
  // _name 变量同样包含在接口中，但它只是库内可见的。
  final _name;

  // 构造函数不在接口中。
  Person(this._name);

  // greet() 方法在接口中。
  String greet(String who) => '你好，$who。我是$_name。';
}

// Person 接口的一个实现。
class Impostor implements Person {
  get _name => '';

  String greet(String who) => '你好$who。你知道我是谁吗？';
}

String greetBob(Person person) => person.greet('小芳');

void main() {
  print(greetBob(Person('小芸')));
  print(greetBob(Impostor()));
}
```

输出：

```dart
你好，小芳。我是小芸。
你好小芳。你知道我是谁吗？
```

### 7.7 类继承

使用 extends 关键字来创建一个子类，并可使用 super 关键字引用一个父类：

```dart
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
  // ···
}

class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
  // ···
}
```

#### 重写类成员

子类可以重写父类的实例方法、Getter 以及 Setter 方法。你可以使用 @override 注解来表示你重写了一个成员：

```dart
class SmartTelevision extends Television {
  @override
  void turnOn() {...}
  // ···
}
```

#### 重写运算符

- 可重写的运算符

|<|+|\||[]|
|---|---|---|---|
|>   |/   |^   |[]=|
|<=  |~/  |&   |~|
|>=  |*   |<<  |==|
|–   |%   |>>||

```dart
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  // 运算符 == 和 hashCode 的实现未在这里展示，详情请查看下方说明。
  // ···
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
```

- noSuchMethod()

如果调用了对象上不存在的方法或实例变量将会触发 noSuchMethod 方法，你可以重写 noSuchMethod 方法来追踪和记录这一行为：

```dart
class A {
  // 除非你重写 noSuchMethod，否则调用一个不存在的成员会导致 NoSuchMethodError。
  @override
  void noSuchMethod(Invocation invocation) {
  print('你尝试使用一个不存在的成员：' +
  '${invocation.memberName}');
  }
}
```

- 不能调用一个未实现的方法除非下面其中的一个条件成立：
    - 接收方是静态的 dynamic 类型。
    - 接收方具有静态类型，定义了未实现的方法（抽象亦可），并且接收方的动态类型实现了 noSuchMethod 方法且具体的实现与 Object 中的不同。

#### Extension 方法

Dart 2.7 中引入的 Extension 方法是向现有库添加功能的一种方式。你可能甚至都不知道有 Extension 方法。例如，当您在 IDE 中使用代码完成功能时，它建议将 Extension 方法与常规方法一起使用。

### 7.7 使用枚举

使用关键字 enum 来定义枚举类型：

```dart
enum Color { red, green, blue }
```

每一个枚举值都有一个名为 index 成员变量的 Getter 方法，该方法将会返回以 0 为基准索引的位置值。例如，第一个枚举值的索引是 0 ，第二个枚举值的索引是 1。以此类推。

```dart
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
```

可以使用枚举类的 values 方法获取一个包含所有枚举值的列表：

```dart
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
```

- 在 Switch 语句中使用枚举

```dart
var aColor = Color.blue;

switch (aColor) {
  case Color.red:
    print('红如玫瑰！');
    break;
  case Color.green:
    print('绿如草原！');
    break;
  default:
    print(aColor); // 'Color.blue'
}
```

### 7.8 使用 Mixin 为类添加功能

Mixin 是一种在多重继承中复用某个类中代码的方法模式。

使用 with 关键字并在其后跟上 Mixin 类的名字来使用 Mixin 模式：

```dart
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person
    with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```

定义一个类继承自 Object 并且不为该类定义构造函数，这个类就是 Mixin 类，除非你想让该类与普通的类一样可以被正常地使用，否则可以使用关键字 mixin 替代 class 让其成为一个单纯的 Mixin 类：

```dart
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
```

可以使用关键字 on 来指定哪些类可以使用该 Mixin 类，比如有 Mixin 类 A，但是 A 只能被 B 类使用，则可以这样定义 A：

```dart
mixin MusicalPerformer on Musician {
  // ···
}
```

### 7.9 类变量和方法

使用关键字 static 可以声明类变量或类方法。

- 静态变量
    - 静态变量（即类变量）常用于声明类范围内所属的状态变量和常量
    - 静态变量在其首次被使用的时候才被初始化
- 静态方法
    - 静态方法（即类方法）不能被一个类的实例访问
    - 静态方法内也不可以使用 this
    - 可以将静态方法作为编译时常量。例如，你可以将静态方法作为一个参数传递给一个常量构造函数

## 八、泛型

### 8.1 示例

```dart
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
```

在上述代码中，T 是一个替代类型。其相当于类型占位符，在开发者调用该接口的时候会指定具体类型。

### 8.2 使用集合字面量

```dart
var names = <String>['小芸', '小芳', '小民'];
var uniqueNames = <String>{'小芸', '小芳', '小民'};
var pages = <String, String>{
  'index.html': '主页',
  'robots.txt': '网页机器人提示',
  'humans.txt': '我们是人类，不是机器'
};
```

### 8.3 使用类型参数化的构造函数

```dart
var nameSet = Set<String>.from(names);
```

### 8.4 限制参数化类型

有时使用泛型的时候可能会想限制泛型的类型范围，这时候可以使用 extends 关键字：

```dart
class Foo<T extends SomeBaseClass> {    // 可以使用 SomeBaseClass 或者它的子类来作为泛型参数
  // 具体实现……
  String toString() => "'Foo<$T>' 的实例";
}

class Extender extends SomeBaseClass {...}

var someBaseClassFoo = Foo<SomeBaseClass>();
var extenderFoo = Foo<Extender>();

var foo = Foo();    // 指定无参数的泛型
print(foo); // 'Foo<SomeBaseClass>' 的实例

var foo = Foo<Object>();    // 将非 SomeBaseClass 的类型作为泛型参数则会导致编译错误
```

### 8.5 使用泛型方法

起初 Dart 只支持在类的声明时指定泛型，现在同样也可以在方法上使用泛型，称之为 泛型方法：

```dart
T first<T>(List<T> ts) {
  // 处理一些初始化工作或错误检测……
  T tmp = ts[0];
  // 处理一些额外的检查……
  return tmp;
}
```

- 方法 first<T> 的泛型 T 可以在如下地方使用：
    - 函数的返回值类型 (T)
    - 参数的类型 (List<T>)
    - 局部变量的类型 (T tmp)

## 九、库和可见性

import 和 library 关键字可以帮助你创建一个模块化和可共享的代码库。代码库不仅只是提供 API 而且还起到了封装的作用：以下划线（\_）开头的成员仅在代码库中可见。每个 Dart 程序都是一个库，即便没有使用关键字 library 指定。

Dart 的库可以使用[包](https://dart.cn/guides/packages)工具来发布和部署。

```dart
import 'dart:html';     // 使用 import 来指定命名空间以便其它库可以访问
```

### 9.1 使用库

import 的唯一参数是用于指定代码库的 URI，对于 Dart 内置的库，使用 dart:xxxxxx 的形式。而对于其它的库，你可以使用一个文件系统路径或者以 package:xxxxxx 的形式。package:xxxxxx 指定的库通过包管理器（比如 pub 工具）来提供：

```dart
import 'package:test/test.dart';
```

- 用法：

```dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;    // 导入的两个代码库有冲突的标识符，你可以为其中一个指定前缀

import 'package:lib1/lib1.dart' show foo;   // 只导入 lib1 中的 foo。(Import only foo).

import 'package:lib2/lib2.dart' hide foo;   // 导入 lib2 中除了 foo 外的所有。

// 延迟加载库，允许应用在需要时再去加载代码库
import 'package:greetings/hello.dart' deferred as hello;
```

### 9.2 实现库

[https://dart.cn/guides/packages](https://dart.cn/guides/packages)

## 十、异步支持

Dart 代码库中有大量返回 Future 或 Stream 对象的函数，这些函数都是 异步 的，它们会在耗时操作（比如I/O）执行完毕前直接返回而不会等待耗时操作执行完毕。

async 和 await 关键字用于实现异步编程，并且让你的代码看起来就像是同步的一样。

### 10.1 处理 Future

- 可以通过下面两种方式，获得 Future 执行完成的结果：
    - 使用 async 和 await；
    - 使用 Future API

- 用法：

```dart
Future checkVersion() async {   // 必须在带有 async 关键字的 异步函数 中使用 await
  var version = await lookUpVersion();  // 使用 await 等待异步函数的执行结果
  // 使用 version 继续处理逻辑
}

// 使用 try、catch 以及 finally 来处理使用 await 导致的异常
try {
  version = await lookUpVersion();
} catch (e) {
  // 无法找到版本时做出的反应
}

// 在异步函数中多次使用 await 关键字
var entrypoint = await findEntrypoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```

await 表达式的返回值通常是一个 Future 对象；如果不是的话也会自动将其包裹在一个 Future 对象里。Future 对象代表一个“承诺”，await 表达式会阻塞直到需要的对象返回。

如果在使用 await 时导致编译错误，请确保 await 在一个异步函数中使用。例如，如果想在 main() 函数中使用 await，那么 main() 函数就必须使用 async 关键字标识。

```dart
Future main() async {
  checkVersion();
  print('在 Main 函数中执行：版本是 ${await lookUpVersion()}');   // 调用 await 了
}
```

### 10.2 声明异步函数

定义 异步函数 只需在普通方法上加上 async 关键字即可。

```dart
String lookUpVersion() => '1.0.0';                  // 普通函数
Future<String> lookUpVersion() async => '1.0.0';    // 修改为异步
```

### 10.3 处理 Stream

- 如果想从 Stream 中获取值，可以有两种选择：
    - 使用 async 关键字和一个 异步循环（使用 await for 关键字标识）。
    - 使用 Stream API。

- 语法：

```dart
await for (varOrType identifier in expression) {
  // 每当 Stream 发出一个值时会执行
}
```

- expression 的类型必须是 Stream。执行流程如下：
    - 等待直到 Stream 返回一个数据；
    - 使用 1 中 Stream 返回的数据执行循环体；
    - 重复 1、2 过程直到 Stream 数据返回完毕。

使用 break 和 return 语句可以停止接收 Stream 数据，这样就跳出了循环并取消注册监听 Stream。

如果在实现异步 for 循环时遇到编译时错误，请检查确保 await for 处于异步函数中。 例如，要在应用程序的 main() 函数中使用异步 for 循环，main() 函数体必须标记为 async：

## 十一、生成器

- 当你需要延迟地生成一连串的值时，可以考虑使用 生成器函数。Dart 内置支持两种形式的生成器方法：
    - 同步 生成器：返回一个 Iterable 对象；
    - 异步 生成器：返回一个 Stream 对象。

通过在函数上加 sync* 关键字并将返回值类型设置为 Iterable 来实现一个 同步 生成器函数，在函数中使用 yield 语句来传递值：

```dart
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
```

实现 异步 生成器函数与同步类似，只不过关键字为 async* 并且返回值为 Stream：

```dart
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}


```

如果生成器是递归调用的，可是使用 yield* 语句提升执行性能：

```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```

## 十二、隔离区

大多数计算机中，甚至在移动平台上，都在使用多核 CPU。为了有效利用多核性能，开发者一般使用共享内存的方式让线程并发地运行。然而，多线程共享数据通常会导致很多潜在的问题，并导致代码运行出错。

为了解决多线程带来的并发问题，Dart 使用 isolates 替代线程，所有的 Dart 代码均运行在一个 isolates 中。每一个 isolates 有它自己的堆内存以确保其状态不被其它 isolates 访问。

## 十二、类型定义

```dart
class SortedCollection {
  Function compare;

  SortedCollection(int f(Object a, Object b)) {
    compare = f;    // 将 f 赋值给 compare 后，f 函数类型 (Object a, Object b) -> int 丢失
  }
}

int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);

  // 我们知道 compare 是一个函数类型的变量，但是具体是什么样的函数却不得而知。
  assert(coll.compare is Function);
}
```

```dart
typedef Compare = int Function(Object a, Object b);

class SortedCollection {
  Compare compare;  // 函数类型

  SortedCollection(this.compare);   // 传入带函数类型的函数
}

// 简单的不完整实现。
int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);
  assert(coll.compare is Function);
  assert(coll.compare is Compare);
}

// 因为类型定义只是别名，因此我们可以使用它判断任意函数类型的方法
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
```

## 十三、元数据

使用元数据可以为代码增加一些额外的信息。元数据注解以 @ 开头，其后紧跟一个编译时常量（比如 deprecated）或者调用一个常量构造函数。

Dart 中有两个注解是所有代码都可以使用的：@deprecated 和 @override。你可以查阅扩展一个类获取有关 @override 的使用示例。下面是使用 @deprecated 的示例：

```dart
class Television {
  /// _弃用: 使用 [turnOn] 替代_
  @deprecated
  void activate() {
    turnOn();
  }

  /// 打开 TV 的电源。
  void turnOn() {...}
}
```

- 自定义注解

```dart
library todo;

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
```

```dart
import 'todo.dart';

@Todo('seth', 'make this do something')
void doSomething() {
  print('do something');
}
```

元数据可以在 library、class、typedef、type parameter、constructor、factory、function、field、parameter 或者 variable 声明之前使用，也可以在 import 或 export 之前使用。可使用反射在运行时获取元数据信息。

## 十四、元数据

Dart 支持单行注释、多行注释和文档注释。

```dart
//  单行注释
print('单行注释');
/*
 *  多行注释
*/
print('多行注释');
```

文档注释可以是多行注释，也可以是单行注释，文档注释以 /// 或者 /** 开始；在连续行上使用 /// 与多行文档注释具有相同的效果。

在文档注释中，除非用中括号括起来，否则 Dart 编译器会忽略所有文本。使用中括号可以引用类、方法、字段、顶级变量、函数、和参数。括号中的符号会在已记录的程序元素的词法域中进行解析。

```dart
/// A domesticated South American camelid (Lama glama).
///
/// Andean cultures have used llamas as meat and pack
/// animals since pre-Hispanic times.
class Llama {
  String name;

  /// Feeds your llama [Food].
  ///
  /// The typical llama eats one bale of hay per week.
  void feed(Food food) {
    // ...
  }

  /// Exercises your llama with an [activity] for
  /// [timeLimit] minutes.
  void exercise(Activity activity, int timeLimit) {
    // ...
  }
}
```

在生成的文档中，[Food] 会成为一个链接，指向 Food 类的 API 文档。

解析 Dart 代码并生成 HTML 文档，可以使用 SDK 中的文档生成工具。