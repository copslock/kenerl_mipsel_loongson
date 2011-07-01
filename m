Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2011 10:27:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58113 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1490989Ab1GAI1P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Jul 2011 10:27:15 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p618R7Bw005250;
        Fri, 1 Jul 2011 09:27:07 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p618R6Hl005248;
        Fri, 1 Jul 2011 09:27:06 +0100
Date:   Fri, 1 Jul 2011 09:27:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Close races in TLB modify handlers.
Message-ID: <20110701082706.GA8308@linux-mips.org>
References: <1309473062-11041-1-git-send-email-david.daney@cavium.com>
 <alpine.LFD.2.00.1106302358550.29709@eddie.linux-mips.org>
 <4E0D0D8C.7000200@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E0D0D8C.7000200@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 390

On Thu, Jun 30, 2011 at 04:58:04PM -0700, David Daney wrote:

> On 06/30/2011 04:34 PM, Maciej W. Rozycki wrote:
> >Hi David,
> >
> >>Page table entries are made invalid by writing a zero into the the PTE
> >>slot in a page table.  This creates a race condition with the TLB
> >>modify handlers when they are updating the PTE.
> >>
> >>CPU0                              CPU1
> >>
> >>Test for _PAGE_PRESENT
> >>.                                 set to not _PAGE_PRESENT (zero)
> >>Set to _PAGE_VALID
> >>
> >>So now the page not present value (zero) is suddenly valid and user
> >>space programs have access to physical page zero.
> >>
> >>We close the race by putting the test for _PAGE_PRESENT and setting of
> >>_PAGE_VALID into an atomic LL/SC section.  This requires more
> >>registers than just K0 and K1 in the handlers, so we need to save some
> >>registers to a save area and then restore them when we are done.
> >
> >  Hmm, good catch, but doesn't your change pessimise the UP case?
> 
> It may, It is really just a first version of the patch.  I am
> looking for feedback and testing.
> 
> >It looks
> >to me like you save&  restore the scratch registers even though the race
> >does not apply to UP (you can't interrupt a TLB handler, not at this
> >stage).
> 
> That's right.  I will look at trying to generate the old code
> sequences for non-SMP.

We can replace all the CONFIG_SMPs in tlbex.c (existing and those added
by your patch) with num_possible_cpus > 1 which will improve readability
and give SMP kernels running on a single processor the uniprocessor TLB
exception handler.

But that's something for a followup patch; your patch is big enough as it
is, it's not as straight forward as it may sound and the 3.0 clock is
ticking ...

  Ralf
