Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 May 2004 10:09:33 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:7868 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225534AbUEIJJc>;
	Sun, 9 May 2004 10:09:32 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i4999Uwc029668;
	Sun, 9 May 2004 11:09:30 +0200 (MEST)
Date: Sun, 9 May 2004 11:09:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: semaphore woes in 2.6, 32bit
In-Reply-To: <20040508224806.A24682@mvista.com>
Message-ID: <Pine.GSO.4.58.0405091108150.26985@waterleaf.sonytel.be>
References: <20040507181031.F9702@mvista.com> <20040508071822.GA29554@linux-mips.org>
 <20040508224806.A24682@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 8 May 2004, Jun Sun wrote:
> On Sat, May 08, 2004 at 09:18:22AM +0200, Ralf Baechle wrote:
> > On Fri, May 07, 2004 at 06:10:31PM -0700, Jun Sun wrote:
> >
> > > I got a bunch of segfaults which are due to HAS_LLSCD cpu operating
> > > on a semaphore which is aligned along 4-byte boundary instead of the
> > > desired 8-byte boundary.
> >
> > Dare to give a complete version number?  I've dumped 2.4 on all my systems
> > months ago and never have seen this problem except with slab debugging
> > enabled - but that side effect of slab debugging is known since years.
> >
>
> Kernel is yesterday's CVS. gcc is 3.3.1.  config is ddb5477.  No
> additional patch.  See below.
>
> In any case if you look at the uart code you should see there
> is a problem already.  'state' is allocated through kmalloc() which only
> gives 4-byte alignement.  The only puzzling thing is that why this
> did not show up before.  Maybe kmalloc() was giving 8-byte aligned block?

AFAIK, kmaloc() always[*] returns 8-byte (or higher, for archs that need it)
aligned blocks.

[*] But I did see reports of this being false if slab debugging was enabled.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
