Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jun 2003 14:51:58 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:10244
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8224802AbTFSNv4>; Thu, 19 Jun 2003 14:51:56 +0100
Received: from hydra.mmc.atmel.com (hydra.mmc.atmel.com [10.127.240.58])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA29758
	for <linux-mips@linux-mips.org>; Thu, 19 Jun 2003 09:51:45 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by hydra.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA03907
	for <linux-mips@linux-mips.org>; Thu, 19 Jun 2003 09:51:44 -0400 (EDT)
X-Authentication-Warning: hydra.mmc.atmel.com: dkesselr owned process doing -bs
Date: Thu, 19 Jun 2003 09:51:44 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Message-ID: <Pine.GSO.4.44.0306190938180.3867-100000@hydra.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2680
Subject: (no subject)
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I'm still trying to compile gcc and glibc for mips64el but am running into
significant problems. Basically, I haven't been able to completely build
anything.
My current problem is when I build glibc-2.2.5. The first error I got was
that gcc couldn't find an asm or linux header directory. So I added
links(asm,linux) to gcc-2.2.5/include that point to linux files
(linux-2.4.20.mips-linux-cvs/include/asm-mips64 and ..include/linux). Next
run I got the following. It looks obscure to me since during the configure
I didn't specify any particular processor options.
The mips64el-linux-gcc that I'm using is the binary from Majick's
website.(Sorry if I misspelled.)
 If you can help, I'd greatly appreciate it.

And if you have any idea why, when building gcc, I get an error saying
that -EL is not a valid option for as, please let me know. I searched the
code for options being passed to the assembler or something pointing to a
mips as instead of the host 386 as, but have been unsuccessful.

Thanks,
David Kesselring

 ----------------------------------------------------------
mips64el-linux-gcc ../sysdeps/unix/sysv/linux/mips/sysdep.S -c
-I../include -I. -I/home/dkesselr/MIPS/gcc-src/mips64el-glibc/csu -I..
-I../libio  -I/home/dkesselr/MIPS/gcc-src/mips64el-glibc
-I../sysdeps/mips/elf -I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../sysdeps/pthread
-I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix
-I../linuxthreads/sysdeps/mips -I../sysdeps/unix/sysv/linux/mips
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common
-I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv
-I../sysdeps/unix/mips -I../sysdeps/unix -I../sysdeps/posix
-I../sysdeps/mips/mips64 -I../sysdeps/wordsize-64
-I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64
-I../sysdeps/mips/fpu -I../sysdeps/mips -I../sysdeps/wordsize-32
-I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic
-D_LIBC_REENTRANT -include ../include/libc-symbols.h  -DPIC
-DHAVE_INITFINI -DASSEMBLER
-I/home/dkesselr/MIPS/gcc-src/mips64el-glibc/csu/.  -o
/home/dkesselr/MIPS/gcc-src/mips64el-glibc/csu/sysdep.o
../sysdeps/unix/mips/sysdep.S: Assembler messages:
../sysdeps/unix/mips/sysdep.S:55: Error: Macro needs a temporary register
due to `nodaddi' while $at is already in use
make[2]: *** [/home/dkesselr/MIPS/gcc-src/mips64el-glibc/csu/sysdep.o]
Error 1
make[2]: Leaving directory `/home/dkesselr/MIPS/gcc-src/glibc-2.2.5/csu'
make[1]: *** [csu/subdir_lib] Error 2
make[1]: Leaving directory `/home/dkesselr/MIPS/gcc-src/glibc-2.2.5'
make: *** [all] Error 2
-----------------------------------------------------------------



David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
