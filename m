Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2JA9iY23056
	for linux-mips-outgoing; Tue, 19 Mar 2002 02:09:44 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2JA9c923053
	for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 02:09:38 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA29924;
	Tue, 19 Mar 2002 11:10:16 +0100 (MET)
Date: Tue, 19 Mar 2002 11:10:16 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Girish Gulawani <girishvg@yahoo.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: PCI VGA Card Initilization (SIS6326 / PT80)
In-Reply-To: <005101c1ced7$262a9560$b8900dd3@gol.com>
Message-ID: <Pine.GSO.4.21.0203191108030.29351-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 19 Mar 2002, Girish Gulawani wrote:
> > > i have a PCI/VGA card PT80 with SIS6326 chipset. i am using MILO BIOS
> source
> > > code. but i am not able to access the internal buffer which is typically
> at
> > > 0xA0000. even the BIOS ROM (0xC0000) read fails to show default value
> > > 0xA5A5. the expansion ROM is enabled in PCI by setting D0 bit to 1.
> however
> > > IO seems okay because the monitor actually switches from power down mode
> to
> > > normal mode. i have tried using both vgaraw1.c and vgaraw2.c files, but
> no
> > > success. could anybody help me to solve this problem.
> > > many thanks.
> >
> > Are you using isa_readb() and friends to access ISA memory space?
> > Did you set up isa_slot_offset correctly with the start address of ISA
> memory
> > space on your MIPS box?
> no i am not using isa_readb() etc. infact i am accessing this area 0xA_0000
> as Memory/IO in memory mode. i have seen the pci bus transactions, its
> generating memory read and memory write commands. but due to some reason
> that is still *unknown* to me generates master abort. i always get master
> received master abort. could you tell me what could be the reason?

Plain memory I/O can work, but is not portable.  You should use isa_readb() and
friends, though, after setting up isa_slot_offset.

It looks like you have access to some PCI bus analyzer? Do you see memory read
and write commands for the correct PCI bus addresses (e.g. 0xa0000)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
