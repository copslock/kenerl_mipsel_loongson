Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 00:48:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8628 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022638AbXCQAsV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Mar 2007 00:48:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2H0kQOC028978;
	Sat, 17 Mar 2007 00:46:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2H0kQqv028977;
	Sat, 17 Mar 2007 00:46:26 GMT
Date:	Sat, 17 Mar 2007 00:46:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070317004625.GA28346@linux-mips.org>
References: <45FB2DEB.70204@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45FB2DEB.70204@pmc-sierra.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 16, 2007 at 03:53:15PM -0800, Marc St-Jean wrote:

> I have been searching for information on this in various 34k manuals as
> well as Dominic's See MIPS Run 2nd Ed. and have not found this limitation
> stated anywhere.
> 
> Programming the MIPS32 34K Core Family (MD00427) Section 3.5 states:
> "The MIPS MT ASE requires that ll/sc also work between concurrent threads
> on an MT CPU. Each TC is equipped with a CP0 register called LLAddr, which
> remembers the physical address (at least to the enclosing 32-byte block) of
> the target location of any ll/sc sequence. The 34K core detects possible
> non-atomicity by checking every write made by any thread against the LLAddr
> of all other TCs."

These are implementation details for the 34K.  The 34K manual and MIPS MT
ASE documentation are extensions to the MIPS32 Revision 2 architecture.

> Doesn't the fact that a physical address is being compared imply any logical
> address type can be used?

You would be relying on an implementation detail, not the guaranteed
semantics of the instruction here.

Now, for a uniprocessor a _likely_ implementation is based on just the
comparing either the virtual or physical address.  I say likely because
it's the simplest implementation.  And yes, there is at least one
MIPS processor implemetation that does it differently, and where SC
will always fail even on uniprocessors when using uncached memory.

> > So to fix this you'd have to use something like this:
> > 
> >         unsigned long flags;
> >         spinlock_t lock;
> > 
> >         spin_lock_irqsave(&lock, flags);
> >         writel(readl(addr) | mask);
> >         spin_unlock_restore(&lock, flags);
> > 
> > Which of course is considerably slower and heavier weight.
> 
> I don't believe we can use a linux lock as the code running on the other TCs
> is not necessarily a linux driver/thread/process. It does not share linux's
> lock implementation.

In which case I suggest you move this file into an platform-specific
directory and add a big and fat comment to ensure nobody reuses the code.

> MIPS32 34K Processor Core Family Software User's Manual (MD00534)
> Store Conditional Word instruction states:
> "If either of the following events occurs between the execution of LL and
> SC, the SC may succeed or it may fail; the success or failure is not
> predictable. Portable programs should not cause one of these events.
>   -A memory access instruction (load, store, or prefetch) is executed on
>    the processor executing the LL/SC.
>   -The instructions executed starting with the LL and ending with the SC
>    do not lie in a 2048-byte contiguous region of virtual memory. (The
>    region does not have to be aligned, other than the alignment required
>    for instruction words.)"

The MIPS32 spec says for the SC instruction:

[...]
If either of the following events occurs between the execution of LL and SC,
the SC fails:
   • A coherent store is completed by another processor or coherent I/O
     module into the block of synchronizable physical memory containing
     the word. The size and alignment of the block is implementation
     dependent, but it is at least one word and at most the minimum page
     size.
   • An ERET instruction is executed.
[...]
Atomic RMW is provided only for synchronizable memory locations. A
synchronizable memory location is one that is associated with the state and
logic necessary to implement the LL/SC semantics. Whether a memory location
is synchronizable depends on the processor and system conﬁgurations, and on
the memory access type used for the location:

   • Uniprocessor atomicity: To provide atomic RMW on a single processor,
     all accesses to the location must be made with memory access type of
     either cached noncoherent or cached coherent. All accesses must be to
     one or the other access type, and they may not be mixed.
   • MP atomicity: To provide atomic RMW among multiple processors, all
     accesses to the location must be made with a memory access type of
     cached coherent.
   • I/O System: To provide atomic RMW with a coherent I/O system, all
     accesses to the location must be made with a memory access type of
     cached coherent. If the I/O system does not use coherent memory
     operations, then atomic RMW cannot be provided with respect to the
     I/O reads and writes.

Restrictions:

The addressed location must have a memory access type of cached noncoherent
or cached coherent; if it does not, the result is UNPREDICTABLE.

The effective address must be naturally-aligned. If either of the 2
least-signiﬁcant bits of the address is non-zero, an Address Error exception
occurs.
[...]

> For the first of these points, if a failure occurs because of activity
> on another TC, the loop should repeat until success.
> 
> For the second point, the code between custom_reg32_read and
> custom_reg32_write is meant to be very simple. We can live with a
> 2k limit.

The 2k limit did show up in the MIPS architecture I think for MIPS IV,
so either the R8000 or R10000 over 10 years ago.  I'm not aware what the
technical reason for this restriction is.  I was wondering if it was just
future proofing.

  Ralf
