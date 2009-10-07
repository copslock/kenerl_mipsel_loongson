Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 18:08:05 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:35083 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493146AbZJGQH7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Oct 2009 18:07:59 +0200
Received: by bwz4 with SMTP id 4so6739bwz.0
        for <multiple recipients>; Wed, 07 Oct 2009 09:07:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=reikXpFjdxug/flZ+uss0F7/AuQUeBVdNKI3lgyj36s=;
        b=RXPH5ZAI88N+FrgcD3bYLe7k1sGzu/to4Atp77D6VWLMFGgY4DI5fw1Bdp0KfZuRKh
         /bYn2183F5B/bC8p32SXMQtvlnYPq1d8T5HLcL3GO1gT+GxusL3s++xzg+AkOu9QMPbm
         YVfsqsDAoxFzDF8o6EJx8zefPtboTaYaZhTGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oYJAeqSAfHOFQvjnfDyMbePsANiOm+ar46BXhbhG1g/a+dWDZTm0j6540VIE642cUR
         fn26xPPdHLBHet1VTD5fXdIJJdnJ//XwkpIaGLd4frx1+2EVaKTXHVZGbW2tVwgibIaq
         XMDFxwnk+qv0QKt4mBrn9bZmoP3xTJ5r8gfRw=
MIME-Version: 1.0
Received: by 10.103.125.17 with SMTP id c17mr40854mun.16.1254931671197; Wed, 
	07 Oct 2009 09:07:51 -0700 (PDT)
In-Reply-To: <4ACCB874.1080206@ru.mvista.com>
References: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com>
	 <20091006115220.GC25263@linux-mips.org>
	 <f861ec6f0910060511t3e95a089h63dc33e628349c11@mail.gmail.com>
	 <20091006142531.GA27430@linux-mips.org>
	 <f861ec6f0910060759v21ac3fe1k7cb130f427834742@mail.gmail.com>
	 <4ACCB874.1080206@ru.mvista.com>
Date:	Wed, 7 Oct 2009 18:07:51 +0200
Message-ID: <f861ec6f0910070907t469ad025xc8fdb9769d17f871@mail.gmail.com>
Subject: Re: Reason for PIO_MASK?
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Sergei!

On Wed, Oct 7, 2009 at 5:49 PM, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>>>> I meant the result of ioremap() of the 36bit address of PCMCIA IO space:
>>>> so the ioport base is somewhere at 0xc0000000, which pata_pcmcia
>>>> tries to devm_iomap(), and this is rejected by the above mentioned file.
>
>>>> The old ide-cs.c driver takes the given IO base as-is (without trying to
>>>> do funky things to it) and just works. (i.e. there are 2 entries in the
>>>> 0xc0000000-range per cf-card in /proc/ioports)
>
>>> Feeding a virtual address as input to devm_ioremap or ioremap does not
>>> make sense.  Ioremap is only to be used for memory resources anyway.
>
>> Somewhere in the pcmcia socket driver I need to ioremap the 36bit
>> base of pcmcia io area:
>> io_base = ioremap(0xF 0000 0000, 0x10000) (->0xc1086000)
>
>> This is passed as io base to all drivers attached to this particular
>> pcmcia socket:
>
>> pata_pcmcia::pcmcia_init_one:
>>   devm_ioport_map(0xc1086000)
>>      ioport_map(0xc1086000) => no way!
>
>   But this is incorrect. You can't pass the result of ioremap to
> ioport_map() -- it's already a virtual *memory* address.

Oh I don't doubt that, but how else am I supposed to access the
PCMCIA IO (which is outside the directly addressable address space!)
area on a non-PC arch?  Since this isn't a PC I don't really see why
the IO port space should be viewed as a sacred area between 0 and 0xffff
rather than another memory area with slightly different electrical
characteristics
(and the fact that it pulls the IOW#/IOR#/ lines on the PCMCIA interface
instead of the "standard" bus r/w signals).

I understand that drivers written for PC-XT hardware won't work, but I can
live with this burden..


>> With 2 sockets I have 2 isolated IO bases, and so far this works as
>> expected, except on drivers which use ioport_map().
>
>   There's something up with either your code or these drivers -- as what
> you're trying to do is just mixing the memory vs I/O port and physical vs
> virtual addresses.

The Alchemy pcmcia socket drivers haven been doing this since before
I knew Alchemy even existed (so > 3 years).


>>>>>> I've temporarily removed the PIO_MASK check and pata_pcmcia
>>>>>> works as expected. Is there any way around this, other than
>>>>>> creating an Alchemy-specific ioport_map() function?
>>>>>
>>>>> The provocative question - why would you want to have more than 64k I/O
>>>>> port
>>>>> space?
>>>>
>>>> *I* don't want more; I want a smarter pata_pcmcia driver ;-)  I'll go
>>>> bug other
>>>> people about this.  I brought this up here because one of my SH boards
>>>> has
>>>> similar needs (need to do an ioremap() with special TLB flags to get
>>>> access to
>>>> pcmcia IO space) but pata_pcmcia does work there (because SH kernel
>>>> either asks the board to translate an x86-IO port to memory address or
>>>> simply returns the port plus an offset).
>>>
>>> Well, Alchemy does this:
>>>
>>> ...
>>>      if (!virt_io_addr) {
>>>              printk(KERN_ERR "Unable to ioremap pci space\n");
>>>              return 1;
>>>      }
>>>      au1x_controller.io_map_base = virt_io_addr;
>>> ...
>>> set_io_port_base(virt_io_addr);
>>> ...
>>>
>>> Which sets up a mapping for the entire port space.  Normally the PCMCIA
>>> I/O port space should also be part of this range so inb, outb etc. for
>>> the low 64k or so of port address range should just work without further
>>> iomap calls of any sort.
>
>> With this scheme, if I put CF cards in both sockets, I think I'm screwed,
>> since both cards will use the same io ports.
>
>> /proc/ioports with 2 cf cards, independet pcmcia sockets:
>> c1086000-c1086007 : ide-cs
>> c108600e-c108600e : ide-cs
>> c108a000-c108a007 : ide-cs
>> c108a00e-c108a00e : ide-cs
>
>> Of all non-x86 archs which implement ioport_map(), MIPS is the only one
>> which excplicitly checks the argument; most simply return it unchanged,
>
>> some adjust the address space (and complain), add an offset,
>> or ioremap it (AVR32).  Why is MIPS special in this regard?
>
>   Look at the default implementation in lib/iomap.c please -- it gets used
> when the arch doesn't implement ioport_map() and it makes use of PIO_MASK.

That probably is the reason why every arch with pcmcia support does implement
its own pass-through variant.   And I'm not nearly smart enough to
figure out what
*else* to do...

In any case. thanks for the comment,
      Manuel Lauss
