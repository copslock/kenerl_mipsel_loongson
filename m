Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OKrNwJ018501
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 13:53:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OKrIYt018499
	for linux-mips-outgoing; Wed, 24 Apr 2002 13:53:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OKrCwJ018496
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 13:53:12 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id NAA56084;
	Wed, 24 Apr 2002 13:53:39 -0700 (PDT)
Date: Wed, 24 Apr 2002 13:53:39 -0700
From: Geoffrey Espin <espin@idiom.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Updates for RedHat 7.1/mips
Message-ID: <20020424135339.A24558@idiom.com>
References: <20020423155925.A8846@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020423155925.A8846@lucon.org>; from H . J . Lu on Tue, Apr 23, 2002 at 03:59:25PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 23, 2002 at 03:59:25PM -0700, H . J . Lu wrote:
> I updated glibc, python, gcc, gdb, rpm, openssl, binutils and toolchain at
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> Let know know if there are any problems.

I've been using your old October toolchain-20011020-* quite happily.
So foolishly, I upgraded to this new toolchain*rpm for mipsel on i386.

When building a linux-mips.sourceforge.net -based kernel, if I
include CONFIG_PCI in the configuration, I get:

...
mipsel-linux-ld -G 0 -static -T arch/mips/ld.script.0x80002000 arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o arch/mips/ramdisk/ramdisk.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/pci/driver.o drivers/mtd/mtdlink.o \
        net/network.o \
        arch/mips/lib/lib.a /home/espin/linux/lib/lib.a arch/mips/korva/korva.a
\
        --end-group \
        -o vmlinux
drivers/char/char.o(.data+0x3990): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1


If I don't include CONFIG_PCI the problem goes away.
It also sometimes complained about symbols in drivers/net/net.o.

I stumbled on:

   http://lists.debian.org/debian-devel/2001/debian-devel-200112/msg00768.html

which says that Alan Cox came up with enabling CONFIG_HOTPLUG as a workaround.
Seems to work.  :-/

Other useful suggestions found were to downgrade ones' binutils. :-)

Geoff
-- 
Geoffrey Espin
espin@idiom.com
--
