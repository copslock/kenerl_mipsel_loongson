Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6I7Ip008074
	for linux-mips-outgoing; Wed, 18 Jul 2001 00:18:51 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6I7InV08068
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 00:18:49 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA03094;
	Wed, 18 Jul 2001 09:18:10 +0200 (MET DST)
Date: Wed, 18 Jul 2001 09:18:10 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: James Simmons <jsimmons@transvirtual.com>
cc: Fuxin Zhang <fxzhang@ict.ac.cn>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: help on linux-mipsel frame buffer
In-Reply-To: <Pine.LNX.4.10.10107171655090.22673-100000@transvirtual.com>
Message-ID: <Pine.GSO.4.21.0107180916490.10746-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 17 Jul 2001, James Simmons wrote:
> >   First I try the vga16 frame buffer driver,but i can only get
> > some black/white strips on the screen.(after made some changes 
> > to the source,most important one is use pci to find and set the
> > vbase address). 
> 
> It is hardwired into the vga16fb driver the memory region (0xA000). This
> is very wrong on non intel platforms. So that drivers pretty much doesn't
> work on anything else.

Does your firmware initialize the VGA card to VGA text mode? Vga16fb requires
this initialization, which is normally done by the VGA BIOS. An x86
BIOS-emulator may be your friend.

> >   Then I try to use vesa driver. This one use some vgabios code 
> > I commented out the x86 relevant codes and made it compiled,
> 
> The VESA framebuffer is also intel specific. It uses the BIOS to setup the
> video mode. This is done long before the cpu is placed into protect mode.

Similar issue here.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
