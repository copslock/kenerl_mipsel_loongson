Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2003 13:02:00 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:2264 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225343AbTHBMB4>;
	Sat, 2 Aug 2003 13:01:56 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h72C1m1W012821;
	Sat, 2 Aug 2003 14:01:48 +0200 (MEST)
Date: Sat, 2 Aug 2003 14:01:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumba <kumba@gentoo.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: udelay
In-Reply-To: <3F2B2521.2060508@gentoo.org>
Message-ID: <Pine.GSO.4.21.0308021401150.543-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Aug 2003, Kumba wrote:
> Pete Popov wrote:
> > Looks like the latest udelay in 2.4 is borked. Anyway else notice that
> > problem?  I did a 10 sec test: mdelay works, udelay is broken, at least
> > for the CPU and toolchain I'm using.
> 
> What's one way of testing this brokeness?  I've been trying to find some 
> explanation for a bug of some sort in a cobalt RaQ2 in which the tulip 
> driver (eth0) just stops dead after several minutes of use.  One of the 
> notable features of the tulip driver patch needed to work on the RaQ2 
> adds a "udelay(1000)" into the tulip source.  Without it, the eth0 on 
> the RaQ2 is dead, so I wonder if these are related.
> 
> If they are related, then this behavior has been slowly getting worse it 
> seems, as eth0 on the RaQ2 apparently has had smaller and smaller 
> amounts of time needed before the interface died.  2.4.18, it took most 
> of a day, by 2.4.21, it happens within seconds.

Any kernel messages (e.g. transmit timed out) from the tulip driver when it
dies?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
