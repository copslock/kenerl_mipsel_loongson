Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 13:58:22 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007089AbbEZL6TOEkRk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 13:58:19 +0200
Date:   Tue, 26 May 2015 12:58:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>,
        James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 01/10] MIPS: Add SysRq operation to dump TLBs on
 all CPUs
In-Reply-To: <556240DE.1050003@gentoo.org>
Message-ID: <alpine.LFD.2.11.1505261230020.11225@eddie.linux-mips.org>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com> <1432025438-26431-2-git-send-email-james.hogan@imgtec.com> <556240DE.1050003@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 24 May 2015, Joshua Kinard wrote:

> > Add a MIPS specific SysRq operation to dump the TLB entries on all CPUs,
> > using the 'x' trigger key.
> 
> Thought: Would it make sense to split apart the data such that one SysRq key
> dumps the CP0 registers of all CPUs, and another dumps the TLB info?

 That would be a large separate project, probing a CPU for its implemented 
CP0 registers is a complex matter.

 I did it for GDB and a bare-iron debug stub a few years ago and back then 
there were IIRC 53 register subsets already defined for MIPS architecture 
processors, wired to various, sometimes overlapping feature bits of CP0 
Config registers, and now there are more.  Plus legacy processors require 
fixed register maps according to CP0.PRId.

 James, I think what you proposed is good enough for TLB diagnostics (I'm 
not sure if dumping EntryLo0 and EntryLo1 registers has any use, but it 
surely does not hurt either).

> > +	pr_info("CPU%d:\n", smp_processor_id());
> > +	pr_info("Index	: %0x\n", read_c0_index());
> > +	pr_info("Pagemask: %0x\n", read_c0_pagemask());
> > +	pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
> > +	pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
> > +	pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
> > +	pr_info("Wired   : %0x\n", read_c0_wired());
> > +	pr_info("Pagegrain: %0x\n", read_c0_pagegrain());

 Please capitalise these consistently: PageMask and PageGrain.

> The older CPUs, like the R10000 don't have a PageGrain register I believe (at
> least R10K doesn't),  Does that need to be stuffed behind a conditional?  Also,
> R10K (and newer?) CPUs have a FrameMask CP0 register ($21).  Linux currently
> scribbles a 0 to the writable bits, though, so I'm not sure if it matters.

 First of all I suggest that this part is split off into separate small 
helper functions within dump_tlb.c and r3k_dump_tlb.c.  This code is not 
performance-critical, so the overhead of an extra function call isn't of 
a concern.

 Then R3k processors have Index, EntryHi and EntryLo (rather than 
EntryLo0) registers only; some Toshiba processors have Wired too (cf. 
`r3k_have_wired_reg').

 And for the R4k-style TLB the PageGrain register does need to be probed 
for.  I think including FrameMask would be good too, that shouldn't be 
difficult (switch on `current_cpu_type'?).

  Maciej
