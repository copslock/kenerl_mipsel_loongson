Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 16:14:52 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:38029 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEWPOu>;
	Fri, 23 May 2003 16:14:50 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4NFEaLT018919;
	Fri, 23 May 2003 17:14:36 +0200 (MEST)
Date: Fri, 23 May 2003 17:14:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Vr41xx unaligned access update
In-Reply-To: <Pine.GSO.3.96.1030523165223.14542I-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0305231713540.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 23 May 2003, Maciej W. Rozycki wrote:
> On Fri, 23 May 2003, Geert Uytterhoeven wrote:
> > >  Hmm, what tree is it against?  I can't see code matching these hunks in
> > > our tree at linux-mips.org.
> > 
> > Check out the 2.4.x branch. I did verify that all patches apply.
> 
>  Being much surprised I've double checked this before replying, both a
> nightly snapshot at my local system here and directly at
> ftp.linux-mips.org.  I'm using a branch tagged as "linux_2_4".  AFAIK, it
> is *the* 2.4 branch.  And AFAIK, it is the only branch that is actively
> maintained these days.
> 
>  Also I recall the discussion on the BD issue on these chips once, but I
> can't recall any results of it going into the CVS. 

Sorry, my fault. My `clean' Linux/MIPS CVS tree wasn't as clean as I thought.
So please ignore.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
