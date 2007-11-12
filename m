Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2007 10:45:18 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13248 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023284AbXKLKpP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Nov 2007 10:45:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lACAiYiC028338;
	Mon, 12 Nov 2007 10:44:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lACAiNc1028304;
	Mon, 12 Nov 2007 10:44:23 GMT
Date:	Mon, 12 Nov 2007 10:44:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: problem with 64bit kernel, BOOT_ELF32 and memory outside CKSEG0
Message-ID: <20071112104423.GA27588@linux-mips.org>
References: <20071111143302.GA26458@alpha.franken.de> <20071111213127.GA26297@linux-mips.org> <20071112083242.GA6065@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071112083242.GA6065@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 12, 2007 at 09:32:42AM +0100, Thomas Bogendoerfer wrote:

> > schedule() doesn't directly depend on very much else working so I get the
> > feeling that your problem may be quite far away.
> 
> well it depends on getting a kernel thread started. And I guess there
> lies the problem.
> 
> Maybe I need to ask more precisely what I want to know: Should a
> kernel linked to CSKEG0 with a CAC_BASE 0x980000000000 work or is 
> this setup "wrong" ? If the answer is yes, I'd say there is still
> a bug left. If no how do we solve the issue of having a 32bit firmware
> and a kernel linked for XPHYS (using some sort of bootloader is not
> want I want to have, if it's avoidable) ?

Typically systems try to put the kernel into CKSEG0 as long as the given
platform happens to have memory mapped there.  Using CKSEG0 allows using
a shorter sequence to load the address of an in-kernel symbol resulting
in a much smaller kernel binary.

One implication of this is that kernel modules will have to be allocated
to CKSEG2/3 because they're built using the same code model.  Modules
are allocated using vmalloc so the vmalloc space needs to be in
CKSEG2/3.  Most people don't care if that space is restricted to just
one gig.

But even if you get that wrong the expected failure mode is different ...

  Ralf
