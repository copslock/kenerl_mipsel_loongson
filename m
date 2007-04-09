Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 15:43:08 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:13239 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20022954AbXDIOnG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Apr 2007 15:43:06 +0100
Received: (qmail 22120 invoked from network); 9 Apr 2007 14:41:39 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 9 Apr 2007 14:41:39 -0000
Message-ID: <461A50E0.1060602@ru.mvista.com>
Date:	Mon, 09 Apr 2007 18:42:40 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Change PCI host bridge setup/resources
References: <20070408113457.GB7553@alpha.franken.de> <4619245F.4030704@ru.mvista.com> <20070408230710.GA9092@alpha.franken.de>
In-Reply-To: <20070408230710.GA9092@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Bogendoerfer wrote:

>>>static struct plat_serial8250_port pcit_cplus_data[] = {
>>>-	PORT(0x3f8, 4),
>>>+	PORT(0x3f8, 0),
>>>	PORT(0x2f8, 3),
>>>	PORT(0x3e8, 4),
>>>	PORT(0x2e8, 3),

>>   Hm, what is that -- UART #1 without IRQ?

> workaround for not fully working interrupts on UART1. IRQ 0 means
> polling. Read the source.

    Thanks, I've read it quite a lot already. But is UART3 IRQ working (being 
the same as UART1's)?

>>>static struct resource sni_io_resource = {
>>>-	.start	= 0x00001000UL,
>>>+	.start	= 0x00000000UL,
>>>	.end	= 0x03bfffffUL,
>>>-	.name	= "PCIT IO MEM",
>>>+	.name	= "PCIT IO",
>>>	.flags	= IORESOURCE_IO,
>>>};

>>   Why us this necessary, only beacuse compatible peripherals are behind 
>>   PCI?
>>EISA is behind PCI as well, yet you're setting PCIBIOS_MIN_IO to 0x9000. 
>>Does this all really make sense? :-/

> it does, how about reading the PCI code ?

    To me, it doesn't make much sense with or without reading the code.
And note that no other boards claim ports 0x0000 thru 0x0fff to PCI.

> EISA IO address space is 0x0000 - 0xffff, so this IO addresses need to
> be forwarded by the PCI host bridge.

    No need to educate me about EISA.

> PCIBIOS_MIN_IO is for the PCI
> address assignment code, and tells this code to start allocating IO
> space starting at 0x9000.

    I know that too.

> This is needed because the pci eisa code
> will use n + 0x1000 as EISA slot base addresses, which gives 0x8000
> for the 8th (last) slot. So it's IMHO a good idea to avoid collisions
> between EISA and PCI for IO space.

    Yeah, and I'd given 0x00009000 as PCI I/O start address for that same 
purpose. [E]ISA resources, while being accessed (via PCI bus as a proxy) are 
generally not a part of PCI bus.

>>   This is certainly *not* a PCI or [E]ISA resource. It's decoded by the 
>>*host* bridge.

> so ? It's an IO address no device should use, because it won't work.
> Therefore mark it busy. That's all the code does.

    It just shouldn't appear under PCI bus in the resource hierarchy.

>>>		.start	=  0xcfc,
>>>		.end	= 0xcff,
>>>		.name	= "PCI config data",

>>   Well, why not just join them into one?

> what's your point ? This stuff is all about giving some hints and
> avoiding address assignment collisions. I could just drop the whole
> table and nothing will change, because the PCI code doesn't assign
> IO addresses below 0x9000. Fine with me, but I think it doesn't hurt
> to know, what IO addresses are used for some stuff.

    You're changing PCI I/O space start address for no apparent reason which 
seems to break general 8259 code.

> Thomas.

WBR, Sergei
