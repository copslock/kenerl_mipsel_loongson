Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 10:56:20 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:182 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224831AbUJEJ4P>; Tue, 5 Oct 2004 10:56:15 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i959qKGG017805
	for <linux-mips@linux-mips.org>; Tue, 5 Oct 2004 15:22:22 +0530
Message-ID: <41626E7D.2070405@procsys.com>
Date: Tue, 05 Oct 2004 15:20:53 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: mips linux glibc-2.3.3 build - Assembler errors in rtld.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,

glibc-2.2.3 build on mips linux breaks with following assembler errors:

sara@eyeore: [over] ~/build/glibc/objdir5$ make
make -r PARALLELMFLAGS="" CVSOPTS="" -C ../glibc-2.3.3 objdir=`pwd` all
make[1]: Entering directory `/home/sara/build/glibc/glibc-2.3.3'
.
.
.
make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/login'
make  -C elf subdir_lib
make[2]: Entering directory `/home/sara/build/glibc/glibc-2.3.3/elf'
.
.
.
gcc -mabi=32 rtld.c -c -std=gnu99 -O2 -Wall -Winline -Wstrict-prototypes 
-Wwrite-strings -g -mips32   -fPIC    -I../include -I. 
-I/home/sara/build/glibc/objdir5/elf -I.. -I../libio  
-I/home/sara/build/glibc/objdir5 -I../sysdeps/mips/elf 
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
-D_LIBC_REENTRANT -include ../include/libc-symbols.h  -DPIC -DSHARED 
-DNOT_IN_libc=1 -DIS_IN_rtld=1     -o 
/home/sara/build/glibc/objdir5/elf/rtld.os -MD -MP -MF 
/home/sara/build/glibc/objdir5/elf/rtld.os.dt
/tmp/ccNhjRu0.s: Assembler messages:
/tmp/ccNhjRu0.s:48: Warning: missing .end
/tmp/ccNhjRu0.s:80: Warning: No .frame pseudo-op used in PIC code
/tmp/ccNhjRu0.s:88: Warning: .end directive without a preceding .ent 
directive.
/tmp/ccNhjRu0.s:88: Error: junk at end of line, first unrecognized 
character is `.'
make[2]: *** [/home/sara/build/glibc/objdir5/elf/rtld.os] Error 1
make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/elf'
make[1]: *** [elf/subdir_lib] Error 2
make[1]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3'
make: *** [all] Error 2

More details:

Changes made to the base code:  replaced sysdeps/mips/machine-gmon.h with
the CVS copy (libc/sysdeps/mips/machine-gmon.h revision:1.1).

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

-Saravanan
