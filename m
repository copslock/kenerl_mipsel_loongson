Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2004 06:48:00 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:930 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224916AbUI3Fry>; Thu, 30 Sep 2004 06:47:54 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i8U5iSGG006671
	for <linux-mips@linux-mips.org>; Thu, 30 Sep 2004 11:14:32 +0530
Message-ID: <415B9CD2.3070607@procsys.com>
Date: Thu, 30 Sep 2004 11:12:42 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: mips linux glibc-2.3.3 build - opcode not supported problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,

I hope it is OK to post linux mips glibc build problems here.  If not, 
please let me
know an appropriate forum.

---

Host type: mipsel-unknown-linux-gnu
System: Linux eyeore 2.4.25 #20 Wed Sep 29 09:01:29 IST 2004 mips unknown
Architecture: mips

Addons: linuxthreads
Build CFLAGS: -g -O2
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

sara@eyeore:~/tmp$ cat /proc/cpuinfo
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
sara@eyeore:~/tmp$

This is how the build dies:
.
.
.
gcc -mabi=32 ../sysdeps/unix/sysv/linux/mips/_test_and_set.c -c 
-std=gnu99 -O2 -Wall -Winline -Wstrict-prototypes -Wwrite-strings 
-g      -I../include -I. -I/home/sara/build/glibc/objdir/misc -I.. 
-I../libio  -I/home/sara/build/glibc/objdir -I../sysdeps/mips/elf 
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
/home/sara/build/glibc/objdir/misc/_test_and_set.o -MD -MP -MF 
/home/sara/build/glibc/objdir/misc/_test_and_set.o.dt

/tmp/ccDGPHmY.s: Assembler messages:
/tmp/ccDGPHmY.s:28: Error: opcode not supported on this processor: mips1 
(mips1) `ll $2,0($4)'
/tmp/ccDGPHmY.s:31: Error: opcode not supported on this processor: mips1 
(mips1) `sc $3,0($4)'
make[2]: *** [/home/sara/build/glibc/objdir/misc/_test_and_set.o] Error 1
make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/misc'
make[1]: *** [misc/subdir_lib] Error 2
make[1]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3'
make: *** [all] Error 2

sara@eyeore:~/build/glibc/objdir$



The problem seems to go away if I put CFLAGS="-mips4 -O2 -g".  Is it OK 
to do this?
Why did gcc/gas fail to use -mips4 opcodes by default?

-Saravanan
