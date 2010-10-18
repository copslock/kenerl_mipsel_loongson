Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 14:48:45 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42020 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491205Ab0JRMsm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Oct 2010 14:48:42 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9ICmd62004002;
        Mon, 18 Oct 2010 13:48:39 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9ICmchn004000;
        Mon, 18 Oct 2010 13:48:38 +0100
Date:   Mon, 18 Oct 2010 13:48:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Question about Context register in TLB refilling
Message-ID: <20101018124838.GF27377@linux-mips.org>
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com>
 <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com>
 <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org>
 <20101018000030.GB31080@linux-mips.org>
 <4CBC256A.7020808@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CBC256A.7020808@niisi.msk.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2010 at 02:46:02PM +0400, Gleb O. Raiko wrote:

> On 18.10.2010 4:00, Ralf Baechle wrote:
> >The aliasing problem is solvable and it may be worth to revisit that old
> >piece of code again now 15 years later.
> 
> Before anybody will start to prepare patches, I'd like to note using
> c0_context allows less than 128 processes (their mm contexts in fact
> but who cares) to be directly mapped on 32-bit cpus. So, some kind
> of caching needs to be implemented and it will add overhead on every
> mm switch. Sure, this overhead might be bounded for a real case
> where there is a small number of processes, so they all fit in the
> cache.
> --- Beware, wild assumptions here ---
> I'm afraid the cost of such caching still will be higher than
> loading pgd_current even from main memory on tlb refill.
> --- End of wild assumptions ---

64 context on R2000/R3000, 256 on everything else but R6000 and RM9000
series, 4096 contexts on RM9000 and that context caching is already
there.  It's fairly lightweight except in the rare case where the
PID / ASID number overflows and a full TLB flush becomes necessary.  A
mm context switch only needs to reload the one wired TLB entry that maps
the pagetables so that's not too bad.  The ugly part are the nested
TLB exceptions.  I dumped that very early on when I realized the cache
alias issues my implementation had so the earliest usable kernel versions
had the tree walking reload handlers.  That's why I don't have any
benchmark results.

  Ralf
