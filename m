Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 21:59:05 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:30949 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225202AbTHKU64>;
	Mon, 11 Aug 2003 21:58:56 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h7BKwDlW013978;
	Mon, 11 Aug 2003 22:58:13 +0200 (MEST)
Date: Mon, 11 Aug 2003 22:58:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Chip Coldwell <coldwell@frank.harvard.edu>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: load/store address overflow on binutils 2.14
In-Reply-To: <20030810145425.GE22977@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.21.0308112257180.20421-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 10 Aug 2003, Thiemo Seufer wrote:
> Chip Coldwell wrote:
> [snip]
> > >         printf("%016x\n", ~a);
> > > 
> > >         return 0;
> > > }
> > > 
> > > outputs
> > > 
> > > 00000000ffffffff
> > > 
> > > on my i386-linux system.
> > 
> > Strangely, this is actually "correct" behavior.  Arguments on
> > variable-length argument lists are implicitly "promoted" to unsigned
> > int at the widest.  See K&R 2nd ed. A6.1 and A7.3.2.
> 
> Ugh. Thanks for pointing this out. I wasn't aware of it.
> 
> 	printf("%016Lx\n", ~a);
> 
> Produces the expected output. So it is actually an implementation
> bug in binutils, which isn't fixable for 2.14 and earlier, because
> those have to remain at K&R C level. The K&R requirement was only
> recenly loosened.

How can it print the correct output if ~a is `promoted' to unsigned int, while
you specify %Lx in the format string?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
