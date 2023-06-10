import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:http/http.dart' as http;

class TikTokProvider {
  static const String userAgent =
      "TikTok 26.2.0 rv:262018 (iPhone; iOS 14.4.2; en_US) Cronet";
  static const String shortUrl = "https://vt.tiktok.com/";
  static const String apiUrl =
      "https://api2.musical.ly/aweme/v1/feed/?aweme_id={postId}&version_code=262&app_name=musical_ly&channel=App&device_id=null&os_version=14.4.2&device_platform=iphone&device_type=iPhone9&region=US&carrier_region=US";

  static Map<String, dynamic>? selector(Map<String, dynamic> j, String id) {
    if (j == null) return null;
    final t = j["aweme_list"]
        .firstWhere((v) => v["aweme_id"] == id, orElse: () => null);
    if (t == null || t.length < 3) return null;
    return t;
  }

  static Future<Map<String, dynamic>?> fetchPostDetail(String postId) async {
    final response = await http
        .get(Uri.parse(apiUrl.replaceFirst("{postId}", postId)), headers: {
      "user-agent": userAgent,
    });

    if (response.statusCode == 200) {
      var res = selector(json.decode(response.body), postId);
      return selector(json.decode(response.body), postId);
    } else {
      return null;
    }
  }

  static Future<String?> extractPostId(String link) async {
    final response = await http.get(Uri.parse(link), headers: {
      "user-agent": userAgent,
    });

    if (response.statusCode == 200) {
      final html = response.body;
      final regex = RegExp(r'/(?:video|v)/([^?/]+)');
      final match = regex.firstMatch(html);
      if (match != null) {
        return match.group(1);
      }
    }
    return null;
  }

  static Future<Map<String, dynamic>> getTikTokInfo(
      String link, bool watermark) async {
    final postId = await extractPostId(link);
    log(postId.toString());
    final detail = await fetchPostDetail(postId!);
    if (detail == null) {
      return {"error": 'ErrorCouldntFetch'};
    }

    final filenameBase = "tiktok_$postId";
    final images = detail["image_post_info"] != null
        ? detail["image_post_info"]["images"]
        : null;

    if (images == null) {
      log("video download");
      final video = detail["video"]["download_addr"]["url_list"][0];
      final videoFilename =
          "${filenameBase}_video${watermark ? '' : '_nw'}.mp4";
      final videoDownload = downloadVideo(video, videoFilename);
      return {
        "end": videoDownload,
        "title": detail["aweme_id"],
        "created": DateTime.now(),
        "provider": "TikTok",
        "url": link,
        "path": "/storage/emulated/0/Download/",
        "type": "Video"
      };
      // return {
      //   "urls": video,
      //   "filename": videoFilename,
      // };
    } else {
      log("image download");
      final imageLinks = <String>[];
      for (final image in images) {
        final test = image["display_image"]["url_list"];
        imageLinks.add(test[1]);
      }
      final imgDownload = downloadImages(imageLinks);

      return {
        "end": imgDownload,
        "title": detail["aweme_id"],
        "created": DateTime.now(),
        "provider": "TikTok",
        "url": link,
        "path": "/storage/emulated/0/Download/",
        "type": "Image"
      };
      // return {
      //   "picker": imageLinks,
      //   "urls": null,
      //   "audioFilename": null,
      //   "isAudioOnly": true,
      //   "isMp3": null,
      // };
    }
  }

  static Future<void> downloadVideo(String videoUrl, String filename) async {
    final File? dlFile =
        (await FileDownloader.downloadFile(url: videoUrl, name: filename));

    log('FILE: ${dlFile?.path}');
  }

  static Future<void> downloadImages(List<String> imageUrls) async {
    log('IMAGES: ${imageUrls.join(',\n')}');
    final List<File?> result =
        await FileDownloader.downloadFiles(urls: imageUrls, isParallel: false);

    log('FILES: ${result.map((e) => e?.path).join(',\n')}');
  }

  // run when files are downloaded

}
