import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final listKey = GlobalKey<AnimatedListState>();
  final List<ListItem> kfz = List.from(kfzList);

  final kfzController = TextEditingController();

  String kfz2 = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      onSubmitted: (value) {
                        setState(() {
                          kfz2 = value;
                        });
                      },
                      controller: kfzController,
                      maxLength: 10,
                      cursorColor: Colors.blue,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                //ADD BUTTON
                InkWell(
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                    width: 50,
                    child: const Center(
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      kfz;
                    });
                    kfzList.add(const ListItem(kfz: "kfz"));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              children: [
                Text("KfzList: $kfzList"),
                Container(
                  height: size.width,
                  width: size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: AnimatedList(
                    key: listKey,
                    initialItemCount: kfzList.length,
                    itemBuilder: (context, index, animation) => ListItemWidget(
                      item: kfzList[index],
                      animation: animation,
                      onClicked: () {
                        removeItem(index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void insertItem() {
    const newIndex = 0;
    const newItem = ListItem(
      kfz: "WI TEST 1214",
    );

    kfz.insert(newIndex, newItem);
    listKey.currentState!.insertItem(newIndex);
  }

  void removeItem(int index) {
    final removedItem = kfz[index];

    kfz.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
        item: removedItem,
        animation: animation,
        onClicked: () {},
      ),
    );
  }
}

class KfzInputElement extends StatefulWidget {
  const KfzInputElement({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<KfzInputElement> createState() => _KfzInputElementState();
}

class _KfzInputElementState extends State<KfzInputElement> {
  final kfzController = TextEditingController();

  String kfz = "";

  List<String> kfzList2 = [];

  final listKey = GlobalKey<AnimatedListState>();

  final List<ListItem> kfzList1 = List.from(kfzList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  color: Colors.white,
                  child: TextField(
                    onSubmitted: (value) {
                      setState(() {
                        kfz = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s-:')),
                      FilteringTextInputFormatter.allow(RegExp(r'[A-ZÄ-Ü0-9]')),
                    ],
                    controller: kfzController,
                    maxLength: 10,
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      kfz;
                    });
                    kfzList2.add(kfz);
                    if (kfzList2.length > 3) {
                      kfzList2.removeLast();
                    }
                    print(kfzList2);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Meine Kennzeichen",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text("List: $kfzList2"),
                  ],
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: widget.size.width,
          width: widget.size.width - 40,
          child: AnimatedList(
            key: listKey,
            initialItemCount: kfzList.length,
            itemBuilder: (context, index, animation) => ListItemWidget(
              item: kfzList[index],
              animation: animation,
              onClicked: () {
                removeItem(index);
              },
            ),
          ),
        ),
      ],
    );
  }

  void insertItem() {
    const newIndex = 0;
    const newItem = ListItem(
      kfz: 'Test',
    );

    kfzList1.insert(newIndex, newItem);
    listKey.currentState!.insertItem(newIndex);
  }

  void removeItem(int index) {
    final removedItem = kfzList[index];

    kfzList.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
        item: removedItem,
        animation: animation,
        onClicked: () {},
      ),
    );
  }
}

class KfzListItem extends StatelessWidget {
  const KfzListItem({
    Key? key,
    required this.kfz,
  }) : super(key: key);

  final String kfz;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          kfz,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black12,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          child: const Icon(
            Icons.close_rounded,
            color: Colors.grey,
            size: 24,
          ),
          onTap: () {
            //TODO: Delete numberPlate
          },
        )
      ],
    );
  }
}

final List<ListItem> kfzList = [
  const ListItem(
    kfz: "WIPB2710",
  ),
];

class ListItem {
  final String kfz;

  const ListItem({
    required this.kfz,
  });
}

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  const ListItemWidget({
    Key? key,
    required this.item,
    required this.animation,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: buildItem(),
      );

  Widget buildItem() => Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(20),
          title: Text(
            item.kfz,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            onPressed: onClicked,
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.red,
              size: 32,
            ),
          ),
        ),
      );
}
