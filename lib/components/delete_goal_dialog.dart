import 'package:build/models/goal.dart';
import 'package:flutter/material.dart';

class DeleteGoalDialog extends StatefulWidget {
  final Goal goal;
  final Function callback;
  final Function removeCallback;

  DeleteGoalDialog(this.callback, this.removeCallback, this.goal);

  @override
  _DeleteGoalDialogState createState() => _DeleteGoalDialogState();
}

class _DeleteGoalDialogState extends State<DeleteGoalDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: 300.0,
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Text(
                    'Delete "${widget.goal.title}"?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      letterSpacing: 0.5,
                    ),
                  )),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // No Button
                MaterialButton(
                  elevation: 1,
                  color: Colors.amber[400],
                  onPressed: () {
                    widget.callback();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[900]),
                  ),
                ),
                // Yes Button
                MaterialButton(
                  elevation: 1,
                  color: Colors.amber[400],
                  onPressed: () {
                    widget.removeCallback(widget.goal);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[900],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
