Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2003 20:34:24 +0100 (BST)
Received: from [IPv6:::ffff:80.88.36.193] ([IPv6:::ffff:80.88.36.193]:27565
	"EHLO witte.sonytel.be") by linux-mips.org with ESMTP
	id <S8225457AbTJMTeM>; Mon, 13 Oct 2003 20:34:12 +0100
Received: from starflower.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id h9DJY7QG001995;
	Mon, 13 Oct 2003 21:34:07 +0200 (MEST)
Date: Mon, 13 Oct 2003 21:34:07 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Horsten <thomas@horsten.com>
cc: "Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: need help on unaligned loads,stores!
In-Reply-To: <200310131927.07171.thomas@horsten.com>
Message-ID: <Pine.GSO.4.21.0310132132550.26520-100000@starflower.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 13 Oct 2003, Thomas Horsten wrote:
> On Monday 13 October 2003 02:44, Liu Hongming (Alan) wrote:
> > I am porting linux for a cpu that doesnt support unaligned loads/stores
> > instructions.
> >
> > when using memcpy in arch/mips/memcpy.S,it will not work on these
> > instructions.
> >
> > Any one could help me to deal with this? Have you ever ported linux for
> > this kind cpu?
> >
> > And anyone could tell me which cpu doesnt support these instructions
> > either,and has
> >
> > been ported for linux?
> 
> Almost all MIPS CPU's are like this, and don't support unaligned accesses.

I guess Liu meant the (patented) instructions to do explicit unaligned
accesses.  Real MIPS CPUs do support these.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
