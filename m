Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2005 12:37:57 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:47800 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226155AbVFCLhl>;
	Fri, 3 Jun 2005 12:37:41 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j53BbeEe000978;
	Fri, 3 Jun 2005 13:37:40 +0200 (MEST)
Date:	Fri, 3 Jun 2005 13:37:39 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thiemo Seufer <ths@networkno.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050603113047.GB11061@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0506031336470.16362@numbat.sonytel.be>
References: <20050603022113Z8226140-1340+8064@linux-mips.org>
 <20050603092205.GA4573@linux-mips.org> <20050603102140.GA1610@hattusa.textio>
 <Pine.LNX.4.62.0506031311200.16362@numbat.sonytel.be> <20050603113047.GB11061@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 3 Jun 2005, Ralf Baechle wrote:
> On Fri, Jun 03, 2005 at 01:12:03PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 3 Jun 2005, Thiemo Seufer wrote:
> > > --- include/asm-mips/hazards.h	3 Jun 2005 02:21:07 -0000	1.1.2.3
> > > +++ include/asm-mips/hazards.h	3 Jun 2005 10:16:28 -0000
> > > @@ -46,6 +46,7 @@
> > >  #define mtc0_tlbw_hazard						\
> > >  	b	. + 8
> > >  #define tlbw_eret_hazard
> > 
> > Missing backslash at end of line?
> 
> 
> Some processors have a 0-cycle hazard between a tlb write and eret.

I understand. But unless I'm mistaken, the compiler will complain about the
lonely `nop' if the preceding line doesn't end with a backslash.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
