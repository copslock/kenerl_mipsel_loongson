Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 16:21:48 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:23971 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022973AbXDIPVr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2007 16:21:47 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Havdc-0000eh-00; Mon, 09 Apr 2007 17:18:36 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2B488C223F; Mon,  9 Apr 2007 17:16:30 +0200 (CEST)
Date:	Mon, 9 Apr 2007 17:16:30 +0200
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Change PCI host bridge setup/resources
Message-ID: <20070409151630.GA9284@alpha.franken.de>
References: <20070408113457.GB7553@alpha.franken.de> <4619245F.4030704@ru.mvista.com> <20070408230710.GA9092@alpha.franken.de> <461A50E0.1060602@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461A50E0.1060602@ru.mvista.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Apr 09, 2007 at 06:42:40PM +0400, Sergei Shtylyov wrote:
> >workaround for not fully working interrupts on UART1. IRQ 0 means
> >polling. Read the source.
> 
>    Thanks, I've read it quite a lot already. But is UART3 IRQ working 
>    (being the same as UART1's)?

right now, none of the ISA interrupts are working on that machine,
probably because I'm missing some IRQ routing setup. The workaround is
there to get serial console working in userspace.

>    To me, it doesn't make much sense with or without reading the code.
> And note that no other boards claim ports 0x0000 thru 0x0fff to PCI.

no other board MIPS board has EISA behind PCI afaik. So this is a new
situation.

>    Yeah, and I'd given 0x00009000 as PCI I/O start address for that same 
> purpose. [E]ISA resources, while being accessed (via PCI bus as a proxy) 
> are generally not a part of PCI bus.

it would help, if you would try to understand the stuff first. Just read
the EISA code...

>    You're changing PCI I/O space start address for no apparent reason which 
> seems to break general 8259 code.

could you try to understand the issue please ? I could leave the i8259
code alone and everything will work as before. Only the entries for
the PIC would be missing in /proc/iomem (which I could kludge around
by adding them to the pcit/pcimt resource list). Every other platform 
won't see a difference, because no other platform needs to request the
PCI IO space starting at 0x0000. 

I've checked the platform device code, and it uses insert_region() like
my proposed change for i8259. So I'm pretty sure, that's the way to
go.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
