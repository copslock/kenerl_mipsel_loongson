Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 13:40:42 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:31702
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8224821AbTGVMkj>; Tue, 22 Jul 2003 13:40:39 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id IAA19986;
	Tue, 22 Jul 2003 08:40:31 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id IAA17061;
	Tue, 22 Jul 2003 08:40:31 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Tue, 22 Jul 2003 08:40:30 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: 64bit Sead build
In-Reply-To: <20030721233649.GA6900@linux-mips.org>
Message-ID: <Pine.GSO.4.44.0307220836390.16466-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Thanks for the info. I'm trying to build 64bit sead so that it can be a
basis for a port to our own chip with a MIPS 5kf core. Is one of the other
supported boards more generic (and thus a better start) than Sead?
David

On Tue, 22 Jul 2003, Ralf Baechle wrote:

> On Mon, Jul 21, 2003 at 10:32:55AM -0400, David Kesselring wrote:
>
> > I'm trying to build linux for Sead in 64 bit. I found that it would not
> > compile without the change at the end of this note. After this fix, I got
> > the following link error. Does anyone have an idea why?
>
> > mips64el-linux-ld --oformat elf32-tradlittlemips -G 0 -static  -Ttext
> > 0x80100000 arch/mips64/kernel/head.o
> > arch/mips64/kernel/init_task.o init/main.o init/version.o init/do_mounts.o
> > \
> >         --start-group \
> >         arch/mips64/kernel/kernel.o arch/mips64/mm/mm.o kernel/kernel.o
> > mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \
> >          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
> > drivers/net/net.o drivers/media/media.o \
> >         net/network.o \
> >         arch/mips64/lib/lib.a
> > /home/dkesselr/MIPS/linux-mips-cvs/2003Jul18/linux-build-mips64b/lib/lib.a
> > arch/mips/mips-boards/sead/sead.o
> > arch/mips/mips-boards/generic/mipsboards.o \
> >         --end-group \
> >         -o vmlinux
> > mips64el-linux-ld: warning: cannot find entry symbol __start; defaulting
> > to 0000000080100000
> > mips64el-linux-ld: vmlinux: Not enough room for program headers (allocated
> > 3, need 4)
>
> It may not be obvious but this is ld's way of telling you it doesn't
> feel happy with the options and input files; in some case it could also
> be considered an insufficiency of ld ...
>
> In this particular case the bug is that the kernel configuration doesn't
> set CONFIG_BOOT_ELF32.
>
> I'm a bit surprised to see somebody's actually using a 64-bit kernel on a
> SEAD.
>
>   Ralf
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
