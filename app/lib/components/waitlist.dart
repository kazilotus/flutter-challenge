import 'package:app/models/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPad extends StatefulWidget {
  const ListPad({Key? key}) : super(key: key);

  @override
  State<ListPad> createState() => _ListPadState();
}

class _ListPadState extends State<ListPad> {
  bool _check = false;

  String _input = "";
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<String> _todo = [
    'Chore 1',
    'Chore 2',
    'Choreas 3',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> services = context.select<ServiceModel, List<String>>(
      (service) => service.getServices(),
    );

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
        key: Key('assd'),
        child: Scaffold(
          floatingActionButton: _addButton(context, services),
          body: _mainBody(),
        ),
      ),
    );
  }

  Widget _mainBody() {
    return Container(
      padding: const EdgeInsets.all(5),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          const BoxShadow(
            color: Color.fromARGB(255, 27, 27, 27),
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(150),
            spreadRadius: -3.0,
            blurRadius: 12.0,
          ),
        ],
      ),
      child: _todo.isNotEmpty
          ? ReorderableListView(
              scrollController: _scrollController,
              buildDefaultDragHandles: false,
              scrollDirection: Axis.vertical,
              onReorder: _onReorder,
              proxyDecorator: _proxyDecorator,
              children: _todo
                  .asMap()
                  .map((i, item) => MapEntry(i, _cardGenerator(item, i)))
                  .values
                  .toList(),
            )
          : Center(
              child: Text(
                'Waitlist Empty'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }

  void _updateInputData(String input) {
    setState(() {
      _input = input.trim();
    });
  }

  void _addToList() async {
    if (_input != "") {
      setState(() {
        int newIndex = _todo.length;
        _todo.insert(newIndex, _input);
        _inputController.text = "";
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollDown();
      });
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final String todo = _todo.removeAt(oldIndex);
      _todo.insert(newIndex, todo);
    });
  }

  Widget _addButton(BuildContext context, List<String> services) {
    return FloatingActionButton(
      onPressed: () => _openInsertModal(context, services),
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _openInsertModal(BuildContext context, List<String> services) {
    const String title = 'Add to Waitlist';
    const String namePlaceHolderText = "Enter client's name";
    const String servicePlaceHolderText = 'Please select a service';

    const EdgeInsets buttonStyle = EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 15,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 15,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      autofocus: true,
                      controller: _inputController,
                      textInputAction: TextInputAction.unspecified,
                      onChanged: _updateInputData,
                      onSubmitted: (input) {
                        _addToList();
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          gapPadding: 4.0,
                        ),
                        hintText: namePlaceHolderText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                    // Initial Value
                    // value: _todo[1],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gapPadding: 4.0,
                      ),
                      hintText: namePlaceHolderText,
                    ),
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: services.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      // setState(() {
                      //   dropdownvalue = newValue!;
                      // });
                    },
                    isExpanded: true,
                    // underline: false,
                    hint: const Text(servicePlaceHolderText),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColorDark,
                            padding: buttonStyle,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            padding: buttonStyle,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Add'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _inputBar(BuildContext context) {
  //   return Positioned(
  //     bottom: 0,
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 10),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //               margin: const EdgeInsets.only(right: 10),
  //               alignment: Alignment.bottomCenter,
  //               padding: const EdgeInsets.symmetric(horizontal: 4),
  //               // decoration: const BoxDecoration(color: Colors.red),
  //               child: TextField(
  //                 controller: _inputController,
  //                 textInputAction: TextInputAction.unspecified,
  //                 onChanged: _updateInputData,
  //                 onSubmitted: (input) {
  //                   _addToList();
  //                 },
  //                 decoration: InputDecoration(
  //                   contentPadding: const EdgeInsets.symmetric(horizontal: 20),
  //                   border: const OutlineInputBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(1000)),
  //                     gapPadding: 4.0,
  //                   ),
  //                   hintText: _inputPlaceHolderText,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             margin: const EdgeInsets.only(right: 5),
  //             child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 primary: Colors.red.withAlpha(200),
  //                 minimumSize: const Size(50, 50),
  //                 padding: const EdgeInsets.symmetric(horizontal: 5),
  //                 shape: const RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(1000)),
  //                 ),
  //               ),
  //               onPressed: _addToList,
  //               child: const Icon(Icons.add),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xFF333A47),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget _cardGenerator(String item, int index) {
    var index = _todo.indexOf(item);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(item),
      onDismissed: (direction) {
        setState(() {
          _todo.removeAt(index);
        });
      },
      background: Container(
        alignment: Alignment.centerRight,
        // color: Colors.grey.withOpacity(0.1),
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          'SWIPE TO DELETE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red.withOpacity(0.4),
          ),
        ),
      ),
      child: Container(
        key: Key('$index'),
        // margin: const EdgeInsets.only(bottom: 15),
        child: Card(
          elevation: 1,
          // margin: EdgeInsets.only(bottom: 10),
          borderOnForeground: false,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                ReorderableDragStartListener(
                  index: index,
                  child: Icon(
                    Icons.drag_indicator,
                    color: Colors.red.withOpacity(0.5),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Checkbox(
                    value: _check,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _check = newValue!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      // margin: const EdgeInsets.only(left: 0),
                      child: Text(item),
                    ),
                  ),
                ),
                Icon(
                  Icons.delete_sweep_outlined,
                  color: Colors.red.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
