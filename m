Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2003 22:17:25 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:64246 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224802AbTGEVRX>;
	Sat, 5 Jul 2003 22:17:23 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h65LGn1W013410;
	Sat, 5 Jul 2003 23:16:49 +0200 (MEST)
Date: Sat, 5 Jul 2003 23:16:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Brian Murphy <brm@murphy.dk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.4] ndelay typo?
In-Reply-To: <20030705133426.GA3750@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0307052305180.23796-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 5 Jul 2003, Ralf Baechle wrote:
> On Sat, Jul 05, 2003 at 03:22:22PM +0200, Brian Murphy wrote:
> > 	I presume you meant this?
> 
> Yes, thanks, will fix.

And don't you want to rename the `usecs' parameter of ndelay() to `nsecs'?

> I'm wondering about the Nile4 support btw.   Vrc5074 == NILE4, right?

Yep.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
