import 'package:ecommerce_task/common_widgets/appbar.dart';
import 'package:ecommerce_task/helper/asset_constants.dart';
import 'package:ecommerce_task/model/product_model.dart';
import 'package:ecommerce_task/providers/products_provider.dart';
import 'package:ecommerce_task/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  SafeArea(child: Scaffold(
//       backgroundColor: lightGrey,
//       appBar: CustomAppbar(title:"E-shop"),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
//         child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: GridView.builder( itemCount: productProvider.products.length,shrinkWrap: true,physics: ClampingScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 0.7
//               ), itemBuilder: (context, index) {
//                 return SizedBox(
//                   child: Card(
//                     color: white,elevation: 0.7,shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("${productProvider.products[index].title}",style: TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w600),),
//                         SizedBox(height: 7,),
//                         Text("${productProvider.products[index].description}",style: TextStyle(fontSize: 15,color: black,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
//                         SizedBox(height: 5,),
//                         Text("\$ ${productProvider.products[index].price}",style: TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
//                         Row(
//                           children: [
//                             Text("\$ ${productProvider.products[index].price}",style: TextStyle(fontSize: 16,decoration: TextDecoration.lineThrough,color: darkGrey,fontWeight: FontWeight.w400),),
//                             Text("\$ ${productProvider.calculateDiscountPrice(productProvider.products[index]).discountedPrice}",style: TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w400),),
//                             Text("${productProvider.products[index].discountPercentage}% off",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.w700),),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },),
//             )
//
//           ],
//         ),
//       ),
//     ));
//   }
//
// }
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Fetching, caching, and activating remote config
  void _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      // cache refresh time
      fetchTimeout: const Duration(seconds: 1),
      // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(seconds: 10),
    ));
    await _remoteConfig.fetchAndActivate();
  }
  bool _isLoading = false;
  String _errorMessage = "";
  @override
  void initState() {
    _initConfig();
    fetChProducts();

    super.initState();
  }
  fetChProducts() {
    _isLoading = true;
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);
    productProvider.getProducts(context).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _errorMessage = e.message;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    return SafeArea(child: Selector<ProductsProvider, List<Products>>(
      selector: (_, provider) => provider.products,
      builder: (_, products, __) {
        return Scaffold(
          backgroundColor: lightGrey,
          appBar: CustomAppbar(title:"E-shop",
            trailingOnTap: (){
              FirebaseAuth.instance.signOut();
            },

          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _isLoading?Center(child: CircularProgressIndicator()):GridView.builder( itemCount: products.length,shrinkWrap: true,physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 4,crossAxisSpacing: 4,childAspectRatio: 0.6
                    ), itemBuilder: (context, index) {
                      return SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(color: lightGrey,blurRadius: 2)]
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 5,
                                    child: products[index].images == null?Image.network(AssetConstants.placeholderImg,fit: BoxFit.cover,):Image.network("${products[index].images?.last}",fit: BoxFit.cover,loadingBuilder: (context,child,loadingProgress)=> loadingProgress == null?child:Center(child: Container(child: CircularProgressIndicator(),height: 35,width: 35,),),)),

                                Expanded(flex:6,child: ListView(
                                  shrinkWrap: true,physics: ClampingScrollPhysics(),
                                  children: [
                                    Text("${products[index].title}",style: TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w600),),
                                    SizedBox(height: 7,),
                                    Text("${products[index].description}",style: TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,maxLines: 3,),
                                    SizedBox(height: 7,),
                                   _remoteConfig.getBool('isDiscountedPrice') != true?Text("\$${products[index].price}",style: TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,):
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text("\$${products[index].price}",style: TextStyle(fontSize: 11,decoration: TextDecoration.lineThrough,color: darkGrey,fontWeight: FontWeight.w400),),
                                          SizedBox(width: 6,),
                                          Text("\$${productProvider.calculateDiscountPrice(products[index])}",style: TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w400),),
                                          SizedBox(width: 6,),
                                          Text("${products[index].discountPercentage}% off",style: TextStyle(fontSize: 12,color: Colors.green,fontWeight: FontWeight.w700),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                )

              ],
            ),
          ),
        );
      },
    ));
  }
}
