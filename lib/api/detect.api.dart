import 'dart:developer';

import 'package:socialdl/api/providers/twitter.provider.dart';
import 'package:socialdl/api/providers/youtube.provider.dart';
import 'package:socialdl/api/providers/tiktok.provider.dart';

Future<dynamic> handleLink(String url) async {
  try {
    dynamic r;

    // check what social media the link is from
    final patternMatch = RegExp(r'^(?:https?:\/\/)?(?:www\.)?([^\/\?]+)').firstMatch(url)?.group(1)?.split('.');
    final host = patternMatch![1];
    log('Host: $host');

    if (!['twitter', 'youtube', 'tiktok', 'instagram'].contains(host)) {
      return {'t': 'Unsupported social media'};
    }

    switch (host) {
      case 'twitter':
        // r = await twitter({
        //   'id': patternMatch['id'] ?? false,
        //   'spaceId': patternMatch['spaceId'] ?? false,
        // });
      log('twitter');
        break;
      case 'youtube':
        // final fetchInfo = {
        //   'id': patternMatch['id']!.substring(0, 11),
        //   'quality': obj != null ? obj['vQuality'] : null,
        //   'format': obj != null ? obj['vCodec'] : null,
        //   'isAudioOnly': isAudioOnly,
        //   'isAudioMuted': obj != null ? obj['isAudioMuted'] : null,
        //   'dubLang': obj != null ? obj['dubLang'] : null,
        // };
        // if (url.contains('music.youtube.com') || isAudioOnly) {
        //   fetchInfo['quality'] = 'max';
        //   fetchInfo['format'] = 'vp9';
        //   fetchInfo['isAudioOnly'] = true;
        // }
        // r = await youtube(fetchInfo);
      log('youtube');
        break;
      case 'tiktok':
        r = await TikTokProvider.getTikTokInfo(url, true);
        log("tiktok-return" + r.toString());
        return r;
        break;
      default:
        return {'t': 'Unsupported social media'};
    }
  } catch (e) {
    return {'t': 'Generic error'};
  }
}