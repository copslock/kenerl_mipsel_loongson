Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2003 15:04:19 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:27705
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225375AbTIEOER>; Fri, 5 Sep 2003 15:04:17 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA03679
	for <linux-mips@linux-mips.org>; Fri, 5 Sep 2003 10:04:12 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA03531
	for <linux-mips@linux-mips.org>; Fri, 5 Sep 2003 10:04:02 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Fri, 5 Sep 2003 10:04:01 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: 64 bit compile problems
Message-ID: <Pine.GSO.4.44.0309050955460.26490-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I'm trying to build u-boot bootloader for a 5kc core in 64 bit mode. I'm
having problems with the compiler/linker. If anyone has any ideas, please
let me know.

When I use the toolchain that installs in
"/usr/cygnus/mips3264-020217/H-i686-pc-linux-gnulibc2.1/bin", I get a link
problem where all opcodes are not aligned on a 64 bit boundry. I get an
extra 32bit word of 0x0 between two 64bit opcodes in the binary file.
The cpp options I use are:-mips64 -EL -mlong64 -mcpu=r5k

When I use a toolchain which I think I ftp'd from linux-mips.org
(mips64el-linux), I get the following error. The cpp options I use are:-EL
-mabi=64 -mips4 -mlong64


/usr/bin/mips64el-linux-gcc  -O   -D__KERNEL__ -DTEXT_BASE=0x00000
-I/home/dkesselr/uboot/u-boot-0.4.5-atmel/include
-I/home/dkesselr/uboot/u-boot-0.4.5-atmel/include/asm -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/lib/gcc-lib/mips64el-linux/2.95.4/include -pipe  -DCONFIG_MIPS
-D__MIPS__ -EL -mabi=64 -mips4
-mlong64 -Wall -Wstrict-prototypes -c -o atmel352.o atmel352.c
atmel352.c: In function `sdram_timing_init':
atmel352.c:82: warning: cast to pointer from integer of different size
atmel352.c:90: warning: cast to pointer from integer of different size
atmel352.c: In function `copydwords':
atmel352.c:186: Internal compiler error in `rtx_equal_for_memref_p', at
alias.c:682
Please submit a full bug report.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
cpp0: output pipe has been closed


Thanks,
David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com 919-462-6587
