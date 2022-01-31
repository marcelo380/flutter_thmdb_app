import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_thmdb_app/src/shared/utils/IOFileSystem/IOFileSystem.dart';

class CustomCacheManager extends CacheManager with ImageCacheManager {
  static const String key = "customCache";

  static CustomCacheManager _instance;

  factory CustomCacheManager() {
    return _instance ??= CustomCacheManager._();
  }

  CustomCacheManager._()
      : super(Config(key, fileSystem: IOFileSystem(key)),);
}