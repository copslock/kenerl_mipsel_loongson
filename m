Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AIFu209509
	for linux-mips-outgoing; Thu, 10 May 2001 11:15:56 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AIFtF09506
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 11:15:55 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4AIFN016469;
	Thu, 10 May 2001 11:15:23 -0700
Message-ID: <3AFADA29.674BA111@mvista.com>
Date: Thu, 10 May 2001 11:12:57 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Wayne Gowcher <wgowcher@yahoo.com>
CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
References: <20010510175339.83183.qmail@web11904.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Wayne Gowcher wrote:
> 
> Geert, Pete,
> 
> Thanks for your input, it makes me question things I
> should have questioned before.

> 0xC000 0000 is the actual address I am trying to use.
> I used it because another PCI card that I have a
> driver for was using it and so I just carried on its
> use. I didnt really question the value or its use. But
> obviously it works for that card.

And this driver works on mips?  When you read the base mem register from
this card that works, it says "0xC0000000"?

> After your emails I revisited that code and now I
> partially understand why it works. The chip has an
> internal bus that translates address requests
> internally. So when i write to 0xC000 0000 it would
> never make to the actual address lines of the chip and
> instead be routed to the PCI controller ( I think :) )

I'm not clear on how this works with the good driver. If you write to
0xC000 0000, that's a mips virtual address in the kseg2 region, which is
a mapped region.  So what physical address you put on the bus when you
write to 0xC000 0000 depends on the tlb entry you've setup.  If 0xC000
0000 is truly a PCI memory physical address, then you need to setup a
tlb entry that maps some virtual address to the physical address 0xC000
0000.  I doubt you want to muck with that and would suggest you redo
your PCI bus memory map so that the PCI bus is at a lower address, like
0x1000 0000. You can then access physical 0x1000 0000 through virtual
address 0xB000 0000 (kseg1). I think you already told me, but what
board/CPU are you working with?

Pete
