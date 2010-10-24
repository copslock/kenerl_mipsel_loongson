Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 07:26:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48495 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490963Ab0JXF0L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Oct 2010 07:26:11 +0200
Date:   Sun, 24 Oct 2010 06:26:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Kevin Cernekee <cernekee@gmail.com>,
        "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Question about Context register in TLB refilling
In-Reply-To: <20101018000030.GB31080@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1010182156450.15889@eddie.linux-mips.org>
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com> <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com> <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org> <20101018000030.GB31080@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 Oct 2010, Ralf Baechle wrote:

> The design of the R4000 c0_context / c0_xcontext register assumes 8 byte
> ptes and a flat page table array.

 As I say you can increase the size by left-shifting the register.  
That's still cheaper than left-shifting and adding a 32-bit of worse yet a 
64-bit base.  Of course that implies higher yet an alignment and the PTE 
size of a power of two (which assuming at least a minimal level of sanity 
you want anyway).

 A flat structure is quite limiting (read: memory-greedy) indeed, but it 
looks to me with clever masking and shifting you should be able to get 
two-level page tables quite cheaply and easily too (on 32-bit).  Hmm...

> You can map the pagetables into virtual memory to get that and in fact 
> very old Linux/MIPS versions did that but that approach may result in 
> aliases on some processors so I eventually dropped it.  The 
> implementation requires nested TLB refill implementations and 
> (Linux/MIPS was still using a.out in this days) I implemented a new 
> relocation type to squeeze a cycle out of the slow path.

 Nested refills shouldn't be too much of a problem, but cache aliases 
always ask for troubles, hmm...  It may be worth investigating on 
processors with no aliases first, if at all.

  Maciej
