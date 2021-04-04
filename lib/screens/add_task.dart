import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  static const routeName = '/add_task';
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _dateTime = DateTime.now();
  // final _controller = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy');

  final List<String> _priorities = ['Low', 'Medium', 'High'];

  @override
  void initialState() {
    super.initState();
    _dateController.text = _dateFormat.format(_dateTime);
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  //dateTimeController
  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _dateTime) {
      setState(() {
        _dateTime = date;
      });
      _dateController.text = _dateFormat.format(date);
    }
  }

  //validating the form
  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    print('$_title,$_dateTime,$_priority');
    //TODO:Inserting task in databse
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Add Task',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      //ENTERING TITTLE
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) =>
                            input.trim().isEmpty ? 'Please enter a task' : null,
                        onSaved: (input) => _title = input,
                        initialValue: _title,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      //SELECTING DATE
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        controller: _dateController,
                        onTap: _handleDatePicker,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      //SELECTING PRIORITY
                      DropdownButtonFormField(
                        icon: Icon(Icons.arrow_drop_down_circle_rounded),
                        items: _priorities
                            .map(
                              (priority) => DropdownMenuItem(
                                value: priority,
                                child: Text(
                                  priority,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Priority',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) => _priority == null
                            ? 'Please select a priority'
                            : null,
                        onSaved: (input) => _priority = input,
                        onChanged: (value) {
                          setState(() {
                            _priority = value;
                          });
                        },
                        value: _priority,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: TextButton(
                          child: Text(
                            'Add task',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: _submit,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
