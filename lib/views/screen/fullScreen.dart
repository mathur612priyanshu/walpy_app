import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';
// import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:walpy_app/views/widgets/customAppBar.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FullScreen extends StatefulWidget {
  final imgUrl;

  const FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  bool alert = false;

  Future<void> _setwallpaper(String imgUrl) async {
    final file = await DefaultCacheManager().getSingleFile(imgUrl);
    int location = WallpaperManagerPlus.bothScreens;
    try {
      final result = await WallpaperManagerPlus().setWallpaper(file, location);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ?? ''),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error Setting Wallpaper'),
        ),
      );
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "Walpy",
          word2: "App",
        ),
      ),
      body: alert
          ? Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white70,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    height: 0.25.sh, // 25% of the screen height
                    width: 0.6.sw, // 60% of the screen width
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Icon(Icons.close, size: 24.sp),
                            onTap: () {
                              setState(() {
                                alert = false;
                              });
                            },
                          ),
                        ),
                        Text(
                          "Set as Wallpaper?",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _setwallpaper(widget.imgUrl);
                            setState(() {
                              alert = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                          ),
                          child: Text(
                            "Yes",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: 1.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            alert = !alert;
          });
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add, size: 28.sp),
      ),
    );
  }
}
