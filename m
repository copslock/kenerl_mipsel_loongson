Received:  by oss.sgi.com id <S42407AbQI2Pvv>;
	Fri, 29 Sep 2000 08:51:51 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:12562 "HELO noose.gt.owl.de") convert =?ISO-8859-1?Q?rfc822-to-8bitgre!=88=01?=
	by oss.sgi.com with SMTP id <S42190AbQI2Pvp>;
	Fri, 29 Sep 2000 08:51:45 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 50A247D9; Fri, 29 Sep 2000 17:51:43 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D283A9014; Fri, 29 Sep 2000 17:50:46 +0200 (CEST)
Date:   Fri, 29 Sep 2000 17:50:46 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Cc:     debian-glibc@lists.debian.org
Subject: debian glibc 2.1.94 package on mips
Message-ID: <20000929175046.A5972@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
i tried building the debian glibc source package for 2.1.94 and
failed like this ...

/bin/sh ../scripts/rellns-sh /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/libc.so /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/libc.so.6.new
mv -f /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/libc.so.6.new /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/libc.so.6
gcc -nostdlib -nostartfiles -o /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/iconv/iconv_prog  -Wl,-dynamic-linker=/lib/ld.so.1   /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/csu/crt1.o /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/csu/crti.o `gcc --print-file-name=crtbegin.o` /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/iconv/iconv_prog.o  -Wl,-rpath-link=/home2/flo/glibc/glibc-2.1.94/mips-linux/obj:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/math:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/elf:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/dlfcn:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/nss:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/nis:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/rt:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/resolv:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/crypt:/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/linuxthreads /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/libc.so.6 /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/libc_nonshared.a -lgcc `gcc --print-file-name=crtend.o` /home2/flo/glibc/glibc-2.1.94/mips-linux/obj/csu/crtn.o
/home/flo/gcc/gcc-20000829/lib/gcc-lib/mips-unknown-linux-gnu/2.96/libgcc.a(__main.o): In function `no symbol':
/home2/flo/gcc/gcc-20000829-src/gcc/./libgcc2.c(.text+0xb4): undefined reference to `__EH_FRAME_BEGIN__'
/home/flo/gcc/gcc-20000829/lib/gcc-lib/mips-unknown-linux-gnu/2.96/libgcc.a(__main.o): In function `__do_global_ctors':
/home2/flo/gcc/gcc-20000829-src/gcc/./libgcc2.c(.text+0xf8): undefined reference to `__EH_FRAME_BEGIN__'
/home/flo/gcc/gcc-20000829/lib/gcc-lib/mips-unknown-linux-gnu/2.96/libgcc.a(__main.o): In function `no symbol':
/home2/flo/gcc/gcc-20000829-src/gcc/./libgcc2.c(.text+0x130): undefined reference to `__CTOR_LIST__'
/home2/flo/gcc/gcc-20000829-src/gcc/./libgcc2.c(.text+0x154): undefined reference to `__CTOR_LIST__'
/home/flo/gcc/gcc-20000829/lib/gcc-lib/mips-unknown-linux-gnu/2.96/libgcc.a(__main.o): In function `__do_global_dtors':
/home2/flo/gcc/gcc-20000829-src/gcc/./libgcc2.c(.data+0x0): undefined reference to `__DTOR_LIST__'
collect2: ld returned 1 exit status
make[3]: *** [/home2/flo/glibc/glibc-2.1.94/mips-linux/obj/iconv/iconv_prog] Error 1
make[3]: Leaving directory `/home2/flo/glibc/glibc-2.1.94/glibc-2.1.94/iconv'

binutils/gcc are cvs snapshots of 20000829

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
