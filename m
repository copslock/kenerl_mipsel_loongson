Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2005 08:34:51 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:10466 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224817AbVG1HeI>;
	Thu, 28 Jul 2005 08:34:08 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j6S7aYpr020732;
	Thu, 28 Jul 2005 09:36:34 +0200 (MEST)
Date:	Thu, 28 Jul 2005 09:36:16 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Niels Sterrenburg <pulsar@kpsws.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050727192816.GF3626@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0507280935040.24391@numbat.sonytel.be>
References: <20050725213607Z8225534-3678+4335@linux-mips.org>
 <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
 <20050727172427.GB3626@linux-mips.org> <Pine.LNX.4.61L.0507271858050.13819@blysk.ds.pg.gda.pl>
 <20050727192816.GF3626@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 27 Jul 2005, Ralf Baechle wrote:
> On Wed, Jul 27, 2005 at 07:03:16PM +0100, Maciej W. Rozycki wrote:
> >  It doesn't wipe other rubbish like spaces followed by tabs, though -- 
> > e.g. ones that would match "^ \t".  Perhaps `indent' could help with them, 
> > but I trust my fingers and eyes instead. ;-)
> 
> Of course it does:
> 
> [ralf@box ~]$ echo -ne '  \t\t' | perl -pi -e 's/[ \t]+$//' | od -x
> 0000000
> [ralf@box ~]$

Maciej meant spaces followed by tabs that do not end a line, e.g.

| tux$ echo -ne '  \t\tx' | perl -pi -e 's/[ \t]+$//' | od -x
| 0000000 2020 0909 0078
| 0000005

These are a bit more difficult to auto-remove, since simply removing them may
change indentation (modulo 8).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
