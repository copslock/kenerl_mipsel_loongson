Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 00:07:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51464 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992183AbdAXXHjBsl4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 00:07:39 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1087DF12F8967;
        Tue, 24 Jan 2017 23:07:27 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 24 Jan 2017
 23:07:30 +0000
Date:   Tue, 24 Jan 2017 23:07:22 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/2] MIPS: ptrace: disallow setting watchpoints in
 kernel address space
In-Reply-To: <20170124220554.GM29015@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1701242229480.13564@tp.orcam.me.uk>
References: <1485163113-21780-1-git-send-email-marcin.nowakowski@imgtec.com> <alpine.DEB.2.00.1701232258380.13564@tp.orcam.me.uk> <20170124185452.GL29015@jhogan-linux.le.imgtec.org> <alpine.DEB.2.00.1701241909540.13564@tp.orcam.me.uk>
 <20170124220554.GM29015@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Tue, 24 Jan 2017, James Hogan wrote:

> >  All the critical data structures would have to be outside the EVA 
> > overlap.
> 
> This in itself is awkward. If a SoC supports multiple RAM sizes, e.g.
> up to 2GB, you might want a single EVA kernel that could support both.
> Normally you could just go with a 2GB compatible layout (for the sake of
> argument, lets say RAM cached @ kernel VA 0x40000000 .. 0xBFFFFFFF,
> ignoring BEV overlays for now), but if less than 1GB is fitted then none
> of that RAM is outside of the user overlap range.

 Well, the kernel is in control of user mappings and can take a piece of 
the virtual address space away for internal use.  At worst the kernel can 
map the necessary stuff in KSEG2 with a wired TLB entry.  I agree this is 
far from being pretty though and do hope my other proposal turns out 
feasible.

> >  Poking at ASID as I described above is just a couple of instructions at 
> > entry and exit, and the rest would only be done if tracing is active.  
> > Plus you don't actually have to move anything away, except from the final 
> > ERET, though likely not even that, owing to the delayed nature of an ASID 
> > update.
> 
> Probably, so long as you ignore QEMU.

 We can paper it over in QEMU I suppose -- we're not supposed to be 
interrupted at EXL and with a linear execution flow any sane hardware will 
have already fetched the following ERET by the time the immediately 
preceding MTC0 has been retired.  We can cache-line-align the instruction 
pair to avoid surprises on real hardware too.

> > 
> >  So can you find a flaw in my proposal so far?
> 
> not a functional one.

 Good!

> > We'll have to think about 
> > the TLB refill handler yet though.
> 
> A deferred watch from refill handler (e.g. page tables) would I think
> trigger an immediate watch exception on eret, and get cleared / ignored.
> It would probably make enough of a timing difference for userland to
> reliably detect (in order to probe where the process' page tables are in
> kernel virtual memory, to be able to mount a more successful attack
> given some other vulnerability).

 I feel uneasy about it: if a watchpoint happens to be badly placed (not 
necessarily deliberately), then this could become a serious performance 
hit for the whole system (and if deliberately, then possibly a security 
concern).

 However I think we can get away quite easily again, by clearing 
CP0.Cause.WP unconditionally at the exit from the refill handler -- 
there's nothing of interest throughout the handler for watchpoints and we 
run at EXL until completion.

 Unfortunately some other writeable bits have been allocated in CP0.Cause, 
specifically DC and especially IV, so we can't just do:

	mtc0	$13, $zero

However if we can prove that we won't need the IP[1:0] bits in scenarios 
that involve a TLB refill, then we could just quickly do a short sequence, 
say:

	lui	$k0, 1 << 23
	mtc0	$13, $k0
	eret

Otherwise we'll have to do a full RMW sequence; fortunately a single INS 
from $0 will do here again to clear CP0.Cause.WP and keep the remaining 
bits.  Maybe we could do just the same in the regular exception epilogue 
to avoid the dependency on a hazard (and consequently an issue with QEMU).

 All these extra operations do cost some performance, but at least the 
latency is constant, so very predictable, which I believe is important in 
some use cases.

  Maciej
