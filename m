Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 10:34:48 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:8138 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225224AbSLDJer>;
	Wed, 4 Dec 2002 10:34:47 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB49YbNf022104;
	Wed, 4 Dec 2002 01:34:37 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA07566;
	Wed, 4 Dec 2002 01:34:36 -0800 (PST)
Message-ID: <007501c29b78$f34680e0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@linux-mips.org>, "Jun Sun" <jsun@mvista.com>
References: <20021203224504.B13437@mvista.com>
Subject: Re: possible Malta 4Kc cache problem ...
Date: Wed, 4 Dec 2002 10:38:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> I attached the test case.  Untar it.  Type 'make' and run 'a.out'.
> 
> If the test fails you will see a print-out.  Otherwise you see nothing.
> 
> It does not always fail.  But if it fails, it is usually pretty consistent.
> Try a few times.  Moving source tree to a different directory may cause
> the symptom appear or disappear.
> 
> I spent quite some time to trace this problem, and came to suspect
> there might be a hardware problem.
> 
> The problem involves emulating a "lw" instruction in cp1 branch delay
> slot, which needs to  set up trampoline in user stack.  The net effect
> looks as if the icache line or dcache line is not flushed properly.
> 
> Using gdb/kgdb, printf or printk in any useful places would hide the bug.
> 
> I did find a smaller part of the problem.  flush_cache_sigtramp for
> MIPS32 (4Kc) calls protected_writeback_dcache_line in mips32_cache.h.
> It uses Hit_Writeback_D, and the 4Kc mannual says it is not implemented
> and executed as no-op (*ick*).

Which version of the 4Kc manual are you looking at?  I'm looking
at a very recent version of the 4Kc Software User's Manual
(version 1.17, dated September 25, 2002), and it only shows
Hit_Writeback_D to be invalid for *secondary and teritary*
caches, which makes sense, since the 4KSc doesn't have any.

> Even after fixing this, I still see the problem happening.

That's not too surprising.  The 4Kc D-cache is write-through,
so if you're really seeing a problem with trampolimes, it is almost
certain to be a problem with the Icache invalidation, not the
Dcache flush.
 
> If you replace flush_cache_sigtramp() with flush_cache_all(), symptom
> would disppear.

Which again would make sense if there's a problem on
the icache side of the flush.  Oddly enough, we've seen
some glitches on other CPUs with other kernels that 
might have been explicable by failures of protected_flush_icache_line(),
but we never found a problem with it, and a higher-level
memory management patch made the problem go away.
Makes me wonder if we shouldn't look at it again, more
closely.  Is there any possibility that the logic for restarting
a protected kernel access following a page fault will somehow
screw up on CACHE instructions, as opposed to the loads
and stores for which the code was originally written?

> Several of my tests seem to suggest it is the icache that did not
> get flushed (or updated) properly.
> 
> Not re-producible on other MIPS boards.  At least so far.
> 
> Does anybody with more knowledge about 4Kc have any clues here?
> 
> Thanks.
> 
> Jun
