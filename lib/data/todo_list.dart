import 'package:meta/meta.dart';

class TodoList {
    String _title;
    List<String> _todos;
    List<String> _finished;

    TodoList(@required this._title) {
        this._todos = [];
        this._finished = [];
    }

    String getName(){
        return this._title;
    }
    void addTodo(String todo) {
        this._todos.add(todo);
    }

    List<String> getTodoList() {
        return this._todos;
    }

    List<String> getFinishedList() {
        return this._finished;
    }

    String getFinished(int ind) {
        return this._finished[ind];
    }

    String finishTodo(int ind){
        String todo = this._todos[ind];
        this._finished.add(todo);
        this._todos.removeAt(ind);
        return todo;
    }

    String undoFinished(int ind){
        String todo = this._finished[ind];
        this._finished.removeAt(ind);
        return todo;
    }

    void addFinished(String str) {
        _finished.add(str);
    }
}
