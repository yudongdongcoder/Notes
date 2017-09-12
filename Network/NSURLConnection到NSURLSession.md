#NSURLSession

1`NSURLSessionConfiguration` 有三个类工厂方法，这很好地说明了 `NSURLSession` 设计时所考虑的不同的使用场景。

1. `+defaultSessionConfiguration` 返回一个标准的 configuration，这个配置实际上与 NSURLConnection 的网络堆栈（networking stack）是一样的，具有相同的共享` NSHTTPCookieStorage`，共享 `NSURLCache `和共享 NSURLCredentialStorage。
2. `+ephemeralSessionConfiguration` 返回一个预设配置，这个配置中不会对缓存，Cookie 和证书进行持久性的存储。这对于实现像秘密浏览这种功能来说是很理想的。
3. `+backgroundSessionConfiguration:(NSString *)identifier` 的独特之处在于，它会创建一个后台 session。后台 session 不同于常规的，普通的 session，它甚至可以在应用程序挂起，退出或者崩溃的情况下运行上传和下载任务。初始化时指定的标识符，被用于向任何可能在进程外恢复后台传输的守护进程（daemon）提供上下文。