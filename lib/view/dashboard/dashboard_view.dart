import 'package:ecommerce_task/common_widgets/appbar.dart';
import 'package:ecommerce_task/model/product_model.dart';
import 'package:ecommerce_task/providers/products_provider.dart';
import 'package:ecommerce_task/theme/colors.dart';
import 'package:ecommerce_task/view/authentication/login_view.dart';
import 'package:ecommerce_task/view/dashboard/widgets/product_card.dart';
import 'package:ecommerce_task/view/dashboard/widgets/product_shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_task/main.dart' as app;

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
    setState(() {
      isDiscountApply = _remoteConfig.getBool('isDiscountedPrice');
    });
    debugPrint("check-value$isDiscountApply");

  }
  bool _isLoading = false;
  bool isDiscountApply =false;
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
       debugPrint(e.toString());
    });
  }
  logout() {
    try{
      FirebaseAuth.instance.signOut();
      GetStorage().write('isLogin', false);
      GetStorage().remove('token');
      app.main();
      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const LoginView()),);
    }
    catch(e){
      debugPrint("exception${e.toString()}");
    }
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
              logout();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder( itemCount:_isLoading?8: products.length,shrinkWrap: true,physics: const ClampingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,childAspectRatio: 0.6
                    ), itemBuilder: (context, index) {
                      return _isLoading?ProductShimmerWidget():ProductCard(product: products[index],calculatedDiscountPrice: productProvider.calculateDiscountPrice(products[index]),isDiscountApply: isDiscountApply,);
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
