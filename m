Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K5Xm803350
	for linux-mips-outgoing; Tue, 19 Feb 2002 21:33:48 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K5Xg903347
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 21:33:42 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16dORn-0005n4-00; Tue, 19 Feb 2002 23:33:39 -0500
Date: Tue, 19 Feb 2002 23:33:39 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Error Compiling 2.4.3 kernel on SGI IP22...
Message-ID: <20020219233339.B22099@nevyn.them.org>
References: <000901c1b9b0$51cdd0b0$0f1610ac@delllaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c1b9b0$51cdd0b0$0f1610ac@delllaptop>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 05:45:46PM -0800, Robert Rusek wrote:
> Initially I got errors telling me that mips-linux-gcc, mips-linux-ld,
> and mips-linux-ar did not exists.  I simply made a link for:
> 
> mips-linux-gcc	-> gcc 
> mips-linux-ld	-> ld
> mips-linux-ar	-> ar

No, set CROSS_COMPILE=mips-linux-


> mips-linux-ld -static -G 0 -T arch/mips/ld.script
> arch/mips/kernel/head.o arch/m
> ips/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o
> mm/mm.o fs/f
> s.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o
> arch/mips/sgi/kernel/ip22-kern.o
>  \
>         drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
> drivers/ne
> t/net.o drivers/media/media.o  drivers/scsi/scsidrv.o
> drivers/cdrom/driver.o dri
> vers/sgi/sgi.a drivers/video/video.o \
>         net/network.o \
>         arch/mips/lib/lib.a /usr/src/linux-2.4.3/lib/lib.a
> arch/mips/arc/arclib.
> a \
>         --end-group \
>         -o vmlinux
> mips-linux-ld: target elf32-bigmips not found
> make: *** [vmlinux] Error 1

2.4.3 is too old for your tools.

I recommend you use a newer kernel.  Otherwise, just changing that to
elf32-tradbigmips should work.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
