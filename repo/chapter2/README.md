# 用Truffle开发投票应用

使用Truflle开发框架重新实现投票应用。

## Truffle使用

初始化项目：

```
~$ mkdir -p ~/repo/tfapp
~$ cd ~/repo/tfapp
~/repo/tfapp$ truffle unbox webpack
```

编译合约：

```
~/repo/tfapp$ truffle compile
```

部署合约：

```
~/repo/tfapp$ truffle migrate
```

## web应用

前端JS脚本打包

```
~/repo/tfapp$ webpack
```

建立网页资源符号链接：

```
~/repo/tfapp$ cd build
~/repo/tfapp/build$ ln -s ~/repo/common/lib lib
~/repo/tfapp/build$ ln -s ~/repo/common/fonts fonts
```

启动服务器：

```
~/repo/tfapp/build$ python -m SimpleHTTPServer
```
