Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2009 16:24:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48506 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493197AbZJFOYY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Oct 2009 16:24:24 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n96EPVvf027986;
	Tue, 6 Oct 2009 16:25:32 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n96EPV2U027983;
	Tue, 6 Oct 2009 16:25:31 +0200
Date:	Tue, 6 Oct 2009 16:25:31 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Reason for PIO_MASK?
Message-ID: <20091006142531.GA27430@linux-mips.org>
References: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com> <20091006115220.GC25263@linux-mips.org> <f861ec6f0910060511t3e95a089h63dc33e628349c11@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0910060511t3e95a089h63dc33e628349c11@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 06, 2009 at 02:11:15PM +0200, Manuel Lauss wrote:

> I meant the result of ioremap() of the 36bit address of PCMCIA IO space:
> so the ioport base is somewhere at 0xc0000000, which pata_pcmcia
> tries to devm_iomap(), and this is rejected by the above mentioned file.
> 
> The old ide-cs.c driver takes the given IO base as-is (without trying to
> do funky things to it) and just works. (i.e. there are 2 entries in the
> 0xc0000000-range per cf-card in /proc/ioports)

Feeding a virtual address as input to devm_ioremap or ioremap does not
make sense.  Ioremap is only to be used for memory resources anyway.

> >> I've temporarily removed the PIO_MASK check and pata_pcmcia
> >> works as expected. Is there any way around this, other than
> >> creating an Alchemy-specific ioport_map() function?
> >
> > The provocative question - why would you want to have more than 64k I/O port
> > space?
> 
> *I* don't want more; I want a smarter pata_pcmcia driver ;-)  I'll go bug other
> people about this.  I brought this up here because one of my SH boards has
> similar needs (need to do an ioremap() with special TLB flags to get access to
> pcmcia IO space) but pata_pcmcia does work there (because SH kernel
> either asks the board to translate an x86-IO port to memory address or
> simply returns the port plus an offset).

Well, Alchemy does this:

...
        if (!virt_io_addr) {
                printk(KERN_ERR "Unable to ioremap pci space\n");
                return 1;
        }
        au1x_controller.io_map_base = virt_io_addr;
...
set_io_port_base(virt_io_addr);
...

Which sets up a mapping for the entire port space.  Normally the PCMCIA
I/O port space should also be part of this range so inb, outb etc. for
the low 64k or so of port address range should just work without further
iomap calls of any sort.

  Ralf
