Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 12:20:36 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:34455 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226016AbVDDLUU>;
	Mon, 4 Apr 2005 12:20:20 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j34BKIGU005292;
	Mon, 4 Apr 2005 13:20:18 +0200 (MEST)
Date:	Mon, 4 Apr 2005 13:20:15 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Ulrich Eckhardt <eckhardt@satorlaser.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: conflicting declaration of prom_getcmdline()
In-Reply-To: <20050404062105.GA4975@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0504041318590.14107@numbat.sonytel.be>
References: <200504011028.04244.eckhardt@satorlaser.com>
 <20050404062105.GA4975@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 4 Apr 2005, Ralf Baechle wrote:
> On Fri, Apr 01, 2005 at 10:28:04AM +0200, Ulrich Eckhardt wrote:
> > I just stumbled over arch/mips/au1000/common/prom.c, which contains a function 
> > defined like this:
> >   char* prom_getcmdline(void);
> >   EXPORT_SYMBOL(prom_getcmdline);
> > while there are implementations that define the function as
> >   char* __init prom_getcmdline();
> > Further, there are several declarations throughout sourcefiles and in 
> > include/asm-mips/mips-boards/prom.h and include/asm-mips/sgialib.h. Just grep 
> > for it and you'll see the mess.
> > 
> > If anyone tells me which one is right and cares to explain why I hereby 
> > volunteer to create a patch. ;)
> 
> __init was introduced long after prom_getcmdline() and not all definitions
> ever got updated.  For prototypes where __init doesn't server any useful
> purpose other than for the human reader so we generally don't use it.

IIRC, there are architectures (alpha?) where __init does matter for prototypes
because a different jump type is used depending on the sections of the caller
and callee.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
