Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IIxhh05276
	for linux-mips-outgoing; Fri, 18 Jan 2002 10:59:43 -0800
Received: from hermes.mvista.com ([12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IIxYP05273
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 10:59:34 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0IHvTB07255;
	Fri, 18 Jan 2002 09:57:34 -0800
Subject: Re: usb-problems with Au1000
From: Pete Popov <ppopov@pacbell.net>
To: Kunihiko IMAI <kimai@laser5.co.jp>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <m3advc6xhx.wl@l5ac152.l5.laser5.co.jp>
References: <3B7DA3A3.8010000@pacbell.net> <3C3DD208.45B5BC29@esk.fhg.de>
	<m3bsft6z87.wl@l5ac152.l5.laser5.co.jp> <1011294123.4550.58.camel@zeus> 
	<m3advc6xhx.wl@l5ac152.l5.laser5.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Jan 2002 09:59:50 -0800
Message-Id: <1011376794.13904.37.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Of course, I patched usb-ohci code with memory mapped I/O support.
> It is very ugly code, so Linux USB stuff will not accept, I think.

I think the work we did was clean, but it wasn't accepted anyway.
Although, Steve L.'s initial work on mips usb did get accepted and that
gave us usb on the it8172 system controller.
 
> About two years ago, I ported USB OHCI to StrongARM SA1111 CPU and
> SA1111 companion chip.  At that time, I suggested to the author of
> usb-ohci.c that it should be better to support of memory mapped I/O
> device, but it was not accepted.  On StrongARM, it has DMA memory
> coherency problem, too. (Au1000 has bus snoop function, so this is not
> a problem.)
> 
> > > The errata report says workaround method:
> > > - set the CPU clock is 384MHz
> > > - set the source of USB host controller is CPU clcck.
> > > 
> > > And the code:
> > > 
> > >         /*
> > >          * Setup 48MHz FREQ2 from CPUPLL for USB Host
> > >          */
> > >         /* FRDIV2=3 -> div by 8 of 384MHz -> 48MHz */
> > >         sys_freqctrl |= ((3<<22) | (1<<21) | (0<<20));
> > >         outl(sys_freqctrl, FQ_CNTRL_1);
> > > 
> > > Comment says "Setup FREQ2" but the code set FREQ5.
> > 
> > It's the comment that's wrong, not the code. The code works and has been
> > tested.  Alchemy makes available the Linux Support Package (LSP) which
> > we did. That kernel has been tested with all peripherals so I would
> > recommend that you get that from them.  Also,make sure your jumpers are
> > setup correctly (S4).
> 
> In the source code:
> 
> 	sys_clksrc |= ((4<<12) | (0<<11) | (0<<10));
> 
> 	(snip...)
> 
> 	outl(sys_clksrc, CLOCK_SOURCE_CNTRL);
> 
> This code sets the clock source of USB host controller is FREQ2.  So
> FREQ5 clock source doesn't affect to USB host controller.
 
I'll take a look at it, thanks.

 
> And I found HHL version of kernel source code in Pb1000 CD-ROM.  I'll
> read it.

I don't think you have the latest CDROM. That one you have probably has
an older version of the LSP.
 
> 
> > I do have a better USB workaround which checks the CPU silicon rev, but
> > I haven't had time to send Ralf an updated patch. The current setup.c
> > should work though.  Get the latest LSP from Alchemy, check the S4
> > jumpers (1-4 off, 5-6 on, 7-8 off), and let me know if it still doesn't
> > work for you.
> 
> OK.  I checked S4 DIP SW, it was setted same config.
> # Pb1000 documentation doesn't clearly explain at this configration.
> # So I looked schematics of Pb1000.
> 
> This switch affects only J24 connector setting.  J2 connector is not
> affected by S4.

The CDROM you have is most definitely old and might not have the latest
usb code.  Try the latest LSP from Alchemy. The rpms should have
"hhl2.0.3" or later in the string.

Pete
