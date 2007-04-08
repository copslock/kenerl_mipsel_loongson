Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 00:27:52 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:19680 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022768AbXDHX13 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2007 00:27:29 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Hagk6-0007Fk-00; Mon, 09 Apr 2007 01:24:18 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 10154C223D; Mon,  9 Apr 2007 01:07:10 +0200 (CEST)
Date:	Mon, 9 Apr 2007 01:07:10 +0200
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Change PCI host bridge setup/resources
Message-ID: <20070408230710.GA9092@alpha.franken.de>
References: <20070408113457.GB7553@alpha.franken.de> <4619245F.4030704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4619245F.4030704@ru.mvista.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Apr 08, 2007 at 09:20:31PM +0400, Sergei Shtylyov wrote:
> > static struct plat_serial8250_port pcit_cplus_data[] = {
> >-	PORT(0x3f8, 4),
> >+	PORT(0x3f8, 0),
> > 	PORT(0x2f8, 3),
> > 	PORT(0x3e8, 4),
> > 	PORT(0x2e8, 3),
> 
>    Hm, what is that -- UART #1 without IRQ?

workaround for not fully working interrupts on UART1. IRQ 0 means
polling. Read the source.

> > static struct resource sni_io_resource = {
> >-	.start	= 0x00001000UL,
> >+	.start	= 0x00000000UL,
> > 	.end	= 0x03bfffffUL,
> >-	.name	= "PCIT IO MEM",
> >+	.name	= "PCIT IO",
> > 	.flags	= IORESOURCE_IO,
> > };
> 
>    Why us this necessary, only beacuse compatible peripherals are behind 
>    PCI?
> EISA is behind PCI as well, yet you're setting PCIBIOS_MIN_IO to 0x9000. 
> Does this all really make sense? :-/

it does, how about reading the PCI code ?

EISA IO address space is 0x0000 - 0xffff, so this IO addresses need to
be forwarded by the PCI host bridge. PCIBIOS_MIN_IO is for the PCI
address assignment code, and tells this code to start allocating IO
space starting at 0x9000. This is needed because the pci eisa code
will use n + 0x1000 as EISA slot base addresses, which gives 0x8000
for the 8th (last) slot. So it's IMHO a good idea to avoid collisions
between EISA and PCI for IO space.

>    This is certainly *not* a PCI or [E]ISA resource. It's decoded by the 
> *host* bridge.

so ? It's an IO address no device should use, because it won't work.
Therefore mark it busy. That's all the code does.

> > 		.start	=  0xcfc,
> > 		.end	= 0xcff,
> > 		.name	= "PCI config data",
> 
>    Well, why not just join them into one?

what's your point ? This stuff is all about giving some hints and
avoiding address assignment collisions. I could just drop the whole
table and nothing will change, because the PCI code doesn't assign
IO addresses below 0x9000. Fine with me, but I think it doesn't hurt
to know, what IO addresses are used for some stuff.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
