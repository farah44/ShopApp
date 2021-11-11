import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, index) => buildFavProductItem(
              ShopCubit.get(context)
                  .favoritesModel!
                  .data!
                  .data![index]
                  .product),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
        ),
      ),
    );
  }

  Widget buildFavProductItem(ProductModel? model) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Image(
              image: NetworkImage(model!.image),
              width: double.infinity,
              height: 200,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.red,
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
