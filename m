Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 20:22:22 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:21153 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225362AbUBEUWW>;
	Thu, 5 Feb 2004 20:22:22 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i15KMKw2003809;
	Thu, 5 Feb 2004 21:22:20 +0100 (MET)
Date: Thu, 5 Feb 2004 21:22:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [ANNOUNCE] "cvs explorer" for linux-mips CVS tree
In-Reply-To: <20040205100525.B9885@mvista.com>
Message-ID: <Pine.GSO.4.58.0402052117470.20594@waterleaf.sonytel.be>
References: <20040204150820.H26726@mvista.com> <Pine.GSO.4.58.0402051218590.11549@waterleaf.sonytel.be>
 <20040205100525.B9885@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 5 Feb 2004, Jun Sun wrote:
> On Thu, Feb 05, 2004 at 12:19:34PM +0100, Geert Uytterhoeven wrote:
> > On Wed, 4 Feb 2004, Jun Sun wrote:
> > > I wrote a CVS tracking tool that tracks CVS changes in patch format
> > > and present them with a web interface.  It is now set up to track
> > > linux-mips.org tree at the following place.  Enjoy.
> > >
> > > http://www.linux-mips.org/xcvs/linux-mips
> >
> > http://www.linux-mips.org/xcvs/html/select.php
> > | Warning: Assertion failed in /var/www/www.linux-mips.org/xcvs/html/db.inc.php on line 36
> > | Warning: readfile("/LAST_UPDATE") - No such file or directory in /var/www/www.linux-mips.org/xcvs/html/select.inc.php on line 47
> >
>
> It appears session somehow does not work on your web viewer.  What is
> your web browser anyway?

Galeon (from Debian testing or unstable on ia32).

> Immediately after you hit above link, please redirect URL to

OK, I'll retry (at home, with a similar Galeon but on PPC):

> http://www.linux-mips.org/xcvs/test.php
>
> If you don't see following, that means sessions do not work.
>
> ------------------------------------------------
> dbname : xcvs_linux_mips
> patchdir : ../linux-mips/patches
> branch : MAIN
> author : all authors
> starting-date :
> ending-date :
> -----------------------------------------------

... and all I see is the two lines with hyphens.

> Anybody else has similar problems?

OK, if I enable cookies, it works fine! Nice!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
