Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4RDbQnC006382
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 06:37:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4RDbQTM006381
	for linux-mips-outgoing; Mon, 27 May 2002 06:37:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4RDbHnC006378
	for <linux-mips@oss.sgi.com>; Mon, 27 May 2002 06:37:20 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA28194;
	Mon, 27 May 2002 15:37:28 +0200 (MET DST)
Date: Mon, 27 May 2002 15:37:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
cc: "Kevin D. Kissell" <kevink@mips.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
In-Reply-To: <3CF233DA.2040602@realitydiluted.com>
Message-ID: <Pine.GSO.4.21.0205271534430.15706-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 27 May 2002, Steven J. Hill wrote:
> Kevin D. Kissell wrote:
> > I'd like to get a video-capable graphics card up
> > and running on a MIPS Malta board (therefore
> > PCI), ideally something mainstream like ATI.
> > Does anyone on the list have any positive or
> > negative recommendations in terms of cards
> > and particularly in terms of the degree to which
> > the drivers (and PCI set-up) have been ported
> > to MIPS/Linux?  I'll do what I must, but I hate
> > re-inventing the wheel.
> > 
> I can think of two things. First, a lot of graphics cards
> rely on BIOS calls to be set up before the operating system
> even boots. Second, I would stick to graphics cards that
> have framebuffer support in the kernel as you stand at least
> half a chance that those cards don't rely so heavily on a
> peecee bios. Just my $.02.

Even then, most frame buffer device drivers rely on the firmware (PC BIOS or
SPARC/PPC Open Firmware) having set up the video card.

One of the exceptions is matroxfb, which is able to initialize older Matrox
cards. This should cover all their PCI cards (Matrox didn't release any new PCI
cards during the last few years).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
