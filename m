Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 17:46:22 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:6545 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S2097312AbZJGPqP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Oct 2009 17:46:15 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 594933EC9; Wed,  7 Oct 2009 08:46:09 -0700 (PDT)
Message-ID: <4ACCB874.1080206@ru.mvista.com>
Date:	Wed, 07 Oct 2009 19:49:08 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Reason for PIO_MASK?
References: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com>	 <20091006115220.GC25263@linux-mips.org>	 <f861ec6f0910060511t3e95a089h63dc33e628349c11@mail.gmail.com>	 <20091006142531.GA27430@linux-mips.org> <f861ec6f0910060759v21ac3fe1k7cb130f427834742@mail.gmail.com>
In-Reply-To: <f861ec6f0910060759v21ac3fe1k7cb130f427834742@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

>>>I meant the result of ioremap() of the 36bit address of PCMCIA IO space:
>>>so the ioport base is somewhere at 0xc0000000, which pata_pcmcia
>>>tries to devm_iomap(), and this is rejected by the above mentioned file.

>>>The old ide-cs.c driver takes the given IO base as-is (without trying to
>>>do funky things to it) and just works. (i.e. there are 2 entries in the
>>>0xc0000000-range per cf-card in /proc/ioports)

>>Feeding a virtual address as input to devm_ioremap or ioremap does not
>>make sense.  Ioremap is only to be used for memory resources anyway.

> Somewhere in the pcmcia socket driver I need to ioremap the 36bit
> base of pcmcia io area:
> io_base = ioremap(0xF 0000 0000, 0x10000) (->0xc1086000)

> This is passed as io base to all drivers attached to this particular
> pcmcia socket:

> pata_pcmcia::pcmcia_init_one:
>    devm_ioport_map(0xc1086000)
>       ioport_map(0xc1086000) => no way!

    But this is incorrect. You can't pass the result of ioremap to 
ioport_map() -- it's already a virtual *memory* address.

> With 2 sockets I have 2 isolated IO bases, and so far this works as
> expected, except on drivers which use ioport_map().

    There's something up with either your code or these drivers -- as what 
you're trying to do is just mixing the memory vs I/O port and physical vs 
virtual addresses.

>>>>>I've temporarily removed the PIO_MASK check and pata_pcmcia
>>>>>works as expected. Is there any way around this, other than
>>>>>creating an Alchemy-specific ioport_map() function?
>>>>
>>>>The provocative question - why would you want to have more than 64k I/O port
>>>>space?
>>>
>>>*I* don't want more; I want a smarter pata_pcmcia driver ;-)  I'll go bug other
>>>people about this.  I brought this up here because one of my SH boards has
>>>similar needs (need to do an ioremap() with special TLB flags to get access to
>>>pcmcia IO space) but pata_pcmcia does work there (because SH kernel
>>>either asks the board to translate an x86-IO port to memory address or
>>>simply returns the port plus an offset).
>>
>>Well, Alchemy does this:
>>
>>...
>>       if (!virt_io_addr) {
>>               printk(KERN_ERR "Unable to ioremap pci space\n");
>>               return 1;
>>       }
>>       au1x_controller.io_map_base = virt_io_addr;
>>...
>>set_io_port_base(virt_io_addr);
>>...
>>
>>Which sets up a mapping for the entire port space.  Normally the PCMCIA
>>I/O port space should also be part of this range so inb, outb etc. for
>>the low 64k or so of port address range should just work without further
>>iomap calls of any sort.

> With this scheme, if I put CF cards in both sockets, I think I'm screwed,
> since both cards will use the same io ports.

> /proc/ioports with 2 cf cards, independet pcmcia sockets:
> c1086000-c1086007 : ide-cs
> c108600e-c108600e : ide-cs
> c108a000-c108a007 : ide-cs
> c108a00e-c108a00e : ide-cs

> Of all non-x86 archs which implement ioport_map(), MIPS is the only one
> which excplicitly checks the argument; most simply return it unchanged,

> some adjust the address space (and complain), add an offset,
> or ioremap it (AVR32).  Why is MIPS special in this regard?

    Look at the default implementation in lib/iomap.c please -- it gets used 
when the arch doesn't implement ioport_map() and it makes use of PIO_MASK.

> Maybe the whole logic should be turned around? Complain loudly if a driver
> tries to access the range covered by PIO_MASK?

    I didn't get the idea. PIO_MASK defined the *valid* address range for 
in*()/out*(), not invalid.

>         Manuel Lauss

WBR, Sergei
