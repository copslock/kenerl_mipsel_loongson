Received:  by oss.sgi.com id <S554245AbRBEM5y>;
	Mon, 5 Feb 2001 04:57:54 -0800
Received: from mail.sonytel.be ([193.74.243.200]:50603 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553787AbRBEM5u>;
	Mon, 5 Feb 2001 04:57:50 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA05332;
	Mon, 5 Feb 2001 13:56:54 +0100 (MET)
Date:   Mon, 5 Feb 2001 13:56:53 +0100 (MET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:     Ralf Baechle <ralf@oss.sgi.com>,
        Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Filesystem corruption
In-Reply-To: <E14PkTf-0003DK-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.10.10102051356090.1124-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 5 Feb 2001, Alan Cox wrote:
> > 2.4.1 is known to cause fs corruption for all architectures; 2.4.0 should
> > actually be fine.  I just reached 8 days of uptime on a 32p Origin 2000,
> > so it can't be that bad.
> 
> Im tracking fs corruption and worse on 2.4.0 as well (zero page corruptions
> since 2.4.0test10 for example)

Is the zero page mapped on non-m68k architectures?

> I dont believe any 2.4 is currently 'safe'

Ugh...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
