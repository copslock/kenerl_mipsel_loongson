Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2IFIaK31226
	for linux-mips-outgoing; Mon, 18 Mar 2002 07:18:36 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2IFIW931221
	for <linux-mips@oss.sgi.com>; Mon, 18 Mar 2002 07:18:32 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA00074;
	Mon, 18 Mar 2002 16:19:01 +0100 (MET)
Date: Mon, 18 Mar 2002 16:19:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Girish Gulawani <girishvg@yahoo.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: PCI VGA Card Initilization (SIS6326 / PT80)
In-Reply-To: <033401c1ce8f$cbec7100$ebcc7d3d@gol.com>
Message-ID: <Pine.GSO.4.21.0203181617040.5561-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 19 Mar 2002, Girish Gulawani wrote:
> i have a PCI/VGA card PT80 with SIS6326 chipset. i am using MILO BIOS source
> code. but i am not able to access the internal buffer which is typically at
> 0xA0000. even the BIOS ROM (0xC0000) read fails to show default value
> 0xA5A5. the expansion ROM is enabled in PCI by setting D0 bit to 1. however
> IO seems okay because the monitor actually switches from power down mode to
> normal mode. i have tried using both vgaraw1.c and vgaraw2.c files, but no
> success. could anybody help me to solve this problem.
> many thanks.

Are you using isa_readb() and friends to access ISA memory space?
Did you set up isa_slot_offset correctly with the start address of ISA memory
space on your MIPS box?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
