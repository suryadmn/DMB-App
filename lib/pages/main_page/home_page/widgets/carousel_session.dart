import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../datas/networking/url_access.dart';
import '../../../../providers/provider_home.dart';
import '../../../../utils/color_pallete_helper.dart';
import '../../../../widgets/shimmer_widget.dart';

class CarouselSession extends StatefulWidget {
  const CarouselSession({super.key});

  @override
  State<CarouselSession> createState() => _CarouselSessionState();
}

class _CarouselSessionState extends State<CarouselSession> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<ProviderHome>(context).isLoadingTopRated
        ? Row(
            children: [
              ShimmerWidget.rectangular(
                height: 400.0,
                width: 40,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: ShimmerWidget.rectangular(
                  height: 400.0,
                ),
              ),
              const SizedBox(width: 16.0),
              ShimmerWidget.rectangular(
                height: 400.0,
                width: 40,
              ),
            ],
          )
        : CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enableInfiniteScroll: true,
            ),
            items: Provider.of<ProviderHome>(context)
                .topRatedResult
                .map((topRatedResultItem) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    padding: const EdgeInsets.all(
                        16.0), // Padding to position text inside
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          "${UrlAccess.urlBaseMedia}${topRatedResultItem.backdropPath}",
                        ),
                        fit: BoxFit
                            .cover, // Ensures the image covers the entire container
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(
                              0.3), // Optional dark overlay for better readability
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          topRatedResultItem.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: ColorPalleteHelper.white,
                                  fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          topRatedResultItem.overview ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorPalleteHelper.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          );
  }
}
