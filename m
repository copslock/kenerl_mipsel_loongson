Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A6GWV23369
	for linux-mips-outgoing; Wed, 9 May 2001 23:16:32 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A6GUF23364
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 23:16:30 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA01389;
	Thu, 10 May 2001 08:15:38 +0200 (MET DST)
Date: Thu, 10 May 2001 08:15:37 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
In-Reply-To: <20010510055512.96321.qmail@web11902.mail.yahoo.com>
Message-ID: <Pine.GSO.4.10.10105100811070.19268-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 9 May 2001, Wayne Gowcher wrote:
> I was wondering if anyone has any experience in
> configuring the PCI registers in a PCI Video Card on a
> MIPS board that has no BIOS like in a PC.
> 
> At the moment when I have some "home grown" PCI
> probing routines based on my best interpretation of
> the PCI spec. But it's not working.
> 
> I can probe the Base Address Register successfully,
> determine the cards memory requirement and that it is
> memory rather than mapped IO. But when I try to write
> the address I have allocated to the PCI card ( eg
> 0xC000 0000 ) the address will not latch in the base
> address register.
> 
> The card is designed for x86 PCs and when the PC bios
> configures the card, the base address register has the
> value 0xF200 0000.
> 
> Any comments from anybody with any insight into what
> is happening here / or how I might fix my probelm,
> would be greatly appreciated.
> 
> Does anyone know of any code that carries out PCI
> probing similar to that found on x86 PC's ?

Initialising video cards is a real PITA. The simplest method is to use a x86
BIOS emulator to execute the code in the video BIOS on the card.

Note that some cards (mostly older cards) power up in VGA legacy mode. They
will not respond to PCI memory space as specified by the BAR before you tell
them to do so (in a card-specific way :-(

Most modern cards power up in PCI mode. However, to use them, you still have to
know the card-specific initialization sequence.

BTW, what video card do you have? If you're lucky and have a Matrox Millennium,
you can use matroxfb, which knows how to initialize uninitialized cards.

Good luck!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
