Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 10:34:49 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:48847 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8225334AbUJHJeo>; Fri, 8 Oct 2004 10:34:44 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i989UTGG024461
	for <linux-mips@linux-mips.org>; Fri, 8 Oct 2004 15:00:30 +0530
Message-ID: <41665DEA.3090307@procsys.com>
Date: Fri, 08 Oct 2004 14:59:14 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: mips linux glibc-2.3.3 build - linker errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,

glibc-2.3.3 build on linux-mips breaks down with following linker error:

sara@eyeore: [over] ~/build/glibc/objdir6$ make
make -r PARALLELMFLAGS="" CVSOPTS="" -C ../glibc-2.3.3 objdir=`pwd` all
make[1]: Entering directory `/home/sara/build/glibc/glibc-2.3.3'
make  -C csu subdir_lib
.
.
.
make[4]: Nothing to be done for `rtld-all'.
make[4]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/time'
make[3]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/elf'
make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/elf'
gcc -mabi=32   -nostdlib -nostartfiles -r -o 
/home/sara/build/glibc/objdir6/libc_pic.os \
 -Wl,-d -Wl,--whole-archive /home/sara/build/glibc/objdir6/libc_pic.a
/home/sara/build/glibc/objdir6/libc_pic.a(strtold_l.os)(.text+0x0): In 
function `*__GI___strtold_internal':
../sysdeps/generic/strtold.c:25: multiple definition of 
`__GI___strtold_internal'
/home/sara/build/glibc/objdir6/libc_pic.a(strtold.os)(.text+0x0):../sysdeps/generic/strtold.c:25: 
first defined here
/home/sara/build/glibc/objdir6/libc_pic.a(strtold_l.os)(.text+0x0): In 
function `*__GI___strtold_internal':
../sysdeps/generic/strtold.c:25: multiple definition of `__strtold_internal'
/home/sara/build/glibc/objdir6/libc_pic.a(strtold.os)(.text+0x0):../sysdeps/generic/strtold.c:25: 
first defined here
/home/sara/build/glibc/objdir6/libc_pic.a(strtold_l.os)(.text+0x38): In 
function `strtold':
../sysdeps/generic/strtold.c:32: multiple definition of `strtold'
/home/sara/build/glibc/objdir6/libc_pic.a(strtold.os)(.text+0x38):../sysdeps/generic/strtold.c:32: 
first defined here
collect2: ld returned 1 exit status
make[1]: *** [/home/sara/build/glibc/objdir6/libc_pic.os] Error 1
make[1]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3'
make: *** [all] Error 2

I tried to compare against the latest CVS - the files have involved have 
seemed to be
renamed/deleted etc.  So it is difficult to follow the changes. 

Does somebody know to a fix to get ahead?

More information follows.

Changes made to glibc-2.2.3:

diff -r -u orig/glibc-2.3.3/sysdeps/mips/dl-machine.h 
glibc-2.3.3/sysdeps/mips/dl-machine.h
--- orig/glibc-2.3.3/sysdeps/mips/dl-machine.h    Thu Jul 31 12:03:52 2003
+++ glibc-2.3.3/sysdeps/mips/dl-machine.h    Tue Oct  5 16:19:22 2004
@@ -474,7 +474,7 @@
     " STRINGXP(PTR_LA) " $25, _dl_start_user\n\
     .globl _dl_start_user\n\
     .type _dl_start_user,@function\n\
-    .ent _dl_start_user\n\
+    .aent _dl_start_user\n\
 _dl_start_user:\n\
     " STRINGXP(SETUP_GP) "\n\
     " STRINGXV(SETUP_GP64($18,_dl_start_user)) "\n\
@@ -512,8 +512,7 @@
     " STRINGXP(PTR_LA) " $2, _dl_fini\n\
     # Jump to the user entry point.\n\
     move $25, $17\n\
-    jr $25\n\
-    .end _dl_start_user\n\t"\
+    jr $25\n\t"\
     _RTLD_EPILOGUE(ENTRY_POINT)\
     ".previous"\
 );
diff -r -u orig/glibc-2.3.3/sysdeps/mips/machine-gmon.h 
glibc-2.3.3/sysdeps/mips/machine-gmon.h
--- orig/glibc-2.3.3/sysdeps/mips/machine-gmon.h    Mon Mar 17 21:23:37 2003
+++ glibc-2.3.3/sysdeps/mips/machine-gmon.h    Wed Oct  6 09:47:36 2004
@@ -1,5 +1,5 @@
 /* Machine-specific calling sequence for `mcount' profiling function.  MIPS
-   Copyright (C) 1996, 1997, 2000, 2001, 2002, 2003
+   Copyright (C) 1996, 1997, 2000, 2001, 2002, 2003, 2004
     Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
@@ -18,6 +18,8 @@
    Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA.  */
 
+#include <sgidefs.h>
+
 #define _MCOUNT_DECL(frompc,selfpc) \
 static void __attribute_used__ __mcount (u_long frompc, u_long selfpc)
 
@@ -81,10 +83,10 @@
 # define CPRETURN
 #endif
 
-#if defined _ABIN32 && _MIPS_SIM == _ABIN32
+#if _MIPS_SIM == _MIPS_SIM_NABI32
 # define PTR_ADDU_STRING "add" /* no u */
 # define PTR_SUBU_STRING "sub" /* no u */
-#elif defined _ABI64 && _MIPS_SIM == _ABI64
+#elif _MIPS_SIM == _MIPS_SIM_ABI64
 # define PTR_ADDU_STRING "daddu"
 # define PTR_SUBU_STRING "dsubu"
 #else


System details:

Host type: mipsel-unknown-linux-gnu
System: Linux eyeore 2.4.25 #20 Wed Sep 29 09:01:29 IST 2004 mips unknown
Architecture: mips

Addons: linuxthreads
Build CFLAGS: -mips32 -O2 -g
Build CC: gcc
Compiler version: 3.4.2
Kernel headers: 2.4.25
Symbol versioning: yes
Build static: yes
Build shared: yes
Build pic-default: yes
Build profile: yes
Build omitfp: no
Build bounded: no
Build static-nss: no

sara@eyeore: [over] ~/tmp$ cat /proc/cpuinfo
system type             : ITE QED-4N-S01B
processor               : 0
cpu model               : Nevada V3.1  FPU V3.0
BogoMIPS                : 299.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 48
extra interrupt vector  : yes
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available

-Sa.
