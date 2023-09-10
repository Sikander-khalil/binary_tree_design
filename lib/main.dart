import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value, {this.left, this.right});
}

class BinaryTreeDiagram extends StatelessWidget {
  final TreeNode root;

  BinaryTreeDiagram(this.root);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200), // Change the size as needed
      painter: TreePainter(root),
    );
  }
}

class TreePainter extends CustomPainter {
  final TreeNode root;

  TreePainter(this.root);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    _drawNode(canvas, size.width / 2, 40, root, paint);
  }

  void _drawNode(Canvas canvas, double x, double y, TreeNode node, Paint paint) {
    if (node == null) {
      return;
    }

    final radius = 20.0;
    canvas.drawCircle(Offset(x, y), radius, paint);
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // Draw text label in the circle
    TextSpan span = TextSpan(
      text: node.value.toString(),
      style: TextStyle(color: Colors.white),
    );
    TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - radius / 2, y - radius / 2));

    if (node.left != null) {
      final childX = x - 40;
      final childY = y + 60;
      canvas.drawLine(Offset(x, y + radius), Offset(childX, childY - radius), linePaint);
      _drawNode(canvas, childX, childY, node.left!, paint);
    }

    if (node.right != null) {
      final childX = x + 40;
      final childY = y + 60;
      canvas.drawLine(Offset(x, y + radius), Offset(childX, childY - radius), linePaint);
      _drawNode(canvas, childX, childY, node.right!, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create a sample binary tree
    TreeNode tree = TreeNode(
      1,
      left: TreeNode(
        2,
        left: TreeNode(4),
        right: TreeNode(5),
      ),
      right: TreeNode(3),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Binary Tree Diagram'),
        ),
        body: Center(
          child: BinaryTreeDiagram(tree),
        ),
      ),
    );
  }
}
