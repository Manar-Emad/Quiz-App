import 'package:flutter/material.dart';

class MyAdd extends StatelessWidget {
  final String? price;
  final String? details;
  final String? address;
  final String? addOwnerName;
  final String? addOwnertype;
  final String? time;
  final String? imageurl;

  const MyAdd(
      {Key? key,
        this.price,
        this.details,
        this.address,
        this.addOwnerName,
        this.addOwnertype,
        this.time,
        this.imageurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = getSize(context).width;
    var height = getSize(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width*.33,
              height: height*.17,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:NetworkImage(
                        imageurl!,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  )
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("${price!} ",style: TextStyle(
                                fontSize:20,
                            )),
                            Text('kdlmcdlfcdsfcdscffd'),
                          ],
                        ),
                        Text(time!,style: TextStyle(color:Colors.black),)
                      ],
                    ),
                    Container(
                      width: width*.5,
                      child: Column(
                        children: [
                          Text(
                            details!,
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getSize(BuildContext context) {}
}