Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJfnE18562
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:41:49 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJfid18557
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:41:44 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16Vzfl-0008Ks-00; Wed, 30 Jan 2002 13:41:29 -0500
Date: Wed, 30 Jan 2002 13:41:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Geoffrey Espin <espin@idiom.com>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Compiler warnings and remove unused code....
Message-ID: <20020130134129.A31924@nevyn.them.org>
References: <3C582D6E.F86FBFE7@cotw.com> <20020130102340.A37609@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130102340.A37609@idiom.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 30, 2002 at 10:23:40AM -0800, Geoffrey Espin wrote:
> Steve,
> 
> > Attached is a patch to clean up a bunch of compiler warnings. Specifically
> > ones associated with gcc-3.x compilers and one use of __FUNCTION__ soon to
> > be deprecated. Also added some #ifdef's for HIGHMEM and removed unused
> > 5432 MM code. Please apply.
> > -Steve
> 
> I used your toolset to compile busybox and everything else pretty well.
> But when I got to the end of "make linux", I got:
> 
> mipsel-linux-ld -G 0 -static -T arch/mips/ld.script.0x80002000 arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o arch/mips/ramdisk/ramdisk.o \
>  drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/atm/atm.o drivers/pci/driver.o drivers/mtd/mtdlink.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
> net/network.o \
> arch/mips/lib/lib.a /home/espin/linux/lib/lib.a arch/mips/korva/korva.a \
>     --end-group \
>     -o vmlinux
> drivers/char/char.o(.data+0x3958): undefined reference to `local symbols in discarded section .text.exit'
> drivers/net/net.o(.data+0x17c): undefined reference to `local symbols in discarded section .text.exit'
> drivers/usb/usbdrv.o(.data+0x4b0): undefined reference to `local symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
> 
> 
> This is linux.2.4.16 + sourceforge/mipslinux (a few weeks old).
> 
> Geoff

These were fixed in the kernel.org tree around 2.4.17 (maybe 2.4.18pre
for a few of them, too).

If you just want to work around it you can comment out the /DISCARD/ {}
block in arch/mips/ld.script.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
