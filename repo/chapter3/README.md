# 加权投票应用开发

为投票应用增加通证（代币）支持。

## Truffle使用

初始化项目：

```
~$ mkdir -p ~/repo/tkapp
~$ cd ~/repo/tkapp
~/repo/tkapp$ truffle unbox webpack
```

编译合约：

```
~/repo/tkapp$ truffle compile
```

部署合约：

```
~/repo/tkapp$ truffle migrate
```

## web应用

前端JS脚本打包

```
~/repo/tkapp$ webpack
```

建立网页资源符号链接：

```
~/repo/tkapp$ cd build
~/repo/tkapp/build$ ln -s ~/repo/common/lib lib
~/repo/tkapp/build$ ln -s ~/repo/common/fonts fonts
```

启动服务器：

```
~/repo/tkapp/build$ python -m SimpleHTTPServer
```


