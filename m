Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA151109 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 10:49:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA28397 for linux-list; Mon, 24 Nov 1997 10:46:03 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA28354; Mon, 24 Nov 1997 10:45:57 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA16089; Mon, 24 Nov 1997 10:45:56 -0800
Date: Mon, 24 Nov 1997 10:45:56 -0800
Message-Id: <199711241845.KAA16089@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: R4600 fun ...
In-Reply-To: <19971124144942.55920@lappi.waldorf-gmbh.de>
References: <19971124144942.55920@lappi.waldorf-gmbh.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > 0000d5c0 <r4k_flush_cache_sigtramp+20> cache Hit_Writeback_Inv_D,0($a0)
 > 0000d5c4 <r4k_flush_cache_sigtramp+24> addu $v1,$a0,$v1
 > 0000d5c8 <r4k_flush_cache_sigtramp+28> cache Hit_Writeback_Inv_D,0($v1)
 > 0000d5cc <r4k_flush_cache_sigtramp+2c> cache Hit_Invalidate_I,0($a0)
 > 0000d5d0 <r4k_flush_cache_sigtramp+30> cache Hit_Invalidate_I,0($v1)
 > 0000d5d4 <r4k_flush_cache_sigtramp+34> jr $ra
...
 > Unless I've got tomatoes of the size of a space ship on my eyes these
 > cache flushes do the right thing in order to guarantee the coherence
 > of Icache with the Dcache.  Nevertheless when executing the code on a
 > R4600 v2.0 I get illegal instruction exceptions for the instructions
 > on the stack.  The other MIPS processors seem not to have any problem
 > with this code.
 > 
 > Silicon problem?  Anybody seen this before?

     This is a known R4600 Rev. 2.0 bug.  From the R4600 errata list:

        3.  The CACHE instructions Hit_Writeback_Invalidate_D,
            Hit_Writeback_D, Hit_Invalidate_D, and
            Create_Dirty_Exclusive_D will only operate correctly if
            the internal data cache refill buffer is empty.  These
            cache instructions should separated from any potential
            data cache miss by a load instruction to an uncached
            address to empty the response buffer.

A brute-force workaround for this is to do the load instruction to an
uncached address (such as a memory controller register) before the
cache invalidation code, and to also do such a load instruction just
before every eret.  

     Alternately, one could put enough nop instructions in front of
every eret to allow time for the refill buffer to empty.  The latter
is what I did on Indy, where 12 cycles are needed to allow the refill
buffer to empty in the worst case.  I arranged to replace every eret
with a labelled jump to a patch area (with a nop in the jump delay
slot), where the patch area was 8 nop instructions and an eret.  I had
a table of the jump addresses, and, at startup time on a CPU other
than an R4600 Rev. 2.0, I patched the jump instructions to eret
instructions, so only the R4600 Rev. 2.0 paid the penalty.

     Yet another alternative would be to disable interrupts around the 
cacheops, probe the tlb to be sure a TLB miss could not occur
during the cacheop, pad 12 nop instructions after the probe,
do the cacheops, and enable interrupts.   (If the TLB probe fails,
enable interrupts, do a load from the first address, and retry
from the beginning.)  
