Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 22:08:58 +0200 (CEST)
Received: from medtron.medtronic.COM ([144.15.157.122]:15529 "EHLO
	medtron.medtronic.com") by linux-mips.org with ESMTP
	id <S1122963AbSIRUI5>; Wed, 18 Sep 2002 22:08:57 +0200
Received: from RADIUM (localhost [127.0.0.1])
	by medtron.medtronic.com (8.10.1/8.10.1) with SMTP id g8IK8ep13793
	for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 15:08:40 -0500 (CDT)
From: "Lyle Bainbridge" <lyle@zevion.com>
To: <linux-mips@linux-mips.org>
Subject: Mips Cross Toolchain
Date: Wed, 18 Sep 2002 15:08:40 -0500
Message-ID: <NCBBKGDBOEEBDOELAFOFOEDCDAAA.lyle@zevion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips

Hi,

Firstly, my apologies for resending this message that I
sent last friday.  My mail server died, so if you read
this and replied I wouldn't have received any resonsed.
So I am trying again...

I have successfully build a mips-linux cross toolchain
under RH Linux, but have really intended to be able to
do it under Cygwin.  I have binutils 2.13, gcc 3.2,
glibc 2.2.5.  Under Cywin, binutils and the first pass
of gcc succeed (c compiler only).  Then glibc gets
a long way through but exists with the text at the end
of this message.

My glibc configure options look like this:

CC=${TARGET}-gcc AR=${TARGET}-ar RANLIB=${TARGET}-ranlib HOST_CC=gcc
BUILD_CC=gcc \
../${LIBC}/configure --host=${TARGET} --prefix=/usr --with-elf --enable-shar
ed --enable-add-ons=linuxthreads --with-headers=${PREFIX}/include -v

Is it even possible to build glibc under Cygwin?
Any help would be appreciated.

Thanks,
Lyle Baingridge


mips-linux-gcc -nostdlib -nostartfiles -o
usr/src/o_libc/iconv/iconv_prog  -Wl,
-dynamic-linker=/lib/ld.so.1    /usr/src/o_libc/csu/crt1.o
/usr/src/o_libc/csu/c
rti.o `mips-linux-gcc --print-file-name=crtbegin.o`
/usr/src/o_libc/iconv/iconv_
prog.o /usr/src/o_libc/iconv/iconv_charmap.o /usr/src/o_libc/iconv/charmap.o
/us
r/src/o_libc/iconv/charmap-dir.o /usr/src/o_libc/iconv/linereader.o
/usr/src/o_l
ibc/iconv/dummy-repertoire.o /usr/src/o_libc/iconv/simple-hash.o
/usr/src/o_libc
/iconv/xstrdup.o
usr/src/o_libc/iconv/xmalloc.o  -Wl,-rpath-link=/usr/src/o_lib
c:/usr/src/o_libc/math:/usr/src/o_libc/elf:/usr/src/o_libc/dlfcn:/usr/src/o_
libc
/nss:/usr/src/o_libc/nis:/usr/src/o_libc/rt:/usr/src/o_libc/resolv:/usr/src/
o_li
bc/crypt:/usr/src/o_libc/linuxthreads /usr/src/o_libc/libc.so.6
/usr/src/o_libc/
libc_nonshared.a -lgcc `mips-linux-gcc --print-file-name=crtend.o`
/usr/src/o_li
bc/csu/crtn.o
/usr/src/o_libc/iconv/iconv_prog.o: In function `main':
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:265: undefined reference to `open'
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:279: undefined reference to
`__fxstat'
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:285: undefined reference to `close'
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:326: undefined reference to `close'
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:317: undefined reference to `close'
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:142: undefined reference to `exit'
/usr/src/o_libc/iconv/iconv_prog.o: In function `process_fd':
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:511: undefined reference to `read'
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:542: undefined reference to `read'
/usr/src/o_libc/iconv/iconv_prog.o: In function `print_known_names':
/usr/src/glibc-2.2.5/iconv/iconv_prog.c:726: undefined reference to `isatty'
/usr/src/o_libc/iconv/iconv_charmap.o: In function `charmap_conversion':
/usr/src/glibc-2.2.5/iconv/iconv_charmap.c:155: undefined reference to
`open'
/usr/src/glibc-2.2.5/iconv/iconv_charmap.c:169: undefined reference to
`__fxstat
'
/usr/src/glibc-2.2.5/iconv/iconv_charmap.c:175: undefined reference to
`close'
/usr/src/glibc-2.2.5/iconv/iconv_charmap.c:215: undefined reference to
`close'
/usr/src/glibc-2.2.5/iconv/iconv_charmap.c:206: undefined reference to
`close'
/usr/src/o_libc/iconv/iconv_charmap.o: In function `process_fd':
/usr/src/glibc-2.2.5/iconv/iconv_charmap.c:498: undefined reference to
`read'
/usr/src/glibc-2.2.5/iconv/iconv_charmap.c:529: undefined reference to
`read'
/usr/src/o_libc/iconv/charmap.o: In function `charmap_read':
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap.c:106: undefined
reference
 to `getenv'
/usr/src/o_libc/iconv/charmap.o: In function `parse_charmap':
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap.c:467: undefined
reference
 to `exit'
/usr/src/o_libc/iconv/charmap.o: In function `charmap_new_char':
/usr/src/glibc-2.2.5/iconv/../stdlib/stdlib.h:308: undefined reference to
`__str
toul_internal'
/usr/src/glibc-2.2.5/iconv/../stdlib/stdlib.h:308: undefined reference to
`__str
toul_internal'
/usr/src/glibc-2.2.5/iconv/../stdlib/stdlib.h:308: undefined reference to
`__str
toul_internal'
/usr/src/glibc-2.2.5/iconv/../stdlib/stdlib.h:308: undefined reference to
`__str
toul_internal'
/usr/src/o_libc/iconv/charmap-dir.o: In function `charmap_readdir':
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:130: undefined
refer
ence to `__xstat'
/usr/src/o_libc/iconv/charmap-dir.o: In function `fopen_uncompressed':
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:171: undefined
refer
ence to `open'
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:177: undefined
refer
ence to `__fxstat'
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:207: undefined
refer
ence to `close'
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:210: undefined
refer
ence to `pipe'
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:204: undefined
refer
ence to `close'
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:205: undefined
refer
ence to `close'
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:198: undefined
refer
ence to `close'
/usr/src/glibc-2.2.5/iconv/../locale/programs/charmap-dir.c:199: undefined
refer
ence to `close'
/usr/src/o_libc/iconv/linereader.o: In function `get_symname':
/usr/src/glibc-2.2.5/iconv/../stdlib/stdlib.h:308: undefined reference to
`__str
toul_internal'
/usr/src/o_libc/iconv/linereader.o: In function `get_string':
/usr/src/glibc-2.2.5/iconv/../stdlib/stdlib.h:308: undefined reference to
`__str
toul_internal'
/usr/src/o_libc/libc.so.6: undefined reference to `__dup'
/usr/src/o_libc/libc.so.6: undefined reference to `__strtod_internal'
/usr/src/o_libc/libc.so.6: undefined reference to `utime'
/usr/src/o_libc/libc.so.6: undefined reference to `lrand48_r'
/usr/src/o_libc/libc.so.6: undefined reference to `__strtoull_internal'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_cmp'
/usr/src/o_libc/libc.so.6: undefined reference to `__libc_fcntl'
/usr/src/o_libc/libc.so.6: undefined reference to `__write'
/usr/src/o_libc/libc.so.6: undefined reference to `__getcwd'
/usr/src/o_libc/libc.so.6: undefined reference to `__strtol_internal'
/usr/src/o_libc/libc.so.6: undefined reference to `bsearch'
/usr/src/o_libc/libc.so.6: undefined reference to `__dup2'
/usr/src/o_libc/libc.so.6: undefined reference to `qsort'
/usr/src/o_libc/libc.so.6: undefined reference to `__strtoll_internal'
/usr/src/o_libc/libc.so.6: undefined reference to `__read'
/usr/src/o_libc/libc.so.6: undefined reference to `__unlink'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_lshift'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_mul'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_submul_1'
/usr/src/o_libc/libc.so.6: undefined reference to `__open'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_construct_float'
/usr/src/o_libc/elf/ld.so.1: undefined reference to `__libc_read'
/usr/src/o_libc/libc.so.6: undefined reference to `__xstat64'
/usr/src/o_libc/libc.so.6: undefined reference to `abort'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_divrem'
/usr/src/o_libc/libc.so.6: undefined reference to `__lxstat'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_construct_double'
/usr/src/o_libc/libc.so.6: undefined reference to `__chmod'
/usr/src/o_libc/libc.so.6: undefined reference to `__strtold_internal'
/usr/src/o_libc/libc.so.6: undefined reference to `__strtod_l'
/usr/src/o_libc/libc.so.6: undefined reference to `__isatty'
/usr/src/o_libc/libc.so.6: undefined reference to `__statfs'
/usr/src/o_libc/libc.so.6: undefined reference to `_fpioconst_pow10'
/usr/src/o_libc/libc.so.6: undefined reference to `__chdir'
/usr/src/o_libc/libc.so.6: undefined reference to `__readlink'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_extract_double'
/usr/src/o_libc/libc.so.6: undefined reference to `__secure_getenv'
/usr/src/o_libc/libc.so.6: undefined reference to `__mkdir'
/usr/src/o_libc/libc.so.6: undefined reference to `__cxa_atexit'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_add_n'
/usr/src/o_libc/libc.so.6: undefined reference to `__poll'
/usr/src/o_libc/libc.so.6: undefined reference to `__statvfs64'
/usr/src/o_libc/libc.so.6: undefined reference to `__pipe'
/usr/src/o_libc/libc.so.6: undefined reference to `__libc_open'
/usr/src/o_libc/libc.so.6: undefined reference to `__chown'
/usr/src/o_libc/libc.so.6: undefined reference to `__random_r'
/usr/src/o_libc/libc.so.6: undefined reference to `__initstate_r'
/usr/src/o_libc/libc.so.6: undefined reference to `__xmknod'
/usr/src/o_libc/libc.so.6: undefined reference to `__lseek'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_rshift'
/usr/src/o_libc/libc.so.6: undefined reference to `__srand48_r'
/usr/src/o_libc/libc.so.6: undefined reference to `__tens'
/usr/src/o_libc/libc.so.6: undefined reference to `__lxstat64'
/usr/src/o_libc/libc.so.6: undefined reference to `__ttyname_r'
/usr/src/o_libc/libc.so.6: undefined reference to `__rmdir'
/usr/src/o_libc/libc.so.6: undefined reference to `__fstatfs'
/usr/src/o_libc/libc.so.6: undefined reference to `__close'
/usr/src/o_libc/libc.so.6: undefined reference to `__fxstat64'
/usr/src/o_libc/libc.so.6: undefined reference to `__mpn_mul_1'
/usr/src/o_libc/libc.so.6: undefined reference to `__strtof_internal'
/usr/src/o_libc/elf/ld.so.1: undefined reference to `__libc_write'
/usr/src/o_libc/libc.so.6: undefined reference to `__fcntl'
/usr/src/o_libc/libc.so.6: undefined reference to `__setenv'
/usr/src/o_libc/libc.so.6: undefined reference to `__access'
/usr/src/o_libc/libc.so.6: undefined reference to `__unsetenv'
/usr/src/o_libc/libc.so.6: undefined reference to `__open64'
/usr/src/o_libc/libc.so.6: undefined reference to `__fstatvfs64'
collect2: ld returned 1 exit status
make[2]: *** [/usr/src/o_libc/iconv/iconv_prog] Error 1
make[2]: Leaving directory `/usr/src/glibc-2.2.5/iconv'
make[1]: *** [iconv/subdir_install] Error 2
make[1]: Leaving directory `/usr/src/glibc-2.2.5'
make: *** [install] Error 2
