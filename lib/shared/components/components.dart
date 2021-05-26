import 'package:flutter/material.dart';
import 'package:headline/modules/webview/webview_screen.dart';

Widget defaultFormField({
  Function onTap,
  @required TextEditingController controller,
  @required TextInputType type,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  bool isClickAble = true

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validate,
  onTap: onTap,

  decoration: InputDecoration(
    labelText: label,
    enabled: isClickAble,
    prefixIcon: Icon(prefix),
    border: OutlineInputBorder()
  ),
);

Widget bulidTaskItem (Map model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius:40,
          backgroundColor: Color(0xff0278ae),
          child: Center(
            child: Text(
              "${model['time']}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${model['title']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "${model['date']}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget buildArticleItem(article,context)=> InkWell(
  onTap: (){
    navigateTo(context,WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(width: 20),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text('${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text('${article['publishedAt']}',

                  style: TextStyle(

                      fontWeight: FontWeight.w600,

                      color: Colors.grey

                  ),),

              ],

            ),

          ),

        )

      ],

    ),

  ),
);

Widget myDivider()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);

void navigateTo(context,widget)=>Navigator.push(context,
MaterialPageRoute(builder: (context)=>widget)
);


