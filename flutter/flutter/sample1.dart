import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 自己定义的路由勾子，缺点是我不知道怎么传参数
    var myRoutes = {
      'onGenerateRoute': NewRoute(),
    };
    // 返回的是一个 app
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // 注册路由表，不在里面的路由会经过路由勾子
      routes:{
        "new_page":(context) => NewRoute()
      },
      // 路由勾子
      onGenerateRoute:(RouteSettings settings){
        return MaterialPageRoute(builder: (context){
          String routeName = settings.name;
          print ("进入路由生成钩子");
          print ("参数：" + settings.arguments);
          // 这里暂时不知道如何传参数，可以从 dart 中寻找
          return myRoutes[routeName];
        });
      },
      // 主页
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
// 主页是一个 StatefulWidget
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // 主页标题
  final String title;
  // 重写 State
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
// 主页 MyHomePage 的状态
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // setState 会让 flutter 调用 build 来刷新状态
    setState(() {
      _counter++;
    });
  }
  // 主页需要展示的页面 Scaffold，StatefulWidget 主页的 build 在状态中定义有原因的
  @override
  Widget build(BuildContext context) {
    // 页面
    return Scaffold(
      // 应用程序栏：_MyHomePageState 是 widget MyHomePage 的一个状态，所以 widget.title 是 MyHomePage 的 title
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // 页面的 body，body 由各个容器组成吧
      body: Center(
        // Center 容器，内容居中
        child: Column(
          // 容器按照列的方向添加零件
          mainAxisAlignment: MainAxisAlignment.center,
          // 各种零件
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              child: Text("路由返回值"),
              textColor: Colors.blue,
              onPressed: () {
                // 导航到新路由
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) {
                      // 这里就是路由，路由肯定返回一个新的页面
                      return RouterTestRoute();
                    })
                );
              },
            ),
            FlatButton(
              child: Text("命名路由"),
              textColor: Colors.blue,
              onPressed: () {
                // 通过命名方式导航到新路由
                Navigator.pushNamed(context, "new_page", arguments: "传递的参数");
              },
            ),
            FlatButton(
              child: Text("钩子"),
              textColor: Colors.blue,
              onPressed: () {
              // 触发路由勾子导航到新路由
              Navigator.pushNamed(context, "onGenerateRoute", arguments: "路由生成钩子");
              },
            ),
            Echo(text: "test StatelessWidget"),
            FlatButton(
              child: Text("测试 Context"),
              textColor: Colors.blue,
              onPressed: () {
                // 触发路由勾子导航到新路由
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // 这里就是路由，路由肯定返回一个新的页面
                  return ContextRoute();
                })
                );
              },
            ),
          ],
        ),
      ),
      // 主页上悬浮的一个按钮
      floatingActionButton: FloatingActionButton(
        // 点击后触发事件
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// -------- test route ------------------
class NewRoute extends StatelessWidget {
  // 测试路由以及从 push 中获取到路由参数
  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context).settings.arguments;
    if (args == null) {
      args = "没有传参数";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text(args),
      ),
    );
  }
}
// -------- end test route ------------------

// -------- test route params ------------------
class RouterTestRoute extends StatelessWidget {
  // 测试路由通过 pop 返回值
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("打开提示的主页"),
      ),
      body: Center(
        child: Center(
          child: RaisedButton(
            onPressed: () async {
              // 打开`TipRoute`，并等待返回结果
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TipRoute(
                      // 路由参数
                      text: "我是提示xxxx",
                    );
                  },
                ),
              );
              //输出 `TipRoute` 路由返回结果
              print("路由返回值: $result");
            },
            child: Text("打开提示页"),
          ),
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text,  // 接收一个text参数
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              // 调用返回按钮就有返回值
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// -------- end test route params ------------------

// -------- start test StatelessWidget ------------------
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
// -------- end test StatelessWidget ------------------

// -------- start test context ------------------
class ContextRoute extends StatelessWidget {
  // BuildContext context 代表当前 widge 的上下文
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Container(
        // context 代表参数
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
// -------- end test context ------------------