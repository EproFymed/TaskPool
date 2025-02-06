import 'package:flutter/material.dart';
import 'addtask.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double addtaskX = screenWidth * 0.8;
    double addtaskY = screenHeight * 0.75;
    return Scaffold(
      appBar: AppBar(title: Text('可移动悬浮按钮')),
      body: Stack(
        children: [
          Center(child: Text('主页内容')),

          // 可拖动悬浮按钮
          Positioned(
            left: addtaskX,
            top: addtaskY,
            child: Draggable(
              feedback: FloatingActionButton(
                onPressed: () => _navigateToNextPage(context, Offset(addtaskX, addtaskY)),
                child: Icon(Icons.add_circle_outline),
              ),
              childWhenDragging: Container(), // 拖动时隐藏原按钮
              onDragEnd: (details) {
                setState(() {
                  addtaskX = details.offset.dx.clamp(0.0, MediaQuery.of(context).size.width);
                  addtaskY = details.offset.dy.clamp(0.0, MediaQuery.of(context).size.height);
                });
              },
              child: FloatingActionButton(
                onPressed: () => _navigateToNextPage(context, Offset(addtaskX, addtaskY)),
                child: Icon(Icons.add_circle_outline),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToNextPage(BuildContext context, Offset buttonOffset) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 350), // 动画持续时间
        pageBuilder: (context, animation, secondaryAnimation) => AddTask(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve), // 淡入
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(curve), // 缩放
              child: Transform.translate(
                offset: Tween<Offset>(begin: buttonOffset, end: Offset.zero).animate(curve).value,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
