Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4REEFnC006877
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 07:14:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4REEFY4006876
	for linux-mips-outgoing; Mon, 27 May 2002 07:14:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4REE5nC006872
	for <linux-mips@oss.sgi.com>; Mon, 27 May 2002 07:14:08 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA01210;
	Mon, 27 May 2002 16:14:38 +0200 (MET DST)
Date: Mon, 27 May 2002 16:14:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
In-Reply-To: <029b01c20588$16335830$10eca8c0@grendel>
Message-ID: <Pine.GSO.4.21.0205271608040.15706-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 27 May 2002, Kevin D. Kissell wrote:
> > One of the exceptions is matroxfb, which is able to initialize older Matrox
> > cards. This should cover all their PCI cards (Matrox didn't release any new PCI
> > cards during the last few years).
> 
> They still sell/support the G450PCI, which has TV output support,
> and a flat-panel transmitter, and which might do the job for me.

Oh, I didn't know they made PCI cards after the G200 (which was hard to get in
its PCI variant). In fact they responded negatively when we (the PPC guys,
thinking about designing our own PPC motherboards) asked them if they intended
to release other PCI chips after the G200, for platforms that lacked AGP
support.

BTW, the FAQ on Matrox' website says:

|  1. What happens if I use the Millennium G450 PCI in a system with a
|  non-Intel chipset?
|
|     1. The G450 PCI does not support bus-mastering with non-Intel chipsets.
|     While this lowers performance on synthetic benchmarks, it does not hinder
|     the everyday usability of the card. Additionally, the Millennium G450 PCI
|     does not support OpenGL acceleration (primarily used for 3D gaming) or
|     DVDMax with non-Intel chipsets.

> Can anyone confirm that the matroxfb support works for it?

I'm not sure matroxfb support full initialization of the '450. You best ask
Petr Vandrovec.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
