Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MIWEs20474
	for linux-mips-outgoing; Tue, 22 Jan 2002 10:32:14 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MIW8P20470
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 10:32:08 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0MHUAB24458;
	Tue, 22 Jan 2002 09:30:10 -0800
Subject: Re: usb-problems with Au1000
From: Pete Popov <ppopov@pacbell.net>
To: Kunihiko IMAI <kimai@laser5.co.jp>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <m37kqa7lpq.wl@l5ac152.l5.laser5.co.jp>
References: <3B7DA3A3.8010000@pacbell.net> <3C3DD208.45B5BC29@esk.fhg.de>
	<m3bsft6z87.wl@l5ac152.l5.laser5.co.jp> <1011294123.4550.58.camel@zeus>
	<m3advc6xhx.wl@l5ac152.l5.laser5.co.jp> <1011383349.18177.6.camel@zeus> 
	<m37kqa7lpq.wl@l5ac152.l5.laser5.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 09:33:29 -0800
Message-Id: <1011720809.28944.149.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-01-22 at 01:56, Kunihiko IMAI wrote:
> Hi,
> 
> At 18 Jan 2002 11:49:09 -0800,
> Pete Popov wrote:
> > 
> > 
> > > > It's the comment that's wrong, not the code. The code works and has been
> > > > tested.  Alchemy makes available the Linux Support Package (LSP) which
> > > > we did. That kernel has been tested with all peripherals so I would
> > > > recommend that you get that from them.  Also,make sure your jumpers are
> > > > setup correctly (S4).
> > > 
> > > In the source code:
> > > 
> > > 	sys_clksrc |= ((4<<12) | (0<<11) | (0<<10));
> > > 
> > > 	(snip...)
> > > 
> > > 	outl(sys_clksrc, CLOCK_SOURCE_CNTRL);
> > > 
> > > This code sets the clock source of USB host controller is FREQ2.  So
> > > FREQ5 clock source doesn't affect to USB host controller.
> > 
> > After looking into it, both the comment and code are correct. From
> > include/asm-mips/au1000.h:
> > 
> > #define FQ_CNTRL_1                0xB1900020
> > #define FQ_CNTRL_2                0xB1900024
> > 
> > So FQ_CNTRL_1 corresponds to what is now sys_freqctrl0. In other words,
> > the update to the databook has not been incorporated into the Au1000
> > files. The names of the registers were updated after I had done all the
> > core work. I need to update the code so the names of the registers
> > correspond to the latest Au1000 manual.
> 
> Oh, I see.  I'm sorry for my misunderstanding.

It's OK, one of these days I'll have time to rename all the registers to
match the last data book.

Pete
 
> Now the relations are like this:
> 
> Au1000 manual	Linux Header
> -----------------------------------
> sys_freqctl0	FQ_CNTRL_1
> sys_freqctl1	FQ_CNTRL_2
> -----------------------------------
