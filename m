Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Oct 2002 17:13:11 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:15768 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123897AbSJEPNK>;
	Sat, 5 Oct 2002 17:13:10 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g95FCnNf020329;
	Sat, 5 Oct 2002 08:12:49 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA20225;
	Sat, 5 Oct 2002 08:13:19 -0700 (PDT)
Received: (from hartvige@localhost)
	by copfs01.mips.com (8.11.4/8.9.0) id g95FCmI11618;
	Sat, 5 Oct 2002 17:12:48 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200210051512.g95FCmI11618@copfs01.mips.com>
Subject: Re: Promblem with PREF (prefetching) in memcpy
To: ralf@linux-mips.org (Ralf Baechle)
Date: Sat, 5 Oct 2002 17:12:47 +0200 (MEST)
Cc: kevink@mips.com (Kevin D. Kissell),
	dom@algor.co.uk (Dominic Sweetman),
	carstenl@mips.com (Carsten Langgaard), linux-mips@linux-mips.org
In-Reply-To: <20021005014345.B15883@linux-mips.org> from "Ralf Baechle" at Oct 05, 2002 01:43:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvige@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvige@mips.com
Precedence: bulk
X-list: linux-mips

I still say we should fix memcpy() (and everything else using prefetches)
never to prefetch anything it hasn't been asked to touch.

Apart from the performance loss of the current practice which Alan pointed
out, I think there is another very good reason to fix it: SW coherency.

Unless we want to do writeback/invalidate both before & after ownership
of buffers are given/taken from DMA IO devices, we need to get rid of 
the prefetches to unwanted areas. 

So that's two good arguments for fixing memcpy() as I see it. I haven't
really heard any arguments against it?

Whether the last page of physical memory needs to be thrown away or not seems
like a separate issue. Is this also done in x86 world? What are the issues
you're thinking about Ralf? Are there devices which will read/write beyond 
what they have been asked to?

/Hartvig


Ralf Baechle writes:
> 
> On Fri, Oct 04, 2002 at 02:36:39PM +0200, Kevin D. Kissell wrote:
> 
> > In case Carsten's reply wasn't clear enough, there is a loophole
> > in the spec:  kseg0.  There is no TLB access to cause a TLB
> > exception (which would suppress the operation and be nullifed),
> > If the prefetch address is correctly aligned, so that there is no
> > address exception.  In typical use, kseg0 is cacheable, which
> > means that the second paragraph you quote does not apply.
> > A prefetch to a well-formed, cacheable kseg0 address which 
> > has no primary storage behind it (e.g. 0x04000000 on a system
> > with 64M of physical memory) should, according to the spec,
> > cause a cache fill to be initiated for the line at that address,
> > which will result in a bus error, if not a flat-out system hang.
> 
> Traditionally the kernel leaves the last page of memory unused but this
> has been lost in the many changes to the memory initialization code.
> It's still a good idea with all the broken I/O chips and PCI bridges out
> there - and can avoid a hard to track bug.
> 
> That only leaves stuff usermode device drivers that are using cachable
> mappings in the dangerzone.  That should be a rare case, if at all.
> 
>   Ralf
> 
> 


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
