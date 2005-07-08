Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 23:20:33 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.202]:43385 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226366AbVGHWUP> convert rfc822-to-8bit;
	Fri, 8 Jul 2005 23:20:15 +0100
Received: by wproxy.gmail.com with SMTP id i21so521302wra
        for <linux-mips@linux-mips.org>; Fri, 08 Jul 2005 15:20:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QzzpZt5IbHAzNN3gAtX8k7Ci3ZbvGSL4YNrB6h5NG3bwaRsP79yNruGiLONCZ4UcWGYa8TEP8s8jaHbhk0UHVX7kTLy7J2KmSKLIL4DLixJ5E6oX3l5lciJ/aGdogJrdTpQcOAcOBGg2/TNjDPYX26rQ8p7ipNJe5hEngG9oIWw=
Received: by 10.54.73.15 with SMTP id v15mr2117957wra;
        Fri, 08 Jul 2005 15:20:13 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 8 Jul 2005 15:20:13 -0700 (PDT)
Message-ID: <2db32b7205070815202bc409f0@mail.gmail.com>
Date:	Fri, 8 Jul 2005 15:20:13 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: glibc 2.3.5 cross building error
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I am trying to cross-compile glibc 2.3.5 with linuxthread. And got the
following errors.
It seems the linker is complaining it can't find the definition of
"__fork_block". But it is really defined in "fork.c", which is at the
same directory as register-atfork.c.

Thanks

******************
mipsel-unknown-linux-gnu-gcc -mabi=32   -shared -static-libgcc -Wl,-O1
 -Wl,-z,defs -Wl,-dynamic-linker=/home/rolf/toolchain/lib/ld.so.1 
-B/home/rolf/toolchain/glibc-build/csu/ 
-Wl,--version-script=/home/rolf/toolchain/glibc-build/libc.map
-Wl,-soname=libc.so.6  -nostdlib -nostartfiles -e __libc_main
-L/home/rolf/toolchain/glibc-build
-L/home/rolf/toolchain/glibc-build/math
-L/home/rolf/toolchain/glibc-build/elf
-L/home/rolf/toolchain/glibc-build/dlfcn
-L/home/rolf/toolchain/glibc-build/nss
-L/home/rolf/toolchain/glibc-build/nis
-L/home/rolf/toolchain/glibc-build/rt
-L/home/rolf/toolchain/glibc-build/resolv
-L/home/rolf/toolchain/glibc-build/crypt
-L/home/rolf/toolchain/glibc-build/linuxthreads
-Wl,-rpath-link=/home/rolf/toolchain/glibc-build:/home/rolf/toolchain/glibc-build/math:/home/rolf/toolchain/glibc-build/elf:/home/rolf/toolchain/glibc-build/dlfcn:/home/rolf/toolchain/glibc-build/nss:/home/rolf/toolchain/glibc-build/nis:/home/rolf/toolchain/glibc-build/rt:/home/rolf/toolchain/glibc-build/resolv:/home/rolf/toolchain/glibc-build/crypt:/home/rolf/toolchain/glibc-build/linuxthreads
-o /home/rolf/toolchain/glibc-build/libc.so -T
/home/rolf/toolchain/glibc-build/shlib.lds
/home/rolf/toolchain/glibc-build/csu/abi-note.o
/home/rolf/toolchain/glibc-build/elf/soinit.os
/home/rolf/toolchain/glibc-build/libc_pic.os
/home/rolf/toolchain/glibc-build/elf/sofini.os
/home/rolf/toolchain/glibc-build/elf/interp.os
/home/rolf/toolchain/glibc-build/elf/ld.so -lgcc
/home/rolf/toolchain/glibc-build/libc_pic.os: In function `list_add_tail':
../linuxthreads/sysdeps/pthread/list.h:59: undefined reference to `__fork_block'
../linuxthreads/sysdeps/pthread/list.h:59: undefined reference to `__fork_block'
../linuxthreads/sysdeps/pthread/list.h:59: undefined reference to `__fork_block'
/home/rolf/toolchain/glibc-build/libc_pic.os: In function
`*__GI___register_atfork':
../linuxthreads/sysdeps/unix/sysv/linux/register-atfork.c:84:
undefined reference to `__fork_block'
../linuxthreads/sysdeps/unix/sysv/linux/register-atfork.c:73:
undefined reference to `__fork_block'
/home/rolf/toolchain/glibc-build/libc_pic.os:../linuxthreads/sysdeps/unix/sysv/linux/unregister-atfork.c:35:
more undefined references to `__fork_block' follow
collect2: ld returned 1 exit status
make[1]: *** [/home/rolf/toolchain/glibc-build/libc.so] Error 1
make[1]: Leaving directory `/home/rolf/toolchain/glibc-2.3.5'
make: *** [all] Error 2
