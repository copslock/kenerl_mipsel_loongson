Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 20:05:31 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:60354 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225072AbTGPTF3>;
	Wed, 16 Jul 2003 20:05:29 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h6GJ5J1W010390;
	Wed, 16 Jul 2003 21:05:19 +0200 (MEST)
Date: Wed, 16 Jul 2003 21:05:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ladislav Michl <ladis@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: sudo oops on mips64 linux_2_4
In-Reply-To: <Pine.GSO.3.96.1030716205804.25959K-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0307162104450.10176-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2003, Maciej W. Rozycki wrote:
> On Wed, 16 Jul 2003, Ladislav Michl wrote:
> > >  At least we know the error is in drivers/video/fbmem.c:fbmem_read_proc() 
> > 
> > and at least we know there is something wrong. why is fbmem compiled in
> > at all?
> 
>  Well, that's not wrong per se and is actually valid at least for
> CONFIG_FB_VIRTUAL.  And the code should fail gracefully if there nothing
> useful to do.

You do not want to set CONFIG_FB_VIRTUAL=y, since the virtual frame buffer
device is meant for testing only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
