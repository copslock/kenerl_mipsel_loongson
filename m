Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3P8B2wJ011803
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 01:11:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3P8B24H011801
	for linux-mips-outgoing; Thu, 25 Apr 2002 01:11:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3P8AuwJ011796
	for <linux-mips@oss.sgi.com>; Thu, 25 Apr 2002 01:10:57 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA16878;
	Thu, 25 Apr 2002 10:10:54 +0200 (MET DST)
Date: Thu, 25 Apr 2002 10:10:53 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jim Paris <jim@jtan.com>
cc: James Simmons <jsimmons@transvirtual.com>, Zhang Fuxin <fxzhang@ict.ac.cn>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: vga initialization
In-Reply-To: <20020424183928.A21149@neurosis.mit.edu>
Message-ID: <Pine.GSO.4.21.0204251008160.1401-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Apr 2002, Jim Paris wrote:
> > Yipes!!! It has been discussed before and no x86 emulator will go into the
> > kernel. Now what I really love to ses is a way to trace threw the bios
> > code so we can write video drivers that don't need the BIOS to work. 
> 
> If you mean "trace through" as in automatically, well, that's an x86
> emulator. :) If you mean manually, there's a problem, because every
> card is going to be entirely different.

I think he means a BIOS `compiler' instead of an `interpreter' or `emulator'.
I.e. something that generates C code which can be compiled and used to
initialize the card later, without caring about the BIOS.

Some caveats:
  - BIOS code frequently uses the timers found in a typical PC-architecture box
  - The BIOS code copyright holder may consider this as a `translation' of
    his work, i.e. copyright infringement.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
