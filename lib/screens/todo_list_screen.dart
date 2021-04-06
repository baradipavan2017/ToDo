import 'package:flutter/material.dart';
import 'package:todo_1/screens/add_task.dart';

class ToDoListScreen extends StatelessWidget {

  
  final bool _value = false;
  Widget _buildTask(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Task Title'),
            subtitle: Text('oct 2  / High Priority'),
            trailing: Checkbox(
              onChanged: (value) {
                print(value);
                value = _value;
              },
              activeColor: Colors.black,
              value: true,
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(AddTask.routeName);
        },
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: 40.0,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'My Task',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return _buildTask(index);
        },
      ),
    );
  }
}
