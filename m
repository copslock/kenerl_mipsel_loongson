Received:  by oss.sgi.com id <S553712AbRA0Vbn>;
	Sat, 27 Jan 2001 13:31:43 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:46070 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553690AbRA0Vb1>;
	Sat, 27 Jan 2001 13:31:27 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0RLSEI26703;
	Sat, 27 Jan 2001 13:28:14 -0800
Message-ID: <3A733E40.9B1F02DD@mvista.com>
Date:   Sat, 27 Jan 2001 13:31:44 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Michael Shmulevich <michaels@jungo.com>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com> <3A712D90.3CC9EBAF@jungo.com> <3A71BF37.7DBE8234@mvista.com> <3A728DCE.33C2CE8A@jungo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Michael Shmulevich wrote:
> 
> Pete Popov wrote:
> 
> > To get the realtek driver to work, all you need to do is to set
> > mips_io_port_base to KSEG1.  Let's assume that the ethernet card has
> > been assigned i/o space at 0x14000000.  The driver will pick that up as
> > the ioaddr and use the 0x1400000 as the "port". The inb()/outb() macros
> > add mips_io_port_base to the "port" value and now you have 0xB4000000,
> > so you can access the card.
> >
> > Pete
> 
> The KSEG1() is indeed what I did, however the driver, as I tried to
> describe, starts to loose synchronization on buffer at some point and
> just waits quietly... Even with all the DEBUG and mental effort switched
> on I can't get the reason why this happens...
> 
> By the way, which version of the driver are you talking about? Mine
> doesn't have any ifdef on anything... besides MODULE of course:-)
> 
> Mine is:
> 
> static const char *version =
> "rtl8139.c:v1.07 5/6/99 Donald Becker
> http://cesdis.gsfc.nasa.gov/linux/drivers/"

Hmmm, the above looks like the header for the 8129 driver, except that
it says rtl8139.  Make sure you're using drivers/net/8139too.c   I see
this in the driver:   #define RTL8139_VERSION "0.9.10". I'm using test9
kernel, I doubt that you're driver is out of date -- it seems you're
perhaps using the wrong driver.

Regarding the I/O vs MEM accesses, look for this:


/* define to 1 to enable PIO instead of MMIO */
#undef USE_IO_OPS


Pete
