Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJAeZW05220
	for linux-mips-outgoing; Wed, 19 Dec 2001 02:40:35 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJAeSo05217;
	Wed, 19 Dec 2001 02:40:28 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA12872;
	Wed, 19 Dec 2001 10:40:07 +0100 (MET)
Date: Wed, 19 Dec 2001 10:40:07 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: jim@jtan.com, Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
In-Reply-To: <3C1F868C.492E155B@mvista.com>
Message-ID: <Pine.GSO.4.21.0112191034450.28694-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jun Sun wrote:
> It has nothing to isa_slot_offset here.  I don't know about the history of
> isa_slot_offset, but it appears to be faint effort to allow the access to what
> is called "ISA memory" space on PC.  This region, if it ever exists, should
> never be a separate region on a MIPS machine.  It should just be the beginning
> part of PCI Memory space.

It's indeed the beginning of PCI memory space, but only when viewed from the
viewpoint of the PCI bus itself, not necessarily from the viewpoint of the CPU.

On ia32 PCs it is, but not on many PPC boxes. And I guess on some MIPS boxes as
well.

> Ralf, we should just delete isa_slot_offset to avoid any further confusions.

Ugh...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
