Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 21:52:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18033 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993939AbdAXUwl1q7kS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2017 21:52:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 09EC2116625B8;
        Tue, 24 Jan 2017 20:52:29 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 24 Jan 2017
 20:52:32 +0000
Date:   Tue, 24 Jan 2017 20:52:22 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/2] MIPS: ptrace: disallow setting watchpoints in
 kernel address space
In-Reply-To: <20170124185452.GL29015@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1701241909540.13564@tp.orcam.me.uk>
References: <1485163113-21780-1-git-send-email-marcin.nowakowski@imgtec.com> <alpine.DEB.2.00.1701232258380.13564@tp.orcam.me.uk> <20170124185452.GL29015@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56480
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

> >  Can't for example the low-level exception handling entry/exit code be 
> > moved out of the way of the EVA overlap range and then all watchpoints 
> > masked for the duration of kernel mode execution?  This would be quite 
> > expensive, however it could only be executed if a task flag indicates 
> > watchpoints are being used.
> 
> That doesn't cover data watches. RAM would still need accessing, e.g. to
> save/restore the watch state from the thread context, or even to read
> the task flag, and stack accesses in C code.

 All the critical data structures would have to be outside the EVA 
overlap.

> The only safe way for it to work would be to somehow disable or inhibit 
> watchpoints before clearing EXL, and re-enable them after setting EXL, 
> though you'd still get a loop of deferred watchpoints if it hit on the 
> way out to user mode unless cleared at the last moment before ERET.

 Ah, I forgot about CP0.Cause.WP -- is it not enough to clear the bit to 
have any pending exception cancelled?  If so (and the architecture manual 
is actually clear that it is) then it looks like we have a solution and we 
don't have to place any code or data specially, although it'll have to be 
carefully coded.

> > Alternatively perhaps we could clobber 
> > CP0.EntryHi.ASID, at least temporarily; that would be cheaper.
> 
> Kernel mode still needs to access the user address space.

 Sure, that's why it would have to be temporary.  Low-level exception 
entry/exit code is not supposed to have a need to access user memory.

 So we can put aside a certain ASID value, say 0 (for easy pasting with 
INS from $0), and never use it for a real context.  Then it can be cleared 
right away at the general exception entry point if EVA is in use, say:

	<d>mfc0	$k0, $10
	<d>ins	$k0, $zero, 0, 10
	<d>mtc0	$k0, $10

(there'll be a hazard here, but we can clear it later on if needed).  
There is no neeed to save the old ASID as we can retrieve the original 
from our data structures.

 Then we can proceed with the usual switch to the kernel mode, switching 
stacks, saving registers, etc.  We can then check CP0.Cause.WP and stash 
it away for further processing if needed (though discarding it would I 
think be the usual if not only choice) and clear, with a hazard barrier, 
right before CP0.Status.EXL is cleared.

 Now that we're in the regular kernel mode, with ASID still set to 0, we 
can check if process tracing has been enabled and if so, then iterate over 
the watchpoints registers masking them all.  At this point we can restore 
the correct ASID in CP0.EntryHi and proceed with the exception handler.

 And then we'd do the reverse in the exception epilogue, only restoring 
the ASID as the last instruction before final ERET.

> Alternatively we could set WatchHi.ASID to a reserved one, and only
> clear/set the WatchHi.G bit (to bypass the ASID match) at the first/last
> moment while EXL=1. It still wouldn't protect against code watches
> around there exposing the kernel address of that code by the resulting
> hang though, so would need to move the ebase out of the overlap range
> too (which would have to be platform specific).

 You'd still have to iterate over all WatchHi registers, a variable number 
up to 8 architecturally, which I think would be too expensive for the 
common exception path.

 Poking at ASID as I described above is just a couple of instructions at 
entry and exit, and the rest would only be done if tracing is active.  
Plus you don't actually have to move anything away, except from the final 
ERET, though likely not even that, owing to the delayed nature of an ASID 
update.

 So can you find a flaw in my proposal so far?  We'll have to think about 
the TLB refill handler yet though.

  Maciej
