import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:td2/API/myAPI.dart';

import '../model/task.dart';

class ScreenTwo extends StatelessWidget{
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    MyAPI myAPI = MyAPI();
    return FutureBuilder(
      future: myAPI.getTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
        if (snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else if (snapshot.data != null){
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, index){
              return Card(
                color: Colors.black26,
                elevation: 7,
                margin: const EdgeInsets.all(10),
                child:ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Text(snapshot.data![index].id.toString())
                  ),
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].description),

                )
              );
            }
          );
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}