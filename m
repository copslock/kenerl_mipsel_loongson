Received:  by oss.sgi.com id <S305157AbPLDDco>;
	Fri, 3 Dec 1999 19:32:44 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:4677 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305156AbPLDDcb>;
	Fri, 3 Dec 1999 19:32:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA02149; Fri, 3 Dec 1999 19:39:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA96566
	for linux-list;
	Fri, 3 Dec 1999 19:20:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA47497
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Dec 1999 19:20:22 -0800 (PST)
	mail_from (fpound@fallschurch.esys.com)
Received: from igate1.fallschurch.esys.com (igate1.fallschurch.esys.com [198.4.96.17]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03160
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Dec 1999 19:20:20 -0800 (PST)
	mail_from (fpound@fallschurch.esys.com)
Received: by igate1.fallschurch.esys.com; id WAA25761; Fri, 3 Dec 1999 22:19:24 -0500 (EST)
Received: from unknown(199.170.244.43) by igate1.fallschurch.esys.com via smap (4.1)
	id xma025757; Fri, 3 Dec 99 22:19:11 -0500
Received: from mailhub.fcd.esys.com (mailhub.fcd.esys.com [199.170.224.9])
	by igate5.fcd.esys.com (8.9.3/8.9.3) with ESMTP id WAA16897;
	Fri, 3 Dec 1999 22:16:21 -0500 (EST)
Received: from crackle.ssw.fcd.esys.com (crackle.ssw.fcd.esys.com [192.53.95.21])
	by mailhub.fcd.esys.com (8.9.3/8.9.3) with ESMTP id WAA21757;
	Fri, 3 Dec 1999 22:16:56 -0500 (EST)
Received: from fallschurch.esys.com (ws237091.fcd.esys.com [199.170.237.91])
	by crackle.ssw.fcd.esys.com (8.9.0/8.9.0) with ESMTP id WAA20674;
	Fri, 3 Dec 1999 22:15:29 -0500 (EST)
Message-ID: <38488746.A0BCB469@fallschurch.esys.com>
Date:   Fri, 03 Dec 1999 22:15:18 -0500
From:   "Frank B. Pound" <fpound@fallschurch.esys.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@uni-koblenz.de>
CC:     Radim Gelner <radim.gelner@siemens.at>,
        SGI Linux Mailing List <linux@cthulhu.engr.sgi.com>
Subject: Re: RM200, off topic?
References: <Pine.LNX.4.21.9911251121250.146-100000@pc8343.gud.siemens.at> <199911291650.IAA21521@liveoak.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I have a friend at Siemens who may be able to help you with this.

Here are some of his suggestions.  Good Luck,  I'd like to see Linux on
MIPS succeed.

Thanks,



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

Looks like this kernel's bottom-half doesn't support being compiled with
the options he selected. Chances are he should start with the kernels
used
on Cobalt machines. 2.0.3x and start from there. 

FWIW, this is complaining because an exception handler doesn't have an
associated count variable (used for things like /proc/interrupts). Since
the interrupt stubs are mechanically generated, you just need to declare
teh varable to make it happy (you don't need to use it).

In irq.c, add:

int  vced_count = 0;

In addition, he should contact Siemens directly as they are beginning to
support Linux to a degree. 

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

I don't have anything like that (I don't have the patched kernel -- nor
do
I have -- or like the MIPS processor); but it looks like your make files
just need some havking to compile the MIPS prom interface code in.

Most MIPS-based computers, SGI and RM included, use variations on the
ROM
provided by MIPS. This is the interface to that. Chances aren, it isn't
being compiled/or linked properly.
 
> I'm willing to learn to hack the RM specific code and to try to do lot
> of
> things by myself, but right now, I'm not even able to compile the
> kernel!

I respect this. Not that I work on the RM division or anything.





Ralf Baechle wrote:
> 
> On Thu, Nov 25, 1999 at 11:30:52AM +0100, Radim Gelner wrote:
> 
> > I've read in SGI/howto that this is list for SGI based computers, so
> > sorry about this quite off-topic letter, but I'm really desperate.
> >
> > I'm very interested in setting up Linux on SNI RM200. I have RM200 in my
> > office and I want to see Linux running on it, but my knowledge about this
> > subject is quite limited. I have no one to learn from. I mean there are
> > lot of peoples in mailing lists who are willing to help me, but nobody
> > owns this particular hardware, so the hints I get are quite general. Is
> > out there someone who is able to provide me some information on Linux on
> > RMs? Or on someone who does this?
> >
> > I've hopefully compiled both binutils and egcs for cross-devel, now I'm
> > ready for kernel. I've tried mips patched 2.2.1 found on
> > decstation.unix-ag.org but althought it's said to support RMs, I'm unable
> > to get over rm200-pci part of compilation. If I disable the support for
> > RM200 PCI, which is nonsense, but just to see what is going on, I get
> > various linker errors:
> >
> > make[1]: Leaving directory `/usr/src/kernel-source-2.2.1/arch/mips/tools'
> > mipsel-linux-ld -static -G 0 -T arch/mips/ld.script.little
> > arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o
> > init/version.o \
> >         --start-group \
> >         arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o
> > mm/mm.o fs/fs.o ipc/ipc.o \
> >         fs/filesystems.a \
> >         net/network.a \
> >         drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
> > drivers/net/net.a \
> >         arch/mips/lib/lib.a /usr/src/kernel-source-2.2.1/lib/lib.a
> > arch/mips/lib/lib.a \
> >         --end-group \
> >         -o vmlinux
> > arch/mips/kernel/head.o: In function `except_vec3_r4000':
> > head.S(.text+0x580): undefined reference to `vced_count'
> > head.S(.text+0x584): undefined reference to `vced_count'
> > head.S(.text+0x58c): undefined reference to `vced_count'
> > head.S(.text+0x59c): undefined reference to `vcei_count'
> > head.S(.text+0x5a0): undefined reference to `vcei_count'
> > head.S(.text+0x5a8): undefined reference to `vcei_count'
> 
> This is a minor braino in proc.c.  Just enable procfs support and recompile.
> 
> > arch/mips/kernel/head.o: In function `kernel_entry':
> > head.S(.text+0x604): undefined reference to `prom_init'
> > head.S(.text+0x604): relocation truncated to fit: R_MIPS_26 prom_init
> > arch/mips/mm/mm.o: In function `free_initmem':
> > init.c(.text+0x5f0): undefined reference to `prom_free_prom_memory'
> > init.c(.text+0x5f0): relocation truncated to fit: R_MIPS_26
> > prom_free_prom_memory
> > arch/mips/mm/mm.o: In function `get_pte_kernel_slow':
> > init.c(.text.init+0x138): undefined reference to `prom_fixup_mem_map'
> > init.c(.text.init+0x138): relocation truncated to fit: R_MIPS_26
> > prom_fixup_mem_map
> > make: *** [vmlinux] Error 1
> 
> > I'm willing to learn to hack the RM specific code and to try to do lot of
> > things by myself, but right now, I'm not even able to compile the kernel!
> 
> Sorry for not answering your emails earlier, I've been busy with hacking
> the MIPS64 code.  The RM200 support got broken by the changes to the ARC
> code above and a minor procfs dumbne
> 
> Fixing would actually be easy ... IF SNI's firmware wouldn't use the
> freedom granted by the ARC spec and ignore the load address of every
> executable.  As it seems every executable gets loaded to the load address
> plus 8 bytes.  The simplest fix it looks like would be to write some
> relocatable code directly at the start of the kernel binary which moves
> everything around to the right place.
> 
> The other SNI bug which I've reported some time ago to this list, the
> interrupt system dying seems to be fixed.  It is caused by an interupt
> hardware foobar.  SNI pointed out a workaround and that one seems to
> be stable in 2.1.131 for me, I've done my entire Linux/MIPS64 work using
> the RM200 as the console for my Origin.
> 
> More later ...
> 
>   Ralf

-- 
_______________________________________________________________
Frank B. Pound
