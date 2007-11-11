Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2007 14:33:08 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:38299 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026821AbXKKOdA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2007 14:33:00 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IrDrv-0004ny-00
	for linux-mips@linux-mips.org; Sun, 11 Nov 2007 15:32:59 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id A4598C2144; Sun, 11 Nov 2007 15:33:02 +0100 (CET)
Date:	Sun, 11 Nov 2007 15:33:02 +0100
To:	linux-mips@linux-mips.org
Subject: problem with 64bit kernel, BOOT_ELF32 and memory outside CKSEG0
Message-ID: <20071111143302.GA26458@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

I tried to get a working 64bit kernel for SNI RM. Most of things
to fix were quite obvious, but there is one thing, which I haven't
understood yet.

The firmware is only able to boot ELF32 images, which mean I need to
use BOOT_ELF32.

RM machines have 256MB memory mapped to KSEG0, anything else is outside.
To me that would mean I need to use the default spaces from
mach-generic/spaces.h. A kernel built that way will hang after calling
schedule() in rest_init() (init/main.c). Has anybody seen this
as well ?

Before digging into schedule() I decided to try mach-ip22/spaces.h
and limit the installed memory to 256MB. This kernel boots and
runs fine.

Then I booted that kernel with all memory (512MB) and it died, when
init had troubles mapping libc. That result didn't surprise me
that much, since the kernel probably tried to map memory > 256MB
via CKSEG0, which won't work. Correct ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
