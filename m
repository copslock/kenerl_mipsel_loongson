Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 00:37:04 +0100 (BST)
Received: from p508B6C3C.dip.t-dialin.net ([IPv6:::ffff:80.139.108.60]:7583
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225230AbTGUXgw>; Tue, 22 Jul 2003 00:36:52 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6LNapDB013269;
	Tue, 22 Jul 2003 01:36:51 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6LNanvM013268;
	Tue, 22 Jul 2003 01:36:49 +0200
Date: Tue, 22 Jul 2003 01:36:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: 64bit Sead build
Message-ID: <20030721233649.GA6900@linux-mips.org>
References: <Pine.GSO.4.44.0307211027270.16227-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0307211027270.16227-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 21, 2003 at 10:32:55AM -0400, David Kesselring wrote:

> I'm trying to build linux for Sead in 64 bit. I found that it would not
> compile without the change at the end of this note. After this fix, I got
> the following link error. Does anyone have an idea why?

> mips64el-linux-ld --oformat elf32-tradlittlemips -G 0 -static  -Ttext
> 0x80100000 arch/mips64/kernel/head.o
> arch/mips64/kernel/init_task.o init/main.o init/version.o init/do_mounts.o
> \
>         --start-group \
>         arch/mips64/kernel/kernel.o arch/mips64/mm/mm.o kernel/kernel.o
> mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
> drivers/net/net.o drivers/media/media.o \
>         net/network.o \
>         arch/mips64/lib/lib.a
> /home/dkesselr/MIPS/linux-mips-cvs/2003Jul18/linux-build-mips64b/lib/lib.a
> arch/mips/mips-boards/sead/sead.o
> arch/mips/mips-boards/generic/mipsboards.o \
>         --end-group \
>         -o vmlinux
> mips64el-linux-ld: warning: cannot find entry symbol __start; defaulting
> to 0000000080100000
> mips64el-linux-ld: vmlinux: Not enough room for program headers (allocated
> 3, need 4)

It may not be obvious but this is ld's way of telling you it doesn't
feel happy with the options and input files; in some case it could also
be considered an insufficiency of ld ...

In this particular case the bug is that the kernel configuration doesn't
set CONFIG_BOOT_ELF32.

I'm a bit surprised to see somebody's actually using a 64-bit kernel on a
SEAD.

  Ralf
