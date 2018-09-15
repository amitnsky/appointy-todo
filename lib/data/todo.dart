import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListWidget extends StatefulWidget {
    String _todo;

    TodoListWidget(@required this._todo);

    @override
    State<StatefulWidget> createState() => _TodoListWidgetState(_todo);
}

class _TodoListWidgetState extends State<TodoListWidget> {
    String _todo;

    _TodoListWidgetState(@required this._todo);

    @override
    Widget build(BuildContext context) {
        return new Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                                child: Text(_todo[0]),
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                                //  crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text(
                                        _todo,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: Colors.black),
                                    ),
                                ],
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}
