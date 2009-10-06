Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2009 17:00:14 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:55673 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492675AbZJFPAI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Oct 2009 17:00:08 +0200
Received: by fxm21 with SMTP id 21so3295963fxm.33
        for <multiple recipients>; Tue, 06 Oct 2009 07:59:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DUm2m26vBJF5iflGOjYwWOWRtReC83OqFXc/RaudlwA=;
        b=PfKtEtWaMZNqyhmZ3BbTB+UilZT6KqWpWZmNVzoCKwBryXl7mgm7PNl78BUHviYouY
         2rOkFztagorwupK94rPDPW9BfKpHknPt4Y85ovL7KCpTZ+LfuBKfBrKlLOnStlc9A2pv
         LF75HfMNkhU2D38rfmULOwdTvauuxPrjcRPEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GstBAcOh0oaXFxAlZiOCyzTq/bOVebVpARxtFhLDo/zPRrDpdfcXZZnsBqbai9eJX5
         ltV6cSw7i0qz0mhScddpBiplxfbgKKMROI59vymxjJtFfMhHo+DHB00Nwg4RJUlyHdAG
         g6lwTH4umuSVjXb0LgNUZ5iFNswvgCwrJMYPA=
MIME-Version: 1.0
Received: by 10.103.84.1 with SMTP id m1mr425932mul.34.1254841197736; Tue, 06 
	Oct 2009 07:59:57 -0700 (PDT)
In-Reply-To: <20091006142531.GA27430@linux-mips.org>
References: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com>
	 <20091006115220.GC25263@linux-mips.org>
	 <f861ec6f0910060511t3e95a089h63dc33e628349c11@mail.gmail.com>
	 <20091006142531.GA27430@linux-mips.org>
Date:	Tue, 6 Oct 2009 16:59:57 +0200
Message-ID: <f861ec6f0910060759v21ac3fe1k7cb130f427834742@mail.gmail.com>
Subject: Re: Reason for PIO_MASK?
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Oct 6, 2009 at 4:25 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Oct 06, 2009 at 02:11:15PM +0200, Manuel Lauss wrote:
>
>> I meant the result of ioremap() of the 36bit address of PCMCIA IO space:
>> so the ioport base is somewhere at 0xc0000000, which pata_pcmcia
>> tries to devm_iomap(), and this is rejected by the above mentioned file.
>>
>> The old ide-cs.c driver takes the given IO base as-is (without trying to
>> do funky things to it) and just works. (i.e. there are 2 entries in the
>> 0xc0000000-range per cf-card in /proc/ioports)
>
> Feeding a virtual address as input to devm_ioremap or ioremap does not
> make sense.  Ioremap is only to be used for memory resources anyway.

Somewhere in the pcmcia socket driver I need to ioremap the 36bit
base of pcmcia io area:
io_base = ioremap(0xF 0000 0000, 0x10000) (->0xc1086000)

This is passed as io base to all drivers attached to this particular
pcmcia socket:

pata_pcmcia::pcmcia_init_one:
   devm_ioport_map(0xc1086000)
      ioport_map(0xc1086000) => no way!

With 2 sockets I have 2 isolated IO bases, and so far this works as
expected, except on drivers which use ioport_map().


>> >> I've temporarily removed the PIO_MASK check and pata_pcmcia
>> >> works as expected. Is there any way around this, other than
>> >> creating an Alchemy-specific ioport_map() function?
>> >
>> > The provocative question - why would you want to have more than 64k I/O port
>> > space?
>>
>> *I* don't want more; I want a smarter pata_pcmcia driver ;-)  I'll go bug other
>> people about this.  I brought this up here because one of my SH boards has
>> similar needs (need to do an ioremap() with special TLB flags to get access to
>> pcmcia IO space) but pata_pcmcia does work there (because SH kernel
>> either asks the board to translate an x86-IO port to memory address or
>> simply returns the port plus an offset).
>
> Well, Alchemy does this:
>
> ...
>        if (!virt_io_addr) {
>                printk(KERN_ERR "Unable to ioremap pci space\n");
>                return 1;
>        }
>        au1x_controller.io_map_base = virt_io_addr;
> ...
> set_io_port_base(virt_io_addr);
> ...
>
> Which sets up a mapping for the entire port space.  Normally the PCMCIA
> I/O port space should also be part of this range so inb, outb etc. for
> the low 64k or so of port address range should just work without further
> iomap calls of any sort.

With this scheme, if I put CF cards in both sockets, I think I'm screwed,
since both cards will use the same io ports.

/proc/ioports with 2 cf cards, independet pcmcia sockets:
c1086000-c1086007 : ide-cs
c108600e-c108600e : ide-cs
c108a000-c108a007 : ide-cs
c108a00e-c108a00e : ide-cs


Of all non-x86 archs which implement ioport_map(), MIPS is the only one
which excplicitly checks the argument; most simply return it unchanged,
some adjust the address space (and complain), add an offset,
or ioremap it (AVR32).  Why is MIPS special in this regard?

Maybe the whole logic should be turned around? Complain loudly if a driver
tries to access the range covered by PIO_MASK?

        Manuel Lauss
