Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 15:37:45 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:36392
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225266AbTEIOhn>; Fri, 9 May 2003 15:37:43 +0100
Received: from pluto.mmc.atmel.com (pluto.mmc.atmel.com [10.127.240.51])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA02372
	for <linux-mips@linux-mips.org>; Fri, 9 May 2003 10:37:37 -0400 (EDT)
Received: from localhost (qfan@localhost)
	by pluto.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA24855
	for <linux-mips@linux-mips.org>; Fri, 9 May 2003 10:37:36 -0400 (EDT)
X-Authentication-Warning: pluto.mmc.atmel.com: qfan owned process doing -bs
Date: Fri, 9 May 2003 10:37:36 -0400 (EDT)
From: Qing Fan <qfan@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: mips64 linux SEAD-2 compile
Message-ID: <Pine.GSO.4.44.0305091033200.24708-100000@pluto.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <qfan@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qfan@mmc.atmel.com
Precedence: bulk
X-list: linux-mips



The cross compile tool I am using is:
binutils-mips64el-linux-2.13.1-1.i386.rpm

Here is a section from  Linux makefile ./arch/mips64/Makefile, which I
don't quite understand:

# The 64-bit ELF tools are pretty broken so at this time we generate
64-bit
# ELF files from 32-bit files by conversion.
#
ifdef CONFIG_BOOT_ELF64
CFLAGS += -Wa,-32
LINKFLAGS += -T arch/mips64/ld.script.elf32
#AS += -64
#LD += -m elf64bmip
#LD += -m elf64ltsmip
#LINKFLAGS += -T arch/mips64/ld.script.elf64
endif



When I tried to compile with this configuration, I received the following
error:

make[1]: Entering directory
`/home/dkesselr/scratch64/linux-2.4.18.sead/kernel'
make all_targets
make[2]: Entering directory
`/home/dkesselr/scratch64/linux-2.4.18.sead/kernel'
mips64el-linux-gcc -D__KERNEL__
-I/home/dkesselr/scratch64/linux-2.4.18.sead/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -I
/home/dkesselr/scratch64/linux-2.4.18.sead/include/asm/gcc -D__KERNEL__
-I/home/dkesselr/scratch64/linux-2.4.18.sead/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -mabi=64 -G 0 -mno-abicalls -fno-pic
-Wa,--trap -pipe -g -mcpu=r8000 -mips4 -Wa,-32   -DKBUILD_BASENAME=sched
-fno-omit-frame-pointer -c -o sched.o sched.c
{standard input}: Assembler messages:
{standard input}:1478: Warning: dla used to load 32-bit register
{standard input}:1598: Error: Number (0xffffffff) larger than 32 bits
{standard input}:1631: Warning: dla used to load 32-bit register
{standard input}:1663: Warning: dla used to load 32-bit register
{standard input}:1824: Warning: dla used to load 32-bit register
{standard input}:1825: Warning: dla used to load 32-bit register
{standard input}:1833: Warning: dla used to load 32-bit register
{standard input}:1834: Warning: dla used to load 32-bit register
{standard input}:1850: Warning: dla used to load 32-bit register
{standard input}:1868: Warning: dla used to load 32-bit register
{standard input}:1872: Warning: dla used to load 32-bit register
{standard input}:1873: Warning: dla used to load 32-bit register
{standard input}:1888: Warning: dla used to load 32-bit register
{standard input}:2364: Warning: dla used to load 32-bit register
{standard input}:2393: Warning: dla used to load 32-bit register
{standard input}:2394: Warning: dla used to load 32-bit register
{standard input}:2450: Warning: dla used to load 32-bit register
{standard input}:2451: Warning: dla used to load 32-bit register
{standard input}:2483: Warning: dla used to load 32-bit register
...
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory
`/home/dkesselr/scratch64/linux-2.4.18.sead/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/home/dkesselr/scratch64/linux-2.4.18.sead/kernel'
make: *** [_dir_kernel] Error 2


Then, I tried to comment out the 32-bit stuff and uncomment the 64-bit
stuff in the Makefile to

ifdef CONFIG_BOOT_ELF64
#CFLAGS += -Wa,-32
#LINKFLAGS += -T arch/mips64/ld.script.elf32
AS += -64
LD += -m elf64bmip
LD += -m elf64ltsmip
LINKFLAGS += -T arch/mips64/ld.script.elf64
endif

The compile went successfully, and 'vmlinus.sre' is created.  However, I
cannot successfully download it to the SEAD board, maybe because of the
64-bit elf format that the tools cannot support?


I need someone to point me to the right direction.  What exactly do I
need to do to make this to work?


Thanks,
qfan
