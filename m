Received:  by oss.sgi.com id <S305156AbPKYNVa>;
	Thu, 25 Nov 1999 05:21:30 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:45948 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbPKYNVN>;
	Thu, 25 Nov 1999 05:21:13 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA09442
	for <linuxmips@oss.sgi.com>; Thu, 25 Nov 1999 05:23:26 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA74331
	for linux-list;
	Thu, 25 Nov 1999 02:09:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA04284
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 Nov 1999 02:09:09 -0800 (PST)
	mail_from (radim.gelner@siemens.at)
Received: from zwei.siemens.at (zwei.siemens.at [193.81.246.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06688
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Nov 1999 02:09:03 -0800 (PST)
	mail_from (radim.gelner@siemens.at)
Received: from scesie13.sie.siemens.at (root@firix-hme0 [10.1.140.1])
	by zwei.siemens.at  with ESMTP id LAA23190
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Nov 1999 11:10:35 +0100 (MET)
Received: (from smap@localhost)
	by scesie13.sie.siemens.at (8.9.3/8.9.3) id LAA18985
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Nov 1999 11:09:00 +0100 (MET)
Received: from scegud01.gud.siemens.at(195.3.240.30) by scesie13 via smap (V2.0beta)
	id xma018757; Thu, 25 Nov 99 11:08:36 +0100
Received: from pc8343.gud.siemens.at (pc8343.gud.siemens.at [195.3.9.13])
	by scegud01.gud.siemens.at (8.9.3/8.8.5) with ESMTP id LAA06039
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Nov 1999 11:08:35 +0100 (MET)
Date:   Thu, 25 Nov 1999 11:30:52 +0100 (CET)
From:   Radim Gelner <radim.gelner@siemens.at>
X-Sender: root@pc8343.gud.siemens.at
To:     SGI Linux Mailing List <linux@cthulhu.engr.sgi.com>
Subject: RM200, off topic? 
Message-ID: <Pine.LNX.4.21.9911251121250.146-100000@pc8343.gud.siemens.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hello everybody,

I've read in SGI/howto that this is list for SGI based computers, so
sorry about this quite off-topic letter, but I'm really desperate.

I'm very interested in setting up Linux on SNI RM200. I have RM200 in my
office and I want to see Linux running on it, but my knowledge about this
subject is quite limited. I have no one to learn from. I mean there are
lot of peoples in mailing lists who are willing to help me, but nobody
owns this particular hardware, so the hints I get are quite general. Is
out there someone who is able to provide me some information on Linux on
RMs? Or on someone who does this?

I've hopefully compiled both binutils and egcs for cross-devel, now I'm
ready for kernel. I've tried mips patched 2.2.1 found on
decstation.unix-ag.org but althought it's said to support RMs, I'm unable
to get over rm200-pci part of compilation. If I disable the support for
RM200 PCI, which is nonsense, but just to see what is going on, I get
various linker errors:

make[1]: Leaving directory `/usr/src/kernel-source-2.2.1/arch/mips/tools'
mipsel-linux-ld -static -G 0 -T arch/mips/ld.script.little
arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
drivers/net/net.a \
        arch/mips/lib/lib.a /usr/src/kernel-source-2.2.1/lib/lib.a
arch/mips/lib/lib.a \
        --end-group \
        -o vmlinux
arch/mips/kernel/head.o: In function `except_vec3_r4000':
head.S(.text+0x580): undefined reference to `vced_count'
head.S(.text+0x584): undefined reference to `vced_count'
head.S(.text+0x58c): undefined reference to `vced_count'
head.S(.text+0x59c): undefined reference to `vcei_count'
head.S(.text+0x5a0): undefined reference to `vcei_count'
head.S(.text+0x5a8): undefined reference to `vcei_count'
arch/mips/kernel/head.o: In function `kernel_entry':
head.S(.text+0x604): undefined reference to `prom_init'
head.S(.text+0x604): relocation truncated to fit: R_MIPS_26 prom_init
arch/mips/mm/mm.o: In function `free_initmem':
init.c(.text+0x5f0): undefined reference to `prom_free_prom_memory'
init.c(.text+0x5f0): relocation truncated to fit: R_MIPS_26
prom_free_prom_memory
arch/mips/mm/mm.o: In function `get_pte_kernel_slow':
init.c(.text.init+0x138): undefined reference to `prom_fixup_mem_map'
init.c(.text.init+0x138): relocation truncated to fit: R_MIPS_26
prom_fixup_mem_map
make: *** [vmlinux] Error 1

I'm fighting with this all for nearly two weeks...

I'm willing to learn to hack the RM specific code and to try to do lot of
things by myself, but right now, I'm not even able to compile the kernel!


Thanks you all for any info

Radim
