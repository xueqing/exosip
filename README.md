# 关于 exosip 库

- [关于 exosip 库](#关于-exosip-库)
  - [1 依赖关系](#1-依赖关系)
  - [2 ubuntu-14 编译](#2-ubuntu-14-编译)
  - [3 ubuntu-16 编译](#3-ubuntu-16-编译)
  - [4 Windows VS2015 编译](#4-windows-vs2015-编译)
    - [4.1 错误及解决方案](#41-错误及解决方案)
      - [4.1.1 osipparser2 工程](#411-osipparser2-工程)
      - [4.1.2 osip2 工程](#412-osip2-工程)
      - [4.1.3 cares 工程(成功)](#413-cares-工程成功)
      - [4.1.4 eXosip 工程](#414-exosip-工程)
  - [5 Windows Mingw 编译](#5-windows-mingw-编译)

## 1 依赖关系

三者之间的依赖关系是：

- c-ares 编译生成 libcares
- libosip 编译生成 libosipparser2 和 libosip2，libosip2 依赖 libosipparser2
- libeXosip 编译生成 libeXosip2，依赖 libcares，libosipparser2 和 libosip2

## 2 ubuntu-14 编译

编译分 3 步

- 1 编译 c-ares
  - 1 进入 c-ares 的目录 `c-ares-1.12.0`
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
- 3 编译 libeXosip
  - 1 进入 libeXosip 的目录 `libexosip2-5.0.0`
  - 2 `./configure`
  - 3 `make`
  - 4 `sudo make install`
  - 5 编译生成的库置于 `libexosip2-5.0.0/src/.libs/`
  - 6 默认安装到 `/usr/local/lib`,`libeXosip2.so.so.12.0.0`, `libeXosip2.so.a`
  - 7 头文件拷贝到 `/usr/local/include/eXosip2`

## 3 ubuntu-16 编译

- 环境：g++5.4
- 步骤
  - 1 修改 [libosip](./libosip2-5.0.0/configure) 和 [libexosip](./libexosip2-5.0.0/configure) 的 configure 脚本
    - 修改 `am__api_version='1.14'` 为 `am__api_version='1.15'`
  - 2 安装 automake: `sudo apt-get install -y autotools-dev automake libtools`
    - automake 版本默认是 1.15
  - 3 按照上面的步骤编译三个库

## 4 Windows VS2015 编译

- 环境：Win10 + Visual Studio 2015
- 步骤
  - 1 将三个库的源码解压到 src-win 目录下，文件夹分别重命名为 c-ares/osip/exosip
  - 2 在 exosip/platform/vsnet 目录下，找到 eXosip.sln 并用 vs2015 打开
  - 3 选择 eXosip 作为启动项目，右键 “生成”
  - 4 编译生成的库位于 src-win/exosip/platform/vsnet/v140

### 4.1 错误及解决方案

#### 4.1.1 osipparser2 工程

- snprintf 重定义：找到该项目下 internal.h 文件，屏蔽第 58 行代码 `#define snprintf _snprintf`

```txt
C1189 #error: Macro definition of snprintf conflicts with Standard Library function declaration osipparser2 C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt\stdio.h 1927
```

#### 4.1.2 osip2 工程

- snprintf 重定义：找到该项目下 internal.h 文件，屏蔽第 58 行代码 `#define snprintf _snprintf`

```txt
C1189 #error: Macro definition of snprintf conflicts with Standard Library function declaration osip2 c:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt\stdio.h 1927
```

- timespec 中定义：找到该项目下 internal.h 文件，在 58 行后追加预编译宏 `#define HAVE_STRUCT_TIMESPEC 1`

```txt
C2011 “timespec”:“struct”类型重定义 osip2 C:\Users\KIKI\Documents\GitHub\exosip\src-win\osip\include\osip2\osip_condv.h 61
```

#### 4.1.3 cares 工程(成功)

#### 4.1.4 eXosip 工程

- snprintf 重定义：找到该项目下 eXosip2.h 文件，屏蔽第 73 行代码 `#define snprintf _snprintf`

```txt
C1189 #error: Macro definition of snprintf conflicts with Standard Library function declaration eXosip C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt\stdio.h 1927
````

- 无法打开 openssl/opensslv.h 文件：`C/C++ --> 预处理器 --> 预处理器定义` 删除 HAVE_OPENSSL_SSL_H

```txt
C1083 无法打开包括文件: “openssl/opensslv.h”: No such file or directory eXosip c:\users\kiki\documents\github\exosip\src-win\exosip\src\eXtransport.h 44
```

- timespec 中定义：找到该项目下 eXosip2.h 文件，在 74 行后追加预编译宏 `#define HAVE_STRUCT_TIMESPEC 1`

```txt
C2011 “timespec”:“struct”类型重定义 eXosip C:\Users\KIKI\Documents\GitHub\exosip\src-win\osip\include\osip2\osip_condv.h 61
```

- 无法打开 tsc_socket_api 文件：`C/C++ --> 预处理器 --> 预处理器定义` 删除 TSC_SUPPORT

```txt
C1083 无法打开包括文件: “tsc_socket_api.h”: No such file or directory eXosip C:\Users\KIKI\Documents\GitHub\exosip\src-win\exosip\src\eXtl_udp.c 55
```

- 无法打开 eXrefer_api.c 文件：从项目中移除不存在的文件 eX_refer.h(不移除此文件可以编译成功)、eXrefer_api.c

```txt
C1083 无法打开源文件: “..\..\..\exosip\src\eXrefer_api.c”: No such file or directory eXosip C:\Users\KIKI\Documents\GitHub\exosip\src-win\exosip\platform\vsnet\c1 1
```

## 5 Windows Mingw 编译

- 环境：Win10 + Mingw + MSYS-1.0.11
- 步骤
  - 1 [安装 mingw-get](http://mingw.org/wiki/Getting_Started)
  - 2 [安装 MSYS-1.0.11](http://mingw.org/wiki/MSYS)
  - 3 使用 Mingw 和 MSYS：打开 MSYS("M" 图标的软链接)，输入`mount c:/mingw /mingw`
  - 4 使用 autotool 编译系统安装第三方库和应用

  ```sh
  ./configure --prefix=/mingw
  make
  make install
  ```

  - 5 应该避免安装到`/usr/local`
