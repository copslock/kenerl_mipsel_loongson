Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJNrJ18079
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:23:53 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJNod18075
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:23:50 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id KAA41401;
	Wed, 30 Jan 2002 10:23:40 -0800 (PST)
Date: Wed, 30 Jan 2002 10:23:40 -0800
From: Geoffrey Espin <espin@idiom.com>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] Compiler warnings and remove unused code....
Message-ID: <20020130102340.A37609@idiom.com>
References: <3C582D6E.F86FBFE7@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <3C582D6E.F86FBFE7@cotw.com>; from Steven J. Hill on Wed, Jan 30, 2002 at 11:29:18AM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steve,

> Attached is a patch to clean up a bunch of compiler warnings. Specifically
> ones associated with gcc-3.x compilers and one use of __FUNCTION__ soon to
> be deprecated. Also added some #ifdef's for HIGHMEM and removed unused
> 5432 MM code. Please apply.
> -Steve

I used your toolset to compile busybox and everything else pretty well.
But when I got to the end of "make linux", I got:

mipsel-linux-ld -G 0 -static -T arch/mips/ld.script.0x80002000 arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o arch/mips/ramdisk/ramdisk.o \
 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/atm/atm.o drivers/pci/driver.o drivers/mtd/mtdlink.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
net/network.o \
arch/mips/lib/lib.a /home/espin/linux/lib/lib.a arch/mips/korva/korva.a \
    --end-group \
    -o vmlinux
drivers/char/char.o(.data+0x3958): undefined reference to `local symbols in discarded section .text.exit'
drivers/net/net.o(.data+0x17c): undefined reference to `local symbols in discarded section .text.exit'
drivers/usb/usbdrv.o(.data+0x4b0): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1


This is linux.2.4.16 + sourceforge/mipslinux (a few weeks old).

Geoff
-- 
espin@idiom.com
