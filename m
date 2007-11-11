Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2007 21:31:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64226 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029982AbXKKVb3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Nov 2007 21:31:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lABLVS5C026844;
	Sun, 11 Nov 2007 21:31:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lABLVSZZ026843;
	Sun, 11 Nov 2007 21:31:28 GMT
Date:	Sun, 11 Nov 2007 21:31:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: problem with 64bit kernel, BOOT_ELF32 and memory outside CKSEG0
Message-ID: <20071111213127.GA26297@linux-mips.org>
References: <20071111143302.GA26458@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071111143302.GA26458@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 11, 2007 at 03:33:02PM +0100, Thomas Bogendoerfer wrote:

> I tried to get a working 64bit kernel for SNI RM. Most of things
> to fix were quite obvious, but there is one thing, which I haven't
> understood yet.
> 
> The firmware is only able to boot ELF32 images, which mean I need to
> use BOOT_ELF32.
> 
> RM machines have 256MB memory mapped to KSEG0, anything else is outside.
> To me that would mean I need to use the default spaces from
> mach-generic/spaces.h. A kernel built that way will hang after calling
> schedule() in rest_init() (init/main.c). Has anybody seen this
> as well ?

No.

schedule() doesn't directly depend on very much else working so I get the
feeling that your problem may be quite far away.

> Before digging into schedule() I decided to try mach-ip22/spaces.h
> and limit the installed memory to 256MB. This kernel boots and
> runs fine.
> 
> Then I booted that kernel with all memory (512MB) and it died, when
> init had troubles mapping libc. That result didn't surprise me
> that much, since the kernel probably tried to map memory > 256MB
> via CKSEG0, which won't work. Correct ?

You should keep all memory mapped in the same kernel segment.  Since
you have too much to do that in CKSEG0 it will have to be XKPHYS which
means the generic spaces.h which will be used when you have none in
in mach-rm200/space.h.

I suspect what happens is the kernel is trying to access memory at above
phys. 512MB.  In your setup it would compute a CKSEG1 address for that
and stomp over something it better shouldn't ...

  Ralf
