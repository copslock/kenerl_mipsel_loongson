Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 00:00:55 +0100 (BST)
Received: from p508B5DDF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.223]:43093
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225763AbUGLXAv>; Tue, 13 Jul 2004 00:00:51 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6CN0lm5013743;
	Tue, 13 Jul 2004 01:00:47 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6CN0kno013734;
	Tue, 13 Jul 2004 01:00:46 +0200
Date: Tue, 13 Jul 2004 01:00:46 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: S C <theansweriz42@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Message-ID: <20040712230046.GA6176@linux-mips.org>
References: <BAY2-F27mxl2RtYP35u0000d191@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY2-F27mxl2RtYP35u0000d191@hotmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 12, 2004 at 09:23:20PM +0000, S C wrote:

> And thinking about it a little more, I might as well clarfy my 
> understanding while we're on the topic.
> 
> Here's a code snippet from r4k_tlb_init() in arch/mips/mm/c-r4k.c
> 
> memcpy((void *)KSEG0, &except_vec0_r4000, 0x80);
> flush_icache_range(KSEG0, KSEG0 + 0x80);
> 
> So my understanding is that the TLB exception handler is being copied to 
> the right memory location, and just in case some other TLB exception 
> handler (YAMON's presumably) is residing in I-cache, to flush ( hit 
> invalidate) it. Is this correct?
> 
> Shouldn't there be code to writeback_invalidate the exception handler from 
> the data cache ?

flush_icache_range() does that where necessary.

> Presumably the memcpy causes the TLB handler to lodge 
> itself in the D cache till it is moved to RAM

Correct.  All MIPS processors [1] do their primary I-cache refills from
second or third level cache or memory - whatever hits first.  If code
was changed a flush of the data cache is required so the I-cache can
actually fetch the new data and because old stale code might still be
in the I-cache an I-cache flush is also required.

> (either explicitly or when 
> some other lines replace the cache lines where the handler is), right?
> 
> Thanks in advance for helping me understand the issue here.

  Ralf

[1] Exceptions are the R4000/R4400 SC and MC versions in a split S-cache
    configuration where the primary I-cache is refilled from the secondary
    I-cache which mean this flush has to flush the secondary data cache
    back to memory also.  Linux doesn't support this configuration because
    no known system uses it iow it's only a theoretically possible config.

    The second exception are the AMD MIPS32 processors where the I-cache
    is snooping the D-cache and therefore the D-cache flush can is
    unnecessary.

    The third exception are R1x000 in SMP configurations where I-caches
    snoop remote stores so coherency doesn't need any maintenance in
    software at all.  Only the I-cache of the CPU that did modify the code
    needs flushing.
