Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 09:34:40 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:61326 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225316AbTKDJe3>;
	Tue, 4 Nov 2003 09:34:29 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hA49YPQG018219;
	Tue, 4 Nov 2003 10:34:26 +0100 (MET)
Date: Tue, 4 Nov 2003 10:34:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: David Kesselring <dkesselr@mmc.atmel.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: lib.a
In-Reply-To: <20031104005039.GA27415@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0311041033030.2050-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Nov 2003, Ralf Baechle wrote:
> On Mon, Nov 03, 2003 at 05:22:42PM -0500, David Kesselring wrote:
> > The function that I am missing (release_firmware) is compiled into
> > lib/lib.a. and shows up in lib.a.flags. But it does not show up in vmlinux
> > binary or the symbol table. I couldn't see that the generic Malta make
> > file has any garbage collection on but I can't see where it is lost.
> > What I get is unresolved symbols when I insmod my driver.
> > Any ideas from the experts?
> 
> It's a library so if no reference is preceeding the library that member
> won't be linked in.

And to be usable by a module, you have to make sure the symbol is exported by
the kernel using EXPORT_SYMBOL().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
