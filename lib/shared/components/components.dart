import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/news_app/web_view/webview_screen.dart';

Widget DefaultButton({
  width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
  bool isUppercase = true,
}) =>
    Container(
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: background,
      ),
    );

Widget DefaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmet,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmet,
      enabled: isClickable,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      validator: validate,
      //  validator: (String value) {
      //     if (value.isEmpty) {
      //       return 'email must not be empty';
      //    }
      //  return null;
      // },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
      ),
    );

/// Dismissible  دي لمسح الدااتا عند الضغط عليها ف اتجاه معين
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),

      /// الاتجاه اللي عاوزة احرك فيه ف ال item يتمسح
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('04.00 PM'),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${model['time']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_circle_outline, color: Colors.green),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.archive_outlined),
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      ///  الشرط اللي عندي ان عدد ال item اللي جوا ال tasks يكون اقل من الصفر
      ///  يعني مفيش ولا ايتم موجود ف انا بقوله ضيف ايتمس لان مفيش
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          print('tasks status ${tasks[index]['status']}');
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text('No Tasks Yet , Please Add Some Tasks',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
  child:   Padding(
  
        padding: const EdgeInsets.all(20.0),
  
        child: Row(
  
          crossAxisAlignment: CrossAxisAlignment.start,
  
          children: [
  
            Container(
  
              height: 120,
  
              width: 120,
  
              decoration: BoxDecoration(
  
                color: Colors.deepOrange,
  
                borderRadius: BorderRadius.circular(10.0),
  
                image: DecorationImage(
  
                  image: NetworkImage('${article['urlToImage']}'),
  
                  fit: BoxFit.cover,
  
                ),
  
              ),
  
            ),
  
            const SizedBox(
  
              width: 20.0,
  
            ),
  
            Expanded(
  
              child: Container(
  
                height: 120,
  
                child: Column(
  
                  mainAxisSize: MainAxisSize.min,
  
                  crossAxisAlignment: CrossAxisAlignment.start,
  
                  mainAxisAlignment: MainAxisAlignment.start,
  
                  children: [
  
                    Expanded(
  
                      child: Text(
  
                        '${article['title']}',
  
  
  
  ///---------------------------------------------------------------------------------------------------
  
  
  
                        style: Theme.of(context).textTheme.bodyText1,
  
  
  
  ///---------------------------------------------------------------------------------------------------
  
                        maxLines: 4,
  
                        overflow: TextOverflow.ellipsis,
  
                      ),
  
                    ),
  
                    SizedBox(
  
                      height: 20,
  
                    ),
  
                    Text(
  
                      '${article['publishedAt']}',
  
                      style: Theme.of(context).textTheme.bodyText1,
  
                      maxLines: 1,
  
                      overflow: TextOverflow.ellipsis,
  
                    ),
  
                  ],
  
                ),
  
              ),
  
            ),
  
          ],
  
        ),
  
      ),
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
);

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list, context, {isSearch=false}) => ConditionalBuilder(
      condition: list.length > 0,
//state is! NewsGetScienceLoadingState,
      builder: (context) => ListView.separated(

          /// عشان اشيل الشادو اللي بينزل معايا لما اسكرول ف الليست
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10),
      fallback: (context) =>isSearch? Container() : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );

void navigateTo(context , widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget ) );

