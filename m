Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1P8K1i31255
	for linux-mips-outgoing; Mon, 25 Feb 2002 00:20:01 -0800
Received: from mail.yacme.com (adsl-133-11.38-151.net24.it [151.38.11.133])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1P8Jh931196
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 00:19:44 -0800
Received: (qmail 2524 invoked from network); 25 Feb 2002 07:19:36 -0000
Received: from cannonau.cantina.yacme (HELO yacme.com) (192.168.1.1)
  by lambrusco.cantina.yacme with SMTP; 25 Feb 2002 07:19:36 -0000
Message-ID: <3C79E588.19C0FE18@yacme.com>
Date: Mon, 25 Feb 2002 08:19:36 +0100
From: Carlo Agostini <carlo.agostini@yacme.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-kipsec i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Problems compiling . soft-float
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi  All

Just to introduce the problem, here is a summary of what I have done.
I work on an Linux port on an MIPS tx39(R3000) based hardware without
hw floating point support .
I finally managed to compile the glibc 2.2.5 for an mipstx39el-linux
configuration for 2.2.14 Kernel .

I'm working on a Pentium III PC with RedHat7.1

I used binutils 2.11.2 and gcc 3.0.3

The parameters I have used for configuration were the following:

---- configure glibc-2.2.5 ----

configure --host=mipsel-linux\
       --target=mipstx39el-linux\
--enable-add-ons\
--build=i686-pc-linux-gnu\
--prefix=$PREFIX \
--without-fp -v

I first generated a glibc (just typing make, with the default
Makefiles).
..... problem, it seems that the --without-fp has not the expected
effects.

I am trying to port microwindows on an mips tx39

Then, I tried to pass explicitly -msoft-float to gcc as an argument
.....

 mipstx39el-linux-gcc -v  -I/utenti/agostini/prova/mw/src/include
-msoft-float -Wall -O3 -s  -L/utenti/agostini/prova/mw/src/lib  -o
/utenti/agostini/prova/mw/src/bin/nano-X srvmain.o srvfunc.o srvutil.o
srvevent.o srvclip.o srvnet.o
/utenti/agostini/prova/mw/src/lib/libmwengine.a
/utenti/agostini/prova/mw/src/lib/libmwdrivers.a
/utenti/agostini/prova/mw/src/lib/libmwfonts.a
-L/utenti/agostini/prova/mw/src/lib
Reading specs from
/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/specs

Configured with: ../../gcc-3.0.3/configure
--with-gcc-version-trigger=/utenti/agostini/mipstx39-linux/src/gcc-3.0.3/gcc/version.c

--host=i686-pc-linux-gnu --prefix=/utenti/agostini/mipstx39-linux
--target=mipstx39el-linux --with-gnu-ld --with-gnu-as --disable-shared
--enable-languages=c -v
Thread model: single
gcc version 3.0.3
 /utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/collect2

-EL -dynamic-linker /lib/ld.so.1 -o
/utenti/agostini/prova/mw/src/bin/nano-X -s
/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/../../../../mipstx39el-linux/lib/crt1.o

/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/../../../../mipstx39el-linux/lib/crti.o

/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/crtbegin.o

-L/utenti/agostini/prova/mw/src/lib -L/utenti/agostini/prova/mw/src/lib
-L/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3
-L/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/../../../../mipstx39el-linux/lib

srvmain.o srvfunc.o srvutil.o srvevent.o srvclip.o srvnet.o
/utenti/agostini/prova/mw/src/lib/libmwengine.a
/utenti/agostini/prova/mw/src/lib/libmwdrivers.a
/utenti/agostini/prova/mw/src/lib/libmwfonts.a -lgcc -lc -lgcc
/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/crtend.o

/utenti/agostini/mipstx39-linux/lib/gcc-lib/mipstx39el-linux/3.0.3/../../../../mipstx39el-linux/lib/crtn.o

/utenti/agostini/prova/mw/src/lib/libmwengine.a(devarc.o): In function
`qcos':
devarc.o(.text+0x28): undefined reference to `fptosi'
devarc.o(.text+0x4c): undefined reference to `sitofp'
devarc.o(.text+0x64): undefined reference to `fpsub'
devarc.o(.text+0x104): undefined reference to `fpmul'
devarc.o(.text+0x11c): undefined reference to `fpadd'
devarc.o(.text+0x164): undefined reference to `fpmul'
devarc.o(.text+0x18c): undefined reference to `fpsub'
devarc.o(.text+0x1d4): undefined reference to `fpmul'
devarc.o(.text+0x1ec): undefined reference to `fpsub'
devarc.o(.text+0x220): undefined reference to `fpmul'
devarc.o(.text+0x238): undefined reference to `fpadd'
devarc.o(.text+0x250): undefined reference to `fpsub'
devarc.o(.text+0x268): undefined reference to `sitofp'
devarc.o(.text+0x280): undefined reference to `fpsub'
/utenti/agostini/prova/mw/src/lib/libmwengine.a(devarc.o): In function
`qsin':
devarc.o(.text+0x2cc): undefined reference to `fptosi'
devarc.o(.text+0x2f4): undefined reference to `sitofp'
devarc.o(.text+0x30c): undefined reference to `fpsub'
devarc.o(.text+0x3ac): undefined reference to `fpmul'
devarc.o(.text+0x3c4): undefined reference to `fpadd'
devarc.o(.text+0x40c): undefined reference to `fpmul'
devarc.o(.text+0x434): undefined reference to `fpsub'
devarc.o(.text+0x47c): undefined reference to `fpmul'
devarc.o(.text+0x494): undefined reference to `fpsub'
devarc.o(.text+0x4c8): undefined reference to `fpmul'
devarc.o(.text+0x4e0): undefined reference to `fpadd'
devarc.o(.text+0x4f8): undefined reference to `fpsub'
devarc.o(.text+0x510): undefined reference to `sitofp'
devarc.o(.text+0x528): undefined reference to `fpsub'
/utenti/agostini/prova/mw/src/lib/libmwengine.a(devarc.o): In function
`GdArcAngle':
devarc.o(.text+0xc14): undefined reference to `litodp'
devarc.o(.text+0xc34): undefined reference to `dpmul'
devarc.o(.text+0xc4c): undefined reference to `dptofp'
devarc.o(.text+0xc84): undefined reference to `sitofp'
devarc.o(.text+0xca0): undefined reference to `fpmul'
devarc.o(.text+0xcb4): undefined reference to `fptosi'
devarc.o(.text+0xccc): undefined reference to `litodp'
devarc.o(.text+0xcec): undefined reference to `dpmul'
devarc.o(.text+0xd04): undefined reference to `dptofp'
devarc.o(.text+0xd3c): undefined reference to `fpmul'
devarc.o(.text+0xd50): undefined reference to `fptosi'
devarc.o(.text+0xd8c): undefined reference to `fpsub'
devarc.o(.text+0xdc4): undefined reference to `fpsub'
devarc.o(.text+0xddc): undefined reference to `sitofp'
devarc.o(.text+0xdf8): undefined reference to `fpmul'
devarc.o(.text+0xe0c): undefined reference to `fptosi'
devarc.o(.text+0xe28): undefined reference to `fpmul'
devarc.o(.text+0xe3c): undefined reference to `fptosi'
/utenti/agostini/mipstx39-linux/lib/libc.so.6: undefined reference to
`no symbol'
collect2: ld returned 1 exit status

Has anyone information about this problem ?

Does anyone know where could I find a set of
floating-point instructions library ?

you can help me ?

Thanking you in advance

Carlo.
