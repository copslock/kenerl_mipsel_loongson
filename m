Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2004 06:55:15 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:18365 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224895AbUJDFzK>; Mon, 4 Oct 2004 06:55:10 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i945pNGG013207
	for <linux-mips@linux-mips.org>; Mon, 4 Oct 2004 11:21:24 +0530
Message-ID: <4160E489.6010503@procsys.com>
Date: Mon, 04 Oct 2004 11:20:01 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: mips linux glibc-2.3.3 build - Unknown ABI problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,

When I try to build glibc-2.3.3 on mips linux - it breaks as shown below:

.
.
.
sara@eyeore: [over] ~/build/glibc/objdir3$ make
make -r PARALLELMFLAGS="" CVSOPTS="" -C ../glibc-2.3.3 objdir=`pwd` all
make[1]: Entering directory `/home/sara/build/glibc/glibc-2.3.3'
make  -C csu subdir_lib
.
.
.
make  -C gmon subdir_lib
make[2]: Entering directory `/home/sara/build/glibc/glibc-2.3.3/gmon'
make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/gmon'
make[2]: Entering directory `/home/sara/build/glibc/glibc-2.3.3/gmon'
gcc -mabi=32 mcount.c -c -std=gnu99 -O2 -Wall -Winline 
-Wstrict-prototypes -Wwrite-strings -g -mips32   
-fno-omit-frame-pointer   -I../include -I. 
-I/home/sara/build/glibc/objdir3/gmon -I.. -I../libio  
-I/home/sara/build/glibc/objdir3 -I../sysdeps/mips/elf 
-I../linuxthreads/sysdeps/unix/sysv/linux/mips 
-I../linuxthreads/sysdeps/unix/sysv/linux 
-I../linuxthreads/sysdeps/pthread -I../sysdeps/pthread 
-I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix 
-I../linuxthreads/sysdeps/mips -I../sysdeps/unix/sysv/linux/mips/mips32 
-I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/linux 
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman 
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv 
-I../sysdeps/unix/mips/mips32 -I../sysdeps/unix/mips -I../sysdeps/unix 
-I../sysdeps/posix -I../sysdeps/mips/mips32 -I../sysdeps/mips 
-I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 
-I../sysdeps/wordsize-32 -I../sysdeps/mips/fpu -I../sysdeps/ieee754 
-I../sysdeps/generic/elf -I../sysdeps/generic -nostdinc -isystem 
/home/sara/usr/local/lib/gcc/mipsel-unknown-linux-gnu/3.4.2/include 
-isystem /home/sara/build/linux/linux-2.4.25mips/include 
-D_LIBC_REENTRANT -include ../include/libc-symbols.h  -DPIC     -o 
/home/sara/build/glibc/objdir3/gmon/mcount.o -MD -MP -MF 
/home/sara/build/glibc/objdir3/gmon/mcount.o.dt
In file included from mcount.c:40:
../sysdeps/mips/machine-gmon.h:91:3: #error "Unknown ABI"
mcount.c:180: error: parse error before "PTR_SUBU_STRING"
make[2]: *** [/home/sara/build/glibc/objdir3/gmon/mcount.o] Error 1
make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/gmon'
make[1]: *** [gmon/subdir_lib] Error 2
make[1]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3'
make: *** [all] Error 2



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
sara@eyeore: [over] ~/tmp$



Some experimentation with "gcc -E" revealed that in the compiler I am using
(by default),

_MIPS_SIM is set to 1
_ABI032 is set to 1
_ABIN32 is not defined
_ABI64 is not defined

I tried compiling a "hello world" program with "gcc -mabi=32" and it works.

If I try "gcc -mabi=n32" it breaks at the linking stage as below:

sara@eyeore: [over] ~/tmp$ gcc -mabi=n32 -o v v.c
/home/sara/usr/local/lib/gcc/mipsel-unknown-linux-gnu/3.4.2/../../../../mipsel-unknown-linux-gnu/bin/ld: 
/tmp/ccnz0jlk.o: ABI is incompatible with that of the selected emulation
/home/sara/usr/local/lib/gcc/mipsel-unknown-linux-gnu/3.4.2/../../../../mipsel-unknown-linux-gnu/bin/ld: 
failed to merge target specific data of file /tmp/ccnz0jlk.o
/home/sara/usr/local/lib/gcc/mipsel-unknown-linux-gnu/3.4.2/../../../../mipsel-unknown-linux-gnu/bin/ld: 
BFD 2.15 assertion fail elfxx-mips.c:1899
collect2: ld returned 1 exit status
sara@eyeore: [over] ~/tmp$

What should I do to fix the build?

-Saravanan.
