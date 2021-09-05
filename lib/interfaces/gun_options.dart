part of gundart;

/**
 * options['module name'] allows you to pass options to a 3rd party module.
 * Their project README will likely list the exposed options
 * https://github.com/amark/gun/wiki/Modules
 */
class GunConstructorOptions {
  /** Undocumented but mentioned. Write data to a JSON. */
  final String? file;
  // /** Undocumented but mentioned. Create a websocket server */
  // web: any;

  /** Undocumented but mentioned. Amazon S3 */
  final S3Options? s3;

  /** the URLs are properties, and the value is an empty object. */
  List<String>? peers;

  /** default: true, creates and persists local (nodejs) data using Radisk. */
  bool? radisk;

  /** default: true, persists local (browser) data to localStorage. */
  bool? localStorage;

  // /** uuid allows you to override the default 24 random alphanumeric soul generator with your own function. */
  // uuid(): string;

  /**
     * allows you to pass options to a 3rd party module. Their project README will likely list the exposed options
     * @see https://github.com/amark/gun/wiki/Modules
     */
  // [key: string]: any;

  Map<String, dynamic>? restOfOptions;

  GunConstructorOptions({
    this.file,
    this.localStorage = true,
    this.peers,
    this.radisk = true,
    this.restOfOptions,
    this.s3,
  });

  Map<String, dynamic> get json {
    return {
      'file': file,
      'localStorage': localStorage,
      'peers': peers,
      'radisk': radisk,
      'restOfOptions': restOfOptions,
      's3': s3?.json,
    };
  }
}

class S3Options {
  final dynamic? key;
  final dynamic? secret;
  final dynamic? bucket;

  S3Options({
    this.bucket,
    this.key,
    this.secret,
  });

  Map<String, dynamic> get json {
    return {
      'key': key,
      'secret': secret,
      'bucket': bucket,
    };
  }
}
