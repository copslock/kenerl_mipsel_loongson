Received:  by oss.sgi.com id <S553746AbRCDUgn>;
	Sun, 4 Mar 2001 12:36:43 -0800
Received: from cassidy.nuernberg.linuxtag.net ([212.204.83.80]:44303 "HELO
        cassidy.nuernberg.linuxtag.net") by oss.sgi.com with SMTP
	id <S553740AbRCDUg3>; Sun, 4 Mar 2001 12:36:29 -0800
Received: from hydra.linuxtag.uni-kl.de (hydra.hq.linuxtag.net [192.168.0.1])
	by cassidy.nuernberg.linuxtag.net (Postfix) with ESMTP id 5859EEC2AB
	for <linux-mips@oss.sgi.com>; Sun,  4 Mar 2001 21:33:33 +0100 (CET)
Received: by hydra.linuxtag.uni-kl.de (Postfix, from userid 1034)
	id 50C4F1B65; Sun,  4 Mar 2001 21:36:09 +0100 (CET)
Date:   Sun, 4 Mar 2001 21:36:09 +0100
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@oss.sgi.com
Subject: build-problems: GNU fileutils 4.01 on mipsel with glibc 2.2.2
Message-ID: <20010304213609.B25825@linuxtag.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hallo everyone,

I am trying to get the components for a Debian mipsel-base.tgz built,
based on glibc-2.2.2. I am working in a chroot()-environment, where I have
installed glibc 2.2.2, binutils 2.10.91 and gcc 2.95.3 as precompiled
binaries, all from Maciej's packages (glibc-2.2.2-2.mipsel.rpm,
gcc-2.95.3-14.mipsel.rpm, binutils-2.10.91-1.mipsel.rpm plus devel and
dependency packages). Gawk and perl are self-compiled inside the
chroot()-environment. When trying to compile fileutils, the ./configure
starts ok, but when coming to "checking for working mktime..." the script
just hangs forever, and according to top there is nothing consuming CPU
time (except for top itself). Compiling the fileutils on the "host
system", i.e. outside the chroot()-environment using egcs-1.0.3a and
glibc-2.0.6 the problem does not appear. Can anybody confirm this on
another system? Any ideas what can be the reason for this?

The system:

bash> cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : R4000SC V3.0
system type             : Digital DECstation 5000/1xx
BogoMIPS                : 49.75
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 360569
VCEI exceptions         : 14106

bash> gcc -v
Reading specs from /usr/lib/gcc-lib/mipsel-linux/2.95.3/specs
gcc version 2.95.3 19991030 (prerelease)

Kernel is 2.4.1 fresh from cvs.

The output from ./configure:
creating cache ./config.cache
checking host system type... mipsel-unknown-linux-gnu
checking for a BSD compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for mawk... no
checking for gawk... gawk
checking whether make sets ${MAKE}... yes
checking for perl5.003 or newer... yes
checking for gcc... gcc
checking whether the C compiler (gcc   ) works... yes
checking whether the C compiler (gcc   ) is a cross-compiler... no
checking whether we are using GNU C... yes
checking whether gcc accepts -g... yes
checking how to run the C preprocessor... gcc -E
checking dependency style of gcc... gcc
checking how to run the C preprocessor... gcc -E
checking whether gcc needs -traditional... no
checking for ranlib... ranlib
checking for AIX... no
checking for minix/config.h... no
checking build system type... mipsel-unknown-linux-gnu
checking for getconf... getconf
checking for CFLAGS value to request large file support... -D_FILE_OFFSET_BITS=64
checking for LDFLAGS value to request large file support... 
checking for LIBS value to request large file support... 
checking for _FILE_OFFSET_BITS... 64
checking for _LARGEFILE_SOURCE... no
checking for _LARGE_FILES... no
checking for gcc option to accept ANSI C... none needed
checking for function prototypes... yes
checking whether sys/types.h defines makedev... yes
checking for dirent.h that defines DIR... yes
checking for opendir in -ldir... no
checking whether closedir returns void... no
checking for inttypes.h... yes
checking for unsigned long long... yes
checking for gcc option to accept ANSI C... none needed
checking for uid_t in sys/types.h... yes
checking whether byte ordering is bigendian... no
checking for an ANSI C conforming const... yes
checking for inline... inline
checking for long double... yes
checking for dirent.h that defines DIR... (cached) yes
checking for opendir in -ldir... (cached) no
checking for ANSI C header files... yes
checking for struct stat.st_blksize... no
checking for struct stat.st_blocks... yes
checking whether struct tm is in sys/time.h or time.h... time.h
checking whether time.h and sys/time.h may both be included... yes
checking for struct tm.tm_zone... yes
checking whether stat file-mode macros are broken... no
checking for nanoseconds member of struct stat.st_mtim... no
checking for st_dm_mode in struct stat... no
checking type of array argument to getgroups... gid_t
checking for mode_t... yes
checking for off_t... yes
checking for pid_t... yes
checking return type of signal handlers... void
checking for size_t... yes
checking for uid_t in sys/types.h... (cached) yes
checking for ino_t... yes
checking for ssize_t... yes
checking for library containing clock_gettime... -lrt
checking for fdatasync... yes
checking for clock_gettime... yes
checking for long file names... yes
checking for pathconf... yes
checking for string.h... yes
checking for fcntl.h... yes
checking for limits.h... yes
checking for sys/time.h... yes
checking for sys/timeb.h... yes
checking for errno.h... yes
checking for unistd.h... yes
checking for stdlib.h... yes
checking for sys/param.h... yes
checking for sys/statfs.h... yes
checking for sys/fstyp.h... no
checking for mnttab.h... no
checking for mntent.h... yes
checking for utime.h... yes
checking for sys/statvfs.h... yes
checking for sys/vfs.h... yes
checking for sys/mntent.h... no
checking for sys/mount.h... yes
checking for sys/filsys.h... no
checking for sys/fs_types.h... no
checking for sys/acl.h... no
checking for sys/wait.h... yes
checking for sys/ioctl.h... yes
checking for sys/fs/s5param.h... no
checking for termios.h... yes
checking for values.h... yes
checking for euidaccess... yes
checking for memcpy... yes
checking for memcmp... yes
checking for memset... yes
checking for sys/time.h... (cached) yes
checking for unistd.h... (cached) yes
checking for alarm... yes
checking for working mktime... 
[hanging forever]

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der
Nutzung oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die
Markt- oder Meinungsforschung.
