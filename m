Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jan 2003 21:11:56 +0000 (GMT)
Received: from 216-166-237-83.clec.madisonriver.net ([IPv6:::ffff:216.166.237.83]:49156
	"EHLO dpr338") by linux-mips.org with ESMTP id <S8225993AbTAFVLz>;
	Mon, 6 Jan 2003 21:11:55 +0000
Received: from dprn03.deltartp.com ([216.166.210.181]) by 216.166.237.83 with InterScan Messaging Security Suite; Mon, 06 Jan 2003 16:19:23 -0800
Received: by dprn03.deltartp.com with Internet Mail Service (5.5.2653.19)
	id <YQ1SVFCQ>; Mon, 6 Jan 2003 15:54:50 -0500
Message-ID: <A4E787A2467EF849B00585F14C9005590689C1@dprn03.deltartp.com>
From: Chien-Lung Wu <cwu@deltartp.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Cross-compiler: glibc-2.2.5 compiling error
Date: Mon, 6 Jan 2003 15:54:49 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <cwu@deltartp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cwu@deltartp.com
Precedence: bulk
X-list: linux-mips



Hi, 

I am working on the cross-compiler for mips target.
I uses:
	binutil-2.13.10
	gcc-2.95.3
	glibc-2.2.5.

I installed the binutils in /usr/xmips-1-2
and get the first phase of gcc compiled and installed on the same directory.

Now when I compile glibc-2.2.5, I got the following error:

/*error message */
mips-linux-gcc   -shared  -Wl,-O1  -Wl,-dynamic-linker=/lib/ld.so.1
-B/home/cross-compiler/mips-glibc-2.2.5-1-6/csu/
-Wl,--version-script=/home/cross-compiler/mips-glibc-2.2.5-1-6/libc.map
-Wl,-soname=libc.so.6  -nostdlib -nostartfiles -e __libc_main -u
__register_frame -L/home/cross-compiler/mips-glibc-2.2.5-1-6
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/math
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/elf
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/dlfcn
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/nss
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/nis
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/rt
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/resolv
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/crypt
-L/home/cross-compiler/mips-glibc-2.2.5-1-6/linuxthreads
-Wl,-rpath-link=/home/cross-compiler/mips-glibc-2.2.5-1-6:/home/cross-compil
er/mips-glibc-2.2.5-1-6/math:/home/cross-compiler/mips-glibc-2.2.5-1-6/elf:/
home/cross-compiler/mips-glibc-2.2.5-1-6/dlfcn:/home/cross-compiler/mips-gli
bc-2.2.5-1-6/nss:/home/cross-compiler/mips-glibc-2.2.5-1-6/nis:/home/cross-c
ompiler/mips-glibc-2.2.5-1-6/rt:/home/cross-compiler/mips-glibc-2.2.5-1-6/re
solv:/home/cross-compiler/mips-glibc-2.2.5-1-6/crypt:/home/cross-compiler/mi
ps-glibc-2.2.5-1-6/linuxthreads -o
/home/cross-compiler/mips-glibc-2.2.5-1-6/libc.so -T
/home/cross-compiler/mips-glibc-2.2.5-1-6/libc.so.lds
/home/cross-compiler/mips-glibc-2.2.5-1-6/csu/abi-note.o
/home/cross-compiler/mips-glibc-2.2.5-1-6/elf/soinit.os
/home/cross-compiler/mips-glibc-2.2.5-1-6/libc_pic.os
/home/cross-compiler/mips-glibc-2.2.5-1-6/elf/sofini.os
/home/cross-compiler/mips-glibc-2.2.5-1-6/elf/interp.os
/home/cross-compiler/mips-glibc-2.2.5-1-6/elf/ld.so -lgcc
/home/cross-compiler/mips-glibc-2.2.5-1-6/libc_pic.os: In function
`__sigprocmask':
/home/cross-compiler/glibc-2.2.5/signal/../sysdeps/unix/sysv/linux/sigprocma
sk.c(.text+0x1bc30): relocation truncated to fit: R_MIPS_PC16
__syscall_error
/home/cross-compiler/mips-glibc-2.2.5-1-6/libc_pic.os: In function
`sigstack':
/home/cross-compiler/glibc-2.2.5/signal/../sysdeps/unix/sysv/linux/sigstack.
c(.text+0x1c6d0): relocation truncated to fit: R_MIPS_PC16 __syscall_error
/home/cross-compiler/mips-glibc-2.2.5-1-6/libc_pic.os: In function `sigset':
/home/cross-compiler/glibc-2.2.5/signal/../sysdeps/posix/sigset.c(.text+0x1d
670): relocation truncated to fit: R_MIPS_PC16 __syscall_error
/home/cross-compiler/glibc-2.2.5/signal/../sysdeps/posix/sigset.c(.text+0x1d
690): relocation 
....

/** end of error emssages ****/

Do anyone ever see this before? Any solution(s)? TIA.


Chien-Lung


	
