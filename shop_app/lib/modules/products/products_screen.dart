import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => WidgetBuilder(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel),
          fallback: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }

  Widget WidgetBuilder(HomeModel? homeModel, CategoriesModel? categoriesModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel!.data.banners
                .map((e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 200,
              reverse: false,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              viewportFraction: 1.0, // so evrey image take full screen
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoresItems(categoriesModel!.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 8.0,
                    ),
                    itemCount: categoriesModel!
                        .data.data.length, //categoriesModel.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey,
            child: GridView.count(
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.58,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              shrinkWrap: true,
              children: List.generate(homeModel.data.products.length,
                  (index) => buildProductItem(homeModel.data.products[index])),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductItem(ProductModel model) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Image(
              image: NetworkImage(model.image),
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
                        Icons.favorite_border,
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

  Widget buildCategoresItems(DataModel model) {
    //DataModel model
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 100,
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
