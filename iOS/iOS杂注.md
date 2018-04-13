### 图片的解码
常用的 UIImage 加载方法有 `imageNamed` 和 `imageWithContentsOfFile`。其中`imageNamed` 加载图片后会马上解码，并且系统会将解码后的图片缓存起来，但是这个缓存策略是不公开的，我们无法知道图片什么时候会被释放。因此在一些性能敏感的页面，我们还可以用 static 变量 hold 住 imageNamed 加载到的图片避免被释放掉，以空间换时间的方式来提高性能
