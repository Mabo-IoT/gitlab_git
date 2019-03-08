> https://stackoverflow.com/questions/11621768/how-can-i-make-git-accept-a-self-signed-certificate/26785963#26785963

因为使用的是私有证书，所以git可能会不信任这个证书。报类似如下错误：

```
fatal: unable to access 'https://X.X.X.X/svn/...': SSL certificate problem: unable to get local issuer certificate
```

类型可能很多，但就是证书的问题。

可以参考如下方式解决：

1. 获取证书

   1. 从浏览器获取服务器证书：

   ![](jpg/git%E8%AF%81%E4%B9%A6.jpg)

   ![](jpg/git%E8%AF%81%E4%B9%A62.jpg)

   ![](jpg/git%E8%AF%81%E4%B9%A63.jpg)

   ![](jpg/git%E8%AF%81%E4%B9%A64.jpg)

2. git bash中信任这个证书

   右键---git bash

   ```
   git config --global http.sslCAInfo 123.cer
   ```

   ![](jpg/git证书5.jpg)