# 关于 exosip 库

## 依赖关系

三者之间的依赖关系是：

- c-ares 编译生成 libcares
- libosip 编译生成 libosipparser2 和 libosip2，libosip2 依赖 libosipparser2
- libexosip 编译生成 libeXosip2，依赖 libcares，libosipparser2 和 libosip2

## 编译

编译分 3 步

- 1 编译 libosip
  - 1 进入 libosip 的目录 `c-ares-1.12.0`
  - 2 `./configure`
  - 3 `make`
  - 4 `sudo make install`
  - 5 编译生成的库置于 `c-ares-1.12.0/.libs/`
  - 6 默认安装到 `/usr/local/lib`,`libcares.so.2.2.0`, `libcares.a`
  - 7 头文件拷贝到 `/usr/local/include`，包括 `ares_build.h`,`ares_dns.h`,`ares.h`,`ares_rules.h`,`ares_version.h`
- 2 编译 libosip
  - 1 进入 libosip 的目录 `libosip2-5.0.0`
  - 2 `./configure`
  - 3 `make`
  - 4 `sudo make install`
  - 5 编译生成的库置于 `libosip2-5.0.0/src/osipparser2/.libs/` `libosip2-5.0.0/src/osip2/.libs/`
  - 6 默认安装到 `/usr/local/lib`,`libosipparser2.so.12.0.0`, `libosipparser2.a`,`libosip2.so.12.0.0`,`libosip2.a`
  - 7 头文件拷贝到 `/usr/local/include/osipparser2` `/usr/local/include/osip2`
- 3 编译 libexosip
  - 1 进入 libexosip 的目录 `libexosip2-5.0.0`
  - 2 `./configure`
  - 3 `make`
  - 4 `sudo make install`
  - 5 编译生成的库置于 `libexosip2-5.0.0/src/.libs/`
  - 6 默认安装到 `/usr/local/lib`,`libeXosip2.so.so.12.0.0`, `libeXosip2.so.a`
  - 7 头文件拷贝到 `/usr/local/include/eXosip2`
