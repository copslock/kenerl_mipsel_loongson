Received:  by oss.sgi.com id <S554095AbRAZSRg>;
	Fri, 26 Jan 2001 10:17:36 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:37880 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S554092AbRAZSR2>;
	Fri, 26 Jan 2001 10:17:28 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0QIDvI19908;
	Fri, 26 Jan 2001 10:13:57 -0800
Message-ID: <3A71BF37.7DBE8234@mvista.com>
Date:   Fri, 26 Jan 2001 10:17:27 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Michael Shmulevich <michaels@jungo.com>
CC:     no To-header on input <"unlisted-recipients:;"@hermes.mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com> <3A712D90.3CC9EBAF@jungo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Michael Shmulevich wrote:
> 
> Pete Popov wrote:
> >
> >
> > Another one is the RTL8139.  It's quite cheap (I think less than $20).
> >
> > Pete
> 
> Surprisingly enough, Realtek's driver is quite x86-oriented. It uses
> some ugly outb() functtions without any ioremap()'ping.

> We tried to modify it to work for MIPS, but failed. There are some
> hard-to-detect situations, when driver just cannot talk to the hardware,
> probably due to transmit/receive buffer synchronization. But after some
> period the connection is restored (reset?).


The 8139 driver (at least the latest one) has an "ifdef" option to use
I/O or memory mapping. I've tried both and both work fine without any
modifications.  The I/O works fine, provided that you've set things up
correctly.

The inb()/outb() functions are part of just about every driver,
unfortunately.  I really don't like this x86 emulation, but if you want
to be able to use drivers without having to modify every one of them,
you'll have to do this.

To get the realtek driver to work, all you need to do is to set
mips_io_port_base to KSEG1.  Let's assume that the ethernet card has
been assigned i/o space at 0x14000000.  The driver will pick that up as
the ioaddr and use the 0x1400000 as the "port". The inb()/outb() macros
add mips_io_port_base to the "port" value and now you have 0xB4000000,
so you can access the card.  

Pete
