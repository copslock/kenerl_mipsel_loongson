Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 10:20:01 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:12646 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20025625AbXI3JTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2007 10:19:51 +0100
X-SBRS:	None
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 30 Sep 2007 17:18:41 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse301.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 17:18:41 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Linux-2.6.20 malta board build with GCC-4.0.0 build error
Date:	Sun, 30 Sep 2007 17:18:39 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C17298602667FE0@sinse303.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux-2.6.20 malta board build with GCC-4.0.0 build error
Thread-Index: AcgDQuNJTWGU+lzVQ06KmLbEaSYr4Q==
From:	<KokHow.Teh@infineon.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 30 Sep 2007 09:18:41.0101 (UTC) FILETIME=[E42E17D0:01C80342]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi;
	I am using eldk-4.1 with gcc-4.0.0 to build linux-2.6.20 for
Malta board little-endian. I bump into following build error with
mipsel-linux-ld:

<snip>
  CHK     include/linux/compile.h
/bin/sh /usr/src/linux-source-2.6.22_mips/scripts/mkcompile_h
include/linux/compile.h \
        "mips" "y" "y" "mipsel-linux-gcc -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2
-mabi=32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -ffreestanding
-EL -UMIPSEB -U_MIPSEB -U__MIPSEB -U__MIPSEB__ -UMIPSEL -U_MIPSEL
-U__MIPSEL -U__MIPSEL__ -DMIPSEL -D_MIPSEL -D__MIPSEL -D__MIPSEL__
-march=mips32r2 -Wa,-mips32r2 -Wa,--trap -Iinclude/asm-mips/mach-mips
-Iinclude/asm-mips/mach-generic -fomit-frame-pointer -g
-Wdeclaration-after-statement -Wno-pointer-sign"
   mipsel-linux-ld  -EL -m elf32ltsmip  -r -o
arch/mips/mips-boards/generic/built-in.o
arch/mips/mips-boards/generic/reset.o
arch/mips/mips-boards/generic/display.o
arch/mips/mips-boards/generic/init.o
arch/mips/mips-boards/generic/memory.o
arch/mips/mips-boards/generic/cmdline.o
arch/mips/mips-boards/generic/time.o
arch/mips/mips-boards/generic/console.o
arch/mips/mips-boards/generic/pci.o
mipsel-linux-ld: cannot open linker script file
ldscripts/elf32ltsmip.xr: No such file or directory
make[1]: *** [arch/mips/mips-boards/generic/built-in.o] Error 1
make: *** [arch/mips/mips-boards/generic] Error 2
make: *** Waiting for unfinished jobs....
  mipsel-linux-ld  -EL -m elf32ltsmip  -r -o init/mounts.o
init/do_mounts.o init/do_mounts_rd.o
mipsel-linux-ld: cannot open linker script file
ldscripts/elf32ltsmip.xr: No such file or directory
make[1]: *** [init/mounts.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [init] Error 2
[tehkok@linux2:/usr/src/linux-source-2.6.22_mips 5]$
[tehkok@linux2:/usr/src/linux-source-2.6.22_mips 6]$ echo $PATH
/opt/mips_sde/./bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/usr/lo
cal/sbin:/usr/local/bin:/usr/games:.:/usr/atria/bin:/opt/cc_scripts/wlns
w:/opt/eldk/4.1/usr/bin:/opt/eldk/4.1/mips_4KCle:/opt/eldk/4.1/mips_4KCl
e/lib:/opt/eldk/4.1/mips_4KCle/usr/lib:/opt/eldk/4.1/mips_4KCle/etc
[tehkok@linux2:/usr/src/linux-source-2.6.22_mips 7]$ echo
$LD_LIBRARY_PATH
/opt/eldk/4.1/mips_4KCle/lib:/opt/eldk/4.1/mips_4KCle/usr/lib
[tehkok@linux2:/usr/src/linux-source-2.6.22_mips 8]$


	The error message is rather misleading in the fact that it
managed to locate the elf32ltsmip.xr file in the right folder. Attached
below is the `strace` of the failed compilation above. One thing that I
notice is that the build system is using /etc/ld.so.cache instead of the
target's ld.so.cache which is highlighted in red below. The build
process actually failed at this point:

open("/opt/eldk/4.1/usr/../mips_4KCle/lib/ldscripts/elf32ltsmip.xr",
O_RDONLY) = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfa00c78) = -1 ENOTTY
(Inappropriate ioctl for device)


	Anybody has any experience with this error? Any advice and
insight is appreciated.

Regards,
KH

[tehkok@linux2:/usr/src/linux-source-2.6.22_mips 5]$ strace
mipsel-linux-ld  -EL -m elf32ltsmip  -r -o
arch/mips/mips-boards/generic/built-in.o
arch/mips/mips-boards/generic/reset.o
arch/mips/mips-boards/generic/display.o
arch/mips/mips-boards/generic/init.o
arch/mips/mips-boards/generic/memory.o
arch/mips/mips-boards/generic/cmdline.o
arch/mips/mips-boards/generic/time.o
arch/mips/mips-boards/generic/console.o
arch/mips/mips-boards/generic/pci.o
execve("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", ["mipsel-linux-ld",
"-EL", "-m", "elf32ltsmip", "-r", "-o",
"arch/mips/mips-boards/generic/bu"...,
"arch/mips/mips-boards/generic/re"...,
"arch/mips/mips-boards/generic/di"...,
"arch/mips/mips-boards/generic/in"...,
"arch/mips/mips-boards/generic/me"...,
"arch/mips/mips-boards/generic/cm"...,
"arch/mips/mips-boards/generic/ti"...,
"arch/mips/mips-boards/generic/co"...,
"arch/mips/mips-boards/generic/pc"...], [/* 54 vars */]) = 0
brk(0)                                  = 0x8114000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f92000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/i686/sse2/cmov/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls/i686/sse2/cmov", 0xbfa004f0) =
-1 ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/i686/sse2/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls/i686/sse2", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/i686/cmov/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls/i686/cmov", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/i686/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls/i686", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/sse2/cmov/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls/sse2/cmov", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/sse2/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls/sse2", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/cmov/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls/cmov", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/tls/libc.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/tls", 0xbfa004f0) = -1 ENOENT (No
such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/i686/sse2/cmov/libc.so.6", O_RDONLY)
= -1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/i686/sse2/cmov", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/i686/sse2/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/i686/sse2", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/i686/cmov/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/i686/cmov", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/i686/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/i686", 0xbfa004f0) = -1 ENOENT (No
such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/sse2/cmov/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/sse2/cmov", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/sse2/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/sse2", 0xbfa004f0) = -1 ENOENT (No
such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/cmov/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/lib/cmov", 0xbfa004f0) = -1 ENOENT (No
such file or directory)
open("/opt/eldk/4.1/mips_4KCle/lib/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0TT\1\000"...,
512) = 512
close(3)                                = 0
stat64("/opt/eldk/4.1/mips_4KCle/lib", {st_mode=S_IFDIR|0775,
st_size=4096, ...}) = 0
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686/sse2/cmov/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686/sse2/cmov",
0xbfa004f0) = -1 ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686/sse2/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686/sse2", 0xbfa004f0) =
-1 ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686/cmov/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686/cmov", 0xbfa004f0) =
-1 ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/i686", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/sse2/cmov/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/sse2/cmov", 0xbfa004f0) =
-1 ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/sse2/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/sse2", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/cmov/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/cmov", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/tls/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/tls", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/i686/sse2/cmov/libc.so.6",
O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/i686/sse2/cmov", 0xbfa004f0) =
-1 ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/i686/sse2/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/i686/sse2", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/i686/cmov/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/i686/cmov", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/i686/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/i686", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/sse2/cmov/libc.so.6", O_RDONLY) =
-1 ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/sse2/cmov", 0xbfa004f0) = -1
ENOENT (No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/sse2/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/sse2", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/cmov/libc.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib/cmov", 0xbfa004f0) = -1 ENOENT
(No such file or directory)
open("/opt/eldk/4.1/mips_4KCle/usr/lib/libc.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/opt/eldk/4.1/mips_4KCle/usr/lib", {st_mode=S_IFDIR|0775,
st_size=8192, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60114, ...}) = 0
mmap2(NULL, 60114, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f83000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260a\1"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1335912, ...}) = 0
mmap2(NULL, 1340944, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xb7e3b000
mmap2(0xb7f7d000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x142) = 0xb7f7d000
mmap2(0xb7f80000, 9744, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f80000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7e3a000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e3a8c0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb7f7d000, 4096, PROT_READ)   = 0
munmap(0xb7f83000, 60114)               = 0
getrusage(RUSAGE_SELF, {ru_utime={0, 0}, ru_stime={0, 2999}, ...}) = 0
brk(0)                                  = 0x8114000
brk(0x8135000)                          = 0x8135000
access("/opt/mips_sde/./bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such
file or directory)
access("/sbin/mipsel-linux-ld", X_OK)   = -1 ENOENT (No such file or
directory)
access("/bin/mipsel-linux-ld", X_OK)    = -1 ENOENT (No such file or
directory)
access("/usr/sbin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("/usr/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("/usr/X11R6/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/usr/local/sbin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such
file or directory)
access("/usr/local/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/usr/games/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("./mipsel-linux-ld", X_OK)       = -1 ENOENT (No such file or
directory)
access("/usr/atria/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/opt/cc_scripts/wlnsw/mipsel-linux-ld", X_OK) = -1 ENOENT (No
such file or directory)
access("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", X_OK) = 0
lstat64("/opt", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
lstat64("/opt/eldk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1/usr", {st_mode=S_IFDIR|0755, st_size=4096, ...})
= 0
lstat64("/opt/eldk/4.1/usr/bin", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", "mips_4KCle-ld", 4096)
= 13
lstat64("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", "mips-linux-ld", 4096) =
13
lstat64("/opt/eldk/4.1/usr/bin/mips-linux-ld", {st_mode=S_IFREG|0755,
st_size=818704, ...}) = 0
stat64("/opt/eldk/4.1/usr/bin/../mips-linux", {st_mode=S_IFDIR|0755,
st_size=4096, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
lstat64("/opt/eldk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1/usr", {st_mode=S_IFDIR|0755, st_size=4096, ...})
= 0
lstat64("/opt/eldk/4.1/usr/bin", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("/opt/eldk/4.1/usr/mips-linux", {st_mode=S_IFDIR|0755,
st_size=4096, ...}) = 0
lstat64("/opt/mips_sde/./bin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT
(No such file or directory)
lstat64("/sbin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No such file
or directory)
lstat64("/bin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No such file or
directory)
lstat64("/usr/sbin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No such
file or directory)
lstat64("/usr/bin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No such
file or directory)
lstat64("/usr/X11R6/bin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No
such file or directory)
lstat64("/usr/local/sbin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No
such file or directory)
lstat64("/usr/local/bin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No
such file or directory)
lstat64("/usr/games/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No such
file or directory)
getcwd("/usr/src/linux-source-2.6.22_mips", 4096) = 34
lstat64("/usr/src/linux-source-2.6.22_mips/mipsel-linux-ld", 0xbfa00c74)
= -1 ENOENT (No such file or directory)
lstat64("/usr/atria/bin/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT (No
such file or directory)
lstat64("/opt/cc_scripts/wlnsw/mipsel-linux-ld", 0xbfa00c74) = -1 ENOENT
(No such file or directory)
lstat64("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
lstat64("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", "mips_4KCle-ld", 4096)
= 13
lstat64("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", "mips-linux-ld", 4096) =
13
lstat64("/opt/eldk/4.1/usr/bin/mips-linux-ld", {st_mode=S_IFREG|0755,
st_size=818704, ...}) = 0
lstat64("/opt/eldk/4.1/usr/bin", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("/opt/eldk/4.1/usr", {st_mode=S_IFDIR|0755, st_size=4096, ...})
= 0
lstat64("/opt/eldk/4.1", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
access("/opt/mips_sde/./bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such
file or directory)
access("/sbin/mipsel-linux-ld", X_OK)   = -1 ENOENT (No such file or
directory)
access("/bin/mipsel-linux-ld", X_OK)    = -1 ENOENT (No such file or
directory)
access("/usr/sbin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("/usr/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("/usr/X11R6/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/usr/local/sbin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such
file or directory)
access("/usr/local/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/usr/games/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("./mipsel-linux-ld", X_OK)       = -1 ENOENT (No such file or
directory)
access("/usr/atria/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/opt/cc_scripts/wlnsw/mipsel-linux-ld", X_OK) = -1 ENOENT (No
such file or directory)
access("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", X_OK) = 0
lstat64("/opt", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
lstat64("/opt/eldk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1/usr", {st_mode=S_IFDIR|0755, st_size=4096, ...})
= 0
lstat64("/opt/eldk/4.1/usr/bin", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", "mips_4KCle-ld", 4096)
= 13
lstat64("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", "mips-linux-ld", 4096) =
13
lstat64("/opt/eldk/4.1/usr/bin/mips-linux-ld", {st_mode=S_IFREG|0755,
st_size=818704, ...}) = 0
stat64("/opt/eldk/4.1/usr/bin/../mips-linux/lib/ldscripts", 0xbfa00c74)
= -1 ENOENT (No such file or directory)
access("/opt/mips_sde/./bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such
file or directory)
access("/sbin/mipsel-linux-ld", X_OK)   = -1 ENOENT (No such file or
directory)
access("/bin/mipsel-linux-ld", X_OK)    = -1 ENOENT (No such file or
directory)
access("/usr/sbin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("/usr/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("/usr/X11R6/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/usr/local/sbin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such
file or directory)
access("/usr/local/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/usr/games/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file or
directory)
access("./mipsel-linux-ld", X_OK)       = -1 ENOENT (No such file or
directory)
access("/usr/atria/bin/mipsel-linux-ld", X_OK) = -1 ENOENT (No such file
or directory)
access("/opt/cc_scripts/wlnsw/mipsel-linux-ld", X_OK) = -1 ENOENT (No
such file or directory)
access("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", X_OK) = 0
lstat64("/opt", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
lstat64("/opt/eldk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/eldk/4.1/usr", {st_mode=S_IFDIR|0755, st_size=4096, ...})
= 0
lstat64("/opt/eldk/4.1/usr/bin", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0
lstat64("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mipsel-linux-ld", "mips_4KCle-ld", 4096)
= 13
lstat64("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", {st_mode=S_IFLNK|0777,
st_size=13, ...}) = 0
readlink("/opt/eldk/4.1/usr/bin/mips_4KCle-ld", "mips-linux-ld", 4096) =
13
lstat64("/opt/eldk/4.1/usr/bin/mips-linux-ld", {st_mode=S_IFREG|0755,
st_size=818704, ...}) = 0
stat64("/opt/eldk/4.1/usr/bin/../lib/ldscripts", 0xbfa00c74) = -1 ENOENT
(No such file or directory)
stat64("/opt/eldk/4.1/usr/mips-linux/lib/ldscripts", 0xbfa00c74) = -1
ENOENT (No such file or directory)
lstat64("/var", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/var/tmp", {st_mode=S_IFLNK|0777, st_size=4, ...}) = 0
readlink("/var/tmp", "/tmp", 4096)      = 4
lstat64("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
lstat64("/tmp/eldk.PyrfxY", 0xbf9fec58) = -1 ENOENT (No such file or
directory)
lstat64("/var", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/var/tmp", {st_mode=S_IFLNK|0777, st_size=4, ...}) = 0
readlink("/var/tmp", "/tmp", 4096)      = 4
lstat64("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
lstat64("/tmp/eldk.PyrfxY", 0xbf9fec58) = -1 ENOENT (No such file or
directory)
open("ldscripts/elf32ltsmip.xr", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/opt/eldk/4.1/usr/../mips_4KCle/lib/ldscripts/elf32ltsmip.xr",
O_RDONLY) = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfa00c78) = -1 ENOTTY
(Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_size=5837, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f91000
read(3, "/* Script for ld -r: link withou"..., 8192) = 5837
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbf9ffde8) = -1 ENOTTY
(Inappropriate ioctl for device)
stat64("arch/mips/mips-boards/generic/built-in.o",
{st_mode=S_IFREG|0644, st_size=228754, ...}) = 0
lstat64("arch/mips/mips-boards/generic/built-in.o",
{st_mode=S_IFREG|0644, st_size=228754, ...}) = 0
unlink("arch/mips/mips-boards/generic/built-in.o") = 0
open("arch/mips/mips-boards/generic/built-in.o", O_RDWR|O_CREAT|O_TRUNC,
0666) = 4
open("arch/mips/mips-boards/generic/reset.o", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=5908, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f90000
_llseek(5, 0, [0], SEEK_SET)            = 0
read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
read(5, "\223\0\0\0\36\0\0p\0\0\0\0\0\0\0\0\0\t\0\0(\0\0\0\0\0\0"...,
4096) = 1812
_llseek(5, 0, [0], SEEK_SET)            = 0
read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
read(5, "\223\0\0\0\36\0\0p\0\0\0\0\0\0\0\0\0\t\0\0(\0\0\0\0\0\0"...,
4096) = 1812
_llseek(5, 0, [0], SEEK_SET)            = 0
read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(5, 4096, [4096], SEEK_SET)      = 0
read(5, "\223\0\0\0\36\0\0p\0\0\0\0\0\0\0\0\0\t\0\0(\0\0\0\0\0\0"...,
4096) = 1812
open("arch/mips/mips-boards/generic/display.o", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0644, st_size=7504, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f8f000
_llseek(6, 0, [0], SEEK_SET)            = 0
read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(6, 4096, [4096], SEEK_SET)      = 0
brk(0x8159000)                          = 0x8159000
_llseek(6, 4096, [4096], SEEK_SET)      = 0
read(6, "DK 4.1 4.0.0)\0\0.symtab\0.strtab\0."..., 4096) = 3408
_llseek(6, 7504, [7504], SEEK_SET)      = 0
_llseek(6, 7504, [7504], SEEK_SET)      = 0
_llseek(6, 7504, [7504], SEEK_SET)      = 0
_llseek(6, 0, [0], SEEK_SET)            = 0
read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(6, 4096, [4096], SEEK_SET)      = 0
read(6, "DK 4.1 4.0.0)\0\0.symtab\0.strtab\0."..., 4096) = 3408
_llseek(6, 7504, [7504], SEEK_SET)      = 0
open("arch/mips/mips-boards/generic/init.o", O_RDONLY) = 7
fstat64(7, {st_mode=S_IFREG|0644, st_size=47124, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f8e000
_llseek(7, 0, [0], SEEK_SET)            = 0
read(7, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(7, 32768, [32768], SEEK_SET)    = 0
read(7, "st\0__s8\0vm_start\0height\0lock_man"..., 4096) = 4096
_llseek(7, 36864, [36864], SEEK_SET)    = 0
_llseek(7, 36864, [36864], SEEK_SET)    = 0
_llseek(7, 36864, [36864], SEEK_SET)    = 0
_llseek(7, 0, [0], SEEK_SET)            = 0
read(7, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(7, 32768, [32768], SEEK_SET)    = 0
read(7, "st\0__s8\0vm_start\0height\0lock_man"..., 4096) = 4096
_llseek(7, 36864, [36864], SEEK_SET)    = 0
read(7, "\2\20\0\0\7\2\0\0\2\20\0\0\25\2\0\0\2\20\0\0#\2\0\0\2\20"...,
4096) = 4096
read(7, "\2\20\0\0;$\0\0\2\20\0\0J$\0\0\2\20\0\0Y$\0\0\2\20\0\0"...,
4096) = 4096
read(7, "\6\33\0\0\264\3\0\0\4#\0\0\260\3\0\0\5\34\0\0\270\3\0\0"...,
4096) = 2068
open("arch/mips/mips-boards/generic/memory.o", O_RDONLY) = 8
fstat64(8, {st_mode=S_IFREG|0644, st_size=39184, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f8d000
_llseek(8, 0, [0], SEEK_SET)            = 0
read(8, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 4096, [4096], SEEK_SET)      = 0
_llseek(8, 28672, [28672], SEEK_SET)    = 0
read(8, "y\0aio_fsync\0dq_op\0\0GCC: (GNU) 4."..., 4096) = 4096
_llseek(8, 32768, [32768], SEEK_SET)    = 0
_llseek(8, 32768, [32768], SEEK_SET)    = 0
_llseek(8, 32768, [32768], SEEK_SET)    = 0
_llseek(8, 0, [0], SEEK_SET)            = 0
read(8, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(8, 28672, [28672], SEEK_SET)    = 0
read(8, "y\0aio_fsync\0dq_op\0\0GCC: (GNU) 4."..., 4096) = 4096
_llseek(8, 32768, [32768], SEEK_SET)    = 0
brk(0x817b000)                          = 0x817b000
read(8, "\0\f\0\0\2\20\0\0\31\f\0\0\2\20\0\0!\f\0\0\2\20\0\0/\f"...,
4096) = 4096
read(8, "\356.\0\0\2\20\0\0\7/\0\0\2\20\0\0\23/\0\0\2\20\0\0 /\0"...,
4096) = 2320
brk(0x8179000)                          = 0x8179000
open("arch/mips/mips-boards/generic/cmdline.o", O_RDONLY) = 9
fstat64(9, {st_mode=S_IFREG|0644, st_size=4672, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f8c000
_llseek(9, 0, [0], SEEK_SET)            = 0
read(9, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(9, 4096, [4096], SEEK_SET)      = 0
read(9, "\270\0\0\0\2\17\0\0\314\0\0\0\2\17\0\0\327\0\0\0\2\t\0"...,
4096) = 576
open("arch/mips/mips-boards/generic/time.o", O_RDONLY) = 10
fstat64(10, {st_mode=S_IFREG|0644, st_size=77104, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f8b000
_llseek(10, 0, [0], SEEK_SET)           = 0
read(10, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(10, 53248, [53248], SEEK_SET)   = 0
read(10, "mapping\0irix_trampoline\0cap_inhe"..., 4096) = 4096
_llseek(10, 57344, [57344], SEEK_SET)   = 0
read(10, "\0\0\0\0\254\343\0\0Z\2\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0"...,
4096) = 4096
_llseek(10, 53248, [53248], SEEK_SET)   = 0
read(10, "mapping\0irix_trampoline\0cap_inhe"..., 4096) = 4096
read(10, "\0\0\0\0\254\343\0\0Z\2\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0"...,
4096) = 4096
_llseek(10, 53248, [53248], SEEK_SET)   = 0
read(10, "mapping\0irix_trampoline\0cap_inhe"..., 4096) = 4096
_llseek(10, 0, [0], SEEK_SET)           = 0
read(10, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(10, 57344, [57344], SEEK_SET)   = 0
read(10, "\0\0\0\0\254\343\0\0Z\2\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0"...,
4096) = 4096
_llseek(10, 61440, [61440], SEEK_SET)   = 0
brk(0x819a000)                          = 0x819a000
read(10, "\255\20\0\0\2\24\0\0\303\20\0\0\2\24\0\0\321\20\0\0\2\24"...,
12288) = 12288
read(10, "\313~\0\0\2\16\0\0\331~\0\0\2\20\0\0\345~\0\0\2\16\0\0"...,
4096) = 3376
brk(0x8197000)                          = 0x8197000
open("arch/mips/mips-boards/generic/console.o", O_RDONLY) = 11
fstat64(11, {st_mode=S_IFREG|0644, st_size=4860, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f8a000
_llseek(11, 0, [0], SEEK_SET)           = 0
read(11, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(11, 4096, [4096], SEEK_SET)     = 0
read(11, "\0\0\0\0\0\0\0\0\20\0\0\0\0arch/mips/mips-boar"..., 4096) =
764
open("arch/mips/mips-boards/generic/pci.o", O_RDONLY) = 12
fstat64(12, {st_mode=S_IFREG|0644, st_size=55332, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f89000
_llseek(12, 0, [0], SEEK_SET)           = 0
read(12, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(12, 40960, [40960], SEEK_SET)   = 0
read(12, "g_str\0.comment\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096)
= 4096
_llseek(12, 45056, [45056], SEEK_SET)   = 0
_llseek(12, 45056, [45056], SEEK_SET)   = 0
_llseek(12, 36864, [36864], SEEK_SET)   = 0
read(12, "xquota\0num_unused_gpl_syms\0ahead"..., 4096) = 4096
read(12, "g_str\0.comment\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096)
= 4096
_llseek(12, 0, [0], SEEK_SET)           = 0
read(12, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(12, 40960, [40960], SEEK_SET)   = 0
read(12, "g_str\0.comment\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096)
= 4096
_llseek(12, 45056, [45056], SEEK_SET)   = 0
read(12, "\2\31\0\0\226\f\0\0\2\31\0\0\244\f\0\0\2\31\0\0\262\f\0"...,
8192) = 8192
read(12, "\2\31\0\0\363]\0\0\2\3\0\0\370]\0\0\2\31\0\0\4^\0\0\2\3"...,
4096) = 2084
_llseek(5, 5908, [5908], SEEK_SET)      = 0
_llseek(6, 7504, [7504], SEEK_SET)      = 0
_llseek(7, 32768, [32768], SEEK_SET)    = 0
read(7, "st\0__s8\0vm_start\0height\0lock_man"..., 4096) = 4096
_llseek(8, 28672, [28672], SEEK_SET)    = 0
read(8, "y\0aio_fsync\0dq_op\0\0GCC: (GNU) 4."..., 4096) = 4096
_llseek(9, 0, [0], SEEK_SET)            = 0
read(9, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(10, 57344, [57344], SEEK_SET)   = 0
read(10, "\0\0\0\0\254\343\0\0Z\2\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0"...,
4096) = 4096
_llseek(11, 0, [0], SEEK_SET)           = 0
read(11, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(12, 40960, [40960], SEEK_SET)   = 0
read(12, "g_str\0.comment\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096)
= 4096
_llseek(5, 0, [0], SEEK_SET)            = 0
read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
brk(0x81b8000)                          = 0x81b8000
fstat64(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f88000
_llseek(4, 221184, [221184], SEEK_SET)  = 0
read(4, "", 2672)                       = 0
_llseek(4, 2672, [223856], SEEK_CUR)    = 0
brk(0x81d9000)                          = 0x81d9000
_llseek(5, 4096, [4096], SEEK_SET)      = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
544) = 544
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(4, -4016, [80], SEEK_CUR)       = 0
write(4, "\0\0\2<D\0B$\0\0\5<\0\0\3<,\0\245$\0\0b\254\0\0\4<\0\0"...,
96) = 96
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3996, [168036], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\35\0\0"...,
96) = 96
_llseek(4, 102400, [102400], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -189, [106307], SEEK_CUR)    = 0
write(4, "\1\21\1\20\6\22\1\21\1%\16\23\v\3\16\33\16\0\0\2$\0\3\16"...,
189) = 189
write(4, "\0\21\25\1\1\23\'\f\0\0\22&\0I\23\0\0\23.\0?\f\3\16:\v"...,
266) = 266
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3552, [8736], SEEK_CUR)     = 0
write(4, "\313\4\0\0\2\0\0\0\0\0\4\1\0\0\0\0\\\0\0\0\0\0\0\0\233"...,
1231) = 1231
_llseek(4, 110592, [110592], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(5, 4096, [4096], SEEK_SET)      = 0
_llseek(4, -3362, [111326], SEEK_CUR)   = 0
write(4, "\r\1\0\0\2\0\327\0\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1a"...,
273) = 273
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -1232, [117552], SEEK_CUR)   = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\f\0\0\0\0\0\0"...,
64) = 64
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -72, [8120], SEEK_CUR)       = 0
write(4, "$\0\0\0\2\0\0\0\0\0\317\4\0\0\321\2\0\0mips_reboot_se"..., 40)
= 40
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -432, [7760], SEEK_CUR)      = 0
write(4, "\34\0\0\0\2\0\0\0\0\0\4\0\0\0\0\0\0\0\0\0\\\0\0\0\0\0\0"...,
32) = 32
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -468, [118316], SEEK_CUR)    = 0
write(4, "raw_local_irq_restore\0ases\0flush"..., 468) = 468
write(4, "ric/reset.c\0platform_enable_wake"..., 367) = 367
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(6, 0, [0], SEEK_SET)            = 0
read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -752, [7440], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3920, [176], SEEK_CUR)      = 0
write(4, "\350\377\275\'\20\0\260\257\0\0\20<\24\0\277\257\0\0\0"...,
288) = 288
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(4, -1152, [7040], SEEK_CUR)     = 0
write(4, "\0\0\0\0\0\0\0\0\350\3\0\0\30\1\0\0\0\0\0\0\0\0\0\0\0\0"...,
32) = 32
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3900, [168132], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\1\200\374\377\377\377\0\0\0\0\0\0\0\0\30\0"...,
96) = 96
_llseek(4, 106496, [106496], SEEK_SET)  = 0
read(4, "\0\21\25\1\1\23\'\f\0\0\22&\0I\23\0\0\23.\0?\f\3\16:\v"...,
4096) = 4096
_llseek(4, -3830, [106762], SEEK_CUR)   = 0
write(4, "\1\21\1\20\6\22\1\21\1%\16\23\v\3\16\33\16\0\0\2$\0\3\16"...,
485) = 485
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2321, [9967], SEEK_CUR)     = 0
write(4, "\237\5\0\0\2\0\307\1\0\0\4\1\21\1\0\0\200\1\0\0`\0\0\0"...,
1443) = 1443
_llseek(4, 110592, [110592], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(6, 4096, [4096], SEEK_SET)      = 0
_llseek(4, -3089, [111599], SEEK_CUR)   = 0
write(4, "q\1\0\0\2\0\30\1\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1arc"...,
373) = 373
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -1168, [117616], SEEK_CUR)   = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\30\0\0\0@\0\0"...,
84) = 84
_llseek(4, 163840, [163840], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3907, [164029], SEEK_CUR)   = 0
write(4, "\0\0\0\0\4\0\0\0\2\0\215h\4\0\0\0H\0\0\0\2\0\215\0H\0\0"...,
107) = 107
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -32, [8160], SEEK_CUR)       = 0
write(4, "?\0\0\0\2\0\317\4\0\0\243\5\0\0\204\3\0\0mips_scroll_m"...,
32) = 32
write(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 35) = 35
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -400, [7792], SEEK_CUR)      = 0
write(4, "\34\0\0\0\2\0\317\4\0\0\4\0\0\0\0\0`\0\0\0 \1\0\0\0\0\0"...,
32) = 32
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3164, [168868], SEEK_CUR)   = 0
write(4, "p\0\0\0t\0\0\0\220\0\0\0\230\0\0\0\0\0\0\0\0\0\0\0", 24) = 24
_llseek(4, 118784, [118784], SEEK_SET)  = 0
read(4, "ric/reset.c\0platform_enable_wake"..., 4096) = 4096
read(6, "DK 4.1 4.0.0)\0\0.symtab\0.strtab\0."..., 4096) = 3408
_llseek(4, -3729, [119151], SEEK_CUR)   = 0
write(4, "mips_io_port_base\0ases\0linesz\0ne"..., 948) = 948
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(7, 0, [0], SEEK_SET)            = 0
read(7, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -712, [7480], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(7, 4096, [4096], SEEK_SET)      = 0
_llseek(4, -3632, [464], SEEK_CUR)      = 0
write(4, "\350\377\275\'\20\0\260\257\24\0\277\257\0\0\0\f!\200\200"...,
624) = 624
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3804, [168228], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\1\200\374\377\377\377\0\0\0\0\0\0\0\0\30\0"...,
160) = 160
_llseek(4, 106496, [106496], SEEK_SET)  = 0
read(4, "\0\21\25\1\1\23\'\f\0\0\22&\0I\23\0\0\23.\0?\f\3\16:\v"...,
4096) = 4096
read(7, "\3\20\214\10\24:\30\0\0\n\306\1!\0\0\0\3\20\220\10\0\3"...,
12288) = 12288
read(7, "\3678\0\0\34,9\0\0\1!\0\0\0\31\335\20\0\0\31\204!\0\0\0"...,
4096) = 4096
_llseek(4, -3345, [107247], SEEK_CUR)   = 0
write(4, "\1\21\1\20\6R\1%\16\23\v\3\16\33\16\0\0\2$\0\3\10\v\v>"...,
901) = 901
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 4096) = 4096
_llseek(4, -878, [11410], SEEK_CUR)     = 0
write(4, "\262E\0\0\2\0\254\3\0\0\4\1\206\2\0\0\0\0\0\0\321\31\0"...,
16384) = 16384
read(7, "\3\v\177\265\201\265KG\207\10:\200\10\251\267\267\3\n\177"...,
4096) = 4096
write(4, "w\3\0\0\rH\0\0\0\17\0*\37 \0\0\34\301\373?\0\0\1\1*\330"...,
1462) = 1462
_llseek(4, 110592, [110592], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2716, [111972], SEEK_CUR)   = 0
write(4, "\341\4\0\0\2\0\33\3\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1"...,
1253) = 1253
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2384, [1712], SEEK_CUR)     = 0
write(4, "\350\377\275\'\20\0\260\257\0\0\2<\24\0\277\257\10\0D\214"...,
1564) = 1564
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(7, 24576, [24576], SEEK_SET)    = 0
_llseek(4, -1600, [6592], SEEK_CUR)     = 0
write(4, "LINUX\0\0\0CC Error\0\0\0\0SC Error\0\0\0\0"..., 212) = 212
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -1648, [6544], SEEK_CUR)     = 0
write(4, "\270\2\0\0\270\2\0\0t\2\0\0X\5\0\0\250\5\0\0t\2\0\0t\2"...,
48) = 48
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -1084, [117700], SEEK_CUR)   = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\24\0\0\0\224"...,
144) = 144
_llseek(4, 163840, [163840], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3800, [164136], SEEK_CUR)   = 0
write(4, "\200\1\0\0\204\1\0\0\2\0\215h\204\1\0\0\364\1\0\0\2\0\215"...,
1259) = 1259
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 4096) = 4096
_llseek(4, -4061, [8227], SEEK_CUR)     = 0
write(4, "y\0\0\0\2\0r\n\0\0\266E\0\0~@\0\0init_debug\0\350@\0"..., 125)
= 125
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -368, [7824], SEEK_CUR)      = 0
write(4, "4\0\0\0\2\0r\n\0\0\4\0\0\0\0\0\200\1\0\0p\2\0\0\0\0\0\0"...,
56) = 56
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
read(7, "fl_mylease\0vm_stat\0per_cpu_pages"..., 8192) = 8192
read(7, "st\0__s8\0vm_start\0height\0lock_man"..., 4096) = 4096
_llseek(4, -3140, [168892], SEEK_CUR)   = 0
write(4, "\254\1\0\0\334\1\0\0,\2\0\0\\\2\0\0\0\0\0\0\0\0\0\0t\2"...,
136) = 136
_llseek(4, 118784, [118784], SEEK_SET)  = 0
read(4, "ric/reset.c\0platform_enable_wake"..., 4096) = 4096
_llseek(4, -2781, [120099], SEEK_CUR)   = 0
write(4, "dqio_mutex\0f_ep_lock\0f_gid\0trunc"..., 8192) = 8192
write(4, "aio_write\0close\0bd_disk\0prev\0vm_"..., 227) = 227
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(8, 0, [0], SEEK_SET)            = 0
read(8, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -672, [7520], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3644, [168388], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\3\200\370\377\377\377\0\0\0\0\0\0\0\0(\1\0"...,
96) = 96
_llseek(4, 106496, [106496], SEEK_SET)  = 0
read(4, "\0\21\25\1\1\23\'\f\0\0\22&\0I\23\0\0\23.\0?\f\3\16:\v"...,
4096) = 4096
read(8, "@\17\0\0<\27]\t\262\16\0\0\27_`\0\0\0\2\20\0\tJ\r\0\0\27"...,
12288) = 12288
read(8, "4<\0\0\33\202<\0\0\1!\0\0\0\30\t2\0\0\30!\0\0\0\30(\0\0"...,
4096) = 4096
_llseek(4, -2444, [108148], SEEK_CUR)   = 0
write(4, "\1\21\1\20\6R\1%\16\23\v\3\16\33\16\0\0\2$\0\3\10\v\v>"...,
750) = 750
_llseek(4, 28672, [28672], SEEK_SET)    = 0
read(4, "A\362&\0\0\0014\0012\1\0\0\371\2\0\0\0C\302C\0\0\206B\0"...,
4096) = 4096
_llseek(4, -3512, [29256], SEEK_CUR)    = 0
write(4, "\370B\0\0\2\0001\7\0\0\4\1k\7\0\0\0\0\0\0Q:\0\0\1#7\0\0"...,
16384) = 16384
write(4, "\1\1)\26?\0\0\5=\17@\0\0\1\1\4G\0\0\0)\273+\0\0\0069G\0"...,
764) = 764
_llseek(4, 110592, [110592], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(8, 20480, [20480], SEEK_SET)    = 0
_llseek(4, -1463, [113225], SEEK_CUR)   = 0
write(4, "\247\3\0\0\2\0\372\2\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1"...,
939) = 939
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -1388, [6804], SEEK_CUR)     = 0
write(4, "memsize\0<4>memsize not set in bo"..., 100) = 100
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -820, [3276], SEEK_CUR)      = 0
write(4, "\0\0\4<\330\376\275\'\0\0\204$ \1\277\257\34\1\261\257"...,
704) = 704
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -940, [117844], SEEK_CUR)    = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\30\0\0\0$\1\0"...,
112) = 112
_llseek(4, 163840, [163840], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2541, [165395], SEEK_CUR)   = 0
write(4, "\34\6\0\0$\6\0\0\3\0\215\330}$\6\0\0t\7\0\0\2\0\215\0t"...,
313) = 313
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 4096) = 4096
_llseek(4, -3936, [8352], SEEK_CUR)     = 0
write(4, "`\0\0\0\2\0(P\0\0\374B\0\0jA\0\0physical_memsi"..., 100) = 100
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -312, [7880], SEEK_CUR)      = 0
write(4, "4\0\0\0\2\0(P\0\0\4\0\0\0\0\0\360\3\0\0\0\0\0\0\34\6\0"...,
56) = 56
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
read(8, "ink\0release_dquot\0dqb_bsoftlimit"..., 8192) = 8192
read(8, "y\0aio_fsync\0dq_op\0\0GCC: (GNU) 4."..., 4096) = 4096
_llseek(4, -3004, [169028], SEEK_CUR)   = 0
write(4, "\324\7\0\0\340\7\0\0\354\7\0\0\20\10\0\0\0\0\0\0\0\0\0"...,
24) = 24
_llseek(4, 126976, [126976], SEEK_SET)  = 0
read(4, "it_unfrozen\0vm_stat_diff\0d_delet"..., 4096) = 4096
_llseek(4, -2554, [128518], SEEK_CUR)   = 0
write(4, "dqio_mutex\0f_ep_lock\0f_gid\0trunc"..., 8192) = 8192
write(4, "_start\0height\0lock_manager_opera"..., 65) = 65
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(4, -632, [7560], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3548, [168484], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\35\0\0"...,
64) = 64
_llseek(4, 106496, [106496], SEEK_SET)  = 0
read(4, "\0\21\25\1\1\23\'\f\0\0\22&\0I\23\0\0\23.\0?\f\3\16:\v"...,
4096) = 4096
_llseek(4, -1694, [108898], SEEK_CUR)   = 0
write(4, "\1\21\1\20\6R\1%\16\23\v\3\16\33\16\0\0\2$\0\3\10\v\v>"...,
250) = 250
_llseek(4, 45056, [45056], SEEK_SET)    = 0
read(4, "UF\0\0\31S$\3\0\0\2\20\10\t=-\0\0\31T\5\30\0\0\2\20\f\0"...,
4096) = 4096
_llseek(4, -2748, [46404], SEEK_CUR)    = 0
write(4, "x\1\0\0\2\0\37\n\0\0\4\1\26\v\0\0\0\0\0\0\264H\0\0\1EI"...,
380) = 380
_llseek(4, 110592, [110592], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(9, 4096, [4096], SEEK_SET)      = 0
_llseek(4, -524, [114164], SEEK_CUR)    = 0
write(4, "\241\0\0\0\2\0a\0\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1ar"...,
165) = 165
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -116, [3980], SEEK_CUR)      = 0
write(4, "\0\0\2<\10\0\340\3\0\0B$\320\377\275\'\34\0\263\257(\0"...,
116) = 116
write(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
136) = 136
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -828, [117956], SEEK_CUR)    = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\f\0\0\0\224\1"...,
68) = 68
_llseek(4, 163840, [163840], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2228, [165708], SEEK_CUR)   = 0
write(4, "\350\10\0\0\354\10\0\0\2\0\215P\354\10\0\0008\t\0\0\2\0"...,
177) = 177
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 4096) = 4096
_llseek(4, -3836, [8452], SEEK_CUR)     = 0
write(4, "8\0\0\0\2\0$\223\0\0|\1\0\0\312\0\0\0prom_getcmdlin"..., 60) =
60
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -256, [7936], SEEK_CUR)      = 0
write(4, ",\0\0\0\2\0$\223\0\0\4\0\0\0\0\0\360\3\0\0\0\0\0\0\334"...,
48) = 48
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2980, [169052], SEEK_CUR)   = 0
write(4, "X\t\0\0\\\t\0\0d\t\0\0x\t\0\0\0\0\0\0\0\0\0\0", 24) = 24
_llseek(4, 135168, [135168], SEEK_SET)  = 0
read(4, "active_list\0direct_IO\0ra_pages\0s"..., 4096) = 4096
_llseek(4, -2489, [136775], SEEK_CUR)   = 0
write(4, "prom_init_cmdline\0short int\0/usr"..., 355) = 355
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -592, [7600], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 221184, [221184], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 3216
_llseek(10, 0, [0], SEEK_SET)           = 0
read(10, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\3\0\"\0\1\0\0\0\0\0\0\0\0\0\0"...,
544) = 544
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3008, [1088], SEEK_CUR)     = 0
write(4, "\350\377\275\'\20\0\277\257\0\0\0\f\0\0\0\0\0\0\2<\324"...,
576) = 576
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(10, 4096, [4096], SEEK_SET)     = 0
_llseek(4, -1120, [7072], SEEK_CUR)     = 0
write(4, "\0\0\0\0 \4\0\0\0\0\0\0008\1\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
32) = 32
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3484, [168548], SEEK_CUR)   = 0
write(4, "\360\3\0\0\0\0\0\200\370\377\377\377\0\0\0\0\0\0\0\0\30"...,
256) = 256
_llseek(4, 106496, [106496], SEEK_SET)  = 0
read(4, "\0\21\25\1\1\23\'\f\0\0\22&\0I\23\0\0\23.\0?\f\3\16:\v"...,
4096) = 4096
read(10, "\27f\3;\0\0\0\3\20\230\1\25\347\7\0\0\27g\3;\0\0\0\3\20"...,
28672) = 28672
read(10, "\0\0\2+\1\1\0036irq\0\2*\1M\0\0\0007n1\0\0\2,\1\3123\0"...,
4096) = 4096
_llseek(4, -1444, [109148], SEEK_CUR)   = 0
write(4, "\1\21\1\20\6R\1%\16\23\v\3\16\33\16\0\0\2$\0\3\16\v\v>"...,
1111) = 1111
_llseek(4, 45056, [45056], SEEK_SET)    = 0
read(4, "UF\0\0\31S$\3\0\0\2\20\10\t=-\0\0\31T\5\30\0\0\2\20\f\0"...,
4096) = 4096
_llseek(4, -2368, [46784], SEEK_CUR)    = 0
write(4, "\222\203\0\0\2\0\31\v\0\0\4\1\273\v\0\0\0\0\0\0\7r\0\0"...,
32768) = 32768
read(10, "o.h\0\3\0\0siginfo.h\0\4\0\0task_io_acco"..., 4096) = 4096
write(4, "\0\0\5\277\1\3N\36\203\0\0\5\276(\0\0\0L\351J\0\0\5\300"...,
918) = 918
_llseek(4, 110592, [110592], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -359, [114329], SEEK_CUR)    = 0
write(4, "\26\7\0\0\2\0%\5\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1arc"...,
359) = 359
_llseek(10, 40960, [40960], SEEK_SET)   = 0
write(4, "tomic.h\0\3\0\0atomic.h\0\4\0\0wait.h\0\2\0"..., 1459) = 1459
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -1288, [6904], SEEK_CUR)     = 0
write(4, "performance\0CPU frequency %d.%02"..., 40) = 40
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -3960, [4232], SEEK_CUR)     = 0
write(4, "\350\377\275\'\20\0\260\257\24\0\277\257\0\0\2<\10\0C\214"...,
1380) = 1380
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "tomic.h\0\3\0\0atomic.h\0\4\0\0wait.h\0\2\0"..., 4096) = 4096
_llseek(4, -760, [118024], SEEK_CUR)    = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\24\0\0\0\330"...,
228) = 228
_llseek(4, 163840, [163840], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2051, [165885], SEEK_CUR)   = 0
write(4, "\360\3\0\0\364\3\0\0\2\0\215h\364\3\0\0h\4\0\0\2\0\215"...,
1377) = 1377
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 4096) = 4096
_llseek(4, -3776, [8512], SEEK_CUR)     = 0
write(4, "\221\0\0\0\2\0\240\224\0\0\226\203\0\0\215x\0\0mips_ti"...,
149) = 149
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -208, [7984], SEEK_CUR)      = 0
write(4, "<\0\0\0\2\0\240\224\0\0\4\0\0\0\0\0\360\3\0\0<\2\0\0\330"...,
64) = 64
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
read(10, "ermitted\0unsigned char\0rmdir\0num"..., 12288) = 12288
read(10, "mapping\0irix_trampoline\0cap_inhe"..., 4096) = 4096
_llseek(4, -2956, [169076], SEEK_CUR)   = 0
write(4, "8\4\0\0d\4\0\0p\4\0\0x\4\0\0\0\0\0\0\0\0\0\0\340\5\0\0"...,
136) = 136
_llseek(4, 135168, [135168], SEEK_SET)  = 0
read(4, "active_list\0direct_IO\0ra_pages\0s"..., 4096) = 4096
_llseek(4, -2134, [137130], SEEK_CUR)   = 0
write(4, "d_revalidate\0cap_permitted\0unsig"..., 12288) = 12288
write(4, "e_t\0user_struct\0i_mapping\0irix_t"..., 2513) = 2513
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(4, -552, [7640], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(4, -2432, [1664], SEEK_CUR)     = 0
write(4, "\0\0\2<\0\0E\214 $\4|\375\3\243$\0\0b\220 \0B0\375\377"...,
48) = 48
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3228, [168804], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\35\0\0"...,
32) = 32
_llseek(4, 106496, [106496], SEEK_SET)  = 0
read(4, "\0\21\25\1\1\23\'\f\0\0\22&\0I\23\0\0\23.\0?\f\3\16:\v"...,
4096) = 4096
_llseek(4, -333, [110259], SEEK_CUR)    = 0
write(4, "\1\21\1\20\6\22\1\21\1%\16\23\v\3\16\33\16\0\0\2$\0\3\16"...,
333) = 333
write(4, "\0\32\5\0001\23\0\0\33\35\0011\23\21\1\22\1\0\0\34\v\1"...,
61) = 61
_llseek(4, 77824, [77824], SEEK_SET)    = 0
read(4, "\0\0 \2\0\0\2\215\0Birq\0\1\371;\0\0\0\302\10\0\0C\252"...,
4096) = 4096
_llseek(4, -1450, [80470], SEEK_CUR)    = 0
write(4, "\251\3\0\0\2\0p\17\0\0\4\1\325\22\0\0\\\6\0\0000\6\0\0"...,
941) = 941
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "tomic.h\0\3\0\0atomic.h\0\4\0\0wait.h\0\2\0"..., 4096) = 4096
_llseek(11, 4096, [4096], SEEK_SET)     = 0
_llseek(4, -2637, [116147], SEEK_CUR)   = 0
write(4, "\302\0\0\0\2\0\214\0\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1"...,
198) = 198
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "tomic.h\0\3\0\0atomic.h\0\4\0\0wait.h\0\2\0"..., 4096) = 4096
_llseek(4, -532, [118252], SEEK_CUR)    = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\f\0\0\0\274\2"...,
32) = 32
_llseek(4, 163840, [163840], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -674, [167262], SEEK_CUR)    = 0
write(4, " \0\0\0$\0\0\0\1\0R\0\0\0\0\0\0\0\0", 19) = 19
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 4096) = 4096
_llseek(4, -3627, [8661], SEEK_CUR)     = 0
write(4, "\37\0\0\0\2\0006\30\1\0\255\3\0\0\0\3\0\0prom_putchar\0"...,
35) = 35
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -144, [8048], SEEK_CUR)      = 0
write(4, "\34\0\0\0\2\0006\30\1\0\4\0\0\0\0\0000\6\0\0,\0\0\0\0\0"...,
32) = 32
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2820, [169212], SEEK_CUR)   = 0
write(4, "\0\0\0\0\10\0\0\0\f\0\0\0\24\0\0\0\0\0\0\0\0\0\0\0", 24) = 24
_llseek(4, 151552, [151552], SEEK_SET)  = 0
read(4, "ve\0mkobj\0bd_holders\0short int\0ch"..., 4096) = 4096
_llseek(4, -3717, [151931], SEEK_CUR)   = 0
write(4, "ases\0flush_data_cache_page\0lines"..., 592) = 592
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(12, 0, [0], SEEK_SET)           = 0
read(12, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -512, [7680], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(12, 4096, [4096], SEEK_SET)     = 0
_llseek(4, -1088, [7104], SEEK_CUR)     = 0
write(4, "\0\0\0\0\0\0\0\0`\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
336) = 336
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -3196, [168836], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\35\0\0"...,
32) = 32
_llseek(4, 110592, [110592], SEEK_SET)  = 0
read(4, "\0\32\5\0001\23\0\0\33\35\0011\23\21\1\22\1\0\0\34\v\1"...,
4096) = 4096
read(12, "\245\1\0\0\5\260\v\0\0\5\202\0\0\0\5\217\1\0\0\5\232\1"...,
20480) = 20480
read(12, "\35R\20\7\0\0\2\20\0\n\241\1\0\0\35Sq\2\0\0\2\20\10\nh"...,
4096) = 4096
_llseek(4, -4035, [110653], SEEK_CUR)   = 0
write(4, "\1\21\1\20\6R\1%\16\23\v\3\16\33\16\0\0\2$\0\3\16\v\v>"...,
673) = 673
_llseek(4, 77824, [77824], SEEK_SET)    = 0
read(4, "\0\0 \2\0\0\2\215\0Birq\0\1\371;\0\0\0\302\10\0\0C\252"...,
4096) = 4096
_llseek(4, -509, [81411], SEEK_CUR)     = 0
write(4, "<a\0\0\2\0\372\20\0\0\4\1\233\23\0\0\0\0\0\0\263\244\0"...,
24576) = 24576
write(4, "\1-\213\237\0\0A\r(\0\0\0\1\1-G\242\0\0B\"(\0\0\0\1\1-"...,
320) = 320
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "tomic.h\0\3\0\0atomic.h\0\4\0\0wait.h\0\2\0"..., 4096) = 4096
_llseek(4, -2439, [116345], SEEK_CUR)   = 0
write(4, "\263\4\0\0\2\0\347\3\0\0\1\1\373\16\n\0\1\1\1\1\0\0\0\1"...,
1207) = 1207
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -1248, [6944], SEEK_CUR)     = 0
write(4, "MSC PCI I/O\0MSC PCI MEM\0Bonito P"..., 96) = 96
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -2580, [5612], SEEK_CUR)     = 0
write(4, "\0\0\2<\0\0C\214\6\0c$\t\0b,:\0@\20\1\0\2$\4 b\0\203\1"...,
928) = 928
_llseek(4, 114688, [114688], SEEK_SET)  = 0
read(4, "tomic.h\0\3\0\0atomic.h\0\4\0\0wait.h\0\2\0"..., 4096) = 4096
read(12, "\3\0\0\1\0V\220\3\0\0\230\3\0\0\1\0V\0\0\0\0\0\0\0\0D\0"...,
4096) = 4096
_llseek(4, -500, [118284], SEEK_CUR)    = 0
write(4, "\f\0\0\0\377\377\377\377\1\0\1|\37\f\35\0\f\0\0\0\334\2"...,
32) = 32
_llseek(4, 163840, [163840], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -655, [167281], SEEK_CUR)    = 0
write(4, "0\20\0\0008\20\0\0\1\0X\304\20\0\0\4\21\0\0\1\0X\34\21"...,
655) = 655
write(4, "\20\0\0\1\0T\264\22\0\0\324\22\0\0\1\0T\0\0\0\0\0\0\0\0"...,
99) = 99
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "ssage\0\315\4\0\0mips_display_message\0\0"..., 4096) = 4096
_llseek(4, -3592, [8696], SEEK_CUR)     = 0
write(4, "$\0\0\0\2\0\343\33\1\0@a\0\0\\`\0\0mips_pcibios_i"..., 40) =
40
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -112, [8080], SEEK_CUR)      = 0
write(4, "$\0\0\0\2\0\343\33\1\0\4\0\0\0\0\0`\6\0\0\0\0\0\0<\17\0"...,
40) = 40
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\20\0\0\1\0T\264\22\0\0\324\22\0\0\1\0T\0\0\0\0\0\0\0\0"...,
4096) = 4096
read(12, "eqcount_t\0statfs\0attrs\0pci_chann"..., 4096) = 4096
read(12, "xquota\0num_unused_gpl_syms\0ahead"..., 4096) = 4096
_llseek(4, -2796, [169236], SEEK_CUR)   = 0
write(4, "\374\17\0\0\4\20\0\0\10\20\0\0\f\20\0\0\0\0\0\0\0\0\0\0"...,
48) = 48
_llseek(4, 151552, [151552], SEEK_SET)  = 0
read(4, "ve\0mkobj\0bd_holders\0short int\0ch"..., 4096) = 4096
_llseek(4, -3125, [152523], SEEK_CUR)   = 0
write(4, "put_inode\0cpu_callout_map\0num_sy"..., 8192) = 8192
write(4, "mips_pcibios_init\0show_stats\0gt6"..., 3314) = 3314
_llseek(4, 4096, [4096], SEEK_SET)      = 0
read(4, "\0\0C\216\200 \21\0!0\0\2!\30d\0\0\0b\214\0\0A\220\1\0"...,
4096) = 4096
_llseek(4, -472, [7720], SEEK_CUR)      = 0
write(4, "\0GCC: (GNU) 4.0.0 (DENX ELDK 4.1"..., 40) = 40
_llseek(4, 221184, [221184], SEEK_SET)  = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 3760
write(4, "\314\1\0\0\324\1\0\0\4\0\0\0\1\0\v\0\337\1\0\0\230\5\0"...,
336) = 336
brk(0x81d1000)                          = 0x81d1000
brk(0x81d0000)                          = 0x81d0000
write(4, "Z\3\0\0\0\0\0\0\0\0\0\0\20\0\0\0r\3\0\0\0\0\0\0\0\0\0\0"...,
3474) = 3474
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -4044, [52], SEEK_CUR)       = 0
write(4, "<\0\0\200\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 24) = 24
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -4024, [72], SEEK_CUR)       = 0
write(4, "\357\177\0\0", 4)             = 4
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\20\0\0\1\0T\264\22\0\0\324\22\0\0\1\0T\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -1064, [170968], SEEK_CUR)   = 0
write(4, "\0\0\0\0\5\2\0\0\4\0\0\0\6\2\0\0\10\0\0\0\5\2\0\0\20\0"...,
1064) = 1064
write(4, "X\1\0\0\6X\0\0T\1\0\0\5\247\0\0\\\1\0\0\6\247\0\0`\1\0"...,
4096) = 4096
write(4, "B\10\0\0\2\30\0\0U\10\0\0\2\30\0\0\\\10\0\0\2\2\0\0`\10"...,
40960) = 40960
write(4, "Sl\1\0\2\30\0\0bl\1\0\2\30\0\0ql\1\0\2\30\0\0\200l\1\0"...,
4096) = 4096
write(4, "\0\t\0\0\2\2\0\0\4\t\0\0\2\2\0\0\f\t\0\0\2\2\0\0\20\t\0"...,
2672) = 2672
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\20\0\0\1\0T\264\22\0\0\324\22\0\0\1\0T\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2748, [169284], SEEK_CUR)   = 0
write(4, "\0.symtab\0.strtab\0.shstrtab\0.regi"..., 281) = 281
_llseek(4, 0, [0], SEEK_SET)            = 0
write(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\10\0\1\0\0\0\0\0\0"...,
52) = 52
_llseek(4, 167936, [167936], SEEK_SET)  = 0
read(4, "\20\0\0\1\0T\264\22\0\0\324\22\0\0\1\0T\0\0\0\0\0\0\0\0"...,
4096) = 4096
_llseek(4, -2464, [169568], SEEK_CUR)   = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1400) = 1400
close(4)                                = 0
munmap(0xb7f88000, 4096)                = 0
brk(0x81cf000)                          = 0x81cf000
brk(0x81c9000)                          = 0x81c9000
brk(0x81be000)                          = 0x81be000
brk(0x81b3000)                          = 0x81b3000
brk(0x81b2000)                          = 0x81b2000
exit_group(0)                           = ?
Process 8199 detached
[tehkok@linux2:/usr/src/linux-source-2.6.22_mips 6]$
