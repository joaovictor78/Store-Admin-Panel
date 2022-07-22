abstract class IHttpClient {
  Future get(String path, {dynamic queryParameters});
  Future post(String path, {dynamic data});
  Future put(String path, {dynamic data});
  Future delete(String path, {dynamic data});
}
