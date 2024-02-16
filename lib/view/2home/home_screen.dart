import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_qsoft/model/notes_model.dart';
import 'package:notes_qsoft/view/2home/spec_screen.dart';
import 'package:notes_qsoft/view/3draw/privacy.dart';
import 'package:notes_qsoft/view/3draw/support.dart';
import 'package:notes_qsoft/view/3draw/info.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  final catList=[
    'Категория не выбрана',
    'Личное',
    'Работа',
    'Здоровье',
    'Обучение',
    'Финансы',
    'Для дома',
    'Путешествия',
    'Покупки',
    'Семья',
    'Хобби',
  ];
final titleController=TextEditingController();
  final descController=TextEditingController();

  var box = Hive.box<NotesModel>('noteBox');


  String? selectedVal;
  droplist(){
    selectedVal=catList[0];
  }

bool isSwitched=false;

  @override
  void initState() {
    droplist();
    getData();
    super.initState();
  }


  List<NotesModel> getData() {
    return box.values.toList();
  }
  void updateData(int index, String newTitle, String newDescription,
      String newCategory,) {
    final dataToUpdate = box.getAt(index);
    if (dataToUpdate != null) {
      dataToUpdate.title = newTitle;
      dataToUpdate.description = newDescription;
      dataToUpdate.category= newCategory;
      box.putAt(index, dataToUpdate);

    }
  }
  void deleteData(int index) {
    box.deleteAt(index);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('NOTES',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),)
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {

            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 216, 123, 123),

        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body:
      ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: box.listenable(),
        builder: (context, box,_) {
          List<NotesModel> dataList = box.values.toList();
          return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          dataList.isEmpty? Center(
            child: Text(
              'Добавить заметку',style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172),fontWeight: FontWeight.bold,fontSize: 30),
            ),
          ):
          ListView.separated(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
          return Slidable(
          startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
          SlidableAction(
          onPressed: (context) {
            titleController.text=dataList[index].title;
            descController.text=dataList[index].description;
            selectedVal=dataList[index].category;
            showModalBottomSheet(
              isScrollControlled: true,
              context: context, builder: (context) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 100
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Заголовок',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 66, 66, 66))),
                          )
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        controller: descController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Описание',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 66, 66, 66))),
                        ),
                      ),
                      const SizedBox(height: 10,),

                      DropdownButtonFormField(
                        value: selectedVal,
                        items: catList.map(
                                (e){
                              return DropdownMenuItem(child: Text(e,style: const TextStyle(color: Color.fromARGB(255, 66, 66, 66)),),value: e,);
                            }
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedVal=value;
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down,color: Color.fromARGB(255, 66, 66, 66),),
                        dropdownColor: Colors.purple[50],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 66, 66, 66))),
                            labelText: 'Выберите категорию',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                            prefixIcon: Icon(Icons.category_rounded,color: Color.fromARGB(255, 66, 66, 66),)
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(onPressed: (){
                            if(titleController.text!=''||descController.text!=''){
                              updateData(index, titleController.text, descController.text, selectedVal.toString());
                              titleController.clear();
                              descController.clear();
                              Get.back();
                              Get.snackbar('Изменение выполнено', '',colorText: Colors.white);
                            }else{
                              Get.snackbar('Заполните все поля', '',colorText: Colors.red);
                            }
                          },
                            child: const Text('Обновить'),color: Color.fromARGB(255, 255, 101, 101),),
                          const SizedBox(width: 10,),
                          MaterialButton(onPressed: (){
                            titleController.clear();
                            descController.clear();
                            selectedVal=catList[0];
                            Get.back();
                          },child: const Text('Назад'),color: const Color.fromARGB(255, 165, 165, 165),),

                        ],
                      )
                    ],
                  ),
                ),
              );
            },);
          },
          backgroundColor: Colors.amber,
          icon: Icons.edit,
          ),
          ],
          ),
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
          onPressed: (context){
            Get.defaultDialog(
              title: 'Удалить?',
               content: const Text('Хотите удалить заметку?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      Get.back();
                    }, child: const Text('Назад')),
                    TextButton(onPressed: (){
                      deleteData(index);
                      Get.back();
                      Get.snackbar('Удалено', '',colorText: Colors.white);
                    }, child: const Text('Удалить',style: TextStyle(color: Colors.red),)),
                  ],
                )
              ]
            );
          },
          backgroundColor: Colors.red,
          icon: Icons.delete,
          )],),
          child: Card(
          child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.blue[50]),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          '${dataList[index].title}',
          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
          ),
          const SizedBox(
          height: 10,
          ),
          Text(dataList[index].description,style: const TextStyle(color: Colors.black),),
          const SizedBox(
          height: 10,
          ),
          Text(dataList[index].category,style: const TextStyle(color: Colors.black),)
          ],
          ),
          ),
          ),
          );
          },
          separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
          height: 20,
          );
          },
          )
          ,
          );
        }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
          isScrollControlled: true,
          context: context, builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 100),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Заголовок',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 66, 66, 66))),
                    )
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: descController,
                    maxLength: 100,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Описание',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 136, 136, 136))),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  DropdownButtonFormField(
                      value: selectedVal,
                      items: catList.map(
                              (e){
                            return DropdownMenuItem(value: e,child: Text(e,style: const TextStyle(color: Color.fromARGB(255, 136, 136, 136)),),);
                          }
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedVal=value;
                        });
                      },
                    icon: const Icon(Icons.arrow_drop_down,color: Color.fromARGB(255, 136, 136, 136),),
                    dropdownColor: Colors.purple[50],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 136, 136, 136))),
                      labelText: 'Выберите категорию',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                      prefixIcon: Icon(Icons.category_rounded,color: Color.fromARGB(255, 136, 136, 136),)
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(onPressed: (){
                        if(titleController.text!=''&&descController.text!=''){
                          box.add(NotesModel(title: titleController.text, description: descController.text, category: selectedVal.toString()));
                          titleController.clear();
                          descController.clear();
                          selectedVal='Категория не выбрана';
                          Get.back();
                          Get.snackbar('Сохранено', 'Свайп влево - удалить, свайп вправо - редактировать',colorText: Colors.white);
                        }
                        else{
                          Get.snackbar('Заполните все поля', '',colorText: const Color.fromARGB(255, 255, 69, 69));
                        }
                      },color: Color.fromARGB(255, 255, 101, 101),
                        child: const Text('Сохранить'),),
                      const SizedBox(width: 10,),
                      MaterialButton(onPressed: (){
                        Get.back();
                      },color: Color.fromARGB(255, 223, 223, 223),child: const Text('Назад'),),

                    ],
                  )
                ],
              ),
            ),
          );
        },);
      },backgroundColor: Color.fromARGB(255, 255, 101, 101),child: const Icon(Icons.add,color: Colors.white,),),

      drawer: Drawer(
        child: Container(
          decoration:const BoxDecoration(),
          child: Column(
            children: [
              const SizedBox(height: 70,),
              Container(
                width: double.infinity,
                height: 200,
                child: const Icon(Icons.speaker_notes,size: 200,color: Color.fromARGB(255, 255, 101, 101),),
              ),
              const Divider(height: 10,),

              Expanded(child: ListView(
                children: [
                  ListTile(
                    onTap: (){
                      Get.to(const TermsAndConditions());
                    },
                    leading: const Icon(Icons.newspaper,color: Color.fromARGB(255, 124, 124, 124),),
                    title: const Text('Важная информация',style: TextStyle(color: Color.fromARGB(255, 124, 124, 124)),),
                  ),
                  const Divider(height: 10,),
                  ListTile(
                    onTap: (){
                      Get.to(const Support_Screen());
                    },
                    leading: const Icon(Icons.contact_support,color: Color.fromARGB(255, 124, 124, 124),),
                    title: const Text('Поддержка',style: TextStyle(color: Color.fromARGB(255, 124, 124, 124)),),
                  ),
                  const Divider(height: 10,),
                  ListTile(
                    onTap: (){
                      Get.to(PrivacyPolicy());
                    },
                    leading: const Icon(Icons.privacy_tip,color: Color.fromARGB(255, 124, 124, 124),),
                    title: const Text('Политика конфиденциальности',style: TextStyle(color: Color.fromARGB(255, 124, 124, 124)),),
                  ),
                  const Divider(height: 10,),
                  ListTile(
                    leading: const Icon(Icons.dark_mode,color: Color.fromARGB(255, 124, 124, 124),),
                      title: const Text('Темная тема',style: TextStyle(color: Color.fromARGB(255, 124, 124, 124)),),
                    trailing: Switch(value: isSwitched,
                        onChanged: (value){
                      setState(() {
                        // Get.changeTheme(ThemeData.dark());
                        isSwitched=value;
                        if (value) {
                          Get.changeTheme(ThemeData.dark());
                        } else {
                          Get.changeTheme(ThemeData.light());
                        }
                      });
                        }),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
class CustomSearchDelegate extends SearchDelegate<String> {
  final List<NotesModel> dataList;

  CustomSearchDelegate({required this.dataList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildCard(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = dataList
        .where((note) =>
    note.title.toLowerCase().contains(query.toLowerCase()) ||
        note.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final suggestion = suggestionList[index];
        return ListTile(
          title: Text(suggestion.title),
          subtitle: Text(suggestion.description),
          onTap: () {
            Get.to(SpecificCardScreen(specificCard: suggestion));
          },
        );
      },
    );
  }

  Widget buildCard(String title) {
    final specificCard = dataList.firstWhere(
          (note) => note.title.toLowerCase() == title.toLowerCase(),
      orElse: () => NotesModel(title: '', description: '', category: ''),
    );

    return Card(
      child: ListTile(
        title: Text(specificCard.title),
        subtitle: Text(specificCard.description),
      ),
    );
  }
}