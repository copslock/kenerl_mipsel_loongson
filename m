Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJdv118404
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:39:57 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJdsd18398
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:39:54 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g0UIdSn4012730;
	Wed, 30 Jan 2002 10:39:28 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g0UIdR1X012726;
	Wed, 30 Jan 2002 10:39:27 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Wed, 30 Jan 2002 10:39:27 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geoffrey Espin <espin@idiom.com>
cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Compiler warnings and remove unused code....
In-Reply-To: <20020130102340.A37609@idiom.com>
Message-ID: <Pine.LNX.4.10.10201301039050.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


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

I'm glad you tried it. I was tempted to apply it to CVS. 
