Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2009 13:51:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33466 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492861AbZJFLvQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Oct 2009 13:51:16 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n96BqMCH021982;
	Tue, 6 Oct 2009 13:52:22 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n96BqLRh021979;
	Tue, 6 Oct 2009 13:52:21 +0200
Date:	Tue, 6 Oct 2009 13:52:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Reason for PIO_MASK?
Message-ID: <20091006115220.GC25263@linux-mips.org>
References: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 03, 2009 at 04:48:12PM +0200, Manuel Lauss wrote:

> In arch/mips/lib/iomap.c  there's this "#define PIO_MASK 0x0ffff"
> which limits the ability to successfully call ioport_map() to the
> first 64kB.  This causes pata_pcmcia to error out on CF card
> probe because devm_ioport_map() is called with the remapped
> PCMCIA IO area, which is somewhere in MAP_BASE space.

Remapped, so that then actually be a physical address?  That'd be wrong.

> I've temporarily removed the PIO_MASK check and pata_pcmcia
> works as expected. Is there any way around this, other than
> creating an Alchemy-specific ioport_map() function?

The provocative question - why would you want to have more than 64k I/O port
space?

I/O ports are x86 legacy and deprecated.  PCI limits allocations to at
most 256 bytes and I don't know of any devices that even come close to
that.

When I wrote ioport_map I reviwed all uses of ioport addresses > 64k and
found each of them to be buggy ...

  Ralf
