Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2007 08:36:11 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:12523 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20021964AbXKLIgB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2007 08:36:01 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IrUix-0005AQ-00; Mon, 12 Nov 2007 09:32:51 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 996AEC2343; Mon, 12 Nov 2007 09:32:42 +0100 (CET)
Date:	Mon, 12 Nov 2007 09:32:42 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: problem with 64bit kernel, BOOT_ELF32 and memory outside CKSEG0
Message-ID: <20071112083242.GA6065@alpha.franken.de>
References: <20071111143302.GA26458@alpha.franken.de> <20071111213127.GA26297@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071111213127.GA26297@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Nov 11, 2007 at 09:31:28PM +0000, Ralf Baechle wrote:
> On Sun, Nov 11, 2007 at 03:33:02PM +0100, Thomas Bogendoerfer wrote:
> 
> > I tried to get a working 64bit kernel for SNI RM. Most of things
> > to fix were quite obvious, but there is one thing, which I haven't
> > understood yet.
> > 
> > The firmware is only able to boot ELF32 images, which mean I need to
> > use BOOT_ELF32.
> > 
> > RM machines have 256MB memory mapped to KSEG0, anything else is outside.
> > To me that would mean I need to use the default spaces from
> > mach-generic/spaces.h. A kernel built that way will hang after calling
> > schedule() in rest_init() (init/main.c). Has anybody seen this
> > as well ?
> 
> No.
> 
> schedule() doesn't directly depend on very much else working so I get the
> feeling that your problem may be quite far away.

well it depends on getting a kernel thread started. And I guess there
lies the problem.

Maybe I need to ask more precisely what I want to know: Should a
kernel linked to CSKEG0 with a CAC_BASE 0x980000000000 work or is 
this setup "wrong" ? If the answer is yes, I'd say there is still
a bug left. If no how do we solve the issue of having a 32bit firmware
and a kernel linked for XPHYS (using some sort of bootloader is not
want I want to have, if it's avoidable) ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
