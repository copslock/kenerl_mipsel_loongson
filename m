Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2005 11:26:53 +0000 (GMT)
Received: from smtp.uk.colt.net ([IPv6:::ffff:195.110.64.125]:53148 "EHLO
	smtp.uk.colt.net") by linux-mips.org with ESMTP id <S8228774AbVCXL0g>;
	Thu, 24 Mar 2005 11:26:36 +0000
Received: from euskadi.packetvision (unknown [213.86.106.84])
	by smtp.uk.colt.net (Postfix) with ESMTP
	id 7062D12EBC3; Thu, 24 Mar 2005 11:24:53 +0000 (GMT)
Subject: ABI incompatibility when building util-linux
From:	Alex Gonzalez <alex.gonzalez@packetvision.com>
To:	debian-mips@lists.debian.org
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1111663536.27220.32.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Thu, 24 Mar 2005 11:25:36 +0000
Content-Transfer-Encoding: 7bit
Return-Path: <alex.gonzalez@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.gonzalez@packetvision.com
Precedence: bulk
X-list: linux-mips

Hi,

When compiling the util-linux-2.12q sources, I get the following linker
ABI incompatibility error:

[alex@euskadi util-linux-2.12q]$ make
make[1]: Entering directory `/home/alex/Projects/util-linux-2.12q/po'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/alex/Projects/util-linux-2.12q/po'
make[1]: Entering directory `/home/alex/Projects/util-linux-2.12q/lib'
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  err.c -o err.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  my_reboot.c -o my_reboot.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  setproctitle.c -o setproctitle.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  env.c -o env.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  carefulputc.c -o carefulputc.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  xstrncpy.c -o xstrncpy.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  md5.c -o md5.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
make[1]: Leaving directory `/home/alex/Projects/util-linux-2.12q/lib'
make[1]: Entering directory `/home/alex/Projects/util-linux-2.12q/getopt'
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  getopt.c -o getopt.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-ld -V -static -t -EB getopt.o -o getopt
GNU ld version 2.13-mips64linux-031001 20020920
  Supported emulations:
   elf32btsmipn32
   elf32ltsmipn32
   elf32btsmip
   elf32ltsmip
   elf64btsmip
   elf64ltsmip
mips64-linux-gnu-ld: mode elf32btsmipn32
getopt.o
mips64-linux-gnu-ld: getopt.o: ABI is incompatible with that of the selected emulation
File in wrong format: failed to merge target specific data of file getopt.o
mips64-linux-gnu-ld: warning: cannot find entry symbol __start; defaulting to 00000000100000a0
getopt.o: In function `our_malloc':
getopt.o(.text+0x18): undefined reference to `malloc'
make[1]: *** [getopt] Segmentation fault
make[1]: *** Deleting file `getopt'
make[1]: Leaving directory `/home/alex/Projects/util-linux-2.12q/getopt'
make: *** [all] Error 1

If I try with -melf32btsmip, I get the following error:

[alex@euskadi util-linux-2.12q]$ make
make[1]: Entering directory `/home/alex/Projects/util-linux-2.12q/po'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/alex/Projects/util-linux-2.12q/po'
make[1]: Entering directory `/home/alex/Projects/util-linux-2.12q/lib'
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  err.c -o err.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  my_reboot.c -o my_reboot.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  setproctitle.c -o setproctitle.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  env.c -o env.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  carefulputc.c -o carefulputc.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  xstrncpy.c -o xstrncpy.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  md5.c -o md5.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
make[1]: Leaving directory `/home/alex/Projects/util-linux-2.12q/lib'
make[1]: Entering directory `/home/alex/Projects/util-linux-2.12q/getopt'
mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -Wl,-melf32btsmip -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  getopt.c -o getopt.o
mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
mips64-linux-gnu-gcc: -melf32btsmip: linker input file unused because linking not done
mips64-linux-gnu-ld -V -static -t -EB -melf32btsmip getopt.o -o getopt
GNU ld version 2.13-mips64linux-031001 20020920
  Supported emulations:
   elf32btsmipn32
   elf32ltsmipn32
   elf32btsmip
   elf32ltsmip
   elf64btsmip
   elf64ltsmip
mips64-linux-gnu-ld: mode elf32btsmip
getopt.o
mips64-linux-gnu-ld: warning: cannot find entry symbol __start; defaulting to 00000000004000b0
getopt.o: In function `our_malloc':
getopt.o(.text+0x18): undefined reference to `malloc'
getopt.o(.text+0x4c): undefined reference to `dcgettext'
getopt.o(.text+0x5c): undefined reference to `stderr'
getopt.o(.text+0x78): undefined reference to `fprintf'
getopt.o(.text+0x8c): undefined reference to `exit'
getopt.o: In function `our_realloc':
getopt.o(.text+0xbc): undefined reference to `realloc'
getopt.o(.text+0xfc): undefined reference to `dcgettext'
getopt.o(.text+0x10c): undefined reference to `stderr'
getopt.o(.text+0x128): undefined reference to `fprintf'
getopt.o(.text+0x13c): undefined reference to `exit'
getopt.o: In function `normalize':
getopt.o(.text+0x1b0): undefined reference to `strlen'
getopt.o(.text+0x1f0): undefined reference to `strcpy'
getopt.o(.text+0x23c): undefined reference to `strlen'
getopt.o(.text+0x304): undefined reference to `__ctype_b_loc'
getopt.o(.text+0x3b0): undefined reference to `free'
getopt.o: In function `generate_output':
getopt.o(.text+0x3d8): undefined reference to `opterr'
getopt.o(.text+0x430): undefined reference to `optind'
getopt.o(.text+0x43c): undefined reference to `opterr'
getopt.o(.text+0x46c): undefined reference to `getopt_long_only'
getopt.o(.text+0x4cc): undefined reference to `printf'
getopt.o(.text+0x4e4): undefined reference to `strchr'
getopt.o(.text+0x504): undefined reference to `optarg'
getopt.o(.text+0x540): undefined reference to `printf'
getopt.o(.text+0x554): undefined refermake[1]: *** Deleting file `getopt'
make[1]: *** [getopt] Interrupt
make: *** [all] Interrupt

This package compiles completely if I use an -mabi=n32 flag for gcc, but the executable won't run on our -mabi=32 compiled kernel.

Can anybody help with the following:

1) What's the difference between -mabi=32 and -mabi=n32?
2) What should I do to compile util-linux with -mabi=32?

Thanks,
Alex
