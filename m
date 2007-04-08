Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 00:27:30 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:19936 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022049AbXDHX13 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2007 00:27:29 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Hagk6-0007Fk-01; Mon, 09 Apr 2007 01:24:18 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id DC21AC223E; Mon,  9 Apr 2007 01:24:06 +0200 (CEST)
Date:	Mon, 9 Apr 2007 01:24:06 +0200
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
Message-ID: <20070408232406.GB9092@alpha.franken.de>
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com> <20070408131228.GA7819@alpha.franken.de> <4618ED95.6040304@ru.mvista.com> <20070408135244.GA8016@alpha.franken.de> <4619008D.1030803@ru.mvista.com> <20070408161027.GA8265@alpha.franken.de> <46191F42.6020409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46191F42.6020409@ru.mvista.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Apr 08, 2007 at 08:58:42PM +0400, Sergei Shtylyov wrote:
> >request_resource will fail, because the range is already taken by
> >sni_io_resource, while insert_region inserts the resource into 
> >sni_io_resource.
> 
>    No, it shouldn't according to what I'm seeing in the code.  Perhaps I'm 
> missing something and need to actually try executing alike code a see...

after startup there is ioport_resource, which is 0x0000-IO_SPACE_LIMIT.
My change in register_pci_controller will request the PCI IO space
from 0x0000 to 0x3bffff (the maximum the PCI host bridge could address).
request_resource from ioport_resource, which i8259.c tried to do, will
fail now in that range, because it'ss taken by the PCI bridge. Therefore
anybody wanting IO space in that range, must take it from the PCI 
IO space. So doing request_region (&sni_io_resource, &pci1_io_resource);
would have worked as well. But the code right now doesn't have a
handle for the parent resource. insert_region() on the other side
searches for the parent resource over the whole given resource and
plugs the wanted resource to the right sub resource. Fine for simple
house keeping, which is IMHO ok in that place.

> >The problem is that init_i8259 doesn't have the right
> >resource for doing the request_resource, if ioport_resource starting from
> >0x0000 is already taken by a PCI host bridge.
> 
>    I'm not at all sure that giving out I/O addresses from 0 to PCI is a 
>    great idea -- is it indeed necessary?

I'm feeling like an oldtimer right now. Ever heard of ISA busses ? The
address space there starts from 0x0000. There is this infamous DMA
controller waiting exactly at IO address 0x0000-0x001f. Floppy DMA
needs to use that for example. Of course this would work even without
the silly resource stuff (inb/outb don't care), EISA code wants to see
0x0000 as base address of the PCI/EISA bridge.

Oh, and addresses for PCI devices (bridges are a different story) will start
at PCIBIOS_MIN_IO. So there will be no PCI device resource starting at 0x0000.

> >I could probably write a
> >patch, which adds a parameter to init_i8259 for the resource, where the
> >request_resource is correct. No idea, whether this is worth the efford.
> 
> >Opions ?
> 
>    Did you mean options, opinions, or something else? :-)

I wanted to know from someone, who knows what I talking about, if my
current code is acceptable or needs more workout.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
