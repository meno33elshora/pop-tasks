import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Bloc/cubit.dart';
import 'package:todo/Bloc/states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeLayoutCubit.get(context);
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) =>cubit.doneTasks.isNotEmpty ? ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          onDismissed: (direction){
            HomeLayoutCubit.get(context).deleteData(id: cubit.doneTasks[index]['id']);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 110,
                      width: 110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '${cubit.doneTasks[index]['time']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cubit.doneTasks[index]['title']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${cubit.doneTasks[index]['data']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          // IconButton(
                          //     onPressed: () {
                          //       HomeLayoutCubit.get(context).updateData(
                          //           status: 'done',
                          //           id: cubit.doneTasks[index]
                          //           ['id']);
                          //     },
                          //     icon: const Icon(
                          //       Icons.check_box,
                          //       color: Colors.white,
                          //     )),
                          IconButton(
                              onPressed: () {
                                HomeLayoutCubit.get(context).updateData(
                                    status: 'archived',
                                    id: cubit.doneTasks[index]
                                    ['id']);
                              },
                              icon: const Icon(
                                Icons.archive,
                                color: Colors.white,
                              )),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          height: 3,
          thickness: 3,
          indent: 80,
          endIndent: 80,
        ),
        itemCount: cubit.doneTasks.length,
      ) : Container(
        width: MediaQuery.of(context).size.width/1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.verified_rounded , color: Colors.grey,size: 100,),
            Text('Done is Empty' , style: TextStyle(color: Colors.grey , fontSize: 20, fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
