Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 12:25:35 +0100 (BST)
Received: from [IPv6:::ffff:80.88.36.193] ([IPv6:::ffff:80.88.36.193]:46753
	"EHLO witte.sonytel.be") by linux-mips.org with ESMTP
	id <S8225549AbTJILZc>; Thu, 9 Oct 2003 12:25:32 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id h99BPUQG009265;
	Thu, 9 Oct 2003 13:25:30 +0200 (MEST)
Date: Thu, 9 Oct 2003 13:25:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: What toolchain for vr4181
In-Reply-To: <20031009110418.GO20846@lug-owl.de>
Message-ID: <Pine.GSO.4.21.0310091320000.7430-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 9 Oct 2003, Jan-Benedict Glaw wrote:
> On Thu, 2003-10-09 10:30:57 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
> wrote in message <Pine.GSO.4.21.0310091030110.7086-100000@waterleaf.sonytel.be>:
> > On Wed, 8 Oct 2003, [iso-8859-1] Jørg Ulrich Hansen wrote:
> > > 
> > > Where is a good starting point for a toolchain that will build and work?
> > > I would prefere to build it my self because at a later state I might build
> > > it under cygwin. But a prebuild does also have interest.
> > 
> > At work we use plain binutils 2.13.2.1 and gcc 3.2.2, which we build ourselves
> > (host is Solaris/SPARC).
> 
> Joined trees? Which configury? Unfortunately, toolchain questions are
> quite FAQs, but there doesn't really exist _that_ good HOWTOs which
> actually contain exactly helpful hints (eg. which versions and/or which
> additional patches are needed).
> 
> If companies have some kind of scripts or the like they use, I'd really
> love to see them published. That'd really help all those guys out
> there:)

Binutils (binutils-2.13.2.1.tar.bz2):
    configure --target=mips-linux --prefix=/wherever/you/want

Gcc (gcc-core-3.2.2.tar.bz2):
    configure --target=mips-linux --prefix=/wherever/you/want --enable-languages=c --enable-shared --with-gnu-as --with-gnu-ld --with-system-zlib --enable-long-long --enable-nls --without-included-gettext

I took the development libraries and includes from Debian:
    libc6-dev_2.2.5-11.2_mips.deb
    libc6_2.2.5-11.2_mips.deb
    zlib1g-dev_1%3a1.1.4-1_mips.deb
    zlib1g_1%3a1.1.4-1_mips.deb

I wrote very simple Perl clones of dpkg and dpkg-deb with just enough
functionality to get `dpkg-cross -i' working on Solaris. I don't know whether I
can share them, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
