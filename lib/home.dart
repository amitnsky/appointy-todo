import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/data/todo_list.dart';
import 'package:todo_app/data/todo_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //this is list of map of all tasks Key:String, val List<String>//tasks under that list
  List<TodoList> _allTasks;
  final String TODO = "TODO";
  final String FINISHED = "FINISHED";
  final String ADD_NEW_LIST = "ADD_NEW_LIST";
  final String ADD_NEW_TODO = "ADD_NEW_TODO";
  final _textController = TextEditingController();
  final int SPECIAL_VAL = 564649;
  bool _showFinished;
  bool _addNewTodoMode;
  bool _addNewTodoListMode;
  String _showHide;

  //currently selected list index
  int _currListIndex;

  _HomePage() {
    _allTasks = [];
    var _todoList = TodoList("Shopping");
    _todoList.addTodo("Soap");
    _todoList.addTodo("Bath");

    _todoList.addFinished("Goto Appointy");
    _allTasks.add(_todoList);

    _allTasks.add(TodoList("Salon Groom"));
    _currListIndex = 0;
    _addNewTodoMode = false;
    _showFinished = false;
    _addNewTodoListMode = false;
    _showHide = "Show Completed";
  }

  final appBar = AppBar(
    title: Text("Just Do it"),
    elevation: 0.0,
    brightness: Brightness.light,
    centerTitle: true,
  );

  void _addNewTodo() {
    setState(() {
      _addNewTodoMode = true;
    });
  }
  //helper method handles swipe to delete feature
  void dismissTodo(int index,String whichOne){
    setState(() {
      if (whichOne == FINISHED) {
        String todo = _allTasks[_currListIndex].undoFinished(index);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Finished todo: ${todo}")));
      } else {
        String undo = _allTasks[_currListIndex].finishTodo(index);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Added one more todo: ${undo}")));
      }
    });
  }

  //helper method to get list widget for tasks of type "TODO" or "COMPLETED"
  Widget _currTodosListView(String whichOne) {
    var itemList = _allTasks[_currListIndex].getTodoList();
    if (whichOne == FINISHED)
      itemList = _allTasks[_currListIndex].getFinishedList();

    return Container(
      child: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (BuildContext con, int index) {
            return Dismissible(
              key: Key(itemList[index]),
              onDismissed: (direction)=>dismissTodo(index,whichOne),
              child: TodoListWidget(itemList[index]),
              background: Container(
                  color: whichOne == FINISHED ? Colors.blue : Colors.green),
            );
          },
          reverse: false,
          itemCount: itemList.length,
        ),
      ),
    );
  }

  //method to hide or show completed tasks
  void _showHideCompleted() {
    setState(() {
      if (_showFinished == true) {
        _showFinished = false;
        _showHide = "Show Completed";
      } else {
        _showFinished = true;
        _showHide = "Hide Completed";
      }
    });
  }

  //handles text submitted by textField on different modes
  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _addNewTodoMode = false;
      if (text != null) {
        _allTasks[_currListIndex].getTodoList().add(text);
      }
    });
  }

  //returns a widget with icon of add and textfield for taking text inputs
  Widget _textComposerWidget() {
    String hintString = "Todo..";
    return IconTheme(
      data: IconThemeData(color: Colors.green),
      child: Container(
        //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
                child: TextField(
              decoration: InputDecoration(
                hintText: hintString,
              ),
              keyboardType: TextInputType.text,
              cursorColor: Colors.lightGreen,
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: "Sans-Serif",
                  fontSize: 18.0),
              textAlign: TextAlign.start,
              controller: _textController,
              onEditingComplete: () => _handleSubmitted(_textController.text),
              //     onSubmitted: (text,mode)=>_handleSubmitted(text,mode),
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _handleSubmitted(_textController.text)),
            )
          ],
        ),
      ),
    );
  }



  //helper method for dropdownitems
  List<DropdownMenuItem<int>> _todoTitleList() {
    List<DropdownMenuItem<int>> titles = [];
    for (int i = 0; i < _allTasks.length; i++)
      titles.add(DropdownMenuItem(
        child: Container(
          child: Text(
            _allTasks[i].getName(),
          ),
          width: 200.0,
          color: i == _currListIndex ? Colors.tealAccent : Colors.transparent,
        ),
        value: i,
      ));
    return titles;
  }

  void _showAnotherTodoList(int index) {
    if (index == SPECIAL_VAL) {}
    setState(() {
      _currListIndex = index;
    });
  }

  Widget _getHomePageWidget() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //for storing current list items no yet finished
        Flexible(child: _currTodosListView(TODO)),

        Divider(
          height: 2.0,
          color: Colors.teal,
        ),
        RaisedButton(
          child: Text(_showHide),
          onPressed: _showHideCompleted,
        ),
        Flexible(
            child: _showFinished == true
                ? _currTodosListView(FINISHED)
                : Container()),
        //for storing completed work in current list

        Center(
          heightFactor: 1.5,
          child: _addNewTodoMode == true
              ? _textComposerWidget()
              : FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: _addNewTodo,
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton(
            items: _todoTitleList(),
            onChanged: (value) => _showAnotherTodoList(value),
            elevation: 2,
            hint: Text(_allTasks[_currListIndex].getName()),
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: _getHomePageWidget(),
    );
  }
}
