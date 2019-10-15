import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/pagerItemProvider.dart';
import '../models/to_do_task.dart';

class NewData extends StatefulWidget {
  static const routeName = '/newData';

  @override
  State<StatefulWidget> createState() {
    return _NewData();
  }
}

class _NewData extends State<NewData> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  String category;

  var _editedProduct = ToDoTask(
      id: "", title: "", imageUrl: "", dateAdded: "", deadLine: "", detail: "");

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageFocusNode.addListener(_updateimage);
    super.initState();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateimage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateimage() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageController.text.startsWith('http') &&
          !_imageController.text.startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    Provider.of<PagerItemProvider>(context, listen: false)
        .addProduct(_editedProduct)
        .catchError((error) {
      return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  "AN ERROR OCCURED",
                ),
                content: Text(
                  "SOMETHING WENT WRONG",
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OKAY'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }).then((_) {
      setState(() {
        //Future<void>.delayed(Duration(seconds:2));
        _isLoading = false;
      });

      Navigator.of(context).pop();
    });
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked != null) {
        setState(() {
          _editedProduct.deadLine = DateFormat.yMMMd().format(datePicked);
        });
      }
    });
  }

  Container _buildText(String text, TextStyle style, double topMargin) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: style,
      ),
      padding: EdgeInsets.only(
        top: topMargin,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    final _width = MediaQuery.of(context).size.shortestSide;
    final categoryList = Provider.of<PagerItemProvider>(context,listen: false).categoryItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Task",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildText("Category", Theme.of(context).textTheme.title,0),
                      DropdownButton<String>(
                        hint: Text("Choose Category"),
                        icon: Icon(Icons.category),
                        underline: null,
                        onChanged: (String newValue) {
                          setState(() {
                            //_editedProduct = newValue;
                          });
                        },
                        items: categoryList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = ToDoTask(
                        id: null,
                        title: value,
                        detail: _editedProduct.detail,
                        imageUrl: _editedProduct.imageUrl,
                        dateAdded: _editedProduct.dateAdded,
                        deadLine: _editedProduct.deadLine,
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      if (value.length < 10) {
                        return 'Should be at least 10 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = ToDoTask(
                        id: null,
                        title: _editedProduct.title,
                        detail: value,
                        imageUrl: _editedProduct.imageUrl,
                        dateAdded: _editedProduct.dateAdded,
                        deadLine: _editedProduct.deadLine,
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: _imageController.text.isEmpty
                            ? Text('Enter a URL')
                            : Image.network(
                                _imageController.text,
                                fit: BoxFit.contain,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageController,
                          focusNode: _imageFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an image URL.';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = ToDoTask(
                              id: null,
                              title: _editedProduct.title,
                              detail: _editedProduct.detail,
                              imageUrl: value,
                              dateAdded: _editedProduct.dateAdded,
                              deadLine: _editedProduct.deadLine,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildText(
                      "Date", Theme.of(context).textTheme.title, 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton.icon(
                        color: Colors.grey[200],
                        icon: Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                        label: Text("Choose Date"),
                      ),
                      Text(_editedProduct.deadLine.isEmpty
                          ? "No date selected!"
                          : _editedProduct.deadLine)
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
