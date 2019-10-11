import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Provider/pagerItemProvider.dart';
import 'package:todolist/models/to_do_task.dart';

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
    id: null,
    title: " ",
    detail: " ",
    imageUrl: " ",
    dateAdded: DateTime.now().toIso8601String(),
    deadLine: null,
  );



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

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.longestSide;
    final _width = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Task",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.teal,
            ),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: <Widget>[
              Positioned(
                top: _height * 0.05,
                left: 0,
                child: Container(
                  height: _height * 0.07,
                  width: _width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[50],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019),
                                lastDate: DateTime.now(),
                              ).then((datePicked) {
                                if (datePicked != null) {
                                  setState(() {
                                    print("$datePicked");
                                    _editedProduct=ToDoTask(
                                      id: null,
                                      title: _editedProduct.title,
                                      detail: _editedProduct.detail,
                                      imageUrl: _editedProduct.imageUrl,
                                      dateAdded: _editedProduct.dateAdded,
                                      deadLine: datePicked.toIso8601String(),
                                    );
                                  });
                                }
                              });
                            },
                            child: Icon(
                              Icons.calendar_today,
                              size: 30,
                            )),
                        GestureDetector(
                            onTap: () {
                              
                            },
                            child: Icon(
                              Icons.arrow_drop_down_circle,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _height * 0.2,
                left: _width * 0.05,
                child: Container(
                  height: _height * 0.6,
                  width: _width,
                  child: Form(
                    key: _form,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                             _editedProduct=ToDoTask(
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
                             _editedProduct=ToDoTask(
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
                              margin: EdgeInsets.only(
                                top: 8,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: _imageController.text.isEmpty
                                  ? Text('Enter a URL')
                                  : FittedBox(
                                      child: Image.network(
                                        _imageController.text,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
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
                                   _editedProduct=ToDoTask(
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
                      ],
                    ),
                  ),
                ),
              ),
            ]),
    );
  }
}
