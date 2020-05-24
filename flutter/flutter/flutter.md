## 一、第一个 Flutter 应用

```dart
// 包导入；导入了 Material UI 组件库。Material 是一种标准的移动端和 web 端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的 UI 组件。
import 'package:flutter/material.dart';

// 应用入口
void main() => runApp(new MyApp());
// 应用结构
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      theme: new ThemeData(
        // 蓝色主题
        primarySwatch: Colors.blue,
      ),
      // 应用页路由
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 首页
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;     // 用于记录按钮点击的总次数

  void _incrementCounter() {
    setState(() {       // setState 方法的作用是通知 Flutter 
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

### 1.1 分析

#### 1.1.1 导入包

导入了 Material UI 组件库。Material 是一种标准的移动端和 web 端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的 UI 组件。

#### 1.1.2 应用入口

- 与 C/C++、Java 类似，Flutter  应用中 main 函数为应用程序的入口。main 函数中调用了 runApp 方法，它的功能是启动 Flutter 应用。runApp 它接受一个 Widget 参数，在本示例中它是一个 MyApp 对象，MyApp() 是 Flutter 应用的根组件。
- main 函数使用了 (=>) 符号，这是 Dart 中单行函数或方法的简写。

#### 1.1.3 应用结构

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //应用名称  
      title: 'Flutter Demo', 
      theme: new ThemeData(
        //蓝色主题  
        primarySwatch: Colors.blue,
      ),
      //应用首页路由  
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

- MyApp 类代表 Flutter 应用，它继承了 StatelessWidget 类，这也就意味着应用本身也是一个 widget。
- 在Flutter中，大多数东西都是 widget（后同“组件”或“部件”），包括对齐(alignment)、填充(padding)和布局(layout)等，它们都是以 widget 的形式提供。
- Flutter 在构建页面时，会调用组件的 build 方法，widget 的主要工作是提供一个 build() 方法来描述如何构建 UI 界面（通常是通过组合、拼装其它基础 widget）。
- MaterialApp 是 Material 库中提供的 Flutter APP 框架，通过它可以设置应用的名称、主题、语言、首页及路由列表等。MaterialApp 也是一个 widget。
- home 为 Flutter 应用的首页，它也是一个 widget。

### 1.2 首页

```dart
class MyHomePage extends StatefulWidget {
 MyHomePage({Key key, this.title}) : super(key: key);
 final String title;
 @override
 _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
...
}
```

- MyHomePage 是 Flutter 应用的首页，它继承自 StatefulWidget 类，表示它是一个有状态的组件（Stateful widget）。现在我们只需简单认为有状态的组件（Stateful widget） 和无状态的组件（Stateless widget）有两点不同：
    - Stateful widget 可以拥有状态，这些状态在 widget 生命周期中是可以变的，而 Stateless widget 是不可变的。
    - Stateful widget 至少由两个类组成：
        - 一个 StatefulWidget 类;
        - 一个 State 类； StatefulWidget 类本身是不变的，但是 State 类中持有的状态在 widget 生命周期中可能会发生变化。

\_MyHomePageState 类是 MyHomePage 类对应的状态类。看到这里，读者可能已经发现：和 MyApp 类不同， MyHomePage 类中并没有 build 方法，取而代之的是，build 方法被挪到了 \_MyHomePageState 方法中，至于为什么这么做，先留个疑问，在分析完完整代码后再来解答。

### 1.3 State 类

接下来，看看 \_MyHomePageState 中都包含哪些东西：

#### 1.3.1 组件状态

```dart
int _counter = 0; //用于记录按钮点击的总次数
```

#### 1.3.2 状态操作方法

```dart
void _incrementCounter() {
  setState(() {     // setState 方法的作用是通知 Flutter 框架，有状态发生了改变
     _counter++;
  });
}
```

当按钮点击时，会调用此函数，该函数的作用是先自增 \_counter，然后调用 setState 方法。setState 方法的作用是通知 Flutter 框架，有状态发生了改变，Flutter 框架收到通知后，会执行 build 方法来根据新的状态重新构建界面， Flutter 对此方法做了优化，使重新执行变的很快，所以你可以重新构建任何需要更新的东西，而无需分别去修改各个 widget。

#### 1.3.3 构建 UI 界面

构建 UI 界面的逻辑在 build 方法中，当 MyHomePage 第一次创建时，\_MyHomePageState 类会被创建，当初始化完成后，Flutter 框架会调用 Widget 的 build 方法来构建 widget 树，最终将 widget 树渲染到设备屏幕上。所以，我们看看 \_MyHomePageState 的 build 方法中都干了什么事：

```dart
Widget build(BuildContext context) {
return new Scaffold(
  appBar: new AppBar(
    title: new Text(widget.title),
  ),
  body: new Center(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          'You have pushed the button this many times:',
        ),
        new Text(
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    ),
  ),
  floatingActionButton: new FloatingActionButton(
    onPressed: _incrementCounter,
    tooltip: 'Increment',
    child: new Icon(Icons.add),
  ),
);
}
```

- Scaffold 是 Material 库中提供的页面脚手架，它提供了默认的导航栏、标题和包含主屏幕 widget 树（后同“组件树”或“部件树”）的 body 属性，组件树可以很复杂。本书后面示例中，路由默认都是通过Scaffold创建。
- body 的组件树中包含了一个 Center 组件，Center 可以将其子组件树对齐到屏幕中心。此例中， Center 子组件是一个 Column 组件，Column 的作用是将其所有子组件沿屏幕垂直方向依次排列； 此例中 Column 子组件是两个 Text：
    - 第一个 Text 显示固定文本 “You have pushed the button this many times:”；
    - 第二个 Text 显示 \_counter 状态的数值。
- floatingActionButton 是页面右下角的带 “+” 的悬浮按钮，它的 onPressed 属性接受一个回调函数，代表它被点击后的处理器，本例中直接将 \_incrementCounter 方法作为其处理函数。

### 1.4 为何将 build 方法放在 State 中，而不是 StatefulWidget

如果将 build() 方法放在 StatefulWidget 中则会有两个问题

#### 状态访问不便

如果我们的 StatefulWidget 有很多状态，而每次状态改变都要调用 build 方法，由于状态是保存在 State 中的，如果 build 方法在 StatefulWidget 中，那么 build 方法和状态分别在两个类中，那么构建时读取状态将会很不方便！如果真的将 build 方法放在 StatefulWidget 中的话，由于构建用户界面过程需要依赖 State，所以 build 方法将必须加一个 State 参数，大概是下面这样：

```dart
Widget build(BuildContext context, State state){
  //state.counter
  ...
}
```

这样的话就只能将 State 的所有状态声明为公开的状态，这样才能在 State 类外部访问状态！但是，将状态设置为公开后，状态将不再具有私密性，这就会导致对状态的修改将会变的不可控。但如果将 build() 方法放在 State 中的话，构建过程不仅可以直接访问状态，而且也无需公开私有状态，这会非常方便。

#### 继承 StatefulWidget 不便

例如，Flutter 中有一个动画 widget 的基类 AnimatedWidget，它继承自 StatefulWidget 类。AnimatedWidget 中引入了一个抽象方法 build(BuildContext context)，继承自 AnimatedWidget 的动画 widget 都要实现这个 build 方法。现在设想一下，如果 StatefulWidget 类中已经有了一个 build 方法，正如上面所述，此时 build 方法需要接收一个 state 对象，这就意味着 AnimatedWidget 必须将自己的 State 对象(记为 \_animatedWidgetState)提供给其子类，因为子类需要在其 build 方法中调用父类的 build 方法，代码可能如下：

```dart
class MyAnimationWidget extends AnimatedWidget{
    @override
    Widget build(BuildContext context, State state){
      //由于子类要用到AnimatedWidget的状态对象_animatedWidgetState，
      //所以AnimatedWidget必须通过某种方式将其状态对象_animatedWidgetState
      //暴露给其子类   
      super.build(context, _animatedWidgetState)
    }
}
```

- 这样很显然是不合理的，因为:
    - AnimatedWidget 的状态对象是 AnimatedWidget 内部实现细节，不应该暴露给外部。
    - 如果要将父类状态暴露给子类，那么必须得有一种传递机制，而做这一套传递机制是无意义的，因为父子类之间状态的传递和子类本身逻辑是无关的。

## 二、基础组件

### 2.1 Widget 简介

#### 2.1.1

Flutter 中几乎所有的对象都是一个 Widget。与原生开发中“控件”不同的是，Flutter 中的 Widget 的概念更广泛，它不仅可以表示 UI 元素，也可以表示一些功能性的组件如：用于手势检测的 GestureDetector widget、用于 APP 主题数据传递的 Theme 等等，而原生开发中的控件通常只是指UI元素。在后面的内容中，我们在描述 UI 元素时可能会用到“控件”、“组件”这样的概念，读者心里需要知道他们就是 widget，只是在不同场景的不同表述而已。由于 Flutter 主要就是用于构建用户界面的，所以，在大多数时候，读者可以认为 widget 就是一个控件，不必纠结于概念。

#### 2.1.2 Widget 与 Element

Widget 的功能是“描述一个 UI 元素的配置数据”，它就是说，Widget 其实并不是表示最终绘制在设备屏幕上的显示元素，而它只是描述显示元素的一个配置数据；真正代表屏幕上显示元素的类是 Element，也就是说 Widget 只是描述 Element 的配置数据。

- Widget 实际上就是 Element 的配置数据，Widget 树实际上是一个配置树，而真正的 UI 渲染树是由 Element 构成；不过，由于 Element 是通过 Widget 生成的，所以它们之间有对应关系，在大多数场景，我们可以宽泛地认为 Widget 树就是指 UI 控件树或 UI 渲染树。
- 一个 Widget 对象可以对应多个 Element 对象。这很好理解，根据同一份配置（Widget），可以创建多个实例（Element）。

#### 2.1.3 Widget 主要接口

先来看一下Widget类的声明：

```dart
@immutable
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });
  final Key key;

  @protected
  Element createElement();

  @override
  String toStringShort() {
    return key == null ? '$runtimeType' : '$runtimeType-$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }

  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
```

- Widget 类：继承自 DiagnosticableTree，DiagnosticableTree 即“诊断树”，主要作用是提供调试信息。
- Key: 主要的作用是决定是否在下一次 build 时复用旧的 widget，决定的条件在 canUpdate() 方法中。
- createElement()：正如前文所述“一个 Widget 可以对应多个 Element”；Flutter Framework 在构建 UI 树时，会先调用此方法生成对应节点的 Element 对象。此方法是 Flutter Framework 隐式调用的，在我们开发过程中基本不会调用到。
- debugFillProperties(...)：复写父类的方法，主要是设置诊断树的一些特性。
- canUpdate(...)：是一个静态方法，它主要用于在 Widget 树重新 build 时复用旧的 widget，其实具体来说，应该是：是否用新的 Widget 对象去更新旧 UI 树上所对应的 Element 对象的配置；通过其源码我们可以看到，只要 newWidget 与 oldWidget 的 runtimeType 和 key 同时相等时就会用 newWidget 去更新 Element 对象的配置，否则就会创建新的 Element。

现在只需知道，为 Widget 显式添加 key 的话可能（但不一定）会使 UI 在重新构建时变的高效，读者目前可以先忽略此参数。本书后面的示例中，只会在构建列表项 UI 时会显式指定 Key。

另外 Widget 类本身是一个抽象类，其中最核心的就是定义了 createElement() 接口，在 Flutter 开发中，我们一般都不用直接继承 Widget 类来实现一个新组件，相反，我们通常会通过继承 StatelessWidget 或 StatefulWidget 来间接继承 Widget 类来实现。StatelessWidget 和 StatefulWidget 都是直接继承自 Widget 类，而这两个类也正是 Flutter 中非常重要的两个抽象类，它们引入了两种 Widget 模型，接下来我们将重点介绍一下这两个类。

#### 2.1.4 StatelessWidget

StatelessWidget相对比较简单，它继承自 Widget 类，重写了 createElement() 方法：

```dart
@override
StatelessElement createElement() => new StatelessElement(this);
```

StatelessElement 间接继承自 Element 类，与 StatelessWidget 相对应（作为其配置数据）。

StatelessWidget 用于不需要维护状态的场景，它通常在 build 方法中通过嵌套其它 Widget 来构建 UI，在构建过程中会递归的构建其嵌套的 Widget。我们看一个简单的例子：

```dart
class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor:Colors.grey,
  }):super(key:key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}
```

上面的代码，实现了一个回显字符串的 Echo widget。

> 按照惯例，widget 的构造函数参数应使用命名参数，命名参数中的必要参数要添加 @required 标注，这样有利于静态代码分析器进行检查。另外，在继承 widget 时，第一个参数通常应该是 Key，另外，如果 Widget 需要接收子 Widget，那么 child 或 children 参数通常应被放在参数列表的最后。同样是按照惯例，Widget 的属性应尽可能的被声明为 final，防止被意外改变。

然后我们可以通过如下方式使用它：

```
Widget build(BuildContext context) {
  return Echo(text: "hello world");
}
```

运行后效果如图：

![StatelessWidget1](./image/StatelessWidget1.png)

##### Context

build 方法有一个 context 参数，它是 BuildContext 类的一个实例，表示当前 widget 在 widget 树中的上下文，每一个 widget 都会对应一个 context 对象（因为每一个 widget 都是 widget 树上的一个节点）。实际上，context 是当前 widget 在 widget 树中位置中执行 "相关操作" 的一个句柄，比如它提供了从当前 widget 开始向上遍历 widget 树以及按照 widget 类型查找父级 widget 的方法。下面是在子树中获取父级 widget 的一个示例：

```dart
class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在 Widget 树中向上查找最近的父级 `Scaffold` widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接返回 AppBar 的 title， 此处实际上是 Text("Context测试")
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}
```
运行后效果如图：

![StatelessWidget2](./image/StatelessWidget2.png)

#### 2.1.5 StatefulWidget

和 StatelessWidget 一样，StatefulWidget 也是继承自 Widget 类，并重写了 createElement() 方法，不同的是返回的 Element 对象并不相同；另外 StatefulWidget 类中添加了一个新的接口 createState()。

```dart
abstract class StatefulWidget extends Widget {
  const StatefulWidget({ Key key }) : super(key: key);

  @override
  StatefulElement createElement() => new StatefulElement(this);

  @protected
  State createState();
}
```

- StatefulElement 间接继承自 Element 类，与 StatefulWidget 相对应（作为其配置数据）。StatefulElement 中可能会多次调用 createState() 来创建状态(State)对象。
- createState() 用于创建和 Stateful widget 相关的状态，它在 Stateful widget 的生命周期中可能会被多次调用。例如，当一个 Stateful widget 同时插入到 widget 树的多个位置时，Flutter framework 就会调用该方法为每一个位置生成一个独立的 State 实例，其实，本质上就是一个 StatefulElement 对应一个 State 实例。

#### 2.1.6 State

一个 StatefulWidget 类会对应一个 State 类，State 表示与其对应的 StatefulWidget 要维护的状态，State 中的保存的状态信息可以：
- 在 widget 构建时可以被同步读取；
- 在 widget 生命周期中可以被改变，当 State 被改变时，可以手动调用其 setState() 方法通知 Flutter framework 状态发生改变，Flutter framework 在收到消息后，会重新调用其 build 方法重新构建 widget 树，从而达到更新 UI 的目的。

State中有两个常用属性：
- widget：它表示与该 State 实例关联的 widget 实例，由 Flutter framework 动态设置。注意，这种关联并非永久的，因为在应用生命周期中，UI 树上的某一个节点的 widget 实例在重新构建时可能会变化，但 State 实例只会在第一次插入到树中时被创建，当在重新构建时，如果 widget 被修改了，Flutter framework 会动态设置 State.widget 为新的 widget 实例；
- context：StatefulWidget 对应的 BuildContext，作用同 StatelessWidget 的 BuildContext。

##### State生命周期

理解 State 的生命周期对 flutter 开发非常重要，为了加深读者印象，本节我们通过一个实例来演示一下 State 的生命周期。在接下来的示例中，我们实现一个计数器 widget，点击它可以使计数器加 1，由于要保存计数器的数值状态，所以我们应继承 StatefulWidget，代码如下：

```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}
```

CounterWidget 接收一个 initValue 整型参数，它表示计数器的初始值。下面我们看一下 State 的代码：

```dart
class _CounterWidgetState extends State<CounterWidget> {  
  int _counter;

  @override
  void initState() {
    super.initState();
    //初始化状态  
    _counter=widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed:()=>setState(()=> ++_counter,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

}
```

接下来，我们创建一个新路由，在新路由中，我们只显示一个CounterWidget：

```dart
Widget build(BuildContext context) {
  return CounterWidget();
}
```

我们运行应用并打开该路由页面，在新路由页打开后，屏幕中央就会出现一个数字 0，然后控制台日志输出：

```
I/flutter ( 5436): initState
I/flutter ( 5436): didChangeDependencies
I/flutter ( 5436): build
```

可以看到，在 StatefulWidget 插入到 Widget 树时首先 initState 方法会被调用。

然后我们点击 ⚡️ 按钮热重载，控制台输出日志如下：

```
I/flutter ( 5436): reassemble
I/flutter ( 5436): didUpdateWidget
I/flutter ( 5436): build
```

可以看到此时 initState 和 didChangeDependencies 都没有被调用，而此时 didUpdateWidget 被调用。

接下来，我们在 widget 树中移除 CounterWidget，将路由 build 方法改为：

```dart
Widget build(BuildContext context) {
  //移除计数器 
  //return CounterWidget();
  //随便返回一个Text()
  return Text("xxx");
}
```

然后热重载，日志如下：

```
I/flutter ( 5436): reassemble
I/flutter ( 5436): deactive
I/flutter ( 5436): dispose
```

我们可以看到，在 CounterWidget 从 widget 树中移除时，deactive 和 dispose 会依次被调用。

下面我们来看看各个回调函数：

- initState：当 Widget 第一次插入到 Widget 树时会被调用，对于每一个 State 对象，Flutter framework 只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。不能在该回调中调用 BuildContext.dependOnInheritedWidgetOfExactType（该方法用于在 Widget 树上获取离当前 widget 最近的一个父级 InheritFromWidget，关于 InheritedWidget 我们将在后面章节介绍），原因是在初始化完成后，Widget 树中的 InheritFromWidget 也可能会发生变化，所以正确的做法应该在在 build（）方法或 didChangeDependencies() 中调用它；
- didChangeDependencies()：当 State 对象的依赖发生变化时会被调用；例如：在之前build() 中包含了一个 InheritedWidget，然后在之后的 build() 中 InheritedWidget 发生了变化，那么此时 InheritedWidget 的子 widget 的 didChangeDependencies() 回调都会被调用。典型的场景是当系统语言 Locale 或应用主题改变时，Flutter framework 会通知 widget 调用此回调；
- build()：此回调读者现在应该已经相当熟悉了，它主要是用于构建 Widget 子树的，会在如下场景被调用：
    - 在调用 initState() 之后。
    - 在调用 didUpdateWidget() 之后。
    - 在调用 setState() 之后。
    - 在调用 didChangeDependencies() 之后。
    - 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
- reassemble()：此回调是专门为了开发调试而提供的，在热重载 (hot reload) 时会被调用，此回调在 Release 模式下永远不会被调用；
- didUpdateWidget()：在 widget 重新构建时，Flutter framework 会调用 Widget.canUpdate 来检测 Widget 树中同一位置的新旧节点，然后决定是否需要更新，如果 Widget.canUpdate 返回 true 则会调用此回调。正如之前所述，Widget.canUpdate 会在新旧 widget 的 key 和 runtimeType 同时相等时会返回 true，也就是说在在新旧 widget 的 key 和 runtimeType 同时相等时 didUpdateWidget() 就会被调用；
- deactivate()：当 State 对象从树中被移除时，会调用此回调。在一些场景下，Flutter framework 会将 State 对象重新插到树中，如包含此 State 对象的子树在树的一个位置移动到另一个位置时（可以通过 GlobalKey 来实现）。如果移除后没有重新插入到树中则紧接着会调用 dispose() 方法；
- dispose()：当 State 对象从树中被永久移除时调用；通常在此回调中释放资源。

StatefulWidget生命周期如图所示：

![StatelessWidget3](./image/StatelessWidget3.jpg)

#### 3.1.7 在 Widget 树中获取 State 对象

由于 StatefulWidget 的的具体逻辑都在其 State 中，所以很多时候，我们需要获取 StatefulWidget 对应的 State 对象来调用一些方法，比如 Scaffold 组件对应的状态类 ScaffoldState 中就定义了打开 SnackBar (路由页底部提示条)的方法。我们有两种方法在子 widget 树中获取父级 StatefulWidget 的 State 对象。

##### 1. 通过 Context 获取

context 对象有一个 findAncestorStateOfType() 方法，该方法可以从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象。下面是实现打开 SnackBar 的示例：

```dart
Scaffold(
  appBar: AppBar(
    title: Text("子树中获取State对象"),
  ),
  body: Center(
    child: Builder(builder: (context) {
      return RaisedButton(
        onPressed: () {
          // 查找父级最近的 Scaffold 对应的 ScaffoldState 对象
          ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
          //调用 ScaffoldState 的 showSnackBar 来弹出 SnackBar
          _state.showSnackBar(
            SnackBar(
              content: Text("我是 SnackBar"),
            ),
          );
        },
        child: Text("显示SnackBar"),
      );
    }),
  ),
);
```

上面示例运行后，点击 "显示SnackBar"，效果如图所示：

![findAncestorStateOfType](./image/findAncestorStateOfType.png)

一般来说，如果 StatefulWidget 的状态是私有的（不应该向外部暴露），那么我们代码中就不应该去直接获取其 State 对象；如果 StatefulWidget 的状态是希望暴露出的（通常还有一些组件的操作方法），我们则可以去直接获取其 State 对象。但是通过 context.findAncestorStateOfType 获取 StatefulWidget 的状态的方法是通用的，我们并不能在语法层面指定 StatefulWidget 的状态是否私有，所以在 Flutter 开发中便有了一个默认的约定：如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget 中提供一个 of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取；如果 State 不希望暴露，则不提供 of 方法。这个约定在 Flutter SDK 里随处可见。所以，上面示例中的 Scaffold 也提供了一个 of 方法，我们其实是可以直接调用它的：

```dart
...//省略无关代码
// 直接通过of静态方法来获取ScaffoldState 
ScaffoldState _state=Scaffold.of(context); 
_state.showSnackBar(
  SnackBar(
    content: Text("我是SnackBar"),
  ),
);
```

##### 2. 通过 GlobalKey

Flutter 还有一种通用的获取 State 对象的方法——通过 GlobalKey 来获取！ 步骤分两步：

- 给目标 StatefulWidget 添加 GlobalKey；

```dart
//定义一个 globalKey, 由于 GlobalKey 要保持全局唯一性，我们使用静态变量存储
static GlobalKey<ScaffoldState> _globalKey= GlobalKey();
...
Scaffold(
    key: _globalKey , //设置key
    ...  
)
```

- 通过 GlobalKey 来获取 State 对象

```dart
_globalKey.currentState.openDrawer()
```

GlobalKey 是 Flutter 提供的一种在整个 APP 中引用 element 的机制。如果一个 widget 设置了 GlobalKey，那么我们便可以通过 globalKey.currentWidget 获得该 widget 对象、globalKey.currentElement 来获得 widget 对应的 element 对象，如果当前 widget 是 StatefulWidget，则可以通过 globalKey.currentState 来获得该 widget 对应的 state 对象。

> 注意：使用 GlobalKey 开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个 GlobalKey 在整个 widget 树中必须是唯一的，不能重复。

#### 3.1.8 Flutter SDK内置组件库介绍

Flutter 提供了一套丰富、强大的基础组件，在基础组件库之上 Flutter 又提供了一套 Material 风格（Android默认的视觉风格）和一套 Cupertino 风格（iOS视觉风格）的组件库。要使用基础组件库，需要先导入：

```dart
import 'package:flutter/widgets.dart';
```

下面我们介绍一下常用的组件

##### 1. 基础组件

- Text：该组件可让您创建一个带格式的文本；
- Row、 Column：这些具有弹性空间的布局类 Widget 可让您在水平（Row）和垂直（Column）方向上创建灵活的布局。其设计是基于 Web 开发中的 Flexbox 布局模型；
- Stack：取代线性布局 ，Stack 允许子 widget 堆叠， 你可以使用 Positioned 来定位他们相对于 Stack 的上下左右四条边的位置。Stacks 是基于 Web 开发中的绝对定位（absolute positioning)布局模型设计的；
- Container： Container 可让您创建矩形视觉元素。container 可以装饰一个 BoxDecoration, 如 background、一个边框、或者一个阴影。 Container 也可以具有边距（margins）、填充(padding)和应用于其大小的约束(constraints)。另外， Container可以使用矩阵在三维空间中对其进行变换。

##### 2. Material 组件

Flutter 提供了一套丰富的 Material 组件，它可以帮助我们构建遵循 Material Design 设计规范的应用程序。Material 应用程序以 MaterialApp 组件开始，该组件在应用程序的根部创建了一些必要的组件，比如 Theme 组件，它用于配置应用的主题。 是否使用 MaterialApp 完全是可选的，但是使用它是一个很好的做法。在之前的示例中，我们已经使用过多个 Material 组件了，如：Scaffold、AppBar、FlatButton 等。要使用 Material 组件，需要先引入它：

```dart
import 'package:flutter/material.dart';
```

##### 3. Cupertino 组件

Flutter 也提供了一套丰富的 Cupertino 风格的组件，尽管目前还没有 Material 组件那么丰富，但是它仍在不断的完善中。值得一提的是在 Material 组件库中有一些组件可以根据实际运行平台来切换表现风格，比如 MaterialPageRoute，在路由切换时，如果是 Android 系统，它将会使用 Android 系统默认的页面切换动画(从底向上)；如果是 iOS 系统，它会使用 iOS 系统默认的页面切换动画（从右向左）。由于在前面的示例中还没有 Cupertino 组件的示例，下面我们实现一个简单的 Cupertino 组件风格的页面：

```dart
//导入cupertino widget库
import 'package:flutter/cupertino.dart';

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text("Press"),
            onPressed: () {}
        ),
      ),
    );
  }
}
```

下面是在 iPhoneX 上页面效果截图：

![Cupertino](./image/Cupertino.png)