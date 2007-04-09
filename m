Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 16:10:55 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:9154 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S20022965AbXDIPKy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2007 16:10:54 +0100
Received: (qmail 22895 invoked from network); 9 Apr 2007 15:10:47 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 9 Apr 2007 15:10:47 -0000
Message-ID: <461A57B4.8020309@ru.mvista.com>
Date:	Mon, 09 Apr 2007 19:11:48 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com> <20070408131228.GA7819@alpha.franken.de> <4618ED95.6040304@ru.mvista.com> <20070408135244.GA8016@alpha.franken.de> <4619008D.1030803@ru.mvista.com> <20070408161027.GA8265@alpha.franken.de> <46191F42.6020409@ru.mvista.com> <20070408232406.GB9092@alpha.franken.de>
In-Reply-To: <20070408232406.GB9092@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Bogendoerfer wrote:

>>>request_resource will fail, because the range is already taken by
>>>sni_io_resource, while insert_region inserts the resource into 
>>>sni_io_resource.

>>   No, it shouldn't according to what I'm seeing in the code.  Perhaps I'm 
>>missing something and need to actually try executing alike code a see...

> after startup there is ioport_resource, which is 0x0000-IO_SPACE_LIMIT.
> My change in register_pci_controller will request the PCI IO space
> from 0x0000 to 0x3bffff (the maximum the PCI host bridge could address).

    Why do you need to claim I/O ports from 0, at the first place (especially 
if nobody else does this)? Apparently in your EISA system, ports 0x0 thru 
0x100 are reserved for ISA compat pereiplerals (they are behind the PCI-ISA 
bridge but that doesn't matter for this purpose), ports 0x100-0x3ff are not 
for PCI anyway (besides, that's legacy ISA card range, along with all the 
aliases), 0x1000-0x1cff, 0x2000-0x2cff, ... 0x8000-0x8cff are reserved for 
EISA slots and everything in beetween you're marking as unavailable to PCI too 
(besides, those ranges are ISA card alias ranges). So, what was the point of 
claiming all the lagacy ranges to belong to PCI and then prevent it from using 
them, (and break 8259 code by doing that)?

> request_resource from ioport_resource, which i8259.c tried to do, will
> fail now in that range, because it'ss taken by the PCI bridge. Therefore
> anybody wanting IO space in that range, must take it from the PCI 
> IO space. So doing request_region (&sni_io_resource, &pci1_io_resource);
> would have worked as well. But the code right now doesn't have a
> handle for the parent resource. insert_region() on the other side
> searches for the parent resource over the whole given resource and
> plugs the wanted resource to the right sub resource.

    OK, seeing my mistake in the code interpretation now. But I must note that 
the comment to that function *is* misguiding:

> Fine for simple house keeping, which is IMHO ok in that place.

    It's OK but I'm still not seeing why we need it at all.

>>>The problem is that init_i8259 doesn't have the right
>>>resource for doing the request_resource, if ioport_resource starting from
>>>0x0000 is already taken by a PCI host bridge.

>>   I'm not at all sure that giving out I/O addresses from 0 to PCI is a 
>>   great idea -- is it indeed necessary?

> I'm feeling like an oldtimer right now. Ever heard of ISA busses ? The

    Alas, your irony is lost on me. :-)

> address space there starts from 0x0000. There is this infamous DMA
> controller waiting exactly at IO address 0x0000-0x001f. Floppy DMA
> needs to use that for example. Of course this would work even without

    I even programmed ISA bus masters. :-)

> the silly resource stuff (inb/outb don't care), EISA code wants to see
> 0x0000 as base address of the PCI/EISA bridge.

    Does EISA code care about PCI bridge?
    Well, looking at drivers/eisa/pci_eisa.c looks like it indeed may care. 
Well, then I've probably lost the case. :-)

>>>I could probably write a
>>>patch, which adds a parameter to init_i8259 for the resource, where the
>>>request_resource is correct. No idea, whether this is worth the efford.

>>>Opions ?

>>   Did you mean options, opinions, or something else? :-)

> I wanted to know from someone, who knows what I talking about, if my
> current code is acceptable or needs more workout.

    You wanted it, you got it.

> Thomas.

WBR, Sergei
