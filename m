Received:  by oss.sgi.com id <S305157AbPK2RJS>;
	Mon, 29 Nov 1999 09:09:18 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:9486 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbPK2RIw>;
	Mon, 29 Nov 1999 09:08:52 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA22324
	for <linuxmips@oss.sgi.com>; Mon, 29 Nov 1999 09:11:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA31476
	for linux-list;
	Mon, 29 Nov 1999 08:50:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [150.166.40.92])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA33620
	for <linux@relay.engr.sgi.com>;
	Mon, 29 Nov 1999 08:50:16 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id IAA21521
	for linux@engr.sgi.com; Mon, 29 Nov 1999 08:50:16 -0800
Date:   Mon, 29 Nov 1999 08:50:16 -0800
Message-Id: <199911291650.IAA21521@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Radim Gelner <radim.gelner@siemens.at>
Cc:     SGI Linux Mailing List <linux@cthulhu.engr.sgi.com>
Subject: Re: RM200, off topic?
In-Reply-To: <Pine.LNX.4.21.9911251121250.146-100000@pc8343.gud.siemens.at>
References: <Pine.LNX.4.21.9911251121250.146-100000@pc8343.gud.siemens.at>
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Nov 25, 1999 at 11:30:52AM +0100, Radim Gelner wrote:

> I've read in SGI/howto that this is list for SGI based computers, so
> sorry about this quite off-topic letter, but I'm really desperate.
> 
> I'm very interested in setting up Linux on SNI RM200. I have RM200 in my
> office and I want to see Linux running on it, but my knowledge about this
> subject is quite limited. I have no one to learn from. I mean there are
> lot of peoples in mailing lists who are willing to help me, but nobody
> owns this particular hardware, so the hints I get are quite general. Is
> out there someone who is able to provide me some information on Linux on
> RMs? Or on someone who does this?
> 
> I've hopefully compiled both binutils and egcs for cross-devel, now I'm
> ready for kernel. I've tried mips patched 2.2.1 found on
> decstation.unix-ag.org but althought it's said to support RMs, I'm unable
> to get over rm200-pci part of compilation. If I disable the support for
> RM200 PCI, which is nonsense, but just to see what is going on, I get
> various linker errors:
> 
> make[1]: Leaving directory `/usr/src/kernel-source-2.2.1/arch/mips/tools'
> mipsel-linux-ld -static -G 0 -T arch/mips/ld.script.little
> arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o
> init/version.o \
>         --start-group \
>         arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o
> mm/mm.o fs/fs.o ipc/ipc.o \
>         fs/filesystems.a \
>         net/network.a \
>         drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
> drivers/net/net.a \
>         arch/mips/lib/lib.a /usr/src/kernel-source-2.2.1/lib/lib.a
> arch/mips/lib/lib.a \
>         --end-group \
>         -o vmlinux
> arch/mips/kernel/head.o: In function `except_vec3_r4000':
> head.S(.text+0x580): undefined reference to `vced_count'
> head.S(.text+0x584): undefined reference to `vced_count'
> head.S(.text+0x58c): undefined reference to `vced_count'
> head.S(.text+0x59c): undefined reference to `vcei_count'
> head.S(.text+0x5a0): undefined reference to `vcei_count'
> head.S(.text+0x5a8): undefined reference to `vcei_count'

This is a minor braino in proc.c.  Just enable procfs support and recompile.

> arch/mips/kernel/head.o: In function `kernel_entry':
> head.S(.text+0x604): undefined reference to `prom_init'
> head.S(.text+0x604): relocation truncated to fit: R_MIPS_26 prom_init
> arch/mips/mm/mm.o: In function `free_initmem':
> init.c(.text+0x5f0): undefined reference to `prom_free_prom_memory'
> init.c(.text+0x5f0): relocation truncated to fit: R_MIPS_26
> prom_free_prom_memory
> arch/mips/mm/mm.o: In function `get_pte_kernel_slow':
> init.c(.text.init+0x138): undefined reference to `prom_fixup_mem_map'
> init.c(.text.init+0x138): relocation truncated to fit: R_MIPS_26
> prom_fixup_mem_map
> make: *** [vmlinux] Error 1

> I'm willing to learn to hack the RM specific code and to try to do lot of
> things by myself, but right now, I'm not even able to compile the kernel!

Sorry for not answering your emails earlier, I've been busy with hacking
the MIPS64 code.  The RM200 support got broken by the changes to the ARC
code above and a minor procfs dumbne

Fixing would actually be easy ... IF SNI's firmware wouldn't use the
freedom granted by the ARC spec and ignore the load address of every
executable.  As it seems every executable gets loaded to the load address
plus 8 bytes.  The simplest fix it looks like would be to write some
relocatable code directly at the start of the kernel binary which moves
everything around to the right place.

The other SNI bug which I've reported some time ago to this list, the
interrupt system dying seems to be fixed.  It is caused by an interupt
hardware foobar.  SNI pointed out a workaround and that one seems to
be stable in 2.1.131 for me, I've done my entire Linux/MIPS64 work using
the RM200 as the console for my Origin.

More later ...

  Ralf
