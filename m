Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B6q7Rw015425
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 23:52:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B6q7aR015424
	for linux-mips-outgoing; Wed, 10 Jul 2002 23:52:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail2.sonytel.be [195.0.45.172])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B6pxRw015415;
	Wed, 10 Jul 2002 23:52:00 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA09556;
	Thu, 11 Jul 2002 08:56:18 +0200 (MET DST)
Date: Thu, 11 Jul 2002 08:56:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, "H. J. Lu" <hjl@lucon.org>,
   Jun Sun <jsun@mvista.com>, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: Malta crashes on the latest 2.4 kernel
In-Reply-To: <005c01c228a2$fb2bf450$10eca8c0@grendel>
Message-ID: <Pine.GSO.4.21.0207110854250.8371-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 11 Jul 2002, Kevin D. Kissell wrote:
> I note that Ralf has, in fact, applied the fix to the
> OSS CVS repository.  I also note that "BARRIER"
> is still defined to be a string of 6 nops.  I would argue
> (again) that those really, really ought to be ssnops,
> and that if they *were* ssnops, one could probably
> have fewer of them.

Sorry for being ignorant, but what's the difference between nop and ssnop?

I see that SSNOP is defined to be `sll zero,zero,1' in <asm/asm.h>, but that
doesn't give me any clue.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
